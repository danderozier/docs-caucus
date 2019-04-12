# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.string :slug, unique: true
      t.text :content
      t.boolean :is_published, default: false
      t.boolean :is_public, default: false

      t.timestamps
    end
    add_index :pages, :slug
    add_index :pages, :is_published
  end
end
