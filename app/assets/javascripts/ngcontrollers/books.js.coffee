angular.module('ForeCite')
.controller 'BooksCtrl', ['$scope', '$http', 'Data', ($scope, $http, Data) ->

  $scope.amazons = null
  $scope.currentBookTitle = null

  Data.getBooks($scope.search.query)
  .then (resp) ->
    $scope.books = resp.data

  Data.getAmazonBooks($scope.search.query)
  .then (resp) ->
    $scope.amazons = resp.data

  $scope.getWikiBook = (book) ->
    Data.getWikiBook(book)
    .then (resp) ->
      $scope.currentWikiBook = resp.data

  $scope.showBookTitle = (title) ->
    $scope.currentBookTitle = title
]
