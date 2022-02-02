# frozen_string_literal: true

require "spec_helper"

RSpec.describe BRL::Auth::AuthenticatedConnection do
  describe "#default_headers" do
    let(:token_service) { instance_double(BRL::Auth::TokenService) }
    let(:token) { BRL::Auth::Token.new(access_token:) }

    subject { described_class.new(token_service:, cache:).default_headers }

    context "when token is cached" do
      let(:access_token) { "Bearer access_token" }
      let(:cache) { double("cache") }

      before do
        allow(token_service).to receive(:retrieve).and_return(token)
        allow(cache).to receive(:fetch).with(described_class::COOKIE_CACHE_KEY, expires_in: BRL::Auth::TOKEN_EXPIRATION).and_return(access_token)
      end

      it { expect(token_service).not_to have_received(:retrieve) }

      it { expect(subject).to eq({
        Accept: described_class::CONTENT_TYPE,
        Authorization: access_token,
        "Content-Type": described_class::CONTENT_TYPE
      }) }
    end

    context "when token is not cached" do
      let(:access_token) { "access_token" }
      let(:cache) { nil }

      before do
        allow(token_service).to receive(:retrieve).and_return(token)
      end

      it { subject; expect(token_service).to have_received(:retrieve).once }

      it { expect(subject).to eq({
        Accept: described_class::CONTENT_TYPE,
        Authorization: "Bearer #{access_token}",
        "Content-Type": described_class::CONTENT_TYPE
      }) }
    end
  end
end
