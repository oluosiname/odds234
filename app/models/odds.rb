class Odds < ApplicationRecord
  belongs_to :event
  belongs_to :bookmaker
end
