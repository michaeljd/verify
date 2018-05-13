require 'securerandom'

# A model used to create random security codes

class VerificationCode
  DEFAULT_LENGTH = 4

  def self.generate(length)
    Array.new(length) { SecureRandom.random_number(10) }.join
  end

  def initialize(code = nil)
    @code = code || self.class.generate(DEFAULT_LENGTH)
  end

  def to_s
    @code
  end

  def ==(other)
    strict_compare(self.to_s, other.to_s)
  end

  private

  # Stolen from ActiveSupport
  def strict_compare(a, b)
    return false unless a.bytesize == b.bytesize

    l = a.unpack "C#{a.bytesize}"

    res = 0
    b.each_byte { |byte| res |= byte ^ l.shift }
    res == 0
  end
end
