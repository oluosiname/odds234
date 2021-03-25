class ClearEventsWorker
  include Sidekiq::Worker

  def perform(*args)
    StaleEventsCleaner.call
  end
end
