angular.module('ForeCite')
.controller 'BooksCtrl', ['$scope', '$http', '$resource', '$location', ($scope, $http, $resource, $location) ->

  $scope.getBooks = ->
    # app.divSelected = false
    $scope.amazons = null
    $scope.currentBookTitle = null

    ajaxReq = $http.get("/links/search/" + $scope.searchQuery)
    ajaxReq.success (data) ->
      $scope.books = data
      $scope.getAmazonBooks($scope.searchQuery)
      $scope.$parent.divSelected = true

  $scope.getAmazonBooks = (query) ->
    ajaxReq = $http.get("/links/amazon_search/" + query)
    ajaxReq.success (data) ->
      $scope.amazons = data

  $scope.getWikiBook = (books_array) ->                 # Refactor: Clean this up since we're now only sending one, not an array
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

  $scope.init = ->
    $scope.getBooks()

  $scope.init()
]
