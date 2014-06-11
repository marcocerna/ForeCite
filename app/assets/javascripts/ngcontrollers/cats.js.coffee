angular.module('ForeCite')
.controller 'CatsCtrl', ['$scope', 'WikiFactory', ($scope, WikiFactory) ->
  $scope.getCategories = (query = $scope.search.query) ->
    WikiFactory.getCategories(query)
    .then (resp) ->
      $scope.cats = resp.data.query.pages[_.first _.keys resp.data.query.pages].categories
      $scope.search.wiki = $scope.search.query.split(" ").join("_")
      category.title = category.title.split(":").pop() for category in $scope.cats

  $scope.getTopics = (category) ->
    WikiFactory.getTopics(category)
    .then (resp) ->
      $scope.topics = resp.data.query.categorymembers
      $scope.currentCategory = category

  $scope.getCategories()
]