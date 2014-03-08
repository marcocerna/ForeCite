angular.module('ForeCite')
.controller 'LinksCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.getLinks = ->
    $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'
    .success (data) ->
      $scope.links = data.query.pages[_.first _.keys data.query.pages].extlinks
      $scope.getDomains()
      $scope.$parent.divSelected = true

  $scope.getDomains = ->
    domainsList = []
    parser = document.createElement("a")
    for link in $scope.links
      link["*"] = "http:" + link["*"] if /^\/\//i.test(link["*"])
      parser.href = link["*"]
      domainsList.push parser.host
    $scope.domains = _.unique(domainsList)

  $scope.getLinks()
]