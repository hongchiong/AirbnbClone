# class PaymentsController < ApplicationController
#   def new
#     @client_token = Braintree::ClientToken.generate
#   end
#   def create
#     amount = @listing.price * params['num_guest'] # In production you should not take amounts directly from clients
#     nonce = params["payment_method_nonce"]

#     result = Braintree::Transaction.sale(
#       amount: amount,
#       payment_method_nonce: nonce,
#     )

#     if result.success? || result.transaction
#       redirect_to checkout_path(result.transaction.id)
#     else
#       error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
#       flash[:error] = error_messages
#       redirect_to listing_path
#     end
#   end
# end