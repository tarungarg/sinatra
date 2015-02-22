module BraintreeTransaction
  def transction(params, amount_pay)
    result = Braintree::Transaction.sale(
      :amount => amount_pay,
      :credit_card => {
        :number => params[:number],
        :cvv => params[:cvv],
        :expiration_month => params[:month],
        :expiration_year => params[:year]
      },
      :options => {
        :submit_for_settlement => true
      }
    )
    return result
  end
end
