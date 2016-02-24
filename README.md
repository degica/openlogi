# Openlogi [![Build Status](https://travis-ci.org/degica/openlogi.svg?branch=master)](https://travis-ci.org/degica/openlogi)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openlogi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openlogi

## Usage

First initialize a client with your access key:

```ruby
client = Openlogi::Client.new("apikey")
```

Then access Openlogi endpoints by calling RESTful actions on `items`, `warehousings` and `shipments`:

### Items endpoint

**`GET /api/items`**

```ruby
client.items.all
=> [{"id"=>"OS239-I000001", "code"=>"testsku", "name"=>"foo", "price"=>123, "barcode"=>"12345111"},
 {"id"=>"OS239-I000002", "code"=>"testcode", "name"=>"testitem23"},
 {"id"=>"OS239-I000003", "code"=>"testsku1234", "name"=>"Testaaa", "price"=>123},
 {"id"=>"OS239-I000004", "code"=>"testcode555", "name"=>"testitem23"},
 {"id"=>"OS239-I000005", "code"=>"testcode555aaa", "name"=>"testitem23aaa"}]
```

**`GET /api/items/<id>`**

```ruby
client.items.find("OS239-I000001")
=> {"id"=>"OS239-I000001", "code"=>"testsku", "name"=>"foo", "price"=>123, "barcode"=>"12345111"}
```

**`POST /api/items`**

```ruby
item = client.items.create(code: "myproductsku", name: "My Product", price: 100, barcode: "1234567890")
=> {"id"=>"OS239-I000007", "code"=>"myproductsku", "name"=>"My Product", "price"=>100, "barcode"=>"1234567890"}
```

**`PUT /api/items/<id>`**

```ruby
client.items.update("OS239-I000007", name: "My New Name")
=> {"id"=>"OS239-I000007", "code"=>"myproductsku", "name"=>"My New Name", "price"=>100, "barcode"=>"1234567890"}
```

**`DELETE /api/items/<id>`**

```ruby
client.items.destroy("OS239-I000007")
=> {"id"=>"OS239-I000007", "code"=>"myproductsku", "name"=>"My New Name", "price"=>100, "barcode"=>"1234567890"}
```

### Warehousings endpoint

**`GET /api/warehousings`**

```ruby
client.warehousings.all
=> [{"id"=>"OS239-W0003",
  "status"=>"waiting",
  "created_at"=>#<DateTime: 2016-02-23T11:34:28+09:00 ((2457442j,9268s,0n),+32400s,2299161j)>,
  "items"=>[{"id"=>"OS239-I000006", "code"=>"testcode555aaaaaa", "name"=>"testitem23aaaaaa", "quantity"=>20}]},
{"id"=>"OS239-W0002",
  "status"=>"waiting",
  "created_at"=>#<DateTime: 2016-02-23T10:47:51+09:00 ((2457442j,6471s,0n),+32400s,2299161j)>,
  "items"=>[{"id"=>"OS239-I000006", "code"=>"testcode555aaaaaa", "name"=>"testitem23aaaaaa", "quantity"=>1}]}]
```

Other actions behave the same as the items endpoint above.

### Shipments endpoint

**`GET /api/shipments`**

```ruby
client.shipments.all
=> [{"id"=>"OS239-S000001",
  "identifier"=>"test",
  "order_no"=>nil,
  "created_at"=>#<DateTime: 2016-02-23T11:00:21+09:00 ((2457442j,7221s,0n),+32400s,2299161j)>,
  "recipient"=>{"postcode"=>"1660003", "prefecture"=>"東京都", "address1"=>"abc", "address2"=>nil, "name"=>"foo", "company"=>nil, "division"=>nil, "phone"=>"080-8888-8888"},
  "sender"=>
   {"postcode"=>"1800004",
    "prefecture"=>"東京都",
    "address1"=>"武蔵野市吉祥寺本町2-5-10",
    "address2"=>"いちご吉祥寺ビル",
    "name"=>"Foo",
    "company"=>"Degica",
    "division"=>"プログラマー",
    "phone"=>"050-6861-0240"},
  "subtotal_amount"=>nil,
  "delivery_charge"=>nil,
  "handling_charge"=>nil,
  "discount_amount"=>nil,
  "total_amount"=>nil,
  "delivery_carrier"=>nil,
  "delivery_time_slot"=>nil,
  "delivery_date"=>nil,
  "cash_on_delivery"=>false,
  "delivery_method"=>nil,
  "gift_wrapping_unit"=>nil,
  "gift_wrapping_type"=>nil,
  "gift_sender_name"=>nil,
  "bundled_items"=>nil,
  "delivery_options"=>nil,
  "message"=>"",
  "status"=>"working",
  "items"=>[{"id"=>"OS239-I000006", "name"=>"testitem23aaaaaa", "code"=>"testcode555aaaaaa", "quantity"=>1, "unit_price"=>nil, "price"=>nil}]},
 {"id"=>"OS239-S000002",
  "identifier"=>"test2",
  "order_no"=>nil,
  "created_at"=>#<DateTime: 2016-02-23T11:36:08+09:00 ((2457442j,9368s,0n),+32400s,2299161j)>,
  "recipient"=>{"postcode"=>"1660003", "prefecture"=>"東京都", "address1"=>"abc", "address2"=>nil, "name"=>"foo", "company"=>nil, "division"=>nil, "phone"=>"080-8888-8888"},
  "sender"=>
   {"postcode"=>"1800004",
    "prefecture"=>"東京都",
    "address1"=>"武蔵野市吉祥寺本町2-5-10",
    "address2"=>"いちご吉祥寺ビル",
    "name"=>"Foo",
    "company"=>"Degica",
    "division"=>"システム開発部",
    "phone"=>"050-6861-0240"},
  "subtotal_amount"=>nil,
  "delivery_charge"=>nil,
  "handling_charge"=>nil,
  "discount_amount"=>nil,
  "total_amount"=>nil,
```

Other actions behave the same as the items endpoint above.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/degica/openlogi.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
