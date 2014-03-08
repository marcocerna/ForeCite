angular.module('ForeCite')
.controller 'CatsCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.getCategories = (query) ->
    $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=100&titles=' + (query) + '&callback=JSON_CALLBACK'
    .then (resp) ->
      $scope.cats = resp.data.query.pages[_.first _.keys resp.data.query.pages].categories

      # Extra stuff: 1) Set searchQuery; 2) Set wiki link; 3) Remove "Category:" string
      $scope.$parent.searchQuery = query
      $scope.$parent.wikifiedQuery = "http://en.wikipedia.org/wiki/" + $scope.$parent.searchQuery.split(" ").join("_")
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