ForeCiteApp = angular.module("ForeCite", [
  'ngRoute',
  'ngResource',
  'ForeCite.controllers'
  ])

ForeCiteApp.config(['$routeProvider', ($routeProvider) ->
    $routeProvider.when('/',            {templateUrl: '/partials/landing.html.erb',     controller: 'LinksController'})
    $routeProvider.when('/links',       {templateUrl: '/partials/links.html.erb',       controller: 'LinksController'})
    $routeProvider.when('/categories',  {templateUrl: '/partials/categories.html.erb',  controller: 'LinksController'})
    $routeProvider.when('/books',       {templateUrl: '/partials/books.html.erb',       controller: 'LinksController'})
    # $routeProvider.when('/links/test',  {templateUrl: 'links/test.html',                controller: 'HelloCtrl'})
    $routeProvider.otherwise({redirectTo: '/'})
  ])
