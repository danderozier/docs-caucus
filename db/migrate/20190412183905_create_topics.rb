# frozen_string_literal: true

class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.string :slug, unique: true
      t.string :description
      t.string :ancestry
      t.integer :ancestry_depth, default: 0
      t.integer :visible_to, default: 0
      t.integer :editable_by, default: 0

      t.timestamps
    end
    add_index :topics, :slug
    add_index :topics, :ancestry
  end
end
