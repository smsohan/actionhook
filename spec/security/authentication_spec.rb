describe ActionHook::Security::Authentication::Basic do

  describe '#to_h' do
    it 'renders the basic auth header' do
      expect(described_class.new(username: 'corona', password: 'virus').to_h).
        to eql("Authorization" => "Basic Y29yb25hOnZpcnVz")
    end
  end

end

describe ActionHook::Security::Authentication::Token do

  describe '#to_h' do
    it 'renders the basic auth header' do
      expect(described_class.new('corona').to_h).
        to eql("Authorization" => "Token corona")
    end
  end

end

describe ActionHook::Security::Authentication::BearerToken do

  describe '#to_h' do
    it 'renders the basic auth header' do
      expect(described_class.new('corona').to_h).
        to eql("Authorization" => "Bearer corona")
    end
  end

end
