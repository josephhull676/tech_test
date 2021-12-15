require_relative "../checkout.rb"
require "spec_helper.rb"

RSpec.describe "Checkout" do
  let(:pricing_rules) { { FR1: 3.11, SR1: 5.00, CF1: 11.23 }  }
  let(:checkout) { Checkout.new(pricing_rules) }

  before(:each) { checkout.order_items.clear }

  describe "#scan" do
    let(:item) { "FR1" }

    before { checkout.scan("FR1") }

    it "adds an item to the order items" do
      expect(checkout.order_items).to eq([:FR1])
    end
  end

  describe "#total" do
    context "when no discounts need to be applied" do

      before do
        checkout.scan("FR1")
        checkout.scan("SR1")
        checkout.scan("CF1")
      end

      it "calculates the total correctly" do
        expect(checkout.total).to eq(19.34)
      end
    end

    context "when the fruit tea buy one get one free offer needs to be applied" do
      before do
        2.times { checkout.scan("FR1") }
        checkout.scan("SR1")
      end

      it "calculates the total correctly" do
        expect(checkout.total).to eq(8.11)
      end
    end

    context "when the strawberry discount needs to be applied" do
      before do
        3.times { checkout.scan("SR1") }
        checkout.scan("FR1")
      end

      it "calculates the total correctly" do
        expect(checkout.total).to eq(16.61)
      end
    end
  end

  describe "test cases" do
    context "FR1, SR1, FR1, FR1, CF1" do
      before do
        3.times { checkout.scan("FR1") }
        checkout.scan("SR1")
        checkout.scan("CF1")
      end

      it "calculates the total correctly" do
        expect(checkout.total).to eq(22.45)
      end
    end

    context "FR1, FR1" do
      before do
        2.times { checkout.scan("FR1") }
      end

      it "calculates the total correctly" do
        expect(checkout.total).to eq(3.11)
      end
    end

    context "SR1, SR1, FR1, SR1" do
      before do
        3.times { checkout.scan("SR1") }
        checkout.scan("FR1")
      end

      it "calculates the total correctly" do
        expect(checkout.total).to eq(16.61)
      end
    end
  end
end
