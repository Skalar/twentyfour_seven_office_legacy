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
      :post_address,
      :fax_number,
      :phone_numbers,
      :email_addresses,
      :date_changed,
      :date_of_birth,
      :web_user_name,
      :web_password,
      :nickname,
      :personal_status,
      :workplace,
      :department,
      :work_position,
      :relation_data, # TwentyfourSevenOfficeLegacy::RelationData
      :customer_id
    ]

    def initialize(attrs = {})
      super attrs
      @client = Savon.client(
        wsdl: "http://webservices.24sevenoffice.com/CRM/Contact/PersonService.asmx?WSDL",
        convert_request_keys_to: :camelcase
      )
    end

    def save
      @client.call(:save_person, message: to_hash)
    end

    def save_request_str
      @client.operation(:save_person).build(message: to_hash).to_s
    end

    def to_hash
      { "personItem" => TwentyfourSevenOfficeLegacy.to_xml_data(self) }
    end
  end
end
