# Carrot2

Ruby client for Carrot2 - the **awesome** open-source document clustering server

## Usage

Download and run the Carrot2 server. [Great instructions here](http://project.carrot2.org/download-dcs.html)

```ruby
require "carrot2"

documents = [
  "Sign up for an exclusive coupon.",
  "Exclusive members get a free coupon.",
  "Coupons are going fast.",
  "This is completely unrelated to the other documents."
]

carrot2 = Carrot2.new
carrot2.cluster(documents)
```

returns

```ruby
{
  "processing-time-total"=>1,
  "clusters"=> [
    {
      "id"=>0,
      "size"=>3,
      "phrases"=>["Coupon"],
      "score"=>0.06462323710740674,
      "documents"=>[0, 1, 2],
      "attributes"=>{"score"=>0.06462323710740674}
    },
    {
      "id"=>1,
      "size"=>2,
      "phrases"=>["Exclusive"],
      "score"=>0.05873148311034013,
      "documents"=>[0, 1],
      "attributes"=>{"score"=>0.05873148311034013}
    },
    {
      "id"=>2,
      "size"=>1,
      "phrases"=>["Other Topics"],
      "score"=>0.0,
      "documents"=>[3],
      "attributes"=>{"other-topics"=>true, "score"=>0.0}
    }
  ],
  "processing-time-algorithm"=>1,
  "query"=>nil
}
```

Documents are numbered in the order provided, starting with 0.

To specify the Carrot2 endpoint, use

```ruby
carrot2 = Carrot2.new("http://localhost:8080/dcs/rest") # default
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
