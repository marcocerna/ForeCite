class LinksController < ApplicationController
include LinksHelper

def index
  @nokoTest = nokoTest
  @books = further_reading

  @book = Book.create

  @title = @book.get_title(1590591526)
  @image = @book.get_image(1590591526)

end

end
