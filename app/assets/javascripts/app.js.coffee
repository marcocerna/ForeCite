angular.module("ForeCite", [
  'ngRoute',
  'ngResource'
  ])

.config(['$routeProvider', ($routeProvider) ->
    $routeProvider.when('/',            {templateUrl: '/partials/landing.html.erb',     controller: 'AppCtrl'})
    $routeProvider.when('/links',       {templateUrl: '/partials/links.html.erb',       controller: 'AppCtrl'})
    $routeProvider.when('/categories',  {templateUrl: '/partials/categories.html.erb',  controller: 'AppCtrl'})
    $routeProvider.when('/books',       {templateUrl: '/partials/books.html.erb',       controller: 'AppCtrl'})
    # $routeProvider.when('/links/test',  {templateUrl: 'links/test.html',                controller: 'HelloCtrl'})
    $routeProvider.otherwise({redirectTo: '/'})
  ])
