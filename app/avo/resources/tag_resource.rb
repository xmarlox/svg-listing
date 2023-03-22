class TagResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.model_class = "::ActsAsTaggableOn::Tag"

  field :id, as: :id
  field :name, as: :text
  field :taggings_count, as: :number, readonly: true
  field :created_at, as: :date_time, readonly: true
  field :taggings, as: :has_many, use_resource: "TaggingResource", through: :taggings
end
