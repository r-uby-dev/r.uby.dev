# frozen_string_literal: true

class RemoveNilOwner < ActiveRecord::Migration[8.0]
  def change
    Raven::Agents::Robert
      .with_deleted
      .where(owner: nil)
      .map(&:really_destroy!)
  end
end
