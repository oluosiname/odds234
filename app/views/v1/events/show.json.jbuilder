# frozen_string_literal: true

if @event
  json.event do
    json.uid @event.uid
    json.home_team @event.home_team
    json.away_team @event.away_team
    json.top_odds @event.top_odds
    json.starts_at @event.starts_at
    json.kickoff @event.starts_at.strftime('%H:%M')
    json.date @event.true_date
    json.country @event.competition.country
    json.competition @event.competition_name
    json.odds @event.odds do |odds|
      json.bookmaker odds.bookmaker.name
      json.home odds.home
      json.draw odds.draw
      json.away odds.away
    end
  end
end
