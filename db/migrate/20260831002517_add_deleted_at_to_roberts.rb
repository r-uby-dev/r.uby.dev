# frozen_string_literal: true

class AddDeletedAtToRoberts < ActiveRecord::Migration[8.0]
  def change
    add_column :roberts, :deleted_at, :datetime
    add_index :roberts, :deleted_at
  end
end
