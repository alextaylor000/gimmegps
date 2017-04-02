require 'find'
require File.expand_path('../image_metadata', __FILE__)

class ImageScanner
  attr_reader :root_path

  class PathNotFound < StandardError; end

  def initialize(root_path)
    @root_path = root_path
    @metadata = []
  end

  def scan_path
    Find.find(root_path) do |path|
      @metadata << build_image_metadata(path)
    end

    @metadata.compact
  end

  def scan_path!
    raise PathNotFound, "#{root_path} isn't a valid root_path" unless Dir.exist?(root_path)

    scan_root_path
  end

  private

  def build_image_metadata(path)
    return if File.directory?(path)

    ImageMetadata.new(path)
  rescue ImageMetadata::ImageNotReadable => e
    # we may want to log the exception here
  end
end
