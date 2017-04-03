require 'csv'
require File.expand_path('../image_scanner', __FILE__)

class Cli
  attr_reader :images_path, :output

  def initialize(images_path = current_directory, output: $stdout)
    raise ArgumentError, "output path must be specified" if output.nil?

    @images_path = images_path
    @output = output
  end

  def output!
    CSV(output) do |csv|
      csv << ['filename', 'latitude', 'longitude']
      row_data.each { |row| csv << row }
    end
  end

  private

  def current_directory
    './'
  end

  def row_data
    ImageScanner.new(images_path).scan_path.map do |image|
      [image.filename, image[:gps_latitude], image[:gps_longitude]]
    end
  end
end
