json.array! @events do |competition, events|
  json.competition competition
  json.events events do |event|
    json.uid event.uid
    json.home_team event.home_team
    json.away_team event.away_team
    json.top_odds event.top_odds
    json.starts_at event.starts_at
    json.kickoff event.starts_at.strftime("%H:%M")
    json.date event.starts_at.strftime("%-d %b")
  end
end