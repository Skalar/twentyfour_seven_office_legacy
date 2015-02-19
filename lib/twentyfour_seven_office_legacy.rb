require "bundler/setup"
require "savon"
require "twentyfour_seven_office_legacy/version"
require "twentyfour_seven_office_legacy/errors"
require "twentyfour_seven_office_legacy/model"
require "twentyfour_seven_office_legacy/credential"
require "twentyfour_seven_office_legacy/phone_number"
require "twentyfour_seven_office_legacy/fax_number"
require "twentyfour_seven_office_legacy/email_address"
require "twentyfour_seven_office_legacy/relation_data"
require "twentyfour_seven_office_legacy/address"
require "twentyfour_seven_office_legacy/person_item"
require "twentyfour_seven_office_legacy/client"

module TwentyfourSevenOfficeLegacy
  def self.to_xml_data(obj)
    return typed_xml_array(obj) if array_with_element?(obj)
    return obj if plain_object?(obj)
    Hash[attribute_value_pairs(obj)]
  end

  # Input: [<PersonItem id: 123>, <PersonItem id: 456>]
  # Output: {"PersonItem" => [{id: 123}, {id: 456}]}
  def self.typed_xml_array(obj)
    { array_xml_element_name(obj) => obj.map { |v| to_xml_data(v) } }
  end

  # Input: <PersonItem id: 123, first_name: "Mikke mus", ...>
  # Output: [[:id, 123], [:first_name, "Mikke mus"], ...]
  def self.attribute_value_pairs(obj)
    obj.attribute_names.map { |name| [name, to_xml_data(obj.send(name))] }
  end

  # Input: [<PersonItem id: 123>, <PersonItem id: 456>]
  # Output: "PersonItem"
  def self.array_xml_element_name(ary)
    ary.first.class.to_s.split("::").last
  end

  def self.array_with_element?(obj)
    obj.is_a?(Array) && obj.any?
  end

  def self.plain_object?(obj)
    !obj.respond_to?(:attribute_names)
  end
end
