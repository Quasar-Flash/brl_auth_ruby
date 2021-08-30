# frozen_string_literal: true

require "spec_helper"

RSpec.describe BRL::Auth do
  describe "BASE_URL" do
    subject { defined? BRL::Auth::BASE_URL }

    it { expect(subject).to be_truthy }
  end

  describe "TOKEN_ENDPOINT" do
    subject { defined? BRL::Auth::TOKEN_ENDPOINT }

    it { expect(subject).to be_truthy }
  end

  describe "TOKEN_EXPIRATION" do
    subject { defined? BRL::Auth::TOKEN_EXPIRATION }

    it { expect(subject).to be_truthy }
  end

  describe ".configure" do
    before do
      BRL.configuration = nil
      ENV.clear
    end

    subject { BRL.configuration }

    context "when configuration is defined" do
      before do
        BRL.configure do |config|
          config.auth_base_url = "auth_url_value"
          config.handshake = "handshake_value"
          config.secret_key = "password_value"
        end
      end

      it { expect(subject).not_to be_nil }

      it { expect(subject.auth_base_url).to eq("auth_url_value") }

      it { expect(subject.handshake).to eq("handshake_value") }

      it { expect(subject.secret_key).to eq("password_value") }
    end

    context "when configuration is not defined" do
      it { expect(subject).not_to be_nil }

      it { expect(subject.auth_base_url).to eq(described_class::BASE_URL) }

      it { expect(subject.handshake).to be_nil }

      it { expect(subject.secret_key).to be_nil }
    end

    context "when its configured by envs" do
      before do
        ENV["BRL_HANDSHAKE"] = "handshake_value"
        ENV["BRL_SECRET_KEY"] = "password_value"
      end

      it { expect(subject).not_to be_nil }

      it { expect(subject.auth_base_url).to eq(described_class::BASE_URL) }

      it { expect(subject.handshake).to eq("handshake_value") }

      it { expect(subject.secret_key).to eq("password_value") }
    end

    context "when its envs configured and configs setted" do
      before do
        ENV["BRL_AUTH_BASE_URL"] = "auth_url_value"
        ENV["BRL_HANDSHAKE"] = "handshake_value"
        ENV["BRL_SECRET_KEY"] = "password_value"

        BRL.configure do |config|
          config.auth_base_url = "auth_url_value2"
          config.handshake = "handshake_value2"
          config.secret_key = "password_value2"
        end
      end

      it { expect(subject).not_to be_nil }

      it { expect(subject.auth_base_url).to eq("auth_url_value2") }

      it { expect(subject.handshake).to eq("handshake_value2") }

      it { expect(subject.secret_key).to eq("password_value2") }
    end

    describe "I18n calls" do
      it { expect(I18n.default_locale).to eq(:en) }

      it { expect(I18n.config.available_locales).to contain_exactly(:en, :'pt-BR') }
    end
  end
end
