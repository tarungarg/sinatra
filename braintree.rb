# standalone applicaiton with braintree
require 'rubygems'
require 'braintree'

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = "xxxxxxxxxxxxx"
Braintree::Configuration.public_key =  "xxxxxxxxxxxxx"
Braintree::Configuration.private_key = "xxxxxxxxxxxxx"

result = Braintree::Transaction.sale(
    :amount => "1000.00",
    :credit_card => {
      :number => "4000 1111 1111 1115",
      :cvv => "216",
      :expiration_month => "06",
      :expiration_year => "2028"
    },
    :options => {
      :submit_for_settlement => true
    }
  )

if result.success?
  puts "Success! Transaction ID: #{result.transaction.id}"
else
  puts "Error: #{result.message}"
end