class AddForeignKeyToEvent < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :events, :competitions
  end
end
