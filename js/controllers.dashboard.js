/* Home Controller Managing Login and Other Relevant Stuff */

angular.module('myApp.controllers.dashboard', ['ui-rangeSlider','ui.bootstrap'])
  .service("dashboardModel",['localStorageService','$rootScope','$http','CONFIGS',function(localStorageService,$rootScope,$http,CONFIGS){
    var self = this;
    self.companies=[];
    self.Allcompanies=[];
    self.growths=[];
    self.geos=[];
    self.companies_geos=[];

    self.growth_value = [];
    self.base_revenue_value = [];
    self.revenue_value = [];
    self.applyAll = 0;
    self.base_values = [];
    self.base_values = [];
    self.base_year_value = [];
    self.revenues_values = [];

    self.geoViewFlag = 1;
    self.segmentViewFlag = 1;

    self.growthValues = [];

    self.countries=[];
    self.regions=[];
    

    self.selected_comp_filter=''; 
    self.selected_country_filter='All';
    self.selected_region_filter='All';
    self.selected_year_filter='All';

    self.revenueMin='';
    self.revenueMax='';
    

    self.revenues=[];
    self.companies_revenue=[];
    

    self.revenueMin='0';
    self.revenueMax='1000';


    self.selected_growth = '';
    self.selected_company = '';
    self.selected_year = '';

    self.selected_companyG = '';
    self.selected_companyR = '';
    self.selected_companyS = '';

    
    

    self.companyGrowthData = '';
    self.companyRevenueData = '';
    self.companyGeoData = '';
    
    
    self.value = '';
    
    

    
    
    
    
    
    
    self.selected_growth='';
    self.selected_revenue='';





    self.analyst='';

    self.errors = [];
    self.companyID='';
    self.companyGrowths=[];
    self.company_growth_error=[];

    self.company_geo_error=[];
    self.company_revenue_error=[];
    

    self.isLoggedin=localStorageService.get('isLoggedin');
    self.userTypeId=localStorageService.get('userTypeId');
    self.username=localStorageService.get('username');
  }])
  .controller('DashboardController', ['localStorageService','companyModel','$scope','dashboardModel','homeModel','$location','$templateCache','$route','CONFIGS','$http','ngProgress','$filter',function(localStorageService,companyModel,$scope,dashboardModel,homeModel,$location,$templateCache,$route,CONFIGS,$http,ngProgress,$filter) {
    $scope.dashboardModel=dashboardModel;
    $scope.companyModel = companyModel;
    $scope.homeModel = homeModel;
    $scope.selectedTab = 1;
    $scope.dashboardModel.percentActive = '/browser_components/images/percent-active.png';
    $scope.dashboardModel.dollarActive = '/browser_components/images/usd-inactive.png';
    $scope.dashboardModel.loading = false;
    ngProgress.stop();
    $('.ngrs-value-max').html('Max');

    
   


      $scope.checkIndex = function(id){
        return 'index_'+id;
      }
      $scope.checkIndex2 = function(id){
        return '-index_'+id;
      }
      //start code
      $scope.dashboardModel.itemsPerPage = 50;
      $scope.dashboardModel.currentPage = 0;
      
         $scope.range = function() {
        var rangeSize = 4;
        var ps = [];
        var start;

        start = $scope.dashboardModel.currentPage;
           //  console.log($scope.pageCount(),$scope.currentPage)
        if ( start > $scope.pageCount()-rangeSize ) {
          start = $scope.pageCount()-rangeSize+1;
        }

        for (var i=start; i<start+rangeSize; i++) {
          if(i>=0) 
             ps.push(i);
        }
        return ps;
      };

      //tab 1
      $scope.prevPage = function() {
        if ($scope.dashboardModel.currentPage > 0) {
          $scope.dashboardModel.currentPage--;
        }
      };

      $scope.DisablePrevPage = function() {
        return $scope.dashboardModel.currentPage === 0 ? "disabled" : "";
      };

      $scope.pageCount = function() {
        return Math.ceil($scope.dashboardModel.companies.length/$scope.dashboardModel.itemsPerPage)-1;
      };

      $scope.nextPage = function() {
        if ($scope.dashboardModel.currentPage < $scope.pageCount()) {
          $scope.dashboardModel.currentPage++;
        }
      };

      $scope.DisableNextPage = function() {
        return $scope.dashboardModel.currentPage === $scope.pageCount() ? "disabled" : "";
      };


      //tab 2 
      $scope.tab2prevPage = function() {
        if ($scope.dashboardModel.currentPage > 0) {
          $scope.dashboardModel.currentPage--;
        }
      };

      $scope.tab2DisablePrevPage = function() {
        return $scope.dashboardModel.currentPage === 0 ? "disabled" : "";
      };

      $scope.tab2pageCount = function() {
        return Math.ceil($scope.dashboardModel.companyGrowths.length/$scope.dashboardModel.itemsPerPage)-1;
      };

      $scope.tab2nextPage = function() {
        if ($scope.dashboardModel.currentPage < $scope.tab2pageCount()) {
          $scope.dashboardModel.currentPage++;
        }
      };

      $scope.tab2DisableNextPage = function() {
        return $scope.dashboardModel.currentPage === $scope.tab2pageCount() ? "disabled" : "";
      };
      $scope.setPage = function(n) {
        $scope.dashboardModel.currentPage = n;
      };

      //tab 3
      $scope.tab3prevPage = function() {
        if ($scope.dashboardModel.currentPage > 0) {
          $scope.dashboardModel.currentPage--;
        }
      };

      $scope.tab3DisablePrevPage = function() {
        return $scope.dashboardModel.currentPage === 0 ? "disabled" : "";
      };

      $scope.tab3pageCount = function() {
        return Math.ceil($scope.dashboardModel.companies_geos.length/$scope.dashboardModel.itemsPerPage)-1;
      };

      $scope.tab3nextPage = function() {
        if ($scope.dashboardModel.currentPage < $scope.tab3pageCount()) {
          $scope.dashboardModel.currentPage++;
        }
      };

      $scope.tab3DisableNextPage = function() {
        return $scope.dashboardModel.currentPage === $scope.tab3pageCount() ? "disabled" : "";
      };
      $scope.setPage = function(n) {
        $scope.dashboardModel.currentPage = n;
      };

      //tab 4
      $scope.tab4prevPage = function() {
        if ($scope.dashboardModel.currentPage > 0) {
          $scope.dashboardModel.currentPage--;
        }
      };

      $scope.tab4DisablePrevPage = function() {
        return $scope.dashboardModel.currentPage === 0 ? "disabled" : "";
      };

      $scope.tab4pageCount = function() {
        return Math.ceil($scope.dashboardModel.companies_revenue.length/$scope.dashboardModel.itemsPerPage)-1;
      };

      $scope.tab4nextPage = function() {
        if ($scope.dashboardModel.currentPage < $scope.tab4pageCount()) {
          $scope.dashboardModel.currentPage++;
        }
      };

      $scope.tab4DisableNextPage = function() {
        return $scope.dashboardModel.currentPage === $scope.tab4pageCount() ? "disabled" : "";
      };
      $scope.setPage = function(n) {
        $scope.dashboardModel.currentPage = n;
      };
             
    

    //end code

    


    $scope.dashboardModel.segmentViewFlag = 2;
    $scope.dashboardModel.geoViewFlag = 2;
    $scope.go = function ( path ) {
      window.location=path;
    };

    $scope.getMasterData= function(){
      $http({method:'GET',url:CONFIGS.URL+'/growths'})
      .success(function(data, status, headers, config){
        
        
        
        var companies=JSON.parse(data.companies);
        //$scope.dashboardModel.companies=companies;
        var Allcompanies = JSON.parse(data.companies);
        $scope.dashboardModel.Allcompanies=Allcompanies;
        $scope.dashboardModel.geos=data.geos;
        $scope.dashboardModel.revenues=data.revenues;
        $scope.dashboardModel.growths = data.growth;
        
        $scope.dashboardModel.countries=data.countries;
        $scope.dashboardModel.regions=data.regions;
        
        var All=Object();
        All.id='All';
        All.name='All regions';

        $scope.dashboardModel.regions.unshift(All);
        var All=Object();
        All.id='All';
        All.name='All countries';
        $scope.dashboardModel.countries.unshift(All);
        
      })
      .error(function(data, status, headers, config){

      });
    }
    $scope.validateCompanyGrowthForm = function(){

      /*var countGrowthYear = $("input[name='growthValue[]']").filter(function(){return $(this).val();}).length;
      if(dashboardModel.selected_company != '' && dashboardModel.selected_year != '' && countGrowthYear != 0){
        dashboardModel.company_growth_error = [];
      } else{
        dashboardModel.company_growth_error.push('Please fill all required fileds.');
      }*/
      if(dashboardModel.selected_company != '' && dashboardModel.selected_year != ''){
        dashboardModel.company_growth_error = [];
      } else{
        dashboardModel.company_growth_error.push('Please fill all required fileds.');
      }


      
    }

    $scope.validateCompanyGeoForm = function(){

      var countGeoYear = $("input[name='GeoValue[]']").filter(function(){return $(this).val();}).length;
      if(dashboardModel.selected_company != '' && dashboardModel.selected_year != '' && countGeoYear != 0){
        dashboardModel.company_geo_error = [];
      } else{
        dashboardModel.company_geo_error.push('Please fill all required fileds.');
      }
    }

    $scope.validateCompanyRevenueForm = function(){

      var countRevenueYear = $("input[name='RevenueValue[]']").filter(function(){return $(this).val();}).length;
      if(dashboardModel.selected_company != '' && dashboardModel.selected_year != '' && countRevenueYear != 0){
        dashboardModel.company_revenue_error = [];
      } else{
        dashboardModel.company_revenue_error.push('Please fill all required fileds.');
      }
    }

    $scope.mergeValuess=function(ids,years,values,revenues){
      var resultVal = Array();
      $(ids).each(function(index,element){
        if(values[index] !=''){
          resultVal.push(ids[index]+'-'+years+'-'+values[index]);
        } else{
          resultVal.push(ids[index]+'-'+years+'-'+revenues[index]);
        }
      });
      return resultVal;
      
    }
    $scope.mergeValues=function(ids,years,values,revenues){
      var resultVal = Array();
      $(ids).each(function(index,element){
        if(values[index] !=''){
          resultVal.push(ids[index]+'-'+years+'-'+values[index]);
        }
      });
      return resultVal;
      
    }

    $scope.baseMergeValues=function(ids,years,values,growths){
      var resultVal = Array();
      $(ids).each(function(index,element){
        if(values[index] !=''){
          if(growths[index] !=''){
            resultVal.push(ids[index]+'-'+years[index]+'-'+values[index]+'-'+growths[index]);  
          } else{
            resultVal.push(ids[index]+'-'+years[index]+'-'+values[index]+'-'+values[index]);
          }
          
        }
      });
      return resultVal;
      
    }

    $scope.baseMergeValuesDiff=function(ids,years,values){
      var resultVal = Array();
      $(ids).each(function(index,element){
        if(values[index] !=''){
          resultVal.push(ids[index]+'-'+years[index]+'-'+values[index]);  
        }
      });
      return resultVal;
      
    }

    $scope.addCompanyGrowth = function(){
      var types = $("input[name='type_id[]']").map( function() { return $(this).val(); } ).get();
      var baesYears = $("select[name='base_year_value[]']").map( function() { return $(this).val(); } ).get();
      var baseRevenues = $("input[name='base_revenue_value[]']").map( function() { return $(this).val(); } ).get();
      var baseGrowths = $("input[name='base_growth_value[]']").map( function() { return $(this).val(); } ).get();
      var revenue = $("input[name='revenue_value[]']").map( function() { return $(this).val(); } ).get();
      var growths = $("input[name='growth_value[]']").map( function() { return $(this).val(); } ).get();
      
      $scope.dashboardModel.base_values = $scope.baseMergeValues(types,baesYears,baseRevenues,baseGrowths);
      $scope.dashboardModel.revenues_values = $scope.mergeValuess(types,dashboardModel.selected_year,revenue,baseRevenues);
      

      //$scope.validateCompanyGrowthForm();
      if(dashboardModel.company_growth_error.length > 0){
        Messenger().post({
            message: dashboardModel.company_growth_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
          ngProgress.height('5px');
          ngProgress.color('#44B3E0');
          ngProgress.start();
        revenueVal = [];
        baseGrowthsVal = [];
        $(revenue).each(function(ind,ele) {
            var value = ele;
            if (value) {
                revenueVal.push(value);
            }
        }); 
        $(baseGrowths).each(function(ind,ele) {
            var value = ele;
            if (value) {
                baseGrowthsVal.push(value);
            }
        }); 
        if(revenueVal =='' && baseGrowthsVal==''){
          $scope.dashboardModel.base_values  = $scope.baseMergeValuesDiff(types,baesYears,baseRevenues);
          $http({method:'POST',url:CONFIGS.URL+'/company_growths/apidiff',data:$scope.dashboardModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
            .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              //$scope.dashboardModel.companyGrowths.push(data);
              ngProgress.complete();
              ngProgress.stop();
              $scope.go('#dashboard');
          })
            .error(function(data, status, headers, config){
              Messenger().post({
                  message: 'internal error.',
                  type: 'error',
                  showCloseButton: true
              });
          }); 
        } else{
          $http({method:'POST',url:CONFIGS.URL+'/company_growths/api',data:$scope.dashboardModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
            .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              //$scope.dashboardModel.companyGrowths.push(data);
              ngProgress.complete();
              ngProgress.stop();
              $scope.go('#dashboard');
          })
            .error(function(data, status, headers, config){
              Messenger().post({
                  message: 'internal error.',
                  type: 'error',
                  showCloseButton: true
              });
          }); 
        }
        
      }
      
    }
    /*$scope.addCompanyGrowth=function(){
      var Growthyears = dashboardModel.selected_year;
      var Growthids = $("input[name='growthIds[]']").map( function() { return $(this).val(); } ).get();
      var Growthvalues = $("input[name='growthValue[]']").map( function() { return $(this).val(); } ).get();

     $scope.dashboardModel.companyGrowthData = $scope.mergeValues(Growthids,Growthyears,Growthvalues);

      $scope.validateCompanyGrowthForm();
      if(dashboardModel.company_growth_error.length > 0){
        Messenger().post({
            message: dashboardModel.company_growth_error[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        $http({method:'POST',url:CONFIGS.URL+'/company_growths',data:$scope.dashboardModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
            Messenger().post({
                message: 'Successfully added',
                type: 'success',
                showCloseButton: true
            });
            //$scope.dashboardModel.companyGrowths.push(data);
            $scope.go('#dashboard');
        })
          .error(function(data, status, headers, config){
            Messenger().post({
                message: 'value against this year is already present',
                type: 'error',
                showCloseButton: true
            });
        });     
      }
    }*/
    $scope.addCompanyGeoPage=function(){
      
      $scope.dashboardModel.selected_year = '';
      $scope.dashboardModel.selected_company = '';
      $scope.go('#/addCompanyGeo');

    }

    $scope.changeGeoView = function(id){
      
      if(id==1){
        $scope.dashboardModel.companies_geos = $scope.dashboardModel.companies_geos_fullData.percent;
        $scope.dashboardModel.percentActive = '/browser_components/images/percent-inactive.png';
        $scope.dashboardModel.dollarActive = '/browser_components/images/usd-active.png';
      } else if(id==2){
        $scope.dashboardModel.companies_geos = $scope.dashboardModel.companies_geos_fullData.dollar;
        $scope.dashboardModel.percentActive = '/browser_components/images/percent-active.png';
        $scope.dashboardModel.dollarActive = '/browser_components/images/usd-inactive.png';
      }
      $scope.dashboardModel.geoViewFlag = id;
    }
    $scope.changeSegView = function(id){
      if(id==1){
        $scope.dashboardModel.companies_revenue = $scope.dashboardModel.companies_revenue_fullData.percent;
        $scope.dashboardModel.percentActive = '/browser_components/images/percent-inactive.png';
        $scope.dashboardModel.dollarActive = '/browser_components/images/usd-active.png';
      } else if(id==2){
        $scope.dashboardModel.companies_revenue = $scope.dashboardModel.companies_revenue_fullData.dollar;
        $scope.dashboardModel.percentActive = '/browser_components/images/percent-active.png';
        $scope.dashboardModel.dollarActive = '/browser_components/images/usd-inactive.png';
      }
      $scope.dashboardModel.segmentViewFlag = id;
    }

    $scope.addCompanyRevenuePage=function(){
      
      $scope.dashboardModel.selected_year = '';
      $scope.dashboardModel.selected_company = '';
      $scope.go('#/addCompanyGrowth');

    }

    $scope.addCompanySegmentPage=function(){
      
      $scope.dashboardModel.selected_year = '';
      $scope.dashboardModel.selected_company = '';
      $scope.go('#/addCompanySegment');

    }

    $scope.fetchCompanyYearRevenue=function(){
      if($scope.dashboardModel.selected_year==''){
        $scope.dashboardModel.selected_year = '2014';
      } 
      
      $http({method:'GET',url:CONFIGS.URL+'/company_growths/getcompanygrowth/'+$scope.dashboardModel.selected_company+'/'+$scope.dashboardModel.selected_year,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
            $('input[name="base_revenue_value[]"]').val('');
            $('input[name="base_growth_value[]"]').val('');
            $('input[name="growth_value[]"]').val('');
            $('input[name="revenue_value[]"]').val('');

            if(data.baseValue.length > 0){
              $('input[name="base_revenue_value[]"]').val('');
              $('input[name="base_growth_value[]"]').val('');
              $('input[name="growth_value[]"]').val('');
              $(data.baseValue).each(function(index,element){
                var id=element.revenue_type;
                $('#base_revenue_value_'+id).val(element.value);
                $('#base_growth_value_'+id).val(element.growth_value);
                $('#base_year_value_'+id).val(element.year);
              });
            } else{
              $('input[name="base_revenue_value[]"]').val('');
              $('input[name="base_growth_value[]"]').val(''); 
            }

            if(data.revenues.length > 0){
              $('input[name="growth_value[]"]').val('');
              $(data.revenues).each(function(index,element){
                var id=element.revenue_type;
                $('#revenue_value_'+id).val(element.growth_value);
                $('#growth_value_'+id).val(element.base_value);  
              });
            } else{
              $('input[name="growth_value[]"]').val(''); 
              $('input[name="revenue_value[]"]').val('');
            }

            
        }).error(function(data, status, headers, config){
           
        });
    }

    $scope.fetchCompanyYearGeo=function(){
      if($scope.dashboardModel.selected_year==''){
        $scope.dashboardModel.selected_year = '2014';
        $('#yearG').select2('val','2014');
      }
      $http({method:'GET',url:CONFIGS.URL+'/company_geos/getcompanygeos/'+$scope.dashboardModel.selected_company+'/'+$scope.dashboardModel.selected_year,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
            if(data.length > 0){
              $('input[name="GeoValue[]"]').val('');
              $(data).each(function(index,element){
                
                var id=element.geo_id -1;
                $('#geoValue_'+id).val(element.value);  
              });
            } else{
              $('input[name="GeoValue[]"]').val('');  
            }
        }).error(function(data, status, headers, config){
           
        });
    }

    $scope.fetchCompanyYearSegment=function(){
      if($scope.dashboardModel.selected_year==''){
        $scope.dashboardModel.selected_year = '2014';
        $('#yearS').select2('val','2014');
      }
      $http({method:'GET',url:CONFIGS.URL+'/company_revenues/getcompanyrevenue/'+$scope.dashboardModel.selected_company+'/'+$scope.dashboardModel.selected_year,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
            if(data.length > 0){
              $('input[name="RevenueValue[]"]').val('');
              $(data).each(function(index,element){
                var id=element.revenue_id;
                $('#revenueValue_'+id).val(element.value);  
              });
            } else{
              $('input[name="RevenueValue[]"]').val('');  
            }
        }).error(function(data, status, headers, config){
           
        });
    }

    $scope.addCompanySegment=function(){
     
     
      var Revenueyears = dashboardModel.selected_year;
      var Revenueids = $("input[name='RevenueIds[]']").map( function() { return $(this).val(); } ).get();
      var Revenuevalues = $("input[name='RevenueValue[]']").map( function() { return $(this).val(); } ).get();

      $scope.dashboardModel.companyRevenueData = $scope.mergeValues(Revenueids,Revenueyears,Revenuevalues);
      $scope.validateCompanyRevenueForm();
      var revenueTotal = 0;
      $(Revenuevalues).each(function(index,element){
        revenueTotal = parseInt(revenueTotal) + parseInt((element!='')?element:0);
      });
      if(revenueTotal > 100){
          Messenger().post({
              message: 'All Segments Values must be equal or less than 100',
              type: 'error',
              showCloseButton: true
          });
      } else{
        if(dashboardModel.company_revenue_error.length > 0){
          Messenger().post({
              message: dashboardModel.company_revenue_error[0],
              type: 'error',
              showCloseButton: true
          });
        } else{
          $http({method:'POST',url:CONFIGS.URL+'/company_revenues',data:$scope.dashboardModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
            .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.go('#dashboard');
              //$scope.dashboardModel.revenues.push(data);
          })
            .error(function(data, status, headers, config){
              Messenger().post({
                  message: 'value against this year is already present',
                  type: 'error',
                  showCloseButton: true
              });
          });     
        }
      }
     
      
    }

    $scope.addCompanyGeo=function(){
      
      var Geoyears = dashboardModel.selected_year;
      var Geoids = $("input[name='GeoIds[]']").map( function() { return $(this).val(); } ).get();
      var Geovalues = $("input[name='GeoValue[]']").map( function() { return $(this).val(); } ).get();

     $scope.dashboardModel.companyGeoData = $scope.mergeValues(Geoids,Geoyears,Geovalues);

     //$scope.validateCompanyGeoForm();
     var geoTotal = 0;
      $(Geovalues).each(function(index,element){
        geoTotal = parseInt(geoTotal) + parseInt((element!='')?element:0);
      });
      if(geoTotal > 100){
          Messenger().post({
              message: 'All Geo Values must be equal or less than 100',
              type: 'error',
              showCloseButton: true
          });
      } else{
        if(dashboardModel.company_geo_error.length > 0){
          Messenger().post({
              message: dashboardModel.company_geo_error[0],
              type: 'error',
              showCloseButton: true
          });
        } else{
          ngProgress.height('5px');
          ngProgress.color('#44B3E0');
          ngProgress.start();
          $http({method:'POST',url:CONFIGS.URL+'/company_geos',data:$scope.dashboardModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
            .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Successfully added',
                  type: 'success',
                  showCloseButton: true
              });
              ngProgress.complete();
              ngProgress.stop();
              $scope.go('#dashboard');
              //$scope.dashboardModel.geos.push(data);
          })
            .error(function(data, status, headers, config){
              Messenger().post({
                  message: 'value against this year is already present',
                  type: 'error',
                  showCloseButton: true
              });
          });    
        }
      }
     
      
    }

    
    $scope.filterCompanies=function(){
        ngProgress.height('5px');
        ngProgress.color('#44B3E0');
        ngProgress.start();
        $scope.dashboardModel.x = 0 ;
        var m = dashboardModel.selected_comp_filter; 
        var c = dashboardModel.selected_country_filter;
        var r = dashboardModel.selected_region_filter;
        var y = dashboardModel.selected_year_filter;
        var min = dashboardModel.revenueMin;
        var max = dashboardModel.revenueMax;


        if (!dashboardModel.selected_comp_filter)
          m='All';
        if (!dashboardModel.selected_country_filter)
          c='All';
        if (!dashboardModel.selected_region_filter)
          r='All';
        if (!dashboardModel.selected_year_filter)
          y='All';


        //companies
        $http({method:'GET',url:CONFIGS.URL+'/companies/getbyName/'+m+'/'+c+'/'+r+'/'+y+'/'+min+'/'+max,headers : {'Content-Type':'application/json; charset=UTF-8'}})
        .success(function(data, status, headers, config){
            


            $scope.dashboardModel.companies=[];
            $(data).each(function(index,ele){
              var cCC=JSON.parse(ele);
              $scope.dashboardModel.companies[index]=cCC;
            });
            $scope.homeModel.companyTotal = $scope.dashboardModel.companies.length;
            //data table
            $scope.dashboardModel.x = $scope.dashboardModel.x + 1;
            $scope.loadingImage();
            
        })
          .error(function(data, status, headers, config){
        });

        //companies growth
        $http({method:'GET',url:CONFIGS.URL+'/companies/getCompaniesGrowth/'+m+'/'+c+'/'+r+'/'+y+'/'+min+'/'+max,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
            
            $scope.dashboardModel.x = $scope.dashboardModel.x + 1;
            $scope.loadingImage();

            $scope.dashboardModel.companyGrowths=data;

            $scope.homeModel.revenueTotal =0;
            $scope.homeModel.users =0;
            $($scope.dashboardModel.companyGrowths).each(function(i,e){
              $scope.homeModel.revenueTotal = $scope.homeModel.revenueTotal  + ((e.index_1)?e.index_1:0);
              $scope.homeModel.users = $scope.homeModel.users  + ((e.GrowthRate)?e.GrowthRate:0);
            });

            
          })
            .error(function(data, status, headers, config){
        });

        //companies geo
        $http({method:'GET',url:CONFIGS.URL+'/companies/getCompaniesGeo/'+m+'/'+c+'/'+r+'/'+y+'/'+min+'/'+max,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
            $scope.dashboardModel.companies_geos_fullData = data;
            $scope.dashboardModel.companies_geos=data.dollar;
            $scope.dashboardModel.x = $scope.dashboardModel.x + 1;
            $scope.loadingImage();

        }).error(function(data, status, headers, config){
        });
        

        //companies revenue
        $http({method:'GET',url:CONFIGS.URL+'/companies/getCompaniesRevenue/'+m+'/'+c+'/'+r+'/'+y+'/'+min+'/'+max,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
            $scope.dashboardModel.companies_revenue_fullData = data;
            $scope.dashboardModel.companies_revenue=data.dollar;
            $scope.dashboardModel.x = $scope.dashboardModel.x + 1;
            $scope.loadingImage();
            ngProgress.complete();
            ngProgress.stop();
            
        })
            .error(function(data, status, headers, config){
        });
        ngProgress.complete();
        ngProgress.stop();

        
    }

    $scope.loadingImage = function(){
      if($scope.dashboardModel.x > 2){
        $scope.dashboardModel.loading = false;
      } else{
        $scope.dashboardModel.loading = true;
      }
    }

    
  $scope.getCompanyDetail=function(companyId,index){
      
      var current=$scope.dashboardModel.companies[index];
      $scope.dashboardModel.companies.splice(index,1);
      $http({method:'GET',url:CONFIGS.URL+'/companies/getbyId/'+companyId,headers : {'Content-Type':'application/json; charset=UTF-8'}})
        .success(function(data, status, headers, config){
            $scope.dashboardModel.companies[index] = data;
            $scope.dashboardModel.companies[$scope.dashboardModel.companies.length] = current;
        })
          .error(function(data, status, headers, config){
        });  
    }




    $scope.getCompGrowthData=function(){
      $http({method:'GET',url:CONFIGS.URL+'/companies/getCompaniesGrowthFirst/All/All/All/All/'+$scope.dashboardModel.revenueMin+'/'+$scope.dashboardModel.revenueMax,headers : {'Content-Type':'application/json; charset=UTF-8'}})
      .success(function(data, status, headers, config){
          $scope.dashboardModel.companyGrowths=data;
        })
          .error(function(data, status, headers, config){
      });
    }
    $scope.getCompRevenueData=function(){

      $http({method:'GET',url:CONFIGS.URL+'/companies/getCompaniesRevenue/All/All/All/All/'+$scope.dashboardModel.revenueMin+'/'+$scope.dashboardModel.revenueMax,headers : {'Content-Type':'application/json; charset=UTF-8'}})
      .success(function(data, status, headers, config){
          $scope.dashboardModel.companies_revenue=data;
        })
          .error(function(data, status, headers, config){
      });
      
    }
    $scope.getCompGeoData=function(){
      $http({method:'GET',url:CONFIGS.URL+'/companies/getCompaniesGeo/All/All/All/All/'+$scope.dashboardModel.revenueMin+'/'+$scope.dashboardModel.revenueMax,headers : {'Content-Type':'application/json; charset=UTF-8'}})
      .success(function(data, status, headers, config){
          $scope.dashboardModel.companies_geos=data;
        })
          .error(function(data, status, headers, config){
      });
    }

      $scope.getMasterData();
      /*$scope.getCompGrowthData();
      $scope.getCompRevenueData();
      $scope.getCompGeoData();*/
      $scope.filterCompanies();
    
      $scope.setTab = function(tab){
        
        $scope.selectedTab = tab;
        if(tab==3 || tab==4){
          $scope.dashboardModel.percentActive = '/browser_components/images/percent-active.png';
          $scope.dashboardModel.dollarActive = '/browser_components/images/usd-inactive.png';

          $scope.dashboardModel.companies_geos = $scope.dashboardModel.companies_geos_fullData.dollar;
          $scope.dashboardModel.companies_revenue = $scope.dashboardModel.companies_revenue_fullData.dollar;

          $scope.dashboardModel.geoViewFlag = 2;
          $scope.dashboardModel.segmentViewFlag = 2;

        }
      }

      $scope.sort = {
        column: 'A',
        descending: false
      }
      $scope.selectedCls = function(column) {
         return column == $scope.sort.column && 'sort-' + $scope.sort.descending;
      };

      $scope.changeSorting=function(column){
        
        var sort = $scope.sort;

        if (sort.column == column) {
            sort.descending = !sort.descending;
        } else {
            sort.column = column;
            sort.descending = false;
        }

        
      }

      

      $scope.sorder = function(predicate, reverse) {
        $scope.dashboardModel.companies_geos = orderBy($scope.dashboardModel.companies_geos, predicate, reverse);
      };


      

      $scope.clearAll=function(){
        dashboardModel.selected_comp_filter=''; 
        dashboardModel.selected_country_filter='All';
        dashboardModel.selected_region_filter='All';
        dashboardModel.selected_year_filter='All';
        dashboardModel.revenueMin='0';

        dashboardModel.revenueMax='1000';
        $('.ngrs-value-max').html('Max');
        $scope.filterCompanies();
      }

      $scope.getGrowthName=function(id){
        return 'asd_'+id;
      }

      $scope.addForm = function(){
        if($scope.selectedTab==1){
          $scope.addComp();
          $scope.go('#/addCompany');
        } else if($scope.selectedTab == 2){
          $scope.addCompanyRevenuePage();
        } else if($scope.selectedTab == 3){
          $scope.addCompanyGeoPage();
        } else if($scope.selectedTab == 4){
          $scope.addCompanySegmentPage();
        }
      }

      $scope.changeView = function(id){
        if($scope.selectedTab==3){
          $scope.changeGeoView(id);
        } else if($scope.selectedTab==4){
          $scope.changeSegView(id);
        }
      }

      $scope.addComp=function(){
        
        $scope.companyModel.ceo='';
        $scope.companyModel.psl='';
        $scope.companyModel.nofdcs='';
        $scope.companyModel.dclocation='';
        $scope.companyModel.dcpartner='';
        $scope.companyModel.name='';
        $scope.companyModel.website='';
        $scope.companyModel.name='';

        
        $scope.companyModel.investor='';
        $scope.companyModel.selected_analyst='';
        $scope.companyModel.selected_status='';
        $scope.companyModel.selected_country ='';
        $scope.companyModel.selected_confidence_level='';
        $scope.companyModel.edit_company_id='';
        $scope.companyModel.selected_companyType='';
        $scope.companyModel.selected_nda='';
        $scope.companyModel.selected_region='';

        $scope.companyModel.selected_city='';
        $scope.companyModel.selected_state='';

        $scope.companyModel.editedGeoData='';
        $scope.companyModel.editedGeoDataHead='';
        
        $scope.companyModel.editedRevenueData='';
        $scope.companyModel.editedRevenueDataHead='';
        //console.log(data.companyGrowths);

        $scope.companyModel.editedSegmentData='';
        $scope.companyModel.editedSegmentDataHead='';
      }

      $scope.deleteCompany = function(id){
        if(confirm("Do you want to delete?")){
          $http({method:'delete',url:CONFIGS.URL+'/companies/destroy/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              Messenger().post({
                  message: 'Delete Successfully',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.go('#dashboard');
            })
              .error(function(data, status, headers, config){
          });
        } 
      }
      $scope.editCompany=function(id){
         $http({method:'GET',url:CONFIGS.URL+'/companies/getbyId/'+id,headers : {'Content-Type':'application/json; charset=UTF-8'}})
          .success(function(data, status, headers, config){
              $scope.go('#editCompany');
              
              
              $scope.companyModel.selected_analyst = parseInt(data.analyst_id);
              $scope.companyModel.selected_status = parseInt(data.status_id);
              $scope.companyModel.ceo=data.CEO;
              $scope.companyModel.psl=data.PSL;
              $scope.companyModel.nofdcs=data.no_of_DCS;
              $scope.companyModel.dclocation=data.dclocation;
              $scope.companyModel.dcpartner=data.dcpartner;
              $scope.companyModel.name=data.name;
              $scope.companyModel.website=data.website;
              $scope.companyModel.name=data.name;
              $scope.companyModel.parent_company = data.parent_company

              var investor = (data.companyInvestors!='')?data.companyInvestors[0].investor:'';
              $scope.companyModel.investor=investor;
              $scope.companyModel.selected_country = data.country_id;
              $scope.companyModel.selected_confidence_level= data.confidence_level_id;
              $scope.companyModel.edit_company_id=data.id;
              $scope.companyModel.selected_companyType=data.company_type_id;
              $scope.companyModel.selected_nda=data.nda_id;
              $scope.companyModel.selected_region=data.region_id;

              $scope.companyModel.selected_city=data.city_id;
              $scope.companyModel.selected_state=data.state_id;



              $scope.companyModel.editedGeoData=data.companyGeos;
              $scope.companyModel.editedGeoDataHead=dashboardModel.geos;
              
              $scope.companyModel.editedRevenueData=data.companyGrowths;
              $scope.companyModel.editedRevenueDataHead=dashboardModel.growths;
              //console.log(data.companyGrowths);

              $scope.companyModel.editedSegmentData=data.companyRevenues;
              $scope.companyModel.editedSegmentDataHead=dashboardModel.revenues;
              
              
              $(data.classifications).each(function(index,element){
                $scope.companyModel.selectedClassifications.push(element.id);
              });

              /*setTimeout(function(){
                $('#companytypeId').select2({placeholder:'Please select company Type'});
                $('#hqstateId').select2({placeholder:'Please select HQ State'});
                $('#hqcityId').select2({placeholder:'Please select HQ City'});
                $('#regionId').select2({placeholder:'Please select region'});
                $('#countryId').select2({placeholder:'Please select country'});
                $('#ndaId').select2({placeholder:'Please select nda'});
                $('#confidenceId').select2({placeholder:'Please select confidence'});
                $('#status').select2({placeholder:'Please select status'});
                $('#analyst').select2({placeholder:'Please select analyst'});
                
                
                $('#classification').select2();
                //$('#classification').select2({placeholder:'Classification'});
              }, 1500);*/

            })
              .error(function(data, status, headers, config){
          });
         
      }

      $scope.myFilter = function(text){
        
        return true;
      }

      

  }])
  .directive('rangeSlider', function ($parse) {
    return {
      restrict: 'A',
      link: function ($scope, element, attrs) {
       var slider = $(element[0]).slider({
        range: true,
        step: 1,
        min: 0,
        max: 1000,
        slide:function(event, ui){
          if($scope.dashboardModel.revenueMax==1000){
            $('.ngrs-value-max').html('Max');
          } else{
            $('.ngrs-value-max').html(ui.values[1]);
          }
        },
        stop:function(event, ui){
            $scope.dashboardModel.revenueMax = ui.values[1];
            if($scope.dashboardModel.selected_year_filter = 'All'){
              $scope.dashboardModel.selected_year_filter = '2014';
            }
            if($scope.dashboardModel.revenueMax==1000){
              $('.ngrs-value-max').html('Max');
            } else{
              $('.ngrs-value-max').html(ui.values[1]);
            }
            $scope.filterCompanies();
            
          }
        });
      }
    }
  }).filter('pagination', function()
{
  return function(input, start) {
    start = parseInt(start, 10);
    return input.slice(start);
  };
}).directive("bnRepeatDelimiter",function() {
 
 
                // I compile the list, injecting in the conditionally
                // visible delimiter onto the end of the template.
                function compile( element, attributes ) {
 
                    // Get the delimiter that goes between each item.
                    var delimiter = ( attributes.bnRepeatDelimiter || "," );
 
                    // The delimiter will show on all BUT the last
                    // item in the list.
                    var delimiterHtml = (
                        "<span ng-show=' ! $last '>" +
                            delimiter +
                        "</span>"
                    );
 
                    // Add the delimiter to the end of the list item,
                    // making sure to add the existing whitespace back
                    // in after the delimiter.
                    var html = element.html().replace(
                        /(\s*$)/i,
                        function( whitespace ) {
 
                            return( delimiterHtml + whitespace );
 
                        }
                    );
 
                    // Update the compiled HTML.
                    element.html( html );
 
                }
 
 
                // Return the directive configuration. Notice that
                // our priority is 1 higher than ngRepeat - this will
                // be compiled before the ngRepeat compiles.
                return({
                    compile: compile,
                    priority: 1001,
                    restirct: "A"
                });
 
 
            });