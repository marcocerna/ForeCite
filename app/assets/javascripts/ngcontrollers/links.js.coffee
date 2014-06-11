angular.module('ForeCite')
.controller 'LinksCtrl', ['$scope', 'WikiFactory', ($scope, WikiFactory) ->
  WikiFactory.getLinks($scope.search.query)
  .then (resp) ->
    $scope.links = resp.data.query.pages[_.first _.keys resp.data.query.pages].extlinks
    $scope.getDomains()

  $scope.getDomains = ->
    domainsList = []
    parser = document.createElement("a")
    for link in $scope.links
      link["*"] = "http:" + link["*"] if /^\/\//i.test(link["*"])
      parser.href = link["*"]
      domainsList.push parser.host
    $scope.domains = _.unique(domainsList)
]

