class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles },status: 200
  end

  def create
    binding.pry
    @article = Article.new(article_params)
    if (@article == "")
      render json: {error: 'Title cant be blank!'}, status: 400

    
    else
      render json: { article: @article }, status: 200
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :snippet, :content)
  end

end