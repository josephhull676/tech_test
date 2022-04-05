class PricingRule
def initialize(prices:, offers:)
    @prices = prices
    @offers = offers
  end

  def price(item)
    @prices[item]
  end

  def total_discount(basket)
    bogof(basket) + quantity_discount(basket)
  end

  private

  def bogof(basket)
    @offers[:bogof].sum { |item| (basket.count(item) / 2) * price(item) }
  end

  def quantity_discount(basket)
    @offers[:quantity_discount].sum do |item, offer_data| 
      basket.count(item) < offer_data[:threshold] ? 0 : offer_data[:amount] * basket.count(item)
    end
  end
end
