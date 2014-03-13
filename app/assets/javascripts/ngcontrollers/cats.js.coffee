angular.module('ForeCite')
.controller 'CatsCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.getCategories = (query) ->
    $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=100&titles=' + query + '&callback=JSON_CALLBACK'
    .success (data) ->
      $scope.cats = data.query.pages[_.first _.keys data.query.pages].categories
      $scope.formatData(query)

  $scope.formatData = (query) ->
    $scope.search.query = query
    $scope.search.wiki = "http://en.wikipedia.org/wiki/" + $scope.search.query.split(" ").join("_")
    element.title = element.title.split(":").pop() for element in $scope.cats

  $scope.getTopics = (category) ->
    $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=' + category + '&cmlimit=400&callback=JSON_CALLBACK'
    .success (data) ->
      $scope.topics = data.query.categorymembers
      $scope.currentCategory = category.split(":").pop()

  $scope.getCategories($scope.search.query)
]