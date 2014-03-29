angular.module('ForeCite')
.controller 'BooksCtrl', ['$scope', 'Data', ($scope, Data) ->
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
]
