class Checkout
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @basket = []
  end

  def scan(product_code)
    @basket.push(product_code.to_sym)
  end

  def total
    @basket.sum { |item| @pricing_rules.price(item.to_sym) } - @pricing_rules.total_discount(@basket)
  end
end
