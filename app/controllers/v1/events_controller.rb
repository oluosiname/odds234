class V1::EventsController < ApplicationController
  def index
    relation = Event.includes(:competition).future
    relation = relation.by_date(params[:date]) if params[:date]
    relation = relation.by_country(params[:country]) if params[:country]
    relation = relation.by_country(params[:competition]) if params[:competition]

    @events = relation.all.group_by(&:competition_name)
  end

  def show
  end
end