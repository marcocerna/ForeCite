angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$location', 'Data', ($scope, $location, Data) ->
  $scope.getValidQuery = (button) ->
    $scope.button = button
    Data.getValidQuery($scope.search.query)
    .then (resp) ->
      $scope.search.results = resp.data

  $scope.executeButton = (query) ->
    $scope.search.results = null
    $scope.search.query = query
    $location.path("/" + $scope.button)

  $scope.clearSearch = ->
    $scope.search.query    = null
    $scope.search.results  = null
    $scope.button = ''
]
