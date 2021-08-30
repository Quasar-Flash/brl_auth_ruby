# frozen_string_literal: true

require "spec_helper"

RSpec.describe BRL::Auth::Connection do
  let(:auth_string) { "aGFuZHNoYWtlX3ZhbHVlOnBhc3N3b3JkX3ZhbHVl" }

  before do
    BRL.configure do |config|
      config.auth_base_url = "auth_url_value"
      config.handshake = "handshake_value"
      config.secret_key = "password_value"
    end
  end

  describe "#default_headers" do
    subject { described_class.new.default_headers }

    it { expect(subject).to eq({
      "Content-Type": described_class::CONTENT_TYPE,
      Accept: described_class::ACCEPT,
      Authorization: "basic #{auth_string}"
    }) }
  end
end
