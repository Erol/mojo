require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  test "large? only returns true when amount is $100 to $1,000" do
    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 99_99, to_currency: "GBP")
    assert_not transaction.large?

    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 100_00, to_currency: "GBP")
    assert transaction.large?

    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 1000_00, to_currency: "GBP")
    assert transaction.large?

    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 1000_01, to_currency: "GBP")
    assert_not transaction.large?
  end

  test "extra_large? returns true when amount > $1,000" do
    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 1_000_00, to_currency: "GBP")
    assert_not transaction.extra_large?

    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 1_000_01, to_currency: "GBP")
    assert transaction.extra_large?
  end

  test "client personal information and manager is not required for small transaction" do
    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 99_99, to_currency: "GBP")
    assert transaction.save
  end

  test "client personal information is required for large transaction" do
    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 100_00, to_currency: "GBP")
    assert_not transaction.save
  end

  test "manager is not required for large transaction" do
    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 100_00, to_currency: "GBP", first_name: "John", last_name: "Doe")
    assert transaction.save
  end

  test "client personal information and manager is required for extra large transaction" do
    transaction = Transaction.new(from_currency: "USD", from_amount_cents: 1000_01, to_currency: "GBP")
    assert_not transaction.save
    assert transaction.errors.messages[:base].include?("conversions over $1000 require personal manager.")
    assert transaction.errors.messages[:first_name].include?("can't be blank")
    assert transaction.errors.messages[:last_name].include?("can't be blank")

    transaction.first_name = "John"
    transaction.last_name = "Doe"
    transaction.manager = Manager.first
    assert transaction.save
  end
end
