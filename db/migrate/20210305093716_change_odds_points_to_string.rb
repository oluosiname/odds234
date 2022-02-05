# frozen_string_literal: true

class ChangeOddsPointsToString < ActiveRecord::Migration[6.1]
  def change
    change_column :odds, :home, :string
    change_column :odds, :away, :string
    change_column :odds, :draw, :string
  end
end
