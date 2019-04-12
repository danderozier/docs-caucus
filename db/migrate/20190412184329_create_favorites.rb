# frozen_string_literal: true

class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :page, foreign_key: true

      t.timestamps
    end
    add_index :favorites, %i[user_id page_id], unique: true
  end
end
