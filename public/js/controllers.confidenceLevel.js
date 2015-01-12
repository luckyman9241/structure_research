/* Home Controller Managing Login and Other Relevant Stuff */

angular.module('myApp.controllers.confidenceLevel', [])
  .service("confLevel",['localStorageService','$rootScope','$http','CONFIGS',function(localStorageService,$rootScope,$http,CONFIGS){
    var self = this;
    self.name = '';
    self.errors = [];
  }])
  .controller('ConfidenceLevelController', ['$scope','sessionModel','$location','$route','CONFIGS',function($scope,sessionModel,$location,$route,CONFIGS) {
    $scope.sessionModel=sessionModel;

    $scope.go = function ( path ) {
      window.location=path;
    };

    /*if(typeof(localStorageService.get("session")!='undefined')){
      scope.userModel = localStorageService.get("session");
    }*/
    $scope.$on('sessionModel::loggedIn', function(broadcast) {
      //Fill the data in
      //$('#login-modal').modal('hide');
      $scope.userModel = userModel;
      $location.path( "/dashboard/" );
     
    });


    $scope.authenticate = function(){
      $http({method: 'POST', url: CONFIGS.URL+'sessions/login',data:$scope.sessionModel}).
      success(function(data, status, headers, config) {
        if(typeof data.success != 'undefined'){
          sessionModel = data.user;
          //$location.path( "/dashboard/" );
        }
        else{
          $.each(data, function(key, value){
            $.each(value, function(key, value){
              self.errors.push(value);
            });
          });
        }
      }).
      error(function(data, status, headers, config) {
        //
      });
    }
  }])
  .directive('ngEnter', function () {
      return function (scope, element, attrs) {
          element.bind("keydown keypress", function (event) {
              if(event.which === 13) {
                  scope.$apply(function (){
                      scope.$eval(attrs.ngEnter);
                  });
                  event.preventDefault();
              }
          });
      };
  });