# frozen_string_literal: true

class Page < ApplicationRecord
  include Sluggable

  # Callbacks
  after_initialize :default_title

  # User Roles
  resourcify

  # Slugs
  friendly_id :title

  # Associations
  has_many :page_topics
  has_many :topics, through: :page_topics

  # Validations
  validates :title, length: { maximum: 100 }
  validates :is_published, :is_public, inclusion: { in: [true, false] }
  validates :topics, presence: true,
                     if: proc { |p| p.is_published? || p.is_public? }
  validates :is_published, inclusion: { in: [true] },
                           if: proc { |p| p.is_public? }

  # Set default title
  #
  def default_title
    self.title ||= 'Untitled Page'
  end
end
