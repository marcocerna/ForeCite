angular.module('ForeCite')
.controller 'BooksCtrl', ['$scope', 'DataFactory', ($scope, DataFactory) ->
  DataFactory.getBooks($scope.search.query)
  .then (resp) ->
    $scope.books = resp.data

  DataFactory.getAmazonBooks($scope.search.query)
  .then (resp) ->
    $scope.amazons = resp.data

  $scope.getWikiBook = (book) ->
    DataFactory.getWikiBook(book)
    .then (resp) ->
      $scope.currentWikiBook = resp.data[0]
]