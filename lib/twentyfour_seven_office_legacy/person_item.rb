module TwentyfourSevenOfficeLegacy
  class PersonItem < Model

    attributes [
      :consumer_person_no,
      :id,
      :first_name,
      :last_name,
      :url,
      :country,
      :comment,
      :post_address, # TwentyfourSevenOfficeLegacy::Address 
      :fax_number, # TwentyfourSevenOfficeLegacy::FaxNumber
      :phone_numbers, # Array<TwentyfourSevenOfficeLegacy::PhoneNumber>
      :email_addresses, # Array<TwentyfourSevenOfficeLegacy::EmailAddress>
      :date_changed,
      :date_of_birth,
      :web_user_name,
      :web_password,
      :nickname,
      :personal_status,
      :workplace,
      :department,
      :work_position,
      :relation_data, # Array<TwentyfourSevenOfficeLegacy::RelationData>
      :customer_id
    ]

    def initialize(attrs)
      super(attrs)
    end

    def to_hash
      { "personItem" => TwentyfourSevenOfficeLegacy.to_xml_data(self) }
    end
  end
end
