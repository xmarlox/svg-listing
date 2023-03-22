class Illustration < ApplicationRecord
  extend FriendlyId

  has_one_attached :svg, dependent: :purge_later

  acts_as_taggable_on :tags
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
end
