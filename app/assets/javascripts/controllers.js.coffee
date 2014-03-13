angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

  $scope.search = {query: "", results: "" }

  $scope.$watch 'search.query', ->
    console.log($scope.search.query)

  $scope.getValidQuery = (query, button) ->
    $scope.buttonSelected = button
    $http.get("/links/boss/" + query)
    .success (data) ->
      $scope.search.results  = data

  $scope.executeButton = (query) ->
    $scope.search.results = null
    $scope.search.query = query
    $location.path("/" + $scope.buttonSelected).replace()

  $scope.clearSearch = ->
    $scope.search.query    = null
    $scope.search.results  = null
]
