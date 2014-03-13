angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->

  $scope.search = {query: "", results: "" }

  $scope.getValidQuery = (query, button) ->
    $http.get("/links/boss/" + query)
    .success (data) ->
      $scope.search.results  = data

  $scope.executeButton = (query) ->
    $scope.search.results = null
    $scope.search.query = query
    $location.path("/" + button).replace()

  $scope.clearSearch = ->
    $scope.search.query    = null
    $scope.search.results  = null
]
