/* Home Controller Managing Login and Other Relevant Stuff */
angular.module('myApp.controllers.home', [])
  .service("homeModel",['localStorageService','$rootScope','$http','CONFIGS',function(localStorageService,$rootScope,$http,CONFIGS){
    var self = this;
    self.email_address = '';
    self.password = '';
    self.errors = [];
    self.isLoggedin=0;
    self.selectedMenu = '';
    //console.log(localStorageService.get('isLoggedin'));
     self.selectedMenu=localStorageService.get('selectedMenu');
  }])
  .controller('HomeController', ['$rootScope','localStorageService','$scope','homeModel','$location','$route','CONFIGS','$http',function($rootScope,localStorageService,$scope,homeModel,$location,$route,CONFIGS,$http) {
    $scope.homeModel=homeModel;
    //$scope.settings_setup = false;
    /*$rootScope.$on("$locationChangeStart",function(event, next, current){
      if(next.indexOf("setting")>-1)
        {$scope.settings_setup=true;
        $scope.homeModel.menuLink = 'setting';}
      else
        {$scope.settings_setup=false;
        $scope.homeModel.menuLink = 'dashboard';}
    //do your validations here
    //prevent the location change.
    //event.preventDefault();

    return true;
    });*/

    $scope.setTab = function(tab){
      
    }
    $scope.go = function ( path ) {
      window.location=path;
    };

    $scope.Authenticate= function(){
      if(localStorageService.get('isLoggedin')==null || localStorageService.get('isLoggedin')==0){
        homeModel.isLoggedin=0;
        homeModel.userTypeId=0;
        homeModel.username='';
        homeModel.menuLink = '';
      } else{
        homeModel.isLoggedin=1;
        homeModel.userTypeId=localStorageService.get('userTypeId');
        homeModel.username=localStorageService.get('username');
        homeModel.menuLink = 'dashboard';
      }
    }

    $scope.GetWidgetDetail=function(){
      $http({method:'GET',url:CONFIGS.URL+'/companies/getWidgetDetail',headers : {'Content-Type':'application/json; charset=UTF-8'}})
        .success(function(data, status, headers, config){
            $scope.homeModel.companyTotal=data.companies;
            $scope.homeModel.growthTotal=data.company_growth;
            $scope.homeModel.revenueTotal=data.company_revenue;
            $scope.homeModel.users=data.users;
        })
        .error(function(data, status, headers, config){
      });
    }

    $scope.logout=function(){
      localStorageService.clearAll();
      $scope.go('#login');
      location.reload();
    }

    $scope.setMenuLink = function(){
      $scope.go('#dashboard');
      $scope.homeModel.menuLink = 'dashboard';
      
    }

    $scope.changeOption = function(){
      
      if(homeModel.menuLink=='logout'){
        localStorageService.clearAll();
        $scope.go('#login');
        location.reload();
      }
      if(homeModel.menuLink=='dashboard'){
        
        $scope.go('#dashboard');
        localStorageService.add('selectedMenu','dashboard');
        
      }
      
      if(homeModel.menuLink=='profile'){
        
        $scope.go('#dashboard');
        
      }

      if(homeModel.menuLink=='settings'){
        
        $scope.go('#settings');
        localStorageService.add('selectedMenu','setting');
        
      }
      
      


    }

    $scope.Authenticate();
    $scope.GetWidgetDetail();

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