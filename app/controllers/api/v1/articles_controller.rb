class Api::V1::ArticlesController < ApplicationController
  def index
    ArticleDataService.new.fecth_data
    @articles = Article.where(current: true)
    render json: @articles, status: :ok
  end
end
