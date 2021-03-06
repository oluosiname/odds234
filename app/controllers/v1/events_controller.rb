class V1::EventsController < ApplicationController
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
end