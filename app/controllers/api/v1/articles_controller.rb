class Api::V1::ArticlesController < ApplicationController
  def index
    @articles = Article.where(current: true)
    render json: @articles, status: :ok
  end
end
