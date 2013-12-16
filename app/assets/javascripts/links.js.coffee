app = angular.module "ForeCite", ["ngResource"]

app.controller 'LinksController', ($scope, $http, $resource) ->

  $scope.hideLoadingBooks = "hide"
  $scope.hideUntilSearch = "hide"

  ##############################################
  # Clear functions for buttons and categories #
  ##############################################

  $scope.clearButtons = ->
    $scope.linksSelected = false
    $scope.catsSelected = false
    $scope.booksSelected = false

  $scope.clearLinks = ->
    $scope.links = null

  $scope.clearCategories = ->
    $scope.cats = null
    $scope.topics = null

  $scope.clearBooks = ->
    $scope.hideBooks = "hide"
    $scope.currentBookTitle = null
    $scope.books = null

  ##################################
  # Check for valid search entries #
  ##################################

  $scope.getValidQuery = (query, button) ->
    $scope.buttonSelected = button
    # Grab searchQuery
    # Run it through boss_call via ajax
    console.log "Ajax call to Yahoo method"
    ajaxReq = $http.get("/links/boss/" + query)
    # Wire up the controller action

    # Grab array from boss_call
    # Attach it to an ng-model
    ajaxReq.success (data) ->
      $scope.validQueries = data
      $scope.hideUntilSearch = null
    .error (data) ->
      console.log 'ERROR: getValidQuery'

    # Add div and ng-model to HTML page
    # When one of them is clicked, execute...I dunno, something

  $scope.executeButton = (query) ->
    $scope.searchQuery = query
    $scope.getLinks()                         if $scope.buttonSelected == "links"
    $scope.getCategories($scope.searchQuery)  if $scope.buttonSelected == "categories"
    $scope.getBooks()                         if $scope.buttonSelected == "books"

  ################
  # Links button #
  ################

  $scope.getLinks = ->
    $scope.clearButtons()
    $scope.clearBooks()
    $scope.clearCategories()
    $scope.linksSelected = true

    console.log "Calling Wikipedia to grab links"
    extlinks = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=extlinks&format=json&ellimit=200&titles=' + $scope.searchQuery + '&callback=JSON_CALLBACK'

    extlinks.success (data) ->
      $scope.links = data.query.pages[_.first _.keys data.query.pages].extlinks
    .error (data) ->
      console.log 'ERROR: getLinks'

  ###################################
  # Categories button (2 functions) #
  ###################################

  $scope.getCategories = (query) ->
    console.log "Getting categories for" + query
    $scope.clearButtons()
    $scope.clearLinks()
    $scope.clearBooks()
    $scope.catsSelected = true

    categories = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&prop=categories&format=json&clshow=!hidden&cllimit=100&titles=' + (query) + '&callback=JSON_CALLBACK'

    categories.success (data) ->
      $scope.cats = data.query.pages[_.first _.keys data.query.pages].categories
      $scope.searchQuery = query
      $scope.hideUntilSearch = "hide"

      # This loop removes "Category:" from every string
      for element in $scope.cats
        newThing = element.title.split(":").pop()
        element.title = newThing

    .error (data) ->
      console.log 'ERROR: getCategories'

  $scope.getTopics = (category) ->
    console.log "Getting topics for " + category
    subcats = $http.jsonp 'http://en.wikipedia.org//w/api.php?action=query&list=categorymembers&format=json&cmtitle=' + category + '&cmlimit=400&callback=JSON_CALLBACK'

    subcats.success (data) ->
      $scope.topics = data.query.categorymembers
      $scope.currentCategory = category.split(":").pop()
    .error (data) ->
      console.log 'ERROR: getTopics'

  #####################################################
  # Books are complicated, so it gets three functions #
  #####################################################

  $scope.getBooks = ->
    $scope.clearButtons()
    $scope.clearLinks()
    $scope.clearCategories()
    $scope.hideBooks = null
    $scope.hideLoadingBooks = null

    ajaxReq = $http.get("/links/search/" + $scope.searchQuery)

    ajaxReq.success (data) ->
      $scope.books = data
      # $scope.getAmazon(data)
      $scope.amazonSearch($scope.searchQuery)
      # Here we need to put a $scope.topFiveBooks function  ###########################
        # For now, have that go to a separate controller action top_five
        # Tie that controller action to lib function
    .error (data) ->
      console.log 'ERROR: getBooks'

  $scope.getAmazon = (books_array) ->

    console.log "Beginning getAmazon function"    ####################
    debugger

    # Convert books_array into isbn_array
    isbns = []
    for book in books_array
      isbn = book.split("ISBN")[1].replace("-", "").replace("-", "").replace("-", "").replace(".", "")
      isbns.push($.trim(isbn))

    # Ajax call to "/links/products/" + isbn_array
    isbn_string = isbns.join("-")
    console.log "About to make ajax call to /products"          ###################
    ajaxReq = $http.get("/links/products/" + isbn_string)

    ajaxReq.success (data) ->
      # $scope.amazons = data
      console.log "Got the Amazon book data!"
      console.log data
      $scope.currentWikiBook = data
      $scope.booksSelected = true
      $scope.hideLoadingBooks = "hide"
      $scope.hideUntilSearch = "hide"

    .error (data) ->
      console.log 'ERROR: getAmazon'

  $scope.showBookTitle = (title) ->
    $scope.currentBookTitle = title

  $scope.amazonSearch = (query) ->
    ajaxReq = $http.get("/links/amazon_search/" + query)
    ajaxReq.success (data) ->
      console.log "amazonSearch successfully fired. Here's the data:"
      console.log data
      $scope.amazons = data
      $scope.hideLoadingBooks = "hide"
      $scope.hideUntilSearch = "hide"
    .error (data) ->
      console.log 'ERROR: amazonSearch'