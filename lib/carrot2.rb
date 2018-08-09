require "carrot2/version"
require "builder"
require "net/http"
require "json"

class Carrot2
  class Error < StandardError; end

  def initialize(url: nil, open_timeout: 3, read_timeout: nil)
    @url = url || ENV["CARROT2_URL"] || "http://localhost:8080"

    # add dcs/rest
    @url = "#{@url.sub(/\/\z/, "")}/dcs/rest"
    @uri = URI.parse(@url)

    @open_timeout = open_timeout
    @read_timeout = read_timeout
  end

  def cluster(documents, language: "English")
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
      "dcs.clusters.only" => true,
      "dcs.c2stream" => xml.target!,
      "MultilingualClustering.defaultLanguage" => language.upcase,
      multipart: true
    )
  end

  def request(params)
    req = Net::HTTP::Post.new(@uri)
    req.set_form_data(params.merge("dcs.output.format" => "JSON"))

    options = {
      use_ssl: @uri.scheme == "https"
    }
    options[:open_timeout] = @open_timeout if @open_timeout
    options[:read_timeout] = @read_timeout if @read_timeout

    response = Net::HTTP.start(@uri.hostname, @uri.port, options) do |http|
      http.request(req)
    end

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
