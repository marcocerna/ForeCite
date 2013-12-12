require 'nokogiri'
require 'open-uri'
require 'pry'

module LinksHelper

def nokoTest

  wikiTest = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/JavaScript'))

  @array_of_stuff = []

  wikiTest.css('ol.references').children().each do |link|
    @array_of_stuff.push(link)
  end

  @array_of_stuff
end



def further_reading

  # Grab wikipedia page from Heroku
  books_list = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/JavaScript'))

  @books = []

  # Push all elements from Further Reading into array (text only)
  books_list.css('div.refbegin').children().children().each do |item|
    @books.push(item.text)
  end

  # Remove empty strings so we don't get extra 'li' elements
  @books.delete("\n")

  # Grab ISBNs and shove them into an array
  @isbns = []
  @books.each do |book|
    isbn = book.split("ISBN")[1]
    @isbns.push(isbn.delete("."))
  end


  # Grab titles and shove them into an array
  @titles = []
  @books.each do |book|
    title = book.split(").")[1].split(".")[0]
    @titles.push(title)
  end


  # Return the correct thing for the HTML!
  @books
end


end
