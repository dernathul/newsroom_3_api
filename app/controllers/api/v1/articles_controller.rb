class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles },status: 200
  end

  def create

    article = Article.create(article_params)
    
    if article.persisted?
      render json: { message: 'Your article was saved' }, status: 200
    else 
      render json: { message: 'Your article could not be saved'}, status: 206
    end

 
  end


  private
  
  def article_params
    params.permit(:title, :snippet, :content)
  end

end