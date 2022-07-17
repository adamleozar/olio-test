class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: %i[update]

  def index
    ArticleDataService.new.fecth_data
    @articles = Article.where(current: true).order("created_at DESC")
    render json: @articles, status: :ok
  end

  def update
    if @article.update(liked: permissible_params[:liked])
      render json: @article, status: :ok
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  private

  def set_article
    @article = Article.find(permissible_params[:id])
  end

  def permissible_params
    params.require(:article).permit(:id, :liked)
  end
end
