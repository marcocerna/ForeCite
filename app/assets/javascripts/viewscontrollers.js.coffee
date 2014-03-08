app = angular.module('ForeCite')

app.controller 'LinksCtrl', ['$scope', '$http', '$resource', '$location', ($scope, $http, $resource, $location) ->

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

app.controller 'BooksCtrl', ['$scope', '$http', '$resource', '$location', ($scope, $http, $resource, $location) ->

  $scope.getBooks = ->
    $scope.amazons = null
    $scope.currentBookTitle = null

    ajaxReq = $http.get("/links/search/" + $scope.searchQuery)
    ajaxReq.success (data) ->
      $scope.books = data
      $scope.getAmazonBooks($scope.searchQuery)
      $scope.divSelected = true

  $scope.getAmazonBooks = (query) ->
    ajaxReq = $http.get("/links/amazon_search/" + query)
    ajaxReq.success (data) ->
      $scope.amazons = data

  $scope.getWikiBook = (books_array) ->                 # Refactor: Clean this up since we're now only sending one, not an array
    isbns = []
    for book in books_array
      isbn = book.split("ISBN")[1].replace("-", "").replace("-", "").replace("-", "").replace(".", "")
      isbns.push($.trim(isbn))
    isbn_string = isbns.join("-")

    ajaxReq = $http.get("/links/products/" + isbn_string)
    ajaxReq.success (data) ->
      $scope.currentWikiBook = data

  $scope.showBookTitle = (title) ->
    $scope.currentBookTitle = title

  $scope.init = ->
    $scope.getBooks()

  $scope.init()
]

app.controller 'CatsCtrl', ['$scope', '$http', '$resource', '$location', ($scope, $http, $resource, $location) ->

  $scope.getCategories = (query) ->
    ajaxReq = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=100&titles=' + (query) + '&callback=JSON_CALLBACK'
    ajaxReq.success (data) ->
      $scope.cats = data.query.pages[_.first _.keys data.query.pages].categories

      # Extra stuff: 1) Set searchQuery; 2) Set wiki link; 3) Remove "Category:" string
      ele = angular.element('#search-query')
      ele.scope().searchQuery = query
      ele.scope().wikifiedQuery = "http://en.wikipedia.org/wiki/" + ele.scope().searchQuery.split(" ").join("_")
      element.title = element.title.split(":").pop() for element in $scope.cats
      $scope.divSelected = true

  $scope.getTopics = (category) ->
    subcats = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=' + category + '&cmlimit=400&callback=JSON_CALLBACK'
    subcats.success (data) ->
      $scope.topics = data.query.categorymembers
      $scope.currentCategory = category.split(":").pop()

  $scope.init = ->
    console.log "CatsCtrl works!"
    $scope.getCategories($scope.searchQuery)

  $scope.init()
]