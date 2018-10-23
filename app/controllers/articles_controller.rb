require 'httpclient'

class ArticlesController < ApplicationController

  def index
  end


  def fetch_articles
    message = ArticlesService.new.fetch_articles(params[:tag])
    render(json: { message: "Articles created" }, status: 200)
  end


end
