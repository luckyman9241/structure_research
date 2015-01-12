/* Home Controller Managing Login and Other Relevant Stuff */

angular.module('myApp.controllers.setting', [])
  .service("settingModel",['localStorageService','$rootScope','$http','CONFIGS',function(localStorageService,$rootScope,$http,CONFIGS){
    var self = this;
    self.companies=[];
    self.company_classifications=[];
    self.percentranges=[];
    self.revenueranges=[];
    self.confidenceLevels=[];
    self.companyTypes=[];
    self.ndas=[];
    self.analysts=[];
    self.statuses=[];
    self.growths=[];
    self.geos=[];
    self.revenues=[];
    self.userTypes=[];
    self.users=[];

    self.user_fullName='';
    self.user_username='';
    self.user_password='';
    self.user_selected_type='';

    self.selected_classification='';
    self.selected_company_id='';
    
    
    self.states=[];
    self.cities=[];
    self.classifications=[];
    self.countries=[];
    self.regions=[];
    self.currencies=[];
    self.currency_year_values=[];
    
    self.per_range='';
    self.per_val='';

    self.geo_name='';
    self.geo_desc='';

    self.revenue_name='';
    self.revenue_desc='';

    self.rev_range='';
    self.rev_val='';


    self.state_name='';
    self.city_name='';
    self.edit_city_name='';

    self.classification_name='';
    self.classification_description='';
    self.country_name='';
    self.region_name='';
    self.growth_name='';

    self.confidence_level_name='';

    self.selected_currency_ID='';
    self.currency_percent='';
    self.currency_percent_value='';
    
    self.nda_name='';
    self.company_type='';
    self.status_name='';
    self.analyst_name='';
    

    self.fxrate='';
    self.currency='';
    self.currencyName='';
    self.currencyPrefix='';

    self.geoErrors = [];
    self.addRevenueErrors =[];
    self.revenueErrors = [];
    self.percentErrors =[];
    self.currencyErrors =[];




    self.state_name_error= [];
    self.city_name_error= [];
    self.classification_name_error= [];
    self.country_name_error= [];
    self.region_name_error= [];
    self.currency_year_values_error= [];
    self.confidence_levels_name_error= [];
    self.nda_name_error=[];
    self.analyst_name_error=[];
    self.status_name_error=[];
    self.growth_name_error=[];
    self.add_user_error=[];
    self.company_classification_errors=[];
    self.company_type_error = [];



  }])
  .controller('SettingController', ['$scope','settingModel','$location','$route','CONFIGS','$http',function($scope,settingModel,$location,$route,CONFIGS,$http) {
    $scope.settingModel=settingModel;
    $scope.selectedTab = 5;

    $scope.go = function ( path ) {
      window.location=path;
    };

    $scope.validateCompanyClassification = function(){

      if(settingModel.selected_classification='' != '' && settingModel.selected_company_id != '' ){
        settingModel.company_classification_errors = [];
      } else{
        settingModel.company_classification_errors.push('Please fill all required fileds.');
      }
    }

    $scope.validateAddUserForm = function(){

      if(settingModel.user_username != '' && settingModel.user_fullName != '' && settingModel.user_password != '' && settingModel.user_selected_type != ''){
        settingModel.add_user_error = [];
      } else{
        settingModel.add_user_error.push('Please fill all required fileds.');
      }
    }
    $scope.validateAddRevenueForm = function(){

      if(settingModel.revenue_name != '' && settingModel.revenue_desc != ''){
        settingModel.addRevenueErrors = [];
      } else{
        settingModel.addRevenueErrors.push('Please fill all required fileds.');
      }
    }

    $scope.validateCurrencyYearValuesForm = function(){

      if(settingModel.currency_ID != '' && settingModel.currency_percent != '' && settingModel.currency_percent_value != ''){
        settingModel.currency_year_values_error = [];
      } else{
        settingModel.currency_year_values_error.push('Please fill all required fileds.');
      }
    }

    $scope.validateGeoForm = function(){

      if(settingModel.geo_name != '' && settingModel.geo_desc!=''){
        settingModel.geoErrors = [];
      } else{
        settingModel.geoErrors.push('Please fill all required fileds.');
      }
    }

    $scope.validateNDAForm = function(){

      if(settingModel.nda_name != ''){
        settingModel.nda_name_error = [];
      } else{
        settingModel.nda_name_error.push('Please fill all required fileds.');
      }
    }
    $scope.validateCompanyTypeForm = function(){

      if(settingModel.company_type != ''){
        settingModel.company_type_error = [];
      } else{
        settingModel.company_type_error.push('Please fill all required fileds.');
      }
    }

    $scope.validateAnalystForm = function(){

      if(settingModel.analyst_name != ''){
        settingModel.nda_analyst_error = [];
      } else{
        settingModel.nda_analyst_error.push('Please fill all required fileds.');
      }
    }

    $scope.validateStatusForm = function(){

      if(settingModel.status_name != ''){
        settingModel.status_name_error = [];
      } else{
        settingModel.status_name_error.push('Please fill all required fileds.');
      }
    }

    $scope.validateGrowthForm = function(){

      if(settingModel.growth_name != ''){
        settingModel.growth_name_error = [];
      } else{
        settingModel.growth_name_error.push('Please fill all required fileds.');
      }
    }

    $scope.validateConfidenceLevelForm = function(){

      if(settingModel.confidence_level_name != ''){
        settingModel.confidence_levels_name_error = [];
      } else{
        settingModel.confidence_levels_name_error.push('Please fill all required fileds.');
      }
    }

    $scope.validateRevenueForm = function(){

      if(settingModel.rev_range != '' && settingModel.rev_val != ''){
        settingModel.revenueErrors = [];
      } else{
        settingModel.revenueErrors.push('Please fill all required fileds.');
      }
    }
    $scope.validateCountryForm = function(){

      if(settingModel.country_name != ''){
        settingModel.country_name_error = [];
      } else{
        settingModel.country_name_error.push('Please fill all required fileds.');
      }
    }
    $scope.validateCityForm = function(){

      if(settingModel.city_name != ''){
        settingModel.city_name_error = [];
      } else{
        settingModel.city_name_error.push('Please fill all required fileds.');
      }
    }
    $scope.validateStateForm = function(){

      if(settingModel.state_name != ''){
        settingModel.state_name_error = [];
      } else{
        settingModel.state_name_error.push('Please fill all required fileds.');
      }
    }
    $scope.validateRegionForm = function(){

      if(settingModel.region_name != ''){
        settingModel.region_name_error = [];
      } else{
        settingModel.region_name_error.push('Please fill all required fileds.');
      }
    }

    $scope.validateClassificationForm = function(){

      if(settingModel.classification_name != '' && settingModel.classification_description != ''){
        settingModel.classification_name_error = [];
      } else{
        settingModel.classification_name_error.push('Please fill all required fileds.');
      }
    }



    $scope.validatePercentForm = function(){

      if(settingModel.per_range != '' && settingModel.per_val != ''){
        settingModel.percentErrors = [];
      } else{
        settingModel.percentErrors.push('Please fill all required fileds.');
      }
    }

    $scope.validateCurrencyForm = function(){

      if(settingModel.fxrate != '' && settingModel.currency != '' && settingModel.currencyName != '' && settingModel.currencyPrefix !=''){
        settingModel.currencyErrors = [];
      } else{
        settingModel.currencyErrors.push('Please fill all required fileds.');
      }
    }

    $scope.getpercentRanges= function(){
      $http({method:'GET',url:CONFIGS.URL+'/percent_ranges'})
      .success(function(data, status, headers, config){
        $scope.settingModel.percentranges = data;
      })
      .error(function(data, status, headers, config){

      });
    }
    $scope.getrevenueRanges= function(){
      $http({method:'GET',url:CONFIGS.URL+'/revenue_ranges'})
      .success(function(data, status, headers, config){
        if(data.length > 0){
          $scope.settingModel.revenueranges = data;
        } else{
          $scope.settingModel.revenueranges = [];
        }
      })
      .error(function(data, status, headers, config){

      });
    }

    $scope.getAllsettings=function(){
      $http({method:'GET',url:CONFIGS.URL+'/companies/masterData'})
      .success(function(data, status, headers, config){
        
        $scope.settingModel.companies = data.companies;
        var cCC=JSON.parse(data.company_classifications);
        $scope.settingModel.company_classifications=cCC;
        $scope.settingModel.cities = data.cities;
        $scope.settingModel.states = data.states;
        $scope.settingModel.countries = data.countries;
        $scope.settingModel.regions = data.regions;
        $scope.settingModel.classifications = data.classifications;
        $scope.settingModel.currencies = data.currencies;
        var currencyYearValues=JSON.parse(data.currency_year_values);
        $scope.settingModel.currency_year_values = currencyYearValues;
        $scope.settingModel.confidenceLevels= data.confidence_levels;
        $scope.settingModel.ndas= data.ndas;
        $scope.settingModel.companyTypes= data.companyTypes;
        $scope.settingModel.analysts= data.analysts;
        $scope.settingModel.statuses= data.statuses;
        $scope.settingModel.growths= data.growths;
        $scope.settingModel.geos= data.geos;
        $scope.settingModel.revenues= data.revenues;
        $scope.settingModel.user_types = data.user_types;
        var cUsers=JSON.parse(data.users);
        $scope.settingModel.users=cUsers;

      })
      .error(function(data, status, headers, config){

      });
    }

    $scope.addRevenueRange=function(){
      $scope.validateRevenueForm();
      if(settingModel.revenueErrors.length > 0){
        Messenger().post({
            message: settingModel.revenueErrors[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/revenue_ranges',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.revenueranges.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addPercentRange=function(){
      $scope.validatePercentForm();
      if(settingModel.percentErrors.length > 0){
        Messenger().post({
            message: settingModel.percentErrors[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/percent_ranges',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.percentranges.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addCountry=function(){
      $scope.validateCountryForm();
      if(settingModel.country_name_error.length > 0){
        Messenger().post({
            message: settingModel.country_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/countries',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.countries.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addCity=function(){
      $scope.validateCityForm();
      if(settingModel.city_name_error.length > 0){
        Messenger().post({
            message: settingModel.city_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/cities',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.cities.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addStates=function(){
      $scope.validateStateForm();
      if(settingModel.state_name_error.length > 0){
        Messenger().post({
            message: settingModel.state_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/states',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.states.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addRegion=function(){
      $scope.validateRegionForm();
      if(settingModel.region_name_error.length > 0){
        Messenger().post({
            message: settingModel.region_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/regions',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.regions.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }
    $scope.addClassification=function(){
      $scope.validateClassificationForm();
      if(settingModel.classification_name_error.length > 0){
        Messenger().post({
            message: settingModel.classification_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/classifications',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.classifications.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addCurrency=function(){
      $scope.validateCurrencyForm();
      if(settingModel.currencyErrors.length > 0){
        Messenger().post({
            message: settingModel.currencyErrors[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/legends',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.settingModel.currencies.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addCurrencyYearValue=function(){
      $scope.validateCurrencyYearValuesForm();
      if(settingModel.currency_year_values_error.length > 0){
        Messenger().post({
            message: settingModel.currency_year_values_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/legend_values',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.settingModel.currency_year_values.push(data);
          })
          .error(function(data, status, headers, config){
        });
      }
    }

    $scope.addConfidenceLevel=function(){
      $scope.validateConfidenceLevelForm();
      if(settingModel.confidence_levels_name_error.length > 0){
        Messenger().post({
            message: settingModel.confidence_levels_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/confidence_levels',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.settingModel.confidenceLevels.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }
    $scope.addNda=function(){
      $scope.validateNDAForm();
      if(settingModel.nda_name_error.length > 0){
        Messenger().post({
            message: settingModel.nda_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/ndas',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.settingModel.ndas.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }
    $scope.addCompType=function(){
      $scope.validateCompanyTypeForm();
      if(settingModel.company_type_error.length > 0){
        Messenger().post({
            message: settingModel.company_type_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/company_types',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.settingModel.companyTypes.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addAnalyst=function(){
      $scope.validateAnalystForm();
      if(settingModel.analyst_name_error.length > 0){
        Messenger().post({
            message: settingModel.analyst_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/analysts',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.settingModel.analysts.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addStatus=function(){
      $scope.validateStatusForm();
      if(settingModel.status_name_error.length > 0){
        Messenger().post({
            message: settingModel.status_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/statuses',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.settingModel.statuses.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }
    $scope.addGeo=function(){
      $scope.validateGeoForm();
      if(settingModel.geoErrors.length > 0){
        Messenger().post({
            message: settingModel.geoErrors[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/geos',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.settingModel.geos.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addGrowth=function(){
      $scope.validateGrowthForm();
      if(settingModel.growth_name_error.length > 0){
        Messenger().post({
            message: settingModel.growth_name_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/growths',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.settingModel.growths.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addRevenue=function(){
      $scope.validateAddRevenueForm();
      if(settingModel.addRevenueErrors.length > 0){
        Messenger().post({
            message: settingModel.addRevenueErrors[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/revenues',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              
              $scope.settingModel.revenues.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addUser=function(){
      $scope.validateAddUserForm();
      if(settingModel.add_user_error.length > 0){
        Messenger().post({
            message: settingModel.add_user_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/users',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              
              $scope.settingModel.users.push(data);
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
    }

    $scope.addCompClassification=function(){
      $scope.validateCompanyClassification();
      if(settingModel.company_classification_errors.length > 0){
        Messenger().post({
            message: settingModel.company_classification_errors[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/company_classifications',data:$scope.settingModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              
              $scope.settingModel.company_classifications.push(data);
          })
          .error(function(data, status, headers, config){
        });
      }
    }

    


    $scope.getpercentRanges();
    $scope.getrevenueRanges();
    $scope.getAllsettings();
    
    $scope.setTab = function(tab){
      $scope.selectedTab = tab;
    }


    
    
    //$scope.clicked = false;
    $scope.editState=function(name,id,index){
      
      if(settingModel.states[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/states',data:$scope.settingModel.states[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.states[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.states[index].clicked = true;
    }

    $scope.deleteState=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/states/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.states.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }


    $scope.editRegion=function(name,id,index){
      
      if(settingModel.regions[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/regions',data:$scope.settingModel.regions[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.regions[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.regions[index].clicked = true;
    }

    $scope.deleteRegion=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/regions/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.regions.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editCity=function(name,id,index){
      
      if(settingModel.cities[index].clicked)
      {
        //It has previously been clicked
        $http({method:'POST',url:CONFIGS.URL+'/cities',data:$scope.settingModel.cities[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.cities[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
        
      }
      else
        $scope.settingModel.cities[index].clicked = true;

    }

    $scope.deleteCity=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/cities/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.cities.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editGrowth=function(name,id,index){
      if(settingModel.growths[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/growths',data:$scope.settingModel.growths[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.growths[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.growths[index].clicked = true;
    }

    $scope.deleteGrowth=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/growths/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.growths.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editRevenue=function(name,id,index){
      if(settingModel.revenues[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/revenues',data:$scope.settingModel.revenues[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.revenues[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.revenues[index].clicked = true;
    }

    $scope.deleteRevenue=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/revenues/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.revenues.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }
    $scope.editGeo=function(name,id,index){
      if(settingModel.geos[index].clicked)
      {
        //It has previously been clicked
        $http({method:'POST',url:CONFIGS.URL+'/geos',data:$scope.settingModel.geos[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.geos[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.geos[index].clicked = true;
    }

    $scope.deleteGeo=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/geos/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.geos.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }



    $scope.editNda=function(name,id,index){
      if(settingModel.ndas[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/ndas',data:$scope.settingModel.ndas[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.ndas[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.ndas[index].clicked = true;
    }

    $scope.deleteNda=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/ndas/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.ndas.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editCompType=function(name,id,index){
      if(settingModel.companyTypes[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/company_types',data:$scope.settingModel.companyTypes[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.companyTypes[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.companyTypes[index].clicked = true;
    }

    $scope.deleteCompType=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/company_types/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.companyTypes.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editAnalyst=function(name,id,index){
      if(settingModel.analysts[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/analysts',data:$scope.settingModel.analysts[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.analysts[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.analysts[index].clicked = true;
    }

    $scope.deleteAnalyst=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/analysts/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.analysts.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editStatus=function(name,id,index){
      if(settingModel.statuses[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/statuses',data:$scope.settingModel.statuses[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.statuses[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.statuses[index].clicked = true;
    }

    $scope.deleteStatus=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/statuses/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.statuses.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editConf=function(name,id,index){
      if(settingModel.confidenceLevels[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/confidence_levels',data:$scope.settingModel.confidenceLevels[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.confidenceLevels[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.confidenceLevels[index].clicked = true;
    }

    $scope.deleteConf=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/confidence_levels/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.confidenceLevels.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editCurrency=function(name,id,index){
      if(settingModel.currencies[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/legends',data:$scope.settingModel.currencies[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.currencies[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.currencies[index].clicked = true;
    }


    $scope.deleteCurrency=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/legends/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.currencies.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }


    $scope.editCyv=function(name,id,index){
      if(settingModel.currency_year_values[index].clicked)
      {
        //It has previously been clicked
        $http({method:'POST',url:CONFIGS.URL+'/legend_values',data:$scope.settingModel.currency_year_values[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.currency_year_values[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.currency_year_values[index].clicked = true;
    }

    $scope.deleteCyv=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/legend_values/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.currency_year_values.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editPercent=function(name,id,index){
      if(settingModel.percentranges[index].clicked)
      {
        //It has previously been clicked
        $http({method:'POST',url:CONFIGS.URL+'/percent_ranges',data:$scope.settingModel.percentranges[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.percentranges[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.percentranges[index].clicked = true;
    }

    $scope.deletePercent=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/percent_ranges/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.percentranges.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }

    $scope.editRev=function(name,id,index){
      if(settingModel.revenueranges[index].clicked)
      {
        //It has previously been clicked
        $http({method:'POST',url:CONFIGS.URL+'/revenue_ranges',data:$scope.settingModel.revenueranges[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.revenueranges[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
        
      }
      else
        $scope.settingModel.revenueranges[index].clicked = true;
    }

    $scope.deleteRev=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/revenue_ranges/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.revenueranges.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }
    $scope.editClassification=function(name,id,index){
      if(settingModel.classifications[index].clicked)
      {
        $http({method:'POST',url:CONFIGS.URL+'/classifications',data:$scope.settingModel.classifications[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.classifications[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.classifications[index].clicked = true;
    }

    $scope.deleteClassification=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/classifications/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.classifications.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }


    $scope.deleteCountry=function(id,index){
      if(confirm("Do you want to delete?")){
        $http({method:'delete',url:CONFIGS.URL+'/countries/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully deleted',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.countries.splice(index, 1);
             
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      } 
    }
    $scope.editCountry=function(name,id,index){
      
      if(settingModel.countries[index].clicked)
      {
        //It has previously been clicked
        $http({method:'POST',url:CONFIGS.URL+'/countries',data:$scope.settingModel.countries[index],headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully Updated',
                  type: 'success',
                  showCloseButton: true
              });
             $scope.settingModel.countries[index].clicked = false;
          })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: data,
                type: 'error',
                showCloseButton: true
            });
        });
      }
      else
        $scope.settingModel.countries[index].clicked = true;

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