# frozen_string_literal: true
# TODO: Remove after migrate all Payments

class Test1Worker
  include Sneakers::Worker
  include RabbitmqUtils::TaggedWorkerTracer

  QUEUE_NAME = 'billing-cloud.payment-v2.migrate'

  from_queue QUEUE_NAME,
    routing_key: [
      'billing-cloud.payment_migration.seed'
    ],
    arguments: { 'x-dead-letter-exchange': "#{QUEUE_NAME}-retry" },
    retry_max_times: 4,
    retry_timeout: 15.minutes.in_milliseconds
end
