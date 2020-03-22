class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles },status: 200
  end

  # def create
  #   article = Article.new(article_params)
  #   if article.new_record?
  #     article.save
  #     if article.persisted?
  #       render json: { message: 'Your article is ready for review.' }, status: 200
  #     else
  #       render json: { message: 'Your article was not saved.' }, status: 400
  #     end
  #   end
  # end

  def create
    @article = Article.new(params[:article])
    render json: { article: @article },status: 200
    
    if @article.save
      redirect_to @article, :notice => "Article was successfully created."
    else
      return "blarrggh"     
    end
  
  end

  private
  
  def article_params
    params.permit(:title, :snippet, :content)
  end

end