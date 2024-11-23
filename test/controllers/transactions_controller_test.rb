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

  test "should render new small transaction type" do
    get new_transaction_path(type: "small")

    assert_template :new_small
  end

  test "should render new large transaction type" do
    get new_transaction_path(type: "large")

    assert_template :new_large
  end

  test "should render new extra large transaction type" do
    get new_transaction_path(type: "extra")

    assert_template :new_extra
  end

  test "should return 404 for unrecognized transaction type" do
    assert_raise(ActionController::RoutingError) do
      get new_transaction_path(type: "unrecognized")
    end
  end
end
