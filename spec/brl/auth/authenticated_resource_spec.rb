# frozen_string_literal: true

require "spec_helper"

RSpec.describe BRL::Auth::AuthenticatedResource do
  describe "#initialize" do
    let(:connection) { instance_double(BRL::Auth::AuthenticatedConnection) }

    subject { described_class.new(connection: connection) }

    it { expect(subject).to be_kind_of(BRL::Auth::AuthenticatedResource) }
  end
end
