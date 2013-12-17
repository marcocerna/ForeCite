ForeCiteControllers = angular.module('ForeCite.controllers', [])

# This is for testing only
# Maybe use it for a welcome page later
ForeCiteControllers.controller "HelloCtrl", ($scope) ->
  $scope.greeting = "hello!!! welcome!"

ForeCiteControllers.controller 'LinksController', ($scope, $http, $resource, $location) ->

  $scope.clearAll = ->
    $scope.linksSelected = false
    $scope.catsSelected = false
    $scope.booksSelected = false

  $scope.getValidQuery = (query, button) ->
    $scope.buttonSelected = button
    ajaxReq = $http.get("/links/boss/" + query)

    ajaxReq.success (data) ->
      $scope.searchResults = true
      $scope.clearAll()
      $scope.validQueries = data

  $scope.executeButton = (query) ->
    $scope.searchQuery = query
    $scope.getLinks()                         if $scope.buttonSelected == "links"
    $scope.getCategories($scope.searchQuery)  if $scope.buttonSelected == "categories"
    $scope.getBooks()                         if $scope.buttonSelected == "books"
    $scope.searchResults = false

  $scope.getLinks = ->
    $scope.linksSelected = true

    extlinks = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'
    extlinks.success (data) ->
      $scope.links = data.query.pages[_.first _.keys data.query.pages].extlinks
      $location.path("/links").replace()
      $scope.$apply()

  $scope.getCategories = (query) ->
    $scope.catsSelected = true

    categories = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=100&titles=' + (query) + '&callback=JSON_CALLBACK'
    categories.success (data) ->
      $scope.cats = data.query.pages[_.first _.keys data.query.pages].categories
      $scope.searchQuery = query
      $scope.wikifiedQuery = "http://en.wikipedia.org/wiki/" + $scope.searchQuery.split(" ").join("_")
      $location.path("/categories").replace()
      $scope.$apply()

      for element in $scope.cats                     # This loop removes "Category:" from every string
        newThing = element.title.split(":").pop()
        element.title = newThing

  $scope.getTopics = (category) ->
    subcats = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=' + category + '&cmlimit=400&callback=JSON_CALLBACK'
    subcats.success (data) ->
      $scope.topics = data.query.categorymembers
      $scope.currentCategory = category.split(":").pop()

  $scope.getBooks = ->
    $scope.booksSelected = true
    $scope.amazons = null
    $scope.currentBookTitle = null

    ajaxReq = $http.get("/links/search/" + $scope.searchQuery)
    ajaxReq.success (data) ->
      $scope.books = data
      $scope.amazonSearch($scope.searchQuery)
      $location.path("/books").replace()
      $scope.$apply()

  $scope.getAmazon = (books_array) ->                 # Refactor: Clean this up since we're now only sending one, not an array
    isbns = []
    for book in books_array
      isbn = book.split("ISBN")[1].replace("-", "").replace("-", "").replace("-", "").replace(".", "")
      isbns.push($.trim(isbn))
    isbn_string = isbns.join("-")

    ajaxReq = $http.get("/links/products/" + isbn_string)
    ajaxReq.success (data) ->
      $scope.currentWikiBook = data

  $scope.showBookTitle = (title) ->
    $scope.currentBookTitle = title

  $scope.amazonSearch = (query) ->
    ajaxReq = $http.get("/links/amazon_search/" + query)
    ajaxReq.success (data) ->
      $scope.amazons = data
