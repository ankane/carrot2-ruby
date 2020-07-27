# dependencies
require "json"
require "net/http"

# modules
require "carrot2/version"

class Carrot2
  class Error < StandardError; end

  HEADERS = {
    "Content-Type" => "application/json",
    "Accept" => "application/json"
  }

  def initialize(url: nil, open_timeout: 3, read_timeout: nil)
    url ||= ENV["CARROT2_URL"] || "http://localhost:8080"
    @uri = URI.parse(url)
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true if @uri.scheme == "https"
    @http.open_timeout = open_timeout if open_timeout
    @http.read_timeout = read_timeout if read_timeout
  end

  def list
    get("service/list")
  end

  def cluster(documents, language: nil, algorithm: nil, parameters: nil, template: nil)
    unless template
      language ||= "English"
      algorithm ||= "Lingo"
      parameters ||= {}
    end
    data = {
      documents: documents.map { |v| v.is_a?(String) ? {field: v} : v }
    }
    data[:language] = language if language
    data[:algorithm] = algorithm if algorithm
    data[:parameters] = parameters if parameters
    path = "service/cluster"
    path = "#{path}?#{URI.encode_www_form(template: template)}" if template
    post(path, data)
  end

  private

  def get(path)
    handle_response do
      @http.get("#{@uri.request_uri.chomp("/")}/#{path}", HEADERS)
    end
  end

  def post(path, data)
    handle_response do
      @http.post("#{@uri.request_uri.chomp("/")}/#{path}", data.to_json, HEADERS)
    end
  end

  def handle_response
    begin
      response = yield
    rescue Errno::ECONNREFUSED => e
      raise Carrot2::Error, e.message
    end

    unless response.kind_of?(Net::HTTPSuccess)
      body = JSON.parse(response.body) rescue {}
      message = body["message"] || "Bad response: #{response.code}"
      raise Carrot2::Error, message
    end

    JSON.parse(response.body)
  end
end
