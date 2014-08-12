# Pluot

Client wrapper gem for [Wild Apricot API v2](http://help.wildapricot.com/display/DOC/API+Version+2)

## Installation

Add this line to your application's Gemfile:

    gem 'pluot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pluot

## Usage

```ruby
Pluot.api_key = Rails.application.secrets.wild_apricot_key
Pluot.account_id = Rails.application.secrets.wild_apricot_account_id
Pluot.contacts.filter('Archived eq false') # => { :Contacts => [{}, ...] }
```
####Endpoints (WIP)

* Contacts
    * #all
    * #count
    * #find(contact_id)
    * #filter(conditions) - [filter syntax](http://help.wildapricot.com/display/DOC/Contacts+API+V2+call#ContactsAPIV2call-Filteringtheresults)

* Payments
    * #find(payment_id)
    * #made_by(contact_id)

## Contributing

1. Fork it ( https://github.com/rapheld/pluot/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

