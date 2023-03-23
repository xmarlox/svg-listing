# This controller has been generated to enable Rails' resource routes.
# More information on https://docs.avohq.io/2.0/controllers.html
class Avo::IllustrationsController < Avo::ResourcesController
  private

  def model_params
    processed_params = super

    processed_params.each do |key, val|
      next if key.to_sym != :tags || val.blank?

      processed_params[:tags] = JSON.parse(val).map do |tag|
        tag.values.first
      end.join(",")
    end

    processed_params
  end
end
