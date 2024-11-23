class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def new
    @transaction = Transaction.new

    render_new
  end

  def new_large
    @transaction = Transaction.new
  end

  def new_extra_large
    @transaction = Transaction.new
    @manager = Manager.sample
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
    render "new_#{params[:type]}"
  end

  def transaction_params
    case params[:type]
    when "small"
      params.require(:transaction).permit(:from_currency, :from_amount, :to_currency)
    when "large"
      params.require(:transaction).permit(:from_currency, :from_amount, :to_currency, :first_name, :last_name)
    when "extra"
      params.require(:transaction).permit(:from_currency, :from_amount, :to_currency, :first_name, :last_name, :manager_id)
    end
  end
end
