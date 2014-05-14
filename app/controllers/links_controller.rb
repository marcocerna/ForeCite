class LinksController < ApplicationController
  include LinksHelper
  include Yahoo
  include AmazonSearch

  def index
  end

  def search
    @books = further_reading(params[:q])
    render json: @books
  end

  def products
    @book = Book.create
    @amazon_data = @book.batch_requests(params[:q].split("-"))
    render json: @amazon_data
  end

  def boss
    @results = boss_call(params[:q])
    render json: @results
  end

  def amazon_search
    @book_search = amazon_book_search(params[:q])
    render json: @book_search
  end

  # def domain
  #   @domain_name = Pismo[params[:q]].title
  #   render json: @domain_name
  # end

end
