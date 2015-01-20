module TwentyfourSevenOfficeLegacy
  class Model
    def self.attributes(attrs)
      @attributes = attrs
      @attributes.each { |name| attr_accessor name }
    end

    def initialize(attrs = {})
      attrs.select { |k, v| attribute_names.include?(k) }.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def attribute_names
      self.class.instance_variable_get(:@attributes)
    end
  end
end
