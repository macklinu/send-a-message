require 'net/http'

def http_post(url, endpoint)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new("/max/#{endpoint}")
    request.add_field('Content-Type', 'application/json')
    response = http.request(request)
    out0 response.body
end
