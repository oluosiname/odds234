# frozen_string_literal: true

class AddColumnStartsAtToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :starts_at, :datetime
  end
end
