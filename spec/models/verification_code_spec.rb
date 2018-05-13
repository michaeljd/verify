require "./lib/verification_code"

RSpec.describe VerificationCode do
  subject { VerificationCode.new('1234') }

  describe ".new" do
    it "builds a new VerificationCode using the given code" do
      code = VerificationCode.new('1234')
      expect(code.to_s).to eq '1234'
    end

    it "builds a new VerificationCode with a random code if none give" do
      code = VerificationCode.new('1234')
      expect(code.to_s).to eq '1234'
    end
  end

  describe "#to_s" do
    it "returns the string version of the generated code" do
      expect(subject.to_s).to eq '1234'
    end
  end

  describe "#==" do
    it 'returns true if given a VerificationCode with the same code' do
      expect(subject).to eq VerificationCode.new('1234')
    end

    it 'returns false if given a VerificationCode with a different code' do
      expect(subject).not_to eq VerificationCode.new('2345')
    end
  end
end
