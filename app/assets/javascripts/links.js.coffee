app = angular.module "ForeCite", ["ngResource"]

app.controller 'LinksController', ($scope, $http, $resource) ->

  $scope.clearButtons = ->
    $scope.linksSelected = false
    $scope.catsSelected = false
    $scope.booksSelected = false


  $scope.getExternalLinks = ->
    $scope.clearButtons()
    $scope.linksSelected = true

    extlinks = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'

    extlinks.success (data) ->
      $scope.cats = null
      $scope.links = data.query.pages[_.first _.keys data.query.pages].extlinks
    .error (data) ->
      console.log 'ERROR'



  $scope.getCategories = (query) ->
    $scope.clearButtons()
    $scope.catsSelected = true

    categories = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=100&titles=' + query + '&callback=JSON_CALLBACK'

    categories.success (data) ->
      $scope.links = null
      $scope.cats = data.query.pages[_.first _.keys data.query.pages].categories
      $scope.searchQuery = query
      $scope.sublinks = null

      # This loop removes "Category:" from every string
      for element in $scope.cats
        newThing = element.title.split(":").pop()
        element.title = newThing

    .error (data) ->
      console.log 'ERROR'


  $scope.getSubcategories = (category) ->
    subcats = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=' + category + '&cmlimit=400&callback=JSON_CALLBACK'

    subcats.success (data) ->
      $scope.sublinks = data.query.categorymembers
      $scope.currentCategory = category.split(":").pop()
    .error (data) ->
      console.log 'ERROR'


  $scope.getReading = ->
    $scope.clearButtons()
    $scope.booksSelected = true

    ajaxReq = $http.get("/links/search/" + $scope.searchQuery)

    ajaxReq.success (data) ->
      $scope.books = data
      $scope.getAmazon(data)
    .error (data) ->
      console.log 'ERROR'


  $scope.getAmazon = (books_array) ->

    # Convert books_array into isbn_array
    isbns = []
    for book in books_array
      isbn = book.split("ISBN")[1].replace("-", "").replace("-", "").replace("-", "").replace(".", "")
      isbns.push($.trim(isbn))

    # Ajax call to "/links/products/" + isbn_array
    isbn_string = isbns.join("-")
    ajaxReq = $http.get("/links/products/" + isbn_string)

    ajaxReq.success (data) ->
      $scope.amazons = data
    .error (data) ->
      console.log 'ERROR'


