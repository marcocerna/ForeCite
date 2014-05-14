angular.module("ForeCite", ['ngRoute'])

.config(['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/',            {templateUrl: '/partials/landing.html.erb',     controller: 'AppCtrl'})
    .when('/links',       {templateUrl: '/partials/links.html.erb',       controller: 'LinksCtrl'})
    .when('/categories',  {templateUrl: '/partials/categories.html.erb',  controller: 'CatsCtrl'})
    .when('/books',       {templateUrl: '/partials/books.html.erb',       controller: 'BooksCtrl'})
    .otherwise({redirectTo: '/'})
])

