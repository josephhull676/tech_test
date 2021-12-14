# DfE software developer tech test

In our quest to stay in touch with what's going on in the commercial world we've decided to open a supermarket - we sell only three products:


| Code | Name         | Price  |
|------|--------------|--------|
| FR1  | Fruit tea    | £3.11  |
| SR1  | Strawberries | £5.00  |
| CF1  | Coffee       | £11.23 |


Our CEO is a big fan of buy-one-get-one-free offers and of fruit tea. She wants us to add a rule so that customers get one free fruit tea when they buy a fruit tea.

The COO, though, likes low prices and wants people buying strawberries to get a price discount for bulk purchases. If you buy 3 or more packs of strawberries, the price per pack should drop to £4.50.

Our checkout can scan items in any order, and because the CEO and COO change their minds often, it needs to be flexible regarding our pricing rules.

Here’s an example of calling this code in Ruby:

```ruby
co = Checkout.new(pricing_rules)
co.scan(product_code)
co.scan(product_code)
price = co.total()
```

### Tasks

Your goal is to implement the Checkout class, so that it will calculate prices correctly for the test data provided below.

It will be used as a library by other parts of the system, so it doesn't need to deal with input or output, it will just be called like in the example shown above.

Your implementation should include automated tests.


| Basket                  | Expected price |
|-------------------------|----------------|
| FR1, SR1, FR1, FR1, CF1 | £22.45         |
| FR1, FR1                | £3.11          |
| SR1, SR1, FR1, SR1      | £16.61         |
