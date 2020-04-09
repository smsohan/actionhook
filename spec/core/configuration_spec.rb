describe ActionHook::Core::Configuration do

  describe 'net_http_options' do
    it 'returns the default values' do
      expect(described_class.new.net_http_options).to eql(
        open_timeout: described_class::DEFAULT_OPEN_TIMEOUT_IN_SECONDS,
        read_timeout: described_class::DEFAULT_READ_TIMEOUT_IN_SECONDS
      )
    end

    it 'allows custom timeout values' do
      expect(described_class.new(open_timeout: 10, read_timeout: 30).net_http_options).to eql(
        open_timeout: 10,
        read_timeout: 30
      )
    end

  end

  describe 'has_header_name' do
    it 'uses the default' do
      expect(described_class.new.hash_header_name).to eql('SHA256-FINGERPRINT')
    end

    it 'allows a custom one' do
      config = described_class.new
      config.hash_header_name = 'CUSTOM-X'
      expect(config.hash_header_name).to eql('CUSTOM-X')
    end
  end

end