require_relative "../checkout.rb"
require "spec_helper"

RSpec.describe "Checkout" do
  let(:checkout) { Checkout.new(pricing_rules) }
  let(:pricing_rules) { instance_double("PricingRule") }

  describe "#scan" do
    context "when one item has been scanned" do
      it "returns an item" do
        expect(checkout.scan("FR1")).to eq [:FR1]
      end
    end

    context "when more items have been scanned" do
      before { checkout.scan("FR1") }

      it "returns all of the items in the basket" do
        expect(checkout.scan("FR1")).to eq [:FR1, :FR1]
      end
    end
  end

  describe "#total" do
    before do 
      allow(pricing_rules).to receive(:total_discount).and_return(discount)
      allow(pricing_rules).to receive(:price).with(:FR1).and_return(3.11)
      allow(pricing_rules).to receive(:price).with(:SR1).and_return(5.00)
      allow(pricing_rules).to receive(:price).with(:CF1).and_return(11.23)
    end

    context "when the basket is FR1, SR1, FR1, FR1, CF1" do

      let(:discount) { 3.11 }

      before do
        3.times { checkout.scan("FR1") }
        checkout.scan("SR1")
        checkout.scan("CF1")
      end

      it "calculates the correct price" do
        expect(checkout.total).to eq 22.45
      end
    end

    context "FR1, FR1" do
      let(:discount) { 0 }

      before { 2.times { checkout.scan("FR1") } }

      it "calculates the total correctly" do
        expect(checkout.total).to eq 6.22
      end
    end

    context "SR1, SR1, FR1, SR1" do
      let(:discount) { 1.50 }

      before do
        3.times { checkout.scan("SR1") }
        checkout.scan("FR1")
      end

      it "calculates the total correctly" do
        expect(checkout.total).to eq 16.61
      end
    end
  end
end
