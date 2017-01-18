# Carrot2

Ruby client for [Carrot2](http://project.carrot2.org/) - the open-source document clustering server

## Installation

First, [download and run](http://project.carrot2.org/download-dcs.html) the Carrot2 server.

Then add this line to your application’s Gemfile:

```ruby
gem 'carrot2'
```

## Usage

```ruby
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

To specify the Carrot2 url, use:

```ruby
carrot2 = Carrot2.new(url: "http://localhost:8080/dcs/rest")
```

## History

View the [changelog](https://github.com/ankane/carrot2/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/carrot2/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/carrot2/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
