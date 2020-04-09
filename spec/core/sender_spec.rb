describe ActionHook::Core::NetHTTPSender do

  describe 'send' do
    [:get, :post, :put, :delete].each do |method|
      it "sends a #{method.upcase} request" do
        stub_request(method, "https://example.com")

        request = ActionHook::Core::JSONRequest.new(url: 'https://example.com',
          method: method)

        described_class.send(request)

        expect(WebMock).to have_requested(method, "https://example.com")
      end
    end

    it 'sets the serialized body' do
      stub_request(:post, "https://example.com")
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

      expect(WebMock).to have_requested(:post, "https://example.com").
        with(body: '{"hello":"world"}',
          headers: {'CUSTOM-X' => 'X'}
        )
    end
  end


end