class LinksController < ApplicationController
  include LinksHelper
  include Yahoo
  include AmazonSearch

  def index
    # @nokoTest = nokoTest
  end

  # This is called from Angular getReading function
  def search
    @books = further_reading(params[:q])
    render json: @books
  end

  def products
    puts "Products action has fired"
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

  def test
    render :test
  end

end
