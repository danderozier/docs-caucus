# frozen_string_literal: true

class Topic < ApplicationRecord
  include Sluggable

  # User Roles
  resourcify

  # Slugs
  friendly_id :title

  # Associations
  has_many :page_topics
  has_many :pages, through: :page_topics

  # Ancestry
  has_ancestry orphan_strategy: :adopt, cache_depth: true

  # Attributes
  enum visible_to: %i[owners members all], _prefix: true
  enum editable_by: %i[owners members all], _prefix: true

  # Validations
  validates :title, presence: true
  validates :title, uniqueness: { scope: :ancestry, message: 'must be unique' }
  validate :parent_has_greater_permissions,
           if: proc { |t| t.ancestry.present? }

  # Ensure that a child topic can't have greater visibility than its parent.
  # Yes, the pluralization of "editable_by" is disgusting.
  def parent_has_greater_permissions
    unless Topic.visible_tos[parent.visible_to] >= Topic.visible_tos[visible_to]
      errors.add :visible_to, 'can’t be greater than parent'
    end
    unless Topic.editable_bies[parent.editable_by] >= Topic.editable_bies[editable_by]
      errors.add :editable_by, 'can’t be greater than parent'
    end
  end
end
