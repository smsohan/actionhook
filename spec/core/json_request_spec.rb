describe ActionHook::Core::JSONRequest do
  let(:request) { described_class.new(url: 'https://some/req') }
  describe 'serialized_body' do
    it 'serializes hashes' do
      request.body = { hello: 'world' }

      expect(request.serialized_body).to eql('{"hello":"world"}')
    end

    it 'serializes arrays' do
      request.body = [{ hello: 'world' }]

      expect(request.serialized_body).to eql('[{"hello":"world"}]')
    end

    it 'falls back otherwise' do
      request.body = 'something'

      expect(request.serialized_body).to eql('something')

    end
  end
end