# frozen_string_literal: true

class RenameMuninnsToRoberts < ActiveRecord::Migration[8.0]
  def change
    rename_table :muninns, :roberts
  end
end