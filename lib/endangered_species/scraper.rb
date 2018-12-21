require 'nokogiri'
require 'open-uri'

module EndangeredSpecies
  # Scrapes www.worldwildlife.org, returns array of animals
  module Scraper
    def self.endangered_species
      [].tap do |animals|
        urls.each { |url| animals << create_animal("https://www.worldwildlife.org#{url}") }
      end
    end

    def self.create_animal(url)
      EndangeredSpecies::Animal.new(select_animal_attributes(url))
    end

    def self.select_animal_attributes(url)
      doc = Nokogiri::HTML(URI.open(url))
      attributes = {
        description: doc.css('.section-pop-inner .lead p').text
      }
      doc.css('.list-stats li').each do |stat|
        attributes[:"#{stat.css('.hdr').text.downcase.strip.tr(' ', '_')}"] = stat.css('.container').text.strip
      end
      attributes
    end

    def self.urls
      [].tap do |links|
        Nokogiri::HTML(URI.open('https://www.worldwildlife.org/species'))
                .css('ul.masonry li.item a')
                .each { |item| links << item['href'] }
      end
    end
  end
end
