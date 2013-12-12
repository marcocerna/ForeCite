class LinksController < ApplicationController
include LinksHelper

def index
  @nokoTest = nokoTest
  @book = Book.create
  @amazon_data = @book.batch_requests(["1590591526", "0789726122"])
end

# This is called from Angular getReading function
def search
  @books = further_reading(params[:q])

  render json: @books
end


end
