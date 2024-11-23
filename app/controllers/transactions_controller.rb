class TransactionsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @transactions = pagy(Transaction)
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new

    render_new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to @transaction
    else
      render_new
    end
  end

  private

  def render_new
    @manager = Manager.sample if params[:type] == "extra"

    if %w[small large extra].include?(transaction_type)
      render "new_#{transaction_type}"
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def transaction_params
    case transaction_type
    when "small"
      params.require(:transaction).permit(:from_currency, :from_amount, :to_currency)
    when "large"
      params.require(:transaction).permit(:from_currency, :from_amount, :to_currency, :first_name, :last_name)
    when "extra"
      params.require(:transaction).permit(:from_currency, :from_amount, :to_currency, :first_name, :last_name, :manager_id)
    end
  end

  def transaction_type
    params[:type]
  end
end
