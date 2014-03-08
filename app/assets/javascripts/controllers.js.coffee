# Using getter, putting it in var because that'll (hopefully) get multiple Ctrl to work
# In future, try to have Ctrls act on module directly

angular.module('ForeCite')
.controller 'AppCtrl', ['$scope', '$http', '$resource', '$location', ($scope, $http, $resource, $location) ->

  $scope.getValidQuery = (query, button) ->
    $scope.buttonSelected = button
    ajaxReq = $http.get("/links/boss/" + query)
    ajaxReq.success (data) ->
      $scope.searchResults  = true
      $scope.divSelected    = false
      $scope.validQueries   = data
      $scope.cats = null
      $scope.topics = null

  $scope.executeButton = (query) ->
    $scope.searchQuery = query
    $location.path("/links").replace()        if $scope.buttonSelected == "links"
    $location.path("/categories").replace()   if $scope.buttonSelected == "categories"
    $location.path("/books").replace()        if $scope.buttonSelected == "books"
    $scope.searchResults = false

  # This is where the scope got all wonky. Investigate what's happening with scope levels here.
  $scope.returnToLanding = ->
    ele = angular.element('#search-query')
    ele.scope().searchQuery = null
    ele.scope().searchResults = null
]
