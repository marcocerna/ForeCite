angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$location', 'DataFactory', ($scope, $location, DataFactory) ->
  $location.path("/")

  $scope.getValidQuery = (setButton) ->
    $location.path("/")                             # Step 1: Reset path (so nothing from previous partials appears in ng-view)
    $scope.button = setButton                       # Step 2: Select button (so executeButton knows what route to take later)
    DataFactory.getValidQuery($scope.search.query)         # Step 3: Get search results promise from Data factory
    .then (resp) ->
      $scope.search.results = resp.data

  $scope.executeButton = (setQuery) ->
    $scope.search = query: setQuery, wiki: setQuery.split(" ").join("_")  # Replace query with selection (also erases search.results)
    $location.path("/" + $scope.button)                                   # Set path to button (which fires proper controller)

  $scope.clearSearch = ->
    $scope.search = {}
    $scope.button = null
]
