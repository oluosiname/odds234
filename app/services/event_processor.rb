# frozen_string_literal: true

class EventProcessor < ApplicationService
  def initialize(data:, competition_id:, bookmaker:)
    @competition_id = competition_id
    @data = data
    @bookmaker = bookmaker
  end

  def call
    if @data[:home_team].blank? || @data[:away_team].blank?
      return { success: false }
    end

    result = ActiveRecord::Base.transaction do
      event = Event.find_or_initialize_by(
        competition_id: @competition_id,
        home_team: @data[:home_team],
        away_team: @data[:away_team]
      )

      event.update(event_params)

      odds = Odds.find_or_initialize_by(event_id: event.id, bookmaker_id: @bookmaker.id)
      odds.update(odds_params(@data[:outcomes]))

      event.set_top_odds
    end
    { success: result }
  end

  private

  def event_params
    {
      starts_at: starts_at(@data[:date], @data[:time]),
    }
  end

  def odds_params(outcomes)
    {
      home: outcomes[:home_odds],
      draw: outcomes[:draw_odds],
      away: outcomes[:away_odds],
    }
  end

  def starts_at(date, time)
    dateString = date == 'today' ? Date.today : "#{date}.#{Date.today.year}"
    Time.zone.parse("#{dateString} #{time}")
  rescue => e
    binding.pry
  end
end
