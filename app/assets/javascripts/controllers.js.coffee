angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$http', '$resource', '$location', ($scope, $http, $resource, $location) ->

  $scope.getValidQuery = (query, button) ->
    $scope.buttonSelected = button
    ajaxReq = $http.get("/links/boss/" + query)
    ajaxReq.success (data) ->
      $scope.searchResults  = true
      $scope.divSelected    = false
      $scope.validQueries   = data
      $scope.cats           = null
      $scope.topics         = null

  $scope.executeButton = (query) ->
    $scope.searchQuery = query
    $location.path("/" + $scope.buttonSelected).replace()
    $scope.searchResults = false

  $scope.returnToLanding = ->
    $scope.searchQuery    = null
    $scope.searchResults  = null
]
