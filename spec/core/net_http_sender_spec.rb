describe ActionHook::Core::NetHTTPSender do

  describe 'send' do
    [:get, :post, :put, :delete].each do |method|
      it "sends a #{method.upcase} request" do
        stub_request(method, "https://example.com")

        request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
          method: method)

        described_class.send(request)

        expect(WebMock).to have_requested(method, 'https://example.com')
      end
    end

    it 'sets the serialized body' do
      stub_request(:post, 'https://example.com')
      request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
        method: :post,
        body: { hello: 'world' }
      )

      described_class.send(request)

      expect(WebMock).to have_requested(:post, "https://example.com").
        with(body: '{"hello":"world"}')
    end

    it 'sets the headers' do
      stub_request(:post, "https://example.com")
      request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
        method: :post,
        body: { hello: 'world' },
        headers: {'CUSTOM-X' => 'X'}
      )

      described_class.send(request)

      expect(WebMock).to have_requested(:post, 'https://example.com').
        with(body: '{"hello":"world"}',
          headers: {'CUSTOM-X' => 'X'}
      )
    end

    it 'adds the sha256 digest' do
      stub_request(:post, "https://example.com")
      request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
        method: :post,
        body: { hello: 'world' },
        secret: "GAGA"
      )

      described_class.send(request)

      expect(WebMock).to have_requested(:post, 'https://example.com').
        with(body: '{"hello":"world"}',
          headers: {ActionHook.configuration.hash_header_name =>
            '3c93293d2d93e47291f818d2b0873321c0e09efc6a7c0c81da19659fc96a1e17'}
      )
    end

    it 'adds the Authorization header' do
      stub_request(:post, "https://example.com")
      request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
        method: :post,
        body: { hello: 'world' },
        secret: "GAGA",
        authentication: ActionHook::Security::Authentication::Token.new('corona')
      )

      described_class.send(request)

      expect(WebMock).to have_requested(:post, 'https://example.com').
        with(body: '{"hello":"world"}',
          headers: {ActionHook.configuration.hash_header_name =>
            '3c93293d2d93e47291f818d2b0873321c0e09efc6a7c0c81da19659fc96a1e17',
            'Authorization' => 'Token corona'}
      )
    end
  end


end