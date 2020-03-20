class Api::V1::ArticlesController < ApplicationController
  def index
    article = Articles.new(params[:article_index])
    if article.save
    end
end