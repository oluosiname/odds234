class V1::WebhooksController < ApplicationController
  def events
    bookmaker = Bookmaker.find_by(name: params[:bookmaker])
    events = params[:events]

    events.each do |eventObject|
      competition = Competition.find_by(name: eventObject[:competition])
      next unless competition

      eventObject[:data].each do |data|
        ::EventProcessor.call(data: data, competition_id: competition.id, bookmaker: bookmaker)
      end
    end
    
    render status: :ok
  rescue
    render status: 500
  end
end
