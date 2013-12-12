app = angular.module "ForeCite", ["ngResource"]

app.controller 'LinksController', ($scope, $http, $resource) ->

  # Ajax call to wikipedia API for external links
  $scope.getExternalLinks = ->
    extlinks = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'

    extlinks.success (data) ->
      $scope.cats = null
      $scope.links = data.query.pages[_.first _.keys data.query.pages].extlinks
    .error (data) ->
      console.log 'ERROR'


  # Ajax call to wikipedia API for categories
  $scope.getCategories = ->
    categories = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=40&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'

    categories.success (data) ->
      $scope.links = null
      $scope.cats = data.query.pages[_.first _.keys data.query.pages].categories

      # This loop removes "Category:" from every string (added in html for the next API call)
      for element in $scope.cats
        newThing = element.title.split(":").pop()
        element.title = newThing

    .error (data) ->
      console.log 'ERROR'


  $scope.getSubcategories = (category) ->
    subcats = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=' + category + '&cmlimit=40&callback=JSON_CALLBACK'

    subcats.success (data) ->
      $scope.sublinks = data.query.categorymembers
    .error (data) ->
      console.log 'ERROR'


  $scope.getReading = ->
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
      debugger
    .error (data) ->
      console.log 'ERROR'

      # Fix up controller methods to flow right


    # ajax success -> $scope.amazon = data



