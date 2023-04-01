class Illustration < ApplicationRecord
  extend FriendlyId

  friendly_id :name, use: :slugged
  acts_as_taggable_on :tags

  has_one_attached :svg

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :svg, attached: true, content_type: "image/svg+xml",
                                  size: {
                                    less_than_or_equal_to: 100.kilobytes,
                                    message: :size_less_than_or_equal_to
                                  },
                                  on: :create
  validate :tags_blank

  scope :search, -> (q) do
    q = q.to_s
    where("LOWER(illustrations.name) LIKE ?", "%#{q.downcase}%")
      .or(where(id: search_by_tags(q).ids))
      .distinct
  end

  scope :search_by_tags, ->(q) do
    tagged_with(
      q.is_a?(Array) ? q : [q.to_s],
      on: :tags,
      wild: true,
      any: true
    )
  end

  private

  def tags_blank
    return unless tag_list.compact_blank.blank?

    errors.add(:tags, :blank)
  end
end
