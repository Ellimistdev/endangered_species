require 'pry'
require 'nokogiri'
require 'open-uri'

module EndangeredSpecies
  # Scrapes www.worldwildlife.org, returns array of animals
  module Scraper
    def self.endangered_species
      [].tap do |animals|
        urls.each { |name, url| animals << create_animal(name, "https://www.worldwildlife.org#{url}") }
      end
    end

    def self.create_animal(name, url)
      EndangeredSpecies::Animal.new(name: name, url: url)
    end

    def self.select_animal_attributes(animal)
      doc = Nokogiri::HTML(URI.open(animal.url))
      attributes = {
        description: doc.css('.section-pop-inner .lead p').text
      }
      doc.css('.list-stats li').each do |stat|
        attributes[:"#{stat.css('.hdr').text.downcase.strip.tr(' ', '_')}"] = stat.css('.container').text.strip
      end
      animal.assign_attributes(attributes)
    end

    def self.urls
      {}.tap do |links|
        Nokogiri::HTML(URI.open('https://www.worldwildlife.org/species'))
                .css('ul.masonry li.item a')
                .each { |item| links[item.css('.name').text.strip.sub(/\n.+$/, '').to_s] = item['href'] }
      end
    end
  end
end
