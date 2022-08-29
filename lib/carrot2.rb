# dependencies
require "json"
require "net/http"

# modules
require "carrot2/client"
require "carrot2/version"

module Carrot2
  class Error < StandardError; end

  def self.new(**options)
    Client.new(**options)
  end
end
