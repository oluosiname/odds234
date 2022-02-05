# frozen_string_literal: true

class Competition < ApplicationRecord
  has_many :events

  before_save :update_priorities

  def update_priorities
    return unless priority_changed?

    before_priority, after_priority = priority_change

    if !before_priority
      Competition.where('priority > ?', after_priority).where.not(id: id).find_each do |competition|
        competition.update_columns(priority: (competition.priority - 1))
      end
    elsif before_priority < after_priority
      Competition.where(priority: (before_priority..after_priority)).where.not(id: id).find_each do |competition|
        competition.update_columns(priority: (competition.priority - 1))
      end
    else
      Competition.where(priority: (after_priority..before_priority)).where.not(id: id).find_each do |competition|
        competition.update_columns(priority: (competition.priority + 1))
      end
    end
  end
end
