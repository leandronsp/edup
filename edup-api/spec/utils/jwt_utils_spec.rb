describe JWTUtils do
  describe '#encode' do
    it 'encodes to a JWT' do
      payload = { data: '123' }
      token = described_class.encode(payload)
      body = JWT.decode(token, nil, false)[0]

      expect(body['data']).to eq('123')
    end
  end

  describe '#decode' do
    it 'decodes a JWT' do
      payload = { data: '123' }
      token = described_class.encode(payload)
      result = described_class.decode(token)

      expect(result['data']).to eq('123')
    end
  end
end
