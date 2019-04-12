class PageTopic < ApplicationRecord
  belongs_to :page
  belongs_to :topic
end
