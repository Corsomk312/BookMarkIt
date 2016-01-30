class ParseURI

  require 'uri'

  def self.call(url)

    # puts url
    # puts "$$$$$$$$$$$$$$$$$$$$$$$$"

    # uri = URI(url)
    # root = uri.host
    # path = uri.path
    # query = uri.query
    # fragment = uri.fragment
    # split = URI.split(url)
    # domain_regex = /https*:\/\/w*\.*(\w*\-*\w*)./
    # domain = url.match(domain_regex).captures.join("")

    # p "++++++++++++++++++++++++++++++++++++++++"
    # puts
    # puts "URL: #{url}"
    # puts "Split: #{split}"
    # puts
    # puts "Domain: #{domain}"
    # puts
    # puts "Root: #{root}"
    # puts "Path: #{path}"
    # puts "Query: #{query}"
    # puts "Fragment: #{fragment}"
    # puts
  end

end

ParseURI.call("https://www.nytimes.com")
