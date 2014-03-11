angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$http', '$resource', '$location', ($scope, $http, $resource, $location) ->

  $scope.getValidQuery = (query, button) ->
    $scope.buttonSelected = button
    $http.get("/links/boss/" + query)
    .success (data) ->
      $scope.searchResults  = data
      $scope.cats           = null
      $scope.topics         = null

  $scope.executeButton = (query) ->
    $scope.searchResults = null
    $scope.searchQuery = query
    $location.path("/" + $scope.buttonSelected).replace()

  $scope.clearSearch = ->
    $scope.searchQuery    = null
    $scope.searchResults  = null
]
