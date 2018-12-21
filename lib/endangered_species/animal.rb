module EndangeredSpecies
  # dynamically assigned Animal object based on a hash of key value pairs
  class Animal
    attr_reader :attribute_names

    def initialize(attributes = {})
      @attribute_names = []
      assign_attributes(attributes)
    end

    def assign_attributes(attributes)
      self.class.assign_attribute_keys(attributes)
      assign_attribute_values(attributes)
    end

    def assign_attribute_values(attributes)
      attributes.each do |k, v|
        send("#{k}=", v)
        @attribute_names << k.to_s
      end
    end

    def self.assign_attribute_keys(attributes)
      attributes.keys.each do |attribute|
        attr_accessor attribute
      end
    end
  end
end
