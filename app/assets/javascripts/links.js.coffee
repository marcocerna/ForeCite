app = angular.module "ForeCite", ["ngResource"]

app.controller 'LinksController', ($scope, $http, $resource) ->

  # Ajax call to wikipedia API for external links
  $scope.getExternalLinks = ->
    extlinks = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'

    extlinks.success (data) ->
         console.log data
         $scope.links = data.query.pages[_.first _.keys data.query.pages].extlinks
      .error (data) ->
         console.log 'ERROR'


  # Ajax call to wikipedia API for categories
  $scope.getCategories = ->
    categories = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=40&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'

    categories.success (data) ->
         console.log data
         $scope.links = data.query.pages[_.first _.keys data.query.pages].categories
      .error (data) ->
         console.log 'ERROR'

  $scope.getSubcategories = (category) ->
    console.log "Subcategories!"
    console.log category
    subcats = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=' + category + '&cmlimit=40&callback=JSON_CALLBACK'

    subcats.success (data) ->
         console.log data
         # debugger
         $scope.sublinks = data.query.categorymembers
         console.log "$scope.sublinks :"
         console.log $scope.sublinks
      .error (data) ->
         console.log 'ERROR'

