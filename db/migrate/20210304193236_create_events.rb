class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :uid, index: true, unique: true
      t.string :home_team, index: true
      t.string :away_team, index: true
      t.json :top_odds
      t.date :date
      t.time :kickoff
      t.belongs_to :competition
      t.timestamps
    end
  end
end
