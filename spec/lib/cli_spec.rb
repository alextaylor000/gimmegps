require 'stringio'

describe Cli do
  let(:images_path) { File.expand_path('../../sample/sub_dir/', __FILE__) }
  let(:mock_output) { '/dev/null' }

  it 'returns a CSV file containing GPS coordinates for all images in the given directory' do
    results = Cli.new(images_path, output: mock_output).output!
    filename, lat, long = results.first

    expect(filename).to match /image_e/
    expect(lat.to_s).to match /^59\./
    expect(long.to_s).to match /^10\./
  end
end
