module TwentyfourSevenOfficeLegacy
  class EmailAddress < Model
    attributes [
      :type,
      :value,
      :description
    ]

    def initialize(attrs)
      raise ArgumentError, "type must be 'Primary'" unless attrs[:type] == "Primary"
      super(attrs)
    end

    def self.primary(nr)
      new(type: "Primary", value: nr)
    end
  end
end
