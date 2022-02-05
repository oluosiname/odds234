# frozen_string_literal: true

class ResetEventsWorker
  include Sidekiq::Worker

  def perform(*args)
    Event.future.destroy_all
    LambdaInvoker.call(func: '234odds_scraper', async: true)
  end
end
