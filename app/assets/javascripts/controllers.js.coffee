angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$http', '$resource', '$location', ($scope, $http, $resource, $location) ->

  $scope.getValidQuery = (query, button) ->
    $scope.buttonSelected = button
    ajaxReq = $http.get("/links/boss/" + query)
    ajaxReq.success (data) ->
      $scope.searchResults  = data
      $scope.divSelected    = false
      $scope.cats           = null
      $scope.topics         = null

  $scope.executeButton = (query) ->
    $scope.searchQuery = query
    $location.path("/" + $scope.buttonSelected).replace()
    $scope.searchResults = null

  $scope.returnToLanding = ->
    $scope.searchQuery    = null
    $scope.searchResults  = null
]
