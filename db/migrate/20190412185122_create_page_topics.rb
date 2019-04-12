# frozen_string_literal: true

class CreatePageTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :page_topics do |t|
      t.references :page, foreign_key: true
      t.references :topic, foreign_key: true

      t.timestamps
    end
    add_index :page_topics, %i[page_id topic_id], unique: true
  end
end
