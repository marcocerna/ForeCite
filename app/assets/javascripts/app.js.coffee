angular.module("ForeCite", ['ngRoute'])

.config(['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/',            {templateUrl: '/partials/landing.html.erb',     controller: 'AppCtrl'})
    .when('/links',       {templateUrl: '/partials/links.html.erb',       controller: 'LinksCtrl'})
    .when('/categories',  {templateUrl: '/partials/categories.html.erb',  controller: 'CatsCtrl'})
    .when('/books',       {templateUrl: '/partials/books.html.erb',       controller: 'BooksCtrl'})
    .otherwise({redirectTo: '/'})
])

.factory 'Wiki', ['$http', ($http) ->
  return {
    getCategories: (query) ->
      return $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=100&titles=' + query + '&callback=JSON_CALLBACK'
    getTopics: (category) ->
      return $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=Category:' + category + '&cmlimit=400&callback=JSON_CALLBACK'
    getLinks: (query) ->
      return $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + query + '&callback=JSON_CALLBACK'

  }
]

.factory 'Data', ['$http', ($http) ->
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