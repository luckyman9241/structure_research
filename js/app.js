'use strict';
// Declare app level module which depends on filters, and services
angular.module('myApp', [
  'ngRoute',
  'LocalStorageModule',
  'oci.fixedHeader',
  'ngProgress',
  'myApp.controllers.home',
  'myApp.controllers.company',
  'myApp.controllers.dashboard',
  'myApp.controllers.setting',
  'myApp.controllers.growth',
  'myApp.controllers.login',
  'myApp.controllers.confidenceLevel',
]).
config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/home', {templateUrl: 'partials/home.html', controller: 'HomeController'});
  $routeProvider.when('/addCompany', {templateUrl: 'partials/addCompany.html', controller: 'CompanyController'});
  $routeProvider.when('/editCompany', {templateUrl: 'partials/editCompany.html', controller: 'CompanyController'});
  $routeProvider.when('/addCompanyGeo', {templateUrl: 'partials/addCompanyGeo.html', controller: 'DashboardController'});
  $routeProvider.when('/addCompanySegment', {templateUrl: 'partials/addCompanySegment.html', controller: 'DashboardController'});
  $routeProvider.when('/addCompanyGrowth', {templateUrl: 'partials/addGrowth.html', controller: 'DashboardController'});

  $routeProvider.when('/dashboard', {templateUrl: 'partials/dashboard.html', controller: 'DashboardController'});
  $routeProvider.when('/confidenceLevel', {templateUrl: 'partials/confidenceLevel.html', controller: 'ConfidenceLevelController'});
  $routeProvider.when('/settings', {templateUrl: 'partials/settings.html', controller: 'SettingController'});
  $routeProvider.when('/growths', {templateUrl: 'partials/growth_main.html', controller: 'GrowthController'});
  $routeProvider.when('/login', {templateUrl: 'partials/login.html', controller: 'LoginController'});

  $routeProvider.otherwise({redirectTo: '/dashboard'});




}]).run(function($rootScope,localStorageService,$location,validateCookie,$templateCache) {
    $rootScope.layout = {};
    $rootScope.layout.loading = false;
    localStorageService.isViewLoading = false;
    $rootScope.$on('$routeChangeSuccess', function () {

        validateCookie(localStorageService,$location);
        $templateCache.removeAll();
    })

    $rootScope.$on('$viewContentLoaded', function() {

       localStorageService.isViewLoading = true;

    })

    setTimeout(function(){
      $rootScope.layout.loading = true;
      localStorageService.isViewLoading = false;

    }, 200);
})
.factory('validateCookie', function(localStorageService,$location){
    return function(scope) {

        var loggedInn=localStorageService.get('isLoggedin');
         if(loggedInn==null || loggedInn==0){
            $location.path('/login');
          }

    }
}).value('CONFIGS', {
    // URL: 'http://structureresearch.net:12003',
    URL: 'http://localhost:3000',
    UPLOAD_URL:'http://localhost/pm/pmapis/uploads/'
});