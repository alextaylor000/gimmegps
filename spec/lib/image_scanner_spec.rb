describe ImageScanner do
  describe '#scan_path' do
    it 'returns an array of ImageMetadata objects for each image in the directory' do
      valid_path = File.expand_path('../../sample/', __FILE__)

      expect(ImageScanner.new(valid_path).scan_path).to all be_an ImageMetadata
    end

    it 'returns an empty array when no images are found in the directory' do
      empty_path = File.expand_path('../../sample/empty/', __FILE__)

      expect(ImageScanner.new(empty_path).scan_path).to eq []
    end
  end

  describe '#scan_path!' do
    it 'raises PathNotFound if given an invalid path' do
      expect {
        ImageScanner.new('/invalid/path').scan_path!
      }.to raise_error ImageScanner::PathNotFound
    end
  end

end
