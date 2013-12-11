app = angular.module "ForeCite", ["ngResource"]

app.controller 'LinksController', ($scope, $http, $resource) ->

  # Ajax call to wikipedia API for external links
  $scope.getExternalLinks = ->
    extlinks = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'

    extlinks.success (data) ->
      $scope.cats = null
      $scope.links = data.query.pages[_.first _.keys data.query.pages].extlinks
    .error (data) ->
      console.log 'ERROR'


  # Ajax call to wikipedia API for categories
  $scope.getCategories = ->
    categories = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=40&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'

    categories.success (data) ->
      $scope.links = null
      $scope.cats = data.query.pages[_.first _.keys data.query.pages].categories

      # This loop removes "Category:" from every string (added in html for the next API call)
      for element in $scope.cats
        newThing = element.title.split(":").pop()
        element.title = newThing

    .error (data) ->
      console.log 'ERROR'


  $scope.getSubcategories = (category) ->
    subcats = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=' + category + '&cmlimit=40&callback=JSON_CALLBACK'

    subcats.success (data) ->
      $scope.sublinks = data.query.categorymembers
    .error (data) ->
      console.log 'ERROR'

# wikiTest = Nokogiri::HTML(open("http://en.wikipedia.org/wiki/JavaScript"))
