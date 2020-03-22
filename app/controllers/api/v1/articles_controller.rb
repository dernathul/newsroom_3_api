class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles },status: 200
  end

  def create

    # if @article.persisted?
    #   binding.pry
    #   render json: { message: 'Very done!' }
    # else
    #   binding.pry
    # end

    article = Article.create(article_params)
    if params[:title] == ""
      render json: {message: 'Im gonna stop you right there'}, status: 400
    end
  end


  private
  
  def article_params
    params.permit(:title, :snippet, :content)
  end

end