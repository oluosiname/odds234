class Event < ApplicationRecord
  belongs_to :competition
  has_many :odds, dependent: :destroy
end
