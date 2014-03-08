angular.module('ForeCite')
.controller 'BooksCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.getBooks = ->
    $http.get("/links/search/" + $scope.searchQuery)
    .success (data) ->
      $scope.books = data
      $scope.getAmazonBooks($scope.searchQuery)
      $scope.$parent.divSelected = true

  $scope.getAmazonBooks = (query) ->
    $http.get("/links/amazon_search/" + query)
    .success (data) ->
      $scope.amazons = data

  $scope.getWikiBook = (book) ->
    isbn = book.split("ISBN")[1].replace("-", "").replace("-", "").replace("-", "").replace(".", "")
    $http.get("/links/products/" + isbn)
    .success (data) ->
      $scope.currentWikiBook = data

  $scope.showBookTitle = (title) ->
    $scope.currentBookTitle = title

  $scope.init = ->
    $scope.amazons = null
    $scope.currentBookTitle = null
    $scope.getBooks()

  $scope.init()
]
