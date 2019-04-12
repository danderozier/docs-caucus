# frozen_string_literal: true

module Sluggable
  extend ActiveSupport::Concern

  included do
    extend FriendlyId

    # If a custom slug is provided, ensure it's formatted correctly.
    # Otherwise, friendly_id will generate the slug for us.
    validates :slug,
              format: {
                with: /\A[a-z0-9-]+\z/,
                message: 'only allows lowercase letters, numbers, and dashes'
              },
              allow_blank: true

    def should_generate_new_friendly_id?
      slug.blank?
    end
  end
end
