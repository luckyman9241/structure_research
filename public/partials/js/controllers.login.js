/* Home Controller Managing Login and Other Relevant Stuff */

angular.module('myApp.controllers.login', [])
  .service("LoginModel",['localStorageService','$rootScope','$http','CONFIGS',function(localStorageService,$rootScope,$http,CONFIGS){
    var self = this;
    self.username = '';
    self.password='';
    self.errors = [];
  }])
  .controller('LoginController', ['localStorageService','$scope','LoginModel','$location','$route','CONFIGS','$http',function(localStorageService,$scope,LoginModel,$location,$route,CONFIGS,$http) {
    $scope.LoginModel=LoginModel;

    $scope.go = function ( path ) {
      window.location=path;
    };

     $scope.validateForm=function(){
      if( LoginModel.username != '' && LoginModel.password != '' ){
        LoginModel.errors = [];
      } else{
        LoginModel.errors.push('Please fill all required fileds.');
      }
    }

    $scope.authenticate = function(){
      $scope.validateForm();
      if(LoginModel.errors.length > 0){
        Messenger().post({
            message: LoginModel.errors[0],
            type: 'error',
            showCloseButton: true
        }); 
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/users/authenticate',data:$scope.LoginModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
        .success(function(data, status, headers, config){
          Messenger().post({
              message: 'Successfully Logged in',
              type: 'success',
              showCloseButton: true
          }); 
          localStorageService.add('isLoggedin',1);
          localStorageService.add('userTypeId',data[0].user_type_id);
          localStorageService.add('username',data[0].username);

          $scope.go('#dashboard');
          location.reload();

        })
        .error(function(data, status, headers, config){
          Messenger().post({
              message: 'Invalid username or password',
              type: 'error',
              showCloseButton: true
          }); 
        });
      }
      
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