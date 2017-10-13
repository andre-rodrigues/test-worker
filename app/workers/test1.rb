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

  ALLOWED_KEYS = [
    :ble,
    :bla
  ]

  def work(message)
    RabbitmqUtils::MessagePublisher.instance.publish!(
      {}.to_json,
      routing_key: 'test-publisher.routing_key'
    )

    RabbitmqUtils::MessagePublisher.instance.publish!(
      {}.to_json,
      routing_key: 'test432423-publisher.routing_key'
    )
  end
end
