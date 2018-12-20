module EndangeredSpecies
  # Scrapes www.worldwildlife.org, returns array of animals
  module Scraper
    def self.animals
      @animals = []
      # @pages = pages
      animal_attr = {
        name: 'Amur Leopard',
        status: 'Endangered',
        population: 'Around 3,890',
        scientific_name: 'Panthera tigris',
        weight: '220–660 pounds',
        length: '6–10 feet',
        habitats: 'Tropical rainforests, evergreen forests, temperate forests, mangrove swamps, grasslands and savannas',
        description: 'description'
      }
      animal2_attr = {
        name: 'POLAR BEAR',
        status: 'Vulnerable',
        population: '22,000-31,000',
        scientific_name: 'Ursus maritimus',
        weight: '800–1,300 pounds',
        length: '6–9 feet',
        habitats: 'Arctic sea ice',
        description: 'description'
      }
      animal = EndangeredSpecies::Animal.new(animal_attr)
      animal2 = EndangeredSpecies::Animal.new(animal2_attr)
      @animals << animal
      @animals << animal2
      @animals
    end
  end
end
