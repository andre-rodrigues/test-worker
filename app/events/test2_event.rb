# frozen_string_literal: true

class PaymentApprovedEvent < PaymentEvent
  def routing_key
    "billing-cloud.#{payment.country.downcase}.#{payment.payable_type.downcase}.payment.approved"
  end
end