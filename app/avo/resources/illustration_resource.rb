class IllustrationResource < Avo::BaseResource
  # self.default_view_type = :grid
  self.after_create_path = :index

  self.title = :slug
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end
  self.resolve_find_scope = ->(model_class:) do
    model_class.friendly
  end

  field :slug, as: :id
  field :name, as: :text, required: true
  field :svg, as: :inline_svg, required: true, accept: "image/svg+xml"
  field :tags, as: :tags, required: true, acts_as_taggable_on: :tags
end
