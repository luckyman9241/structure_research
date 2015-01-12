/* Home Controller Managing Login and Other Relevant Stuff */

angular.module('myApp.controllers.growth', [])
  .service("growthModel",['localStorageService','$rootScope','$http','CONFIGS',function(localStorageService,$rootScope,$http,CONFIGS){
    var self = this;
    self.growths=[];
    self.companies=[];
    self.years=[];
    self.selected_growth = '';
    self.selected_company = '';
    self.selected_year = '';
    self.value = '';
    self.errors = [];
  }])
  .controller('GrowthController', ['$scope','growthModel','$location','$route','CONFIGS','$http',function($scope,growthModel,$location,$route,CONFIGS,$http) {
    $scope.growthModel=growthModel;
    $scope.selectedTab = 1;
    $scope.go = function ( path ) {
      window.location=path;
    };

    $scope.getMasterData= function(){
      $http({method:'GET',url:CONFIGS.URL+'/growths'})
      .success(function(data, status, headers, config){
        $scope.growthModel.growths = data.growth;
        $scope.growthModel.companies = data.companies;
      })
      .error(function(data, status, headers, config){

      });
    }

    $scope.getMasterData();
    
    $scope.setTab = function(tab){
      $scope.selectedTab = tab;
    }

    $scope.validateForm = function(){

      if(growthModel.selected_company != '' && growthModel.selected_growth != '' && growthModel.value != '' && growthModel.selected_year != ''){
        growthModel.errors = [];
      } else{
        growthModel.errors.push('Please fill all required fileds.');
      }
    }

    $scope.addCompanyGrowth=function(){
      $scope.validateForm();
      if(growthModel.errors.length > 0){
        Messenger().post({
            message: growthModel.errors[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/company_growths',data:$scope.growthModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
            Messenger().post({
                message: 'Successfully added',
                type: 'success',
                showCloseButton: true
            });

        })
          .error(function(data, status, headers, config){
        });        
      }

      /*$http({method:'POST',url:CONFIGS.URL+'/company_growths',data:$scope.growthModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
        .success(function(data, status, headers, config){
          
        })
        .error(function(data, status, headers, config){
        });*/
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