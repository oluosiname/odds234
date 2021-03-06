class V1::WebhooksController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :verify_webhook

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
    head :ok
  end
  
  private

  def verify_webhook
    request.body.rewind
    data = request.body.read
    hmac_header =  request.headers["X-Authorization-Content-SHA256"]

    calculated_hmac = Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', Rails.application.credentials.webhook_key, data))
    if !ActiveSupport::SecurityUtils.secure_compare(calculated_hmac, hmac_header)
      return head :forbidden
    end
  end
end
