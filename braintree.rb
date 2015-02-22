# standalone applicaiton with braintree
require 'rubygems'
require 'braintree'

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = '4xpf2p84xtmyxds7'
Braintree::Configuration.public_key = 'xryf8nx72jz9mvkx'
Braintree::Configuration.private_key = '47a4d44e7ba331c9043528d537626f90'

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