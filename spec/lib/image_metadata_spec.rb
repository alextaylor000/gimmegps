describe ImageMetadata do
  let(:image_with_metadata) { File.expand_path('../../sample/image_with_metadata.jpg', __FILE__) }
  let(:image_with_corrupted_data) { File.expand_path('../../sample/image_with_corrupted_data.jpg', __FILE__) }

  let(:image) { ImageMetadata.new(image_with_metadata) }
  let(:broken_image) { ImageMetadata.new(image_with_corrupted_data) }

  it 'extracts the specified fields from the image metadata' do
    expect(image[:gps_latitude]).to eq 38.4
  end

  it 'works with strings as keys' do
    expect(image['gps_latitude']).to eq 38.4
  end

  it 'returns nil when the specified fields are not present' do
    expect(image[:nuclear_launch_codes]).to eq nil
  end

  it 'raises an ImageNotReadable error when the image cannot be read' do
    expect { broken_image['anything'] }.to raise_error ImageMetadata::ImageNotReadable
  end

  describe '#filename' do
    it 'returns the filename of the image' do
      expect(image.filename).to match %r{sample/image_with_metadata.jpg}
    end
  end
end
