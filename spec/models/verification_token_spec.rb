require './lib/verification_token'

RSpec.describe VerificationToken do
  before do
    pkey = File.read("./spec/support/key.pem")
    key = OpenSSL::PKey::RSA.new(pkey)

    allow(VerificationToken).to receive(:key).and_return(key)
  end

  let(:encrypted_token) do
    "eyJhbGciOiJSU0EtT0FFUCIsImVuYyI6IkExMjhHQ00ifQ.GWvB7QRsEOv-lZfFMDR5xs4eg2v5gX0jQRfv--RHGH0-0I_bR_d-OB--5RCs2Y0W0Uq6ubVIV2GyhLHUUGlKhLDxOIGehwk7LvwRj0yefIvmxLoD1eRd2xz2hnDHROc-93ADm_S-qlAbfFFjpxrsO8Wgn85vHSIJdcyZUWcLa_5V6S4Y726tbB_Y_-CKqPGVhe1MxifMV_rg824lobjqvQsO7gdV7F-BwcLdxn41IWgRgRuzKyB6Cx6bvj0-vXIODsXeeq7Q67f_SZ1oUocdlEqI_RX82-Y-TKZX-Fx2FU07_eN-YCWyawJyxmgduh4wDwwHFFMLUR6P2ngQ4E9j-A.OOJJNPpXxjrpcMlN.3hmwWUcyn4UJCjgQ3mQ1oHIo_jxxWu28_NEJRk-1U1rdUGVzSkoF2UYZeA.tIXauZhZEIvKrKf1svgxyg"
  end

  describe '.decrypt' do
    it 'decrypts the encrypted token and returns the payload' do
      payload = VerificationToken.decrypt(encrypted_token)
      expect(payload).to eq({ 'source' => 'test@example.com', 'code' => '1234' })
    end
  end

  describe '.match?' do
    it 'returns true if the given code matches the code from the token' do
      expect(VerificationToken.match?(code: '1234', token: encrypted_token)).to be true
    end

    it 'returns false if the code does not match the code from the token' do
      expect(VerificationToken.match?(code: '2345', token: encrypted_token)).to be false
    end
  end

  describe '#to_s' do
    it 'encrypts the payload and returns a JWE' do
      t = VerificationToken.new(source: 'test@example.com', code: '1234')
      expect(t.to_s.split('.').first).to eq encrypted_token.split('.').first
    end
  end
end
