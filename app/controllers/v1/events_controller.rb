class V1::EventsController < ApplicationController
  before_action :authenticate
  
  def index
    relation = Event.includes(:competition).future
    relation = relation.by_date(params[:date]) if params[:date]
    relation = relation.by_country(params[:country]) if params[:country]
    relation = relation.by_competition(params[:competition]) if params[:competition]

    @events = relation.all.group_by(&:competition).sort_by{|competition, _extras| competition.priority }
  end

  def show
    @event = Event.find_by(uid: params[:id])

    return render staus: 404 unless @event
  end

  private

  def authenticate
    return head :unauthorized unless ActiveSupport::SecurityUtils.secure_compare(token, Rails.application.credentials.api_key)
  end

  def token
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    else
      return head :unauthorized
    end
  end
end