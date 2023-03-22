class TaggingResource < Avo::BaseResource
  self.title = :id
  self.includes = [:taggable]
  self.model_class = "::ActsAsTaggableOn::Tagging"

  field :id, as: :id
  field :tag, as: :belongs_to
  field :taggable, as: :belongs_to, polymorphic_as: :taggable, types: [::Illustration], readonly: true
end
