class Event < ApplicationRecord
  include Uidable

  belongs_to :competition
  has_many :odds, dependent: :destroy

  def set_top_odds
    home = odds.maximum(:home)
    draw = odds.maximum(:draw)
    away = odds.maximum(:away)

    self.update(top_odds: { home: home, draw: draw, away: away })
  end
end
