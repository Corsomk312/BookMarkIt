require 'Phantomjs'
require 'aws-sdk'

class AddSnapshot

  def self.call(url)
    filename = create_filename(url)
    Phantomjs.run('app/services/capturesnap.js', url, filename)
    add_snap_to_bookmark(filename)
  end

  def self.add_snap_to_bookmark(filename)
    ### READ FILE AS BINARY OBJ & RETURN OBJ
    tmp_file = File.open(filename, "rb") { |file| file.read }
    return filename

  end

  def self.create_filename(url)
    domain_regex = /https*:\/\/w*\.*(\w*\-*\w*)./
    domain = url.match(domain_regex).captures.join("")
    filename = "../tmp/#{domain}-#{rand(555555..999999)}.jpg"
    ### STORES TEMP SNAPSHOT IN ../TMP/domain-777777.jpg
  end

end