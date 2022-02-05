# frozen_string_literal: true

module V1
  class WebhooksController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :verify_webhook

    def events
      bookmaker = Bookmaker.find_by(name: params[:bookmaker])
      events = params[:events]
      events.each do |event_object|
        competition = Competition.find_by(name: event_object[:competition])
        next unless competition

        event_object[:data].each do |data|
          ::EventProcessor.call(data: data, competition_id: competition.id, bookmaker: bookmaker)
        end
      end
      head :ok
    end

    private

    def verify_webhook
      request.body.rewind
      data = request.body.read
      hmac_header = request.headers['X-Authorization-Content-SHA256']

      calculated_hmac = Base64.strict_encode64(OpenSSL::HMAC.digest('sha256', Rails.application.credentials.webhook_key,
        data))
      unless ActiveSupport::SecurityUtils.secure_compare(calculated_hmac, hmac_header)
        head :forbidden
      end
    end
  end
end
