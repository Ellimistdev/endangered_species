module EndangeredSpecies
  # This is a CLI that displays information scraped from www.worldwildlife.org
  class CLI
    attr_reader :animals

    def call
      @animals = EndangeredSpecies::Scraper.endangered_species
      list_animals
      menu
    end

    def menu
      input = nil
      while input != 'exit'
        input = gets.chomp
        if input.to_i > 0
          animal_info(input.to_i - 1)
        elsif input.casecmp('list').zero?
          list_animals
        elsif input.casecmp('exit').zero?
          puts 'Goodbye!'
        else
          puts "Please enter either a number between 1 and #{animals.length}, 'list', or 'exit'"
        end
      end
    end

    def list_animals
      puts 'Here are the endangered species'
      animals.each.with_index(1) { |animal, index| puts "\t#{index}. #{animal}" }
      puts "Which animal would you like more information about? (enter '1'-'#{animals.length}', or 'exit')"
    end

    def animal_info(num)
      @animals[num].attribute_names.each do |attribute|
        puts "#{attribute}: #{@animals[num].send(attribute)}" unless attribute.casecmp('description').zero?
      end
      more_info(num)
    end

    def more_info(num)
      puts "Would you like more information, or to see the list again? (enter 'more' or 'list')"
      if gets.chomp.casecmp('more').zero?
        puts @animals[num].description
        puts "Would you like to learn about another animal? Enter 'list' or 'exit'"
      else
        list_animals
      end
    end
  end
end
