# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
comps = [
  {name: "bundesliga", country: "germany", priority: 4},
  {name: "premier league", country: "england", priority: 1},
  {name: "la liga", country: "spain", priority: 3},
  {name: "ligue 1", country: "france", priority: 5},
  {name: "serie a", country: "italy", priority: 2},
  {name: "champions league", country: "europe", priority: 6},
  {name: "europa league", country: "europe", priority: 7},
  {name: "eredivisie", country: "netherlands", priority: 8},
  {name: "primeira liga", country: "portugal", priority: 9},
  {name: "belgium first division a", country: "belgium", priority: 10},
]

comps.each do |comp|
  c = Competition.find_or_initialize_by(name: comp[:name], country: comp[:country])
  c.update(priority: comp[:priority]) unless c.persisted?
end

bookmakers = ["bet9ja", "nairabet", "betking", "sportybet"]
bookmakers.each do |bookmaker|
  Bookmaker.find_or_create_by(name: bookmaker)
end