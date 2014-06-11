angular.module("ForeCite")

.factory 'WikiFactory', ['$http', ($http) ->
  return {
    getCategories: (query) ->
      return $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=100&titles=' + query + '&callback=JSON_CALLBACK'
    getTopics: (category) ->
      return $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=Category:' + category + '&cmlimit=400&callback=JSON_CALLBACK'
    getLinks: (query) ->
      return $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + query + '&callback=JSON_CALLBACK'

  }
]

.factory 'DataFactory', ['$http', ($http) ->
  return {
    getValidQuery: (query) ->
      return $http.get "/links/boss/" + query
    getBooks: (query) ->
      return $http.get "/links/search/" + query
    getAmazonBooks: (query) ->
      return $http.get "/links/amazon_search/" + query
    getWikiBook: (book) ->
      isbn = book.split("ISBN")[1].replace("-", "").replace("-", "").replace("-", "").replace(".", "")
      return $http.get "/links/products/" + isbn
  }
]