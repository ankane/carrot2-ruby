require "carrot2/version"
require "builder"
require "rest-client"
require "json"

class Carrot2
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
    response = RestClient.post(@url, params) { |response, request, result| response }
    if response.code == 200
      JSON.parse(response.body)
    else
      raise "Bad response code from Carrot2 server: #{response.code}"
    end
  end
end
