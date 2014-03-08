angular.module('ForeCite')
.controller 'BooksCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.getBooks = ->
    ajaxReq = $http.get("/links/search/" + $scope.searchQuery)
    ajaxReq.success (data) ->
      $scope.books = data
      $scope.getAmazonBooks($scope.searchQuery)
      $scope.$parent.divSelected = true

  $scope.getAmazonBooks = (query) ->
    ajaxReq = $http.get("/links/amazon_search/" + query)
    ajaxReq.success (data) ->
      $scope.amazons = data

  $scope.getWikiBook = (book) ->
    isbn = book.split("ISBN")[1].replace("-", "").replace("-", "").replace("-", "").replace(".", "")
    ajaxReq = $http.get("/links/products/" + isbn)
    ajaxReq.success (data) ->
      $scope.currentWikiBook = data

  $scope.showBookTitle = (title) ->
    $scope.currentBookTitle = title

  $scope.init = ->
    $scope.amazons = null
    $scope.currentBookTitle = null
    $scope.getBooks()

  $scope.init()
]
