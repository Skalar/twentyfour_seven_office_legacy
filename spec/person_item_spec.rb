require "twentyfour_seven_office_legacy"
require "savon/mock/spec_helper"

describe TwentyfourSevenOfficeLegacy::PersonItem do
  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:attrs) {
    [
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
      :relation_data,
      :customer_id
    ]
  }

  subject { described_class.new(id: 123, first_name: "Homer", last_name: "Simpson") }

  it "has accessors for all attributes" do
    attrs.each do |attribute|
      expect(subject.respond_to?(attribute)).to eq(true)
      expect(subject.respond_to?("#{attribute}=")).to eq(true)
    end
  end

  describe "#attribut_names" do
    it "returns an array with all attributes names" do
      expect(attrs).to eq(subject.attribute_names)
    end
  end

  describe "#to_hash" do
    it "returns a hash { 'personItem' => { attribute_name: attribute_value } }" do
      subject.relation_data = [
        TwentyfourSevenOfficeLegacy::RelationData.new(title: "test a"),
        TwentyfourSevenOfficeLegacy::RelationData.new(title: "test b")        
      ]

      hash = subject.to_hash

      expect(hash["personItem"].class).to be(Hash)
      expect(hash["personItem"].keys).to eq(attrs)
      expect(hash["personItem"][:id]).to eq(123)
      expect(hash["personItem"][:first_name]).to eq("Homer")
      expect(hash["personItem"][:last_name]).to eq("Simpson")
      expect(hash["personItem"][:relation_data]["RelationData"].length).to eq(2)
      expect(hash["personItem"][:relation_data]["RelationData"].first[:title]).to eq("test a")
      expect(hash["personItem"][:relation_data]["RelationData"].last[:title]).to eq("test b")
    end
  end
end
