class LinksController < ApplicationController
include LinksHelper

def index
  @nokoTest = nokoTest
  @books = further_reading

  @book = Book.create
  @amazon_data = @book.batch_requests(["1590591526", "0789726122"])
  # binding.pry

end

end
