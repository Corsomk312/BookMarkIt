require 'Phantomjs'
require 'aws-sdk'

class AddSnapshot

  ### ITERATE OVER LISTS HERE AND CALL RUNPHANTOM ON EACH URL
  ### CHANGE SELF.CALL TO RUNPHANTOM & CALL HERE

  def self.call(url, id)
    filename = create_filename(url, id)
    Phantomjs.run('app/services/capturesnap.js', url, filename)
    add_snap_to_bookmark(filename)
  end

  def self.add_snap_to_bookmark(filename)
    ### READ FILE AS BINARY OBJ & RETURN OBJ
    tmp_file = File.open(filename, "rb") { |file| file.read }
    return filename

  end

  def self.create_filename(url, id)
    domain_regex = /https*:\/\/w*\.*(\w*\-*\w*)./
    domain = url.match(domain_regex).captures.join("")
    filename = "tmp/thumbnails/#{domain}-0000#{id}.jpg"
    ### STORES TEMP SNAPSHOT IN TMP/domain-777777.jpg
  end

end