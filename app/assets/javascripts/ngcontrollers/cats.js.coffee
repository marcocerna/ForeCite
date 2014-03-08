angular.module('ForeCite')
.controller 'CatsCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.getCategories = (query) ->
    ajaxReq = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=100&titles=' + (query) + '&callback=JSON_CALLBACK'
    ajaxReq.success (data) ->
      $scope.cats = data.query.pages[_.first _.keys data.query.pages].categories

      # Extra stuff: 1) Set searchQuery; 2) Set wiki link; 3) Remove "Category:" string
      ele = angular.element('#search-query')
      ele.scope().searchQuery = query
      ele.scope().wikifiedQuery = "http://en.wikipedia.org/wiki/" + ele.scope().searchQuery.split(" ").join("_")
      element.title = element.title.split(":").pop() for element in $scope.cats
      $scope.$parent.divSelected = true

  $scope.getTopics = (category) ->
    subcats = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=' + category + '&cmlimit=400&callback=JSON_CALLBACK'
    subcats.success (data) ->
      $scope.topics = data.query.categorymembers
      $scope.currentCategory = category.split(":").pop()

  $scope.init = ->
    $scope.getCategories($scope.searchQuery)

  $scope.init()
]