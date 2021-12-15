class Checkout
  STRAWBERRY_DISCOUNT_AMOUNT = 0.5
  STRAWBERRY_DISCOUNT_THRESHOLD = 3

  attr_reader :pricing_rules
  attr_accessor :order_items

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @order_items = []
    # @total = 0
  end

  def scan(product_code)
    order_items.push(product_code.upcase.to_sym)
  end

  def total
    # apply_discounts

    # @total -= order_items.map { |item| pricing_rules[item] }.sum

    (order_items.map { |item| pricing_rules[item] }.sum - discount).round(2)
  end
end

private

# def apply_discounts
#   apply_strawberry_price_change if order_items.count(:SR1) >= 3

#   @total -= total_fruit_tea_discount
# end

def discount
  fruit_tea_discount + strawberry_discount
end

def fruit_tea_discount
  order_items.count(:FR1).even? ? n = 0 : n = 1

  (order_items.count(:FR1) - n) / 2 * pricing_rules[:FR1]
end

def strawberry_discount
  return 0 unless order_items.count(:SR1) >= Checkout::STRAWBERRY_DISCOUNT_THRESHOLD

  order_items.count(:SR1) * Checkout::STRAWBERRY_DISCOUNT_AMOUNT
end

# def apply_strawberry_price_change
#   pricing_rules[:SR1] = 4.50
# end

# Notes:
#   - Commented out code is there as a reminder of the other approach I took so I can refer
#     to it in interview if necessary.

# Future ideas:
#   - Pass in a hash of offers, with keys related to the name of the offer (bogof for eg)
#     and an array of product codes they're applied to.
#   - On top of this, make offer methods more generic so that any product can be passed in
#     and have the offer applied to it - For eg. bogof_discount(:FR1)
