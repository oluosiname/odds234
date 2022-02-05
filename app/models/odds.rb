# frozen_string_literal: true

class Odds < ApplicationRecord
  belongs_to :event
  belongs_to :bookmaker
end
