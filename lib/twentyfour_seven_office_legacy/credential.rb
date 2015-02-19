module TwentyfourSevenOfficeLegacy
  class Credential < Model

    attributes [
      :username,
      :password,
      :application_id,
      :identity_id
    ]

    def to_hash
      { "credential" => TwentyfourSevenOfficeLegacy.to_xml_data(self) }
    end
  end
end
