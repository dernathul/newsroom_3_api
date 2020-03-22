class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles },status: 200
  end

  def create
    binding.pry
    article = Article.create(article_params)

  end

  private
  
  def article_params
    params.permit(:title, :snippet, :content)
  end

end