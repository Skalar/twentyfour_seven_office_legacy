module TwentyfourSevenOfficeLegacy
  class Address < Model
    attributes [
      :country,
      :description,
      :county,
      :street,
      :postal_code,
      :postal_area,
      :city,
      :state,
      :type
    ]

    def initialize(attrs)
      raise ArgumentError, "type must be 'Post'" unless attrs[:type] == "Post"
      super(attrs)
    end

    def self.post(attrs = {})
      new(attrs.merge({ type: "Post" }))
    end
  end
end
