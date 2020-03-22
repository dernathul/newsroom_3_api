class Api::V1::ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: { articles: articles },status: 200
  end

  def create

    article = Article.create(article_params)
    if params[:title] == ""
      render json: {message: 'Im gonna stop you right there, you need to enter a title'}, status: 400
    elsif params[:snippet] == ""
      render json: {message: 'You dont think it is okay to leave the snippet blank, do you?'}, status: 400
    elsif params[:content] == ""
      render json: {message: 'What is an article without content? Add content and think about your life.'}, status: 400
    else
      render json: {message: 'Nice! Your article has been created'}, status: 200
    end

    if article.persisted?
      render json: { message: 'Your article was saved' }
    end

  end


  private
  
  def article_params
    params.permit(:title, :snippet, :content)
  end

end