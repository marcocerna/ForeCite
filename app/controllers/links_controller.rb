class LinksController < ApplicationController
include LinksHelper
require 'pry'

def index
  @nokoTest = nokoTest
  @books = further_reading
end

end
