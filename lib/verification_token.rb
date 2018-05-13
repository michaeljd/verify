require 'jwe'

# A model used to encrypt the source and verification code

class VerificationToken
  def self.decrypt(encrypted_token)
    payload = JWE.decrypt(encrypted_token, key)
    JSON.parse(payload)
  end

  def self.match?(code:, token:)
    payload = VerificationToken.decrypt(token)

    code == payload.fetch('code')
  end

  def initialize(source:, code:)
    @source = source
    @code = code
  end

  def to_s
    JWE.encrypt(JSON.generate(payload), self.class.key)
  end

  private

  # TODO: Read from environment variable
  class << self
    def key
      @_key ||= OpenSSL::PKey::RSA.generate(2048)
    end
  end

  def payload
    { 'source' => @source, 'code' => @code }
  end
end
