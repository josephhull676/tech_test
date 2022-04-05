require_relative "../pricing_rule"
require "spec_helper"

RSpec.describe "Checkout" do
  let(:checkout) { PricingRule.new }

  let(:rules) do
    {
      prices: { FR1: 3.11, SR1: 5.00, CF1: 11.23 },
      offers: { bogof: [:FR1], quantity_discount: { SR1: { amount: 0.5, threshold: 3 } } },
    }
  end

  let(:pricing_rules) { PricingRule.new(**rules) }

  describe "#price" do
    it "returns the price of an item" do
      expect(pricing_rules.price(:FR1)).to eq(rules.dig(:prices, :FR1))
    end
  end

  describe "#total_discount" do
    let(:basket) { %i[FR1 FR1 FR1] }

    context "when there is a bogof offer" do
      it "calculates how much should be removed from the the total" do
        expect(pricing_rules.total_discount(basket)).to eq 3.11
      end
    end

    context "when there is a quantity discount offer" do
      context "when the threshold has been met" do
        let(:basket) { %i[SR1 SR1 SR1] }

        it "calculates how much should be removed from the the total" do
          expect(pricing_rules.total_discount(basket)).to eq 1.50
        end
      end

      context "when the threshold has not been met" do
        let(:basket) { %i[SR1 SR1] }

        it "calculates how much should be removed from the the total" do
          expect(pricing_rules.total_discount(basket)).to eq 0
        end
      end
    end
  end
end
