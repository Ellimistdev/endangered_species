require 'word_wrap'
require 'rainbow'

module EndangeredSpecies
  # This is a CLI that displays information scraped from www.worldwildlife.org
  class CLI
    attr_reader :animals

    def call
      @animals = EndangeredSpecies::Scraper.endangered_species
      animal_list_handler
    end

    def menu
      input = gets.chomp.downcase
      return animal_info_handler(input.to_i - 1) if input.to_i > 0 && input.to_i <= @animals.length
      return animal_list_handler if input.casecmp('list').zero?

      if input.casecmp('exit').zero?
        puts 'Goodbye!'
      else
        puts "Please enter either a number between 1 and #{animals.length}, 'list', or 'exit'"
        menu
      end
    end

    def animal_list_handler
      puts "Here are the endangered species:\n\n"
      list_animals
      puts "\n#{Rainbow('Which animal would you like more information about?').bright} #{Rainbow("(Enter '1'-'#{animals.length}', or 'exit')").aqua}\n\n"
      menu
    end

    def animal_info_handler(num)
      EndangeredSpecies::Scraper.select_animal_attributes(@animals[num])
      put_animal_info(@animals[num])
      prompt_for_more_info(@animals[num])
    end

    def list_animals
      animals.each.with_index(1) { |animal, index| puts "\t#{Rainbow(index).cyan}. #{animal.name}" }
    end

    def put_animal_info(animal)
      animal.attribute_names.each do |attribute|
        puts "\t#{Rainbow(attribute).cyan}: #{animal.send(attribute)}" unless attribute.casecmp('description').zero? || attribute.casecmp('url').zero?
      end
    end

    def prompt_for_more_info(animal)
      puts "\n#{Rainbow('Would you like more information, or to see the list again?').bright} #{Rainbow("(Enter 'more' or 'list')").aqua}"
      gets.chomp.casecmp('more').zero? ? more_info(animal) : animal_list_handler
    end

    def more_info(animal)
      puts WordWrap.ww("\n\t#{animal.description.join("\n\n\t")}")
      puts "\n#{Rainbow('Would you like to learn about another animal?').bright} #{Rainbow('(Enter \'list\' or \'exit\')').aqua}"
      menu
    end
  end
end
