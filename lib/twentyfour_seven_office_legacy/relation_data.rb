module TwentyfourSevenOfficeLegacy
  class RelationData < Model

    attributes [
      :contact_id,
      :customer_id,
      :title,
      :email,
      :phone,
      :mobile
    ]

     def to_hash
      { "relation" => TwentyfourSevenOfficeLegacy.to_xml_data(self) }
    end  
  end
end
