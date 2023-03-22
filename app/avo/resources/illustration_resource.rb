class IllustrationResource < Avo::BaseResource
  self.title = :slug
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end
  self.resolve_find_scope = ->(model_class:) do
    model_class.friendly
  end

  field :id, as: :id
  field :name, as: :text
  field :svg, as: :file, accept: "image/svg+xml"
  field :tags, as: :tags, acts_as_taggable_on: :tags
end