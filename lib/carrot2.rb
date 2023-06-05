# stdlib
require "json"
require "net/http"

# modules
require_relative "carrot2/client"
require_relative "carrot2/version"

module Carrot2
  class Error < StandardError; end

  def self.new(**options)
    Client.new(**options)
  end
end
