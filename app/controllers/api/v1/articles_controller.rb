class Api::V1::ArticlesController < ApplicationController
  def index
    binding.pry
    articles = Article.all
    render json: { articles: articles },status: 200
  end
  binding.pry
end