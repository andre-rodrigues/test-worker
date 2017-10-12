# frozen_string_literal: true
# TODO: Remove after migrate all Payments

module SubFolder
  class Test2Worker
    include Sneakers::Worker
    include RabbitmqUtils::TaggedWorkerTracer

    QUEUE_NAME = 'billing-cloud.-v2.migrate'

    from_queue QUEUE_NAME,
      routing_key: [
        'billing-cloud.payment_migration.bleblers'
      ],
      arguments: { 'x-dead-letter-exchange': "#{QUEUE_NAME}-retry" },
      retry_max_times: 4,
      retry_timeout: 15.minutes.in_milliseconds
  end
end
