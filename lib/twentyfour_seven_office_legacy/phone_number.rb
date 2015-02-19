module TwentyfourSevenOfficeLegacy
  class PhoneNumber < Model
    attributes [
      :type,
      :value,
      :description
    ]

    def initialize(attrs)
      unless %w{ Primary Mobile }.include?(attrs[:type])
        raise ArgumentError, "type must be one of 'Primary' or 'Mobile'"
      end

      super(attrs)
    end

    def self.mobile(nr)
      new(type: "Mobile", value: nr)
    end

    def self.primary(nr)
      new(type: "Primary", value: nr)
    end
  end
end
