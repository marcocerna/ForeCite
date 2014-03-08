angular.module('ForeCite')
.controller 'LinksCtrl', ['$scope', '$http', '$resource', '$location', ($scope, $http, $resource, $location) ->

  $scope.getLinks = ->
    ajaxReq = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'
    ajaxReq.success (data) ->
      $scope.links = data.query.pages[_.first _.keys data.query.pages].extlinks

      # Extra stuff: Get domains
      domainsList = []
      parser = document.createElement("a")
      for link in $scope.links
        link["*"] = "http:" + link["*"] if /^\/\//i.test(link["*"])
        parser.href = link["*"]
        domainsList.push parser.host
      $scope.domains = _.unique(domainsList)
      $scope.divSelected = true

  $scope.init = ->
    console.log "LinksCtrl works!"
    $scope.getLinks()

  $scope.init()
]