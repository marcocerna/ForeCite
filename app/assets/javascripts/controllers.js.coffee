angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$location', 'Data', ($scope, $location, Data) ->
  $location.path("/")

  $scope.getValidQuery = (setButton) ->
    $location.path("/")                             # Step 1: Reset path (so nothing from previous partials appears in ng-view)
    $scope.button = setButton                       # Step 2: Select button (so executeButton knows what route to take later)
    Data.getValidQuery($scope.search.query)         # Step 3: Get search results promise from Data factory
    .then (resp) ->
      $scope.search.results = resp.data

  $scope.executeButton = (setQuery) ->
    $scope.search = {query: setQuery}               # Replace query with search result (also erases search.results)
    $scope.search.wiki = setQuery.split(" ").join("_")
    $location.path("/" + $scope.button)             # Set path to button from previous function (also fires proper controller)

  $scope.clearSearch = ->
    $scope.search = {}
    $scope.button = null
]
