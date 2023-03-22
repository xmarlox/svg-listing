# This controller has been generated to enable Rails' resource routes.
# More information on https://docs.avohq.io/2.0/controllers.html
class Avo::IllustrationsController < Avo::ResourcesController

  private

  def illustration_params
    params.require(:illustration).permit(:name, :svg, tag_list: [])
  end
end
