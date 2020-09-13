require "uri"
require "net/http"

class DemoCallSoapService
  def initialize(uri)
    @uri = uri
  end

  def call
    url = URI(@uri)
    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "text/xml; charset=utf-8"
    request.body = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\r\n  <soap:Body>\r\n    <NumberToWords xmlns=\"http://www.dataaccess.com/webservicesserver/\">\r\n      <ubiNum>501</ubiNum>\r\n    </NumberToWords>\r\n  </soap:Body>\r\n</soap:Envelope>\r\n"

    response = https.request(request)
    parse_response(response.body)
  end

  def parse_response(response)
    parser = Nori.new
    puts "====== response: #{response}"
    parser.parse(response)
  end
end
