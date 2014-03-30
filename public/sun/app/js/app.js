'use strict';


// Declare app level module which depends on filters, and services
angular.module('myApp', [
  'ngRoute',
  'myApp.filters',
  'myApp.services',
  'myApp.directives',
  'myApp.controllers',
  'myApp.translators'
  ]).
config(['$routeProvider', '$httpProvider', function($routeProvider, $httpProvider) {
  $httpProvider.defaults.useXDomain = true;
  delete $httpProvider.defaults.headers.common["X-Requested-With"];

  $routeProvider.when('/freelancerAPI', {templateUrl: 'partials/freelancerAPI.html', controller: 'FreelancerController'});
  $routeProvider.when('/odeskAPI', {templateUrl: 'partials/odeskAPI.html', controller: 'OdeskController'});
  $routeProvider.when('/projects', {templateUrl: 'partials/projects.html', controller: 'projectsController'});
  $routeProvider.when('/translators/login', {templateUrl: 'partials/translators/login.html', controller: 'translatorsAccountController'});
  $routeProvider.when('/translators/project', {templateUrl: 'partials/translators/project.html', controller: 'TranslatorsProjectController'});
  $routeProvider.when('/translators/project/:projectId', {templateUrl: 'partials/translators/editProject.html', controller: 'TranslatorsProjectController'});

  $routeProvider.otherwise({redirectTo: '/translators/login'});
}]);
