angular.module('ForeCite')
.controller 'CatsCtrl', ['$scope', 'Wiki', ($scope, Wiki) ->
  $scope.getCategories = (query = $scope.search.query) ->
    Wiki.getCategories(query)
    .then (resp) ->
      $scope.cats = resp.data.query.pages[_.first _.keys resp.data.query.pages].categories
      $scope.search.wiki = "http://en.wikipedia.org/wiki/" + $scope.search.query.split(" ").join("_")
      element.title = element.title.split(":").pop() for element in $scope.cats

  $scope.getTopics = (category) ->
    Wiki.getTopics(category)
    .then (resp) ->
      $scope.topics = resp.data.query.categorymembers
      $scope.currentCategory = category

  $scope.getCategories()
]