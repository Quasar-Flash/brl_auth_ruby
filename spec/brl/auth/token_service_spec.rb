# frozen_string_literal: true

require "spec_helper"

RSpec.describe BRL::Auth::TokenService do
  let(:connection) { instance_double(BRL::Auth::Connection) }

  describe "#retrieve" do
    let(:req_body) { "grant_type=client_credentials&scope=refresh_token" }
    let(:result) { double("result") }
    let(:access_token) { "access_token" }
    let(:expires_in) { 19000 }
    let(:refresh_token) { "refresh_token" }
    let(:scope) { "scope" }
    let(:token_type) { "token_type" }

    subject { described_class.new(connection:).retrieve }

    before do
      allow(connection).to receive(:post).with(url: BRL::Auth::TOKEN_ENDPOINT, body: req_body).and_return(result)
    end

    context "when it was requested successfully" do
      before do
        allow(result).to receive(:body).and_return({
          access_token:  access_token,
          expires_in:    expires_in,
          refresh_token: refresh_token,
          scope:         scope,
          token_type:    token_type
        }.to_json)
        allow(result).to receive(:status).and_return(200)
      end

      it { expect(subject.access_token).to eq(access_token) }
      it { expect(subject.expires_in).to eq(expires_in) }
      it { expect(subject.refresh_token).to eq(refresh_token) }
      it { expect(subject.scope).to eq(scope) }
      it { expect(subject.token_type).to eq(token_type) }
    end

    context "when it received a bad request error" do
      before { allow(result).to receive(:status).and_return(400) }

      it { expect { subject }.to raise_error(BRL::Auth::BadRequestError) }
    end

    context "when it received an unauthorized error" do
      before { allow(result).to receive(:status).and_return(401) }

      it { expect { subject }.to raise_error(BRL::Auth::InvalidCredentialsError) }
    end

    context "when it received an internal server error" do
      before { allow(result).to receive(:status).and_return(500) }

      it { expect { subject }.to raise_error(BRL::Auth::ServerError) }
    end

    context "when it received an unexpected error" do
      before { allow(result).to receive(:status).and_return(550) }

      it { expect { subject }.to raise_error(BRL::Auth::UnexpectedError) }
    end
  end
end
