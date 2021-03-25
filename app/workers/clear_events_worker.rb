class ClearEventsWorker
  include Sidekiq::Worker

  def perform(*args)
    Event.past.destroy_all
  end
end
