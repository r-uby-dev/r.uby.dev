# frozen_string_literal: true

class AddOwnerToRoberts < ActiveRecord::Migration[8.0]
  def change
    add_column :roberts, :owner, :string
  end
end