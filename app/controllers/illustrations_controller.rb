class IllustrationsController < ApplicationController
  def index
    @illustrations = Illustration.all

    if (q = search_params[:q]).present?
      @illustrations = @illustrations.search(q)
    elsif search_params.key?(:q)
      @illustrations = []
    end
  end

  def search; end

  private

  def search_params
    params.permit(:q)
  end
end
