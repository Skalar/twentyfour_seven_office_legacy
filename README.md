# TwentyfourSevenOfficeLegacy

The library offers a simple API for searching and saving/updating a person or relation
via the legacy 24SevenOffice WebService API.

The gem is not feature complete; Most services and operations of the legacy WebServices are
not implemented.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twentyfour_seven_office_legacy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twentyfour_seven_office_legacy

## Usage

```ruby
cred = TwentyfourSevenOfficeLegacy::Credential.new(username: "your@email.com", password: "secret", application_id: "something-xxxx-1111-aaaa-etcetera")
client = TwentyfourSevenOfficeLegacy::Client.new(cred)
client.authenticate unless client.has_session?
client.find_person_by_id(123) # returns a TwentyfourSevenOfficeLegacy::PersonItem object

pi = TwentyfourSevenOfficeLegacy::PersonItem.new(
  first_name: "John",
  last_name: "Smith",
  phone_numbers: [
    PhoneNumber.primary(123),
    PhoneNumber.mobile(456)
  ],
  fax_number: FaxNumber.primary(789),
  email_addresses: [
    EmailAddress.primary("john@smith.com")
  ],
  post_address: Address.post(street: "Neverwhere", postal_code: "1313", postal_area: "EARTH")
)

client.save_person_item(pi) # returns id

client.relations(123) # returns an array of TwentyfourSevenOfficeLegacy::RelationData for the person with id 123

client.make_relation(TwentyfourSevenOfficeLegacy::RelationData.new(contact_id: 123, customer_id: 456))
client.delete_relation(123, 456) # removes relation between contact 123 and customer 456
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/twentyfour_seven_office_legacy/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
