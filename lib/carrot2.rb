require "carrot2/version"
require "builder"
require "net/http"
require "json"

class Carrot2
  class Error < StandardError; end

  def initialize(url: nil)
    @url = url || ENV["CARROT2_URL"] || "http://localhost:8080"

    # add dcs/rest
    @url = "#{@url.sub(/\/\z/, "")}/dcs/rest"
  end

  def cluster(documents, language: "ENGLISH")
    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
    xml.searchresult do |s|
      documents.each do |document|
        s.document do |d|
          d.title document
        end
      end
    end

    request(
      "dcs.output.format" => "JSON",
      "dcs.clusters.only" => true,
      "dcs.c2stream" => xml.target!,
      "MultilingualClustering.defaultLanguage" => language,
      multipart: true
    )
  end

  def request(params)
    uri = URI.parse(@url)
    response = Net::HTTP.post_form(uri, params)
    if response.code == "200"
      JSON.parse(response.body)
    else
      body = response.body.to_s
      # try to get reason from title
      m = body.match(/<title>(.+)<\/title>/)
      message = m ? m[1] : body
      raise Carrot2::Error, message
    end
  end
end
