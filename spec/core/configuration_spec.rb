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

  describe 'allow_private_ips' do
    it 'sets to false by default' do
      expect(described_class.new.allow_private_ips).to be false
    end
    it 'allows user to unblock private ip' do
      config = described_class.new
      config.allow_private_ips = true
      expect(config.allow_private_ips).to be true

      config = described_class.new allow_private_ips: true
      expect(config.allow_private_ips).to be true
    end

  end

  describe 'blocked_custom_ip_ranges' do
    it 'sets to empty by default' do
      expect(described_class.new.blocked_custom_ip_ranges).to eql []
    end

    it 'allows user set a range of IP addresses' do
      config = described_class.new
      config.blocked_custom_ip_ranges = ["193.168.2.0/24"]
      expect(config.blocked_custom_ip_ranges).to eql([IPAddr.new("193.168.2.0/24")])

      config = described_class.new blocked_custom_ip_ranges: ["193.168.2.0/24"]
      expect(config.blocked_custom_ip_ranges).to eql [IPAddr.new("193.168.2.0/24")]
    end

  end

  describe 'allow_all?' do
    it 'sets to false by default' do
      expect(described_class.new.allow_all?).to be false
    end
    it 'sets to false if private ips are allowed without any custom range' do
      config = described_class.new
      config.allow_private_ips = true
      config.blocked_custom_ip_ranges = ["189.9.0.1"]
      expect(config.allow_all?).to be false
    end

    it 'sets to true if private ips are allowed without any custom range' do
      config = described_class.new
      config.allow_private_ips = true
      expect(config.allow_all?).to be true
    end

  end


end