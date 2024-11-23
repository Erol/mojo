require "test_helper"

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should create small transaction" do
    post transactions_url, params: { type: "small", transaction: { from_currency: "USD", from_amount: "99.99", to_currency: "GBP" } }

    transaction = Transaction.last

    assert_redirected_to transaction_path(transaction)
  end

  test "should create large transaction" do
    post transactions_url, params: { type: "large", transaction: { from_currency: "USD", from_amount: "100.00", to_currency: "GBP", first_name: "John", last_name: "Doe" } }

    transaction = Transaction.last

    assert_redirected_to transaction_path(transaction)
  end

  test "should create extra large transaction" do
    post transactions_url, params: { type: "extra", transaction: { from_currency: "USD", from_amount: "1000.01", to_currency: "GBP", first_name: "John", last_name: "Doe", manager_id: Manager.sample.id } }

    transaction = Transaction.last

    assert_redirected_to transaction_path(transaction)
  end
end
