angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

  $scope.getValidQuery = (query, button) ->
    $scope.buttonSelected = button
    $http.get("/links/boss/" + query)
    .success (data) ->
      $scope.searchResults  = data

  $scope.executeButton = (query) ->
    $scope.searchResults = null
    $scope.searchQuery = query
    $location.path("/" + $scope.buttonSelected).replace()

  $scope.clearSearch = ->
    $scope.searchQuery    = null
    $scope.searchResults  = null
]
