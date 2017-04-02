require 'exif'

class ImageMetadata
  attr_reader :exif_data, :filename

  class ImageNotReadable < StandardError; end

  def initialize(filename)
    @exif_data = Exif::Data.new(filename)
    @filename = filename

  # the Exif gem raises an unfortunately generic
  # RuntimeError when a file is not readable, so
  # let's make sure we're only rescuing what we need to.
  rescue RuntimeError => e
    case e.message
    when /no EXIF data/
      raise ImageNotReadable, "Can't extract metadata from file: #{filename}"
    else
      raise
    end
  end

  def [](key)
    exif_data[key.to_sym]
  end
end
