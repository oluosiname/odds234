# frozen_string_literal: true

json.array! @events do |competition, events|
  json.competition competition.name
  json.events events.group_by(&:true_date) do |day, day_events|
    json.day day
    json.day_events day_events do |event|
      json.uid event.uid
      json.home_team event.home_team
      json.away_team event.away_team
      json.top_odds event.top_odds
      json.kickoff event.starts_at.strftime('%H:%M')
      json.date event.true_date
    end
  end
end
