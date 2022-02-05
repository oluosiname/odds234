# frozen_string_literal: true

class AddPriorityToCompetitions < ActiveRecord::Migration[6.1]
  def change
    add_column :competitions, :priority, :integer
  end
end
