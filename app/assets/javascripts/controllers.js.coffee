angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$location', 'Data', ($scope, $location, Data) ->
  $location.path("/")

  $scope.getValidQuery = (button) ->
    $location.path("/")                             # Step 1: Reset path (so nothing from previous partials appears in ng-view)
    $scope.button = button                          # Step 2: Select button (so executeButton knows what route to take later)
    Data.getValidQuery($scope.search.query)         # Step 3: Get search results promise from Data factory
    .then (resp) ->
      $scope.search.results = resp.data             # Step 4: Add search results to scope

  $scope.executeButton = (query) ->
    $scope.search = {query: query}                  # Step 1: Replace query with search result (also erases search.results)
    $scope.search.wiki = query.split(" ").join("_") # Step 2: Add wiki link
    $location.path("/" + $scope.button)             # Step 3: Set path to button from previous function (also fires proper controller)

  $scope.clearSearch = ->
    $scope.search = {}
    $scope.button = null
]
