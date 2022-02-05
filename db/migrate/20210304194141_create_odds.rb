# frozen_string_literal: true

class CreateOdds < ActiveRecord::Migration[6.1]
  def change
    create_table :odds do |t|
      t.belongs_to :event, foreign_key: true
      t.belongs_to :bookmaker, foreign_key: true
      t.float :home
      t.float :draw
      t.float :away
      t.timestamps
    end
  end
end
