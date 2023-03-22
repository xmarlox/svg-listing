desc "Avo acts-as-taggable-on integration"
task :add_taggings_and_tags do
  TAGS_CONTROLLER_TEMPLATE = <<~CONTENT
  # This controller has been generated to enable Rails' resource routes.
  # More information on https://docs.avohq.io/2.0/controllers.html
  class Avo::TagsController < Avo::ResourcesController
  end
  CONTENT
  TAGGINGS_CONTROLLER_TEMPLATE = <<~CONTENT
    # This controller has been generated to enable Rails' resource routes.
    # More information on https://docs.avohq.io/2.0/controllers.html
    class Avo::TaggingsController < Avo::ResourcesController
    end
  CONTENT
  TAG_RESOURCE_TEMPLATE = <<~CONTENT
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
  CONTENT
  TAGGING_RESOURCE_TEMPLATE = <<~CONTENT
    class TaggingResource < Avo::BaseResource
      self.title = :id
      self.includes = [:taggable]
      self.model_class = "::ActsAsTaggableOn::Tagging"

      field :id, as: :id
      field :tag, as: :belongs_to
      field :taggable, as: :belongs_to, polymorphic_as: :taggable, types: [::Illustration], readonly: true
    end
  CONTENT

  files = {
    "app/controllers/avo/tags_controller.rb": TAGS_CONTROLLER_TEMPLATE,
    "app/controllers/avo/taggings_controller.rb": TAGGINGS_CONTROLLER_TEMPLATE,
    "app/avo/resources/tag_resource.rb": TAG_RESOURCE_TEMPLATE,
    "app/avo/resources/tagging_resource.rb": TAGGING_RESOURCE_TEMPLATE
  }

  files.each do |path, content|
    File.write(path.to_s, content)
  end

  puts "Done! We added the resource and controller files."
  puts "If you're using the menu editor don't forget to add the resources to your menus."
  puts "\nresource :taggings\nresource :tags"
end
