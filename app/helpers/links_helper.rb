require 'nokogiri'
require 'open-uri'

module LinksHelper

  def further_reading(query)

    # Grab wikipedia page from Heroku
    query = query.split(" ").join("_")
    books_list = Nokogiri::HTML(open('http://en.wikipedia.org/wiki/' + query))
    @books = []

    # Push all elements from Further Reading into array (text only)
    books_list.css('div.refbegin').children.children.each do |item|
      @books.push(item.text)
    end

    # Remove empty strings so we don't get extra 'li' elements
    @books.delete("\n")

    # Return the correct thing for the HTML!
    @books
  end


  def get_isbns(books)

    # Grab ISBNs and shove them into an array
    @isbns = []
    @books.each do |book|
      isbn = book.split("ISBN")[1]
      @isbns.push(isbn.delete("."))
    end

    @isbns
  end
end
