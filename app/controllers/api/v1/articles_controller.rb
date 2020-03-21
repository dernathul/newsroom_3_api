class Api::V1::ArticlesController < ApplicationController
  def index
    binding.pry
    @articles = Article.all

  end
end