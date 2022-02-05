# frozen_string_literal: true

class Event < ApplicationRecord
  include Uidable

  belongs_to :competition
  has_many :odds, dependent: :destroy

  validates :home_team, presence: true
  validates :away_team, presence: true

  scope :future, -> { where('starts_at > ?', Time.zone.now).order(:starts_at) }

  scope :past, -> { where('starts_at < ?', 2.days.ago) }

  scope :by_competition, ->(competition_name) {
    joins(:competition).where('LOWER(competitions.name) =  ?', competition_name.downcase)
  }

  scope :by_country, ->(country) {
    joins(:competition).where('LOWER(competitions.country) =  ?', country.downcase)
  }

  scope :by_team, ->(search) {
    where('LOWER(home_team) LIKE  ? OR LOWER(away_team) LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%")
  }

  scope :by_date, ->(date) { where('DATE(starts_at) = ?', date) }

  def set_top_odds
    home = odds.maximum(:home)
    draw = odds.maximum(:draw)
    away = odds.maximum(:away)

    update(top_odds: { home: home, draw: draw, away: away })
  end

  delegate :name, to: :competition, prefix: true

  def true_date
    return 'Today' if starts_at.to_date == Date.today

    starts_at.strftime('%-d %b')
  end
end
