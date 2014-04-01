angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$location', 'Data', ($scope, $location, Data) ->
  $location.path("/")

  $scope.getValidQuery = (button) ->
    $location.path("/")
    $scope.button = button
    Data.getValidQuery($scope.search.query)
    .then (resp) ->
      $scope.search.results = resp.data

  $scope.executeButton = (query) ->
    $scope.search = {query: query}
    $location.path("/" + $scope.button)

  $scope.clearSearch = ->
    $scope.search = {}
    $scope.button = ''
]
