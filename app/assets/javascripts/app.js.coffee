angular.module("ForeCite", [
  'ngRoute',
  'ngResource'
  ])

.config(['$routeProvider', ($routeProvider) ->
    $routeProvider
      .when('/',            {templateUrl: '/partials/landing.html.erb',     controller: 'AppCtrl'})
      .when('/links',       {templateUrl: '/partials/links.html.erb',       controller: 'LinksCtrl'})
      .when('/categories',  {templateUrl: '/partials/categories.html.erb',  controller: 'AppCtrl'})
      .when('/books',       {templateUrl: '/partials/books.html.erb',       controller: 'BooksCtrl'})
    # $routeProvider.when('/links/test',  {templateUrl: 'links/test.html',                controller: 'HelloCtrl'})
      .otherwise({redirectTo: '/'})
  ])
