# Carrot2 Ruby

Ruby client for [Carrot2](https://github.com/carrot2/carrot2) - the open-source document clustering server

[![Build Status](https://github.com/ankane/carrot2-ruby/workflows/build/badge.svg?branch=master)](https://github.com/ankane/carrot2-ruby/actions)

## Installation

First, [download and run](https://github.com/carrot2/carrot2#installation) the Carrot2 server. With Homebrew, use:

```sh
brew install carrot2
brew services start carrot2
```

Then add this line to your application’s Gemfile:

```ruby
gem "carrot2"
```

The latest version works with Carrot2 4. For Carrot2 3, use version 0.2.1 and [this readme](https://github.com/ankane/carrot2-ruby/blob/v0.2.1/README.md).

## How to Use

To cluster documents, use:

```ruby
documents = [
  "Sign up for an exclusive coupon.",
  "Exclusive members get a free coupon.",
  "Coupons are going fast.",
  "This is completely unrelated to the other documents."
]

carrot2 = Carrot2::Client.new
carrot2.cluster(documents)
```

This returns:

```ruby
{
  "clusters" => [
    {
      "labels" => ["Coupon"],
      "documents" => [0, 1, 2],
      "clusters" => [],
      "score" => 0.06418006702675011
    },
    {
      "labels" => ["Exclusive"],
      "documents" => [0, 1],
      "clusters" => [],
      "score" => 0.7040290701763807
    }
  ]
}
```

Documents are numbered in the order provided, starting with 0.

Specify a language with:

```ruby
carrot2.cluster(documents, language: "French")
```

Specify an [algorithm](https://carrot2.github.io/release/4.0.0/doc/algorithms/) with:

```ruby
carrot2.cluster(documents, algorithm: "Lingo")
```

Get a list of supported languages and algorithms with:

```ruby
carrot2.list
```

Specify parameters with:

```ruby
parameters = {
  preprocessing: {
    phraseDfThreshold: 1,
    wordDfThreshold: 1
  }
}
carrot2.cluster(documents, parameters: parameters)
```

See supported parameters for [Lingo](https://carrot2.github.io/release/4.0.0/doc/lingo-attributes/), [STC](https://carrot2.github.io/release/4.0.0/doc/stc-attributes/), and [Bisecting K-Means](https://carrot2.github.io/release/4.0.0/doc/kmeans-attributes/).

Specify a [template](https://carrot2.github.io/release/4.0.0/doc/dcs-templates/) with:

```ruby
carrot2.cluster(documents, template: "lingo")
```

## Configuration

To specify the Carrot2 server, set `ENV["CARROT2_URL"]` or use:

```ruby
Carrot2::Client.new(url: "http://localhost:8080")
```

Set timeouts

```ruby
Carrot2::Client.new(open_timeout: 3, read_timeout: 5)
```

## Resources

- [Carrot2 REST API Basics](https://carrot2.github.io/release/4.0.0/doc/rest-api-basics/)

## History

View the [changelog](https://github.com/ankane/carrot2-ruby/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/carrot2-ruby/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/carrot2-ruby/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/carrot2-ruby.git
cd carrot2-ruby
bundle install
bundle exec rake test
```
