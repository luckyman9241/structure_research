/* Home Controller Managing Login and Other Relevant Stuff */

angular.module('myApp.controllers.company',[])
  .service("companyModel",['localStorageService','$rootScope','$http','CONFIGS',function(localStorageService,$rootScope,$http,CONFIGS){
    var self = this;
    
    self.confidence_levels = [];
    self.ndas = [];
    self.statuses= [];
    self.analysts = [];
    self.cities = [];
    self.states = [];
    self.countries = [];
    self.companyTypes = [];
    self.SegmentApplyAll = 0;
    self.GeoApplyAll = 0;
    self.base_values = [];
    self.revenues_values = [];
    self.selected_base_year='';

    self.growths = [];
    self.revenues = [];
    self.geos = [];
    self.classifications = [];
    
    self.selected_confidence_level = '';
    self.selected_nda = '';
    self.selected_city = '';
    self.selected_state = '';
    self.selected_country = '';
    self.selected_companyType = '';
    self.selected_region = '';
    self.selected_status = '';
    self.selected_analyst = '';

    
    self.companyGrowthData = '';
    self.companyRevenueData = '';
    self.companyGeoData = '';

    self.editedGeoData=[];
    self.editedGeoDataHead=[];

    


    self.edit_company_id='';
    
    
    self.ceo='';
    self.psl='';
    self.nofdcs='';
    self.dclocation='';
    self.dcpartner='';
    self.name='';
    self.investor='';
    self.parent_company = '';

    
    self.compTotalRevenue='';
    self.compTotalRevenueYear='';

    self.selected_classifications='';
    self.selectedClassifications=[];

    self.errors = [];
  
  }])
  .controller('CompanyController', ['localStorageService','$scope','companyModel','$location','$route','CONFIGS','$http',function(localStorageService,$scope,companyModel,$location,$route,CONFIGS,$http) {
    $scope.companyModel=companyModel;
    $scope.go = function ( path ) {
      window.location=path;
    };

    $scope.getMasterData= function(){
      $http({method:'GET',url:CONFIGS.URL+'/companies/masterData'})
      .success(function(data, status, headers, config){
        $scope.companyModel.confidence_levels = data.confidence_levels;
        $scope.companyModel.ndas = data.ndas;
        $scope.companyModel.statuses = data.statuses;
        $scope.companyModel.analysts = data.analysts;
        $scope.companyModel.cities = data.cities;
        $scope.companyModel.states = data.states;
        $scope.companyModel.countries = data.countries;
        $scope.companyModel.companyTypes = data.companyTypes;
        $scope.companyModel.regions = data.regions;
        $scope.companyModel.classifications=data.classifications;
        $scope.companyModel.geos=data.geos;
        $scope.companyModel.revenues=data.revenues;
        $scope.companyModel.growths=data.growths;
      })
      .error(function(data, status, headers, config){

      });
    }

    $scope.getMasterData();

    /*if(typeof(localStorageService.get("session")!='undefined')){
      scope.userModel = localStorageService.get("session");
    }*/
    $scope.$on('sessionModel::loggedIn', function(broadcast) {
      //Fill the data in
      //$('#login-modal').modal('hide');
      $scope.companyModel = companyModel;
      $location.path( "/dashboard/" );
     
    });

    $scope.checkYears=function(){
      var countGrowthYear = $("input[name='growthValue[]']").filter(function(){return $(this).val();}).length;
      var countRevenueYear = $("input[name='RevenueValue[]']").filter(function(){return $(this).val();}).length;
      var countGeoYear = $("input[name='GeoValue[]']").filter(function(){return $(this).val();}).length;
      
      if(countGrowthYear != 0){
        if($("#GrwothYearSelect").val() == ''){
          companyModel.errors[0]='Please fill Year.';
        }
        
      }
      if(countRevenueYear != 0){
        if($("#RevenueYearSelect").val() == ''){
          companyModel.errors[0]='Please fill Year.';
        } 
      }
      if(countGeoYear != 0){
        if($("#GeoYearSelect").val() == ''){
          companyModel.errors[0]='Please fill Year.';
        } 

      }
    }



    $scope.validateForm=function(){
      if( companyModel.name != ''/*companyModel.selected_confidence_level != '' 
          && companyModel.selected_nda != '' 
          && companyModel.selected_city != '' 
          && companyModel.selected_state != ''
          && companyModel.selected_country != ''
          && companyModel.selected_companyType != ''
          && companyModel.analyst != ''
          && companyModel.status != ''
          && companyModel.ceo != ''
          && companyModel.psl != ''
          && companyModel.nofdcs != ''
          && companyModel.name != ''
          && companyModel.dclocation != ''
          && companyModel.dcpartner != ''
          && companyModel.investor != ''*/
        ){
          companyModel.errors = [];
          $scope.checkYears();
          
      } else{
        companyModel.errors.push('Please fill required fileds.');
      }
    }

    $scope.toObject=function(arr){
      var rv = {};
      for (var i = 0; i < arr.length; ++i)
        rv[i] = arr[i];
      return rv;
    }

    $scope.mergeValues=function(ids,years,values){
      
      var resultVal = Array();
      var year = '';
      var yearCount = 0;
      $(ids).each(function(index,element){
        if(ids[index]==1){
          year = years[yearCount];
          yearCount++;
        }
        if(values[index] !=''){
          resultVal.push(ids[index]+'-'+year+'-'+values[index]);
        }
      });
      
      return resultVal;
      
    }

    $scope.hasDuplicates = function(array) {
        var valuesSoFar = {};
        for (var i = 0; i < array.length; ++i) {
            var value = array[i];
            if (Object.prototype.hasOwnProperty.call(valuesSoFar, value)) {
                return true;
            }
            valuesSoFar[value] = true;
        }
        return false;
    }

    /*$scope.baseMergeValues=function(ids,years,values,growths){
      var resultVal = Array();
      $(ids).each(function(index,element){
        if(values[index] !=''){
          resultVal.push(ids[index]+'-'+years[index]+'-'+values[index]+'-'+growths[index]);
        }
      });
      return resultVal;
      
    }*/
    $scope.mergeValues=function(ids,years,values){
      var resultVal = Array();
      $(ids).each(function(index,element){
        if(values[index] !=''){
          resultVal.push(ids[index]+'-'+years+'-'+values[index]);
        } else{
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
    $scope.mergeValues2=function(ids,years,values){
      var resultVal = Array();
      $(ids).each(function(index,element){
        if(values[index] !=''){
          resultVal.push(ids[index]+'-'+years+'-'+values[index]);
        }
      });
      return resultVal;
      
    }

    $scope.addCompany= function(){
      

        
      $scope.validateForm();
      
       if(companyModel.errors.length > 0){
        Messenger().post({
            message: companyModel.errors[0],
            type: 'error',
            showCloseButton: true
        });
      } else{
        var Growthyears = $("select[name='GrwothYearSelect[]']").map( function() { return $(this).val(); } ).get();
        //var Growthids = $("input[name='growthIds[]']").map( function() { return $(this).val(); } ).get();
        //var Growthvalues = $("input[name='growthValue[]']").map( function() { return $(this).val(); } ).get();
        var types = $("input[name='type_id[]']").map( function() { return $(this).val(); } ).get();
        var baesYears = $("select[name='base_year_value[]']").map( function() { return $(this).val(); } ).get();
        var baseRevenues = $("input[name='base_revenue_value[]']").map( function() { return $(this).val(); } ).get();
        var baseGrowths = $("input[name='base_growth_value[]']").map( function() { return $(this).val(); } ).get();
        var revenue = $("input[name='revenue_value[]']").map( function() { return $(this).val(); } ).get();

        var Revenueyears = $("select[name='RevenueYearSelect[]']").map( function() { return $(this).val(); } ).get();
        var Revenueids = $("input[name='RevenueIds[]']").map( function() { return $(this).val(); } ).get();
        var Revenuevalues = $("input[name='RevenueValue[]']").map( function() { return $(this).val(); } ).get();

        var Geoyears = $("select[name='GeoYearSelect[]']").map( function() { return $(this).val(); } ).get();
        var Geoids = $("input[name='GeoIds[]']").map( function() { return $(this).val(); } ).get();
        var Geovalues = $("input[name='GeoValue[]']").map( function() { return $(this).val(); } ).get();
        

            

        if($scope.hasDuplicates(Growthyears)){
          Messenger().post({
              message: 'Duplicate years in Revenue Section.',
              type: 'error',
              showCloseButton: true
          });
        } 
        if($scope.hasDuplicates(Revenueyears)){
          Messenger().post({
              message: 'Duplicate years in Segment Section.',
              type: 'error',
              showCloseButton: true
          });
        } 
        if($scope.hasDuplicates(Geoyears)){
          Messenger().post({
              message: 'Duplicate years in Geo Section.',
              type: 'error',
              showCloseButton: true
          });
        } 

          var geoTotal= 0;
          var revTotal= 0;
          $(Geovalues).each(function(index,element){
            geoTotal = parseInt(geoTotal) + parseInt((element!='')?element:0);
          });

          $(Revenuevalues).each(function(index,element){
            revTotal = parseInt(revTotal) + parseInt((element!='')?element:0);
          });

          if(geoTotal > 100){
              Messenger().post({
                  message: 'All Geo Values must be equal or less than 100',
                  type: 'error',
                  showCloseButton: true
              });
          } else if(revTotal > 100){
              Messenger().post({
                  message: 'All Revenue Values must be equal or less than 100',
                  type: 'error',
                  showCloseButton: true
              });
          } else{
            $scope.companyModel.compTotalRevenueYear = Growthyears;
            //growth values 
            $scope.companyModel.base_values = $scope.baseMergeValues(types,baesYears,baseRevenues,baseGrowths);
            $scope.companyModel.revenues_values = $scope.mergeValues(types,companyModel.selected_year,revenue,baseRevenues);
            //$scope.companyModel.revenues_values = $scope.mergeValues2(types,companyModel.selected_base_year,revenue);

            $scope.companyModel.companyRevenueData = $scope.mergeValues(Revenueids,Revenueyears,Revenuevalues);
            $scope.companyModel.companyGeoData = $scope.mergeValues(Geoids,Geoyears,Geovalues);

            
            $http({method:'POST',url:CONFIGS.URL+'/companies',data:$scope.companyModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
            .success(function(data, status, headers, config){
               Messenger().post({
                  message: 'successfully Added',
                  type: 'success',
                  showCloseButton: true
              });
              $scope.go('#dashboard');
              location.reload();
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


        
    }

    $scope.mergeEditValues=function(ids,years,values){
      var resultVal = Array();
      $(ids).each(function(index,element){
        if(values[index] !=''){
          resultVal.push(ids[index]+'-'+years[index]+'-'+values[index]);
        }
      });
      return resultVal;
      
    }

    $scope.editCompany=function(){
      

      
      var Growthyears = $("input[name='GrowthYears[]']").map( function() { return $(this).val(); } ).get();
      var Growthids = $("input[name='GrowthIds[]']").map( function() { return $(this).val(); } ).get();
      var Growthvalues = $("input[name='GrowthValue[]']").map( function() { return $(this).val(); } ).get();

      var Revenueyears = $("input[name='RevenueYears[]']").map( function() { return $(this).val(); } ).get();
      var Revenueids = $("input[name='RevenueIds[]']").map( function() { return $(this).val(); } ).get();
      var Revenuevalues = $("input[name='RevenueValue[]']").map( function() { return $(this).val(); } ).get();

      var Geoyears = $("input[name='GeoYears[]']").map( function() { return $(this).val(); } ).get();
      var Geoids = $("input[name='GeoIds[]']").map( function() { return $(this).val(); } ).get();
      var Geovalues = $("input[name='GeoValue[]']").map( function() { return $(this).val(); } ).get();


      $scope.companyModel.companyGrowthData = $scope.mergeEditValues(Growthids,Growthyears,Growthvalues);
      $scope.companyModel.companyRevenueData = $scope.mergeEditValues(Revenueids,Revenueyears,Revenuevalues);
      $scope.companyModel.companyGeoData = $scope.mergeEditValues(Geoids,Geoyears,Geovalues);
      
      //if(!$scope.hasDuplicates(Growthyears) && !!$scope.hasDuplicates(Revenueyears) && !$scope.hasDuplicates(Geoyears)){
        $http({method:'POST',url:CONFIGS.URL+'/companies/updateCompany',data:$scope.companyModel,headers : {'Content-Type':'application/json; charset=UTF-8'}})
        .success(function(data, status, headers, config) {
          Messenger().post({
              message: 'successfully Updated',
              type: 'success',
              showCloseButton: true
          });
          $scope.go('#dashboard');
          location.reload();

        }).
        error(function(data, status, headers, config) {
          
        });
      /*} else{
          Messenger().post({
              message: 'Duplicate Years',
              type: 'error',
              showCloseButton: true
          });
      }*/
      
    }
    
    

    $scope.addMoreRevenue=function(){

      var rand = Math.floor((Math.random() * 100) + 1);
      var table = '<button type="button" class="btn btn-danger btn-xs deleteBtn" recordId="'+rand+'"  style="float:left">Delete</button><div id="box_'+rand+'"><select id="GrwothYearSelect_'+rand+'" class="pull-right moreGrowthYears" name="GrwothYearSelect[]" style="width:50%!important;margin-bottom:10px"><option></option><option value="2010">2010</option><option value="2011">2011</option><option value="2012">2012</option><option value="2013">2013</option><option value="2014">2014</option><option value="2015">2015</option><option value="2016">2016</option><option value="2017">2017</option><option value="2018">2018</option><option value="2019">2019</option></select></h3><table class="table table-striped"><th>Revenue Type</th><th>Value</th>';
            $(companyModel.growths).each(function(index,element){
              table +='<tr><td>'+element.name+'</td><td><input type="hidden" name="growthIds[]" class="moreGrowthIds" value="'+element.id+'"/><input type="text" class="form-control moreGrowthValues" name="growthValue[]" id="nofdcs"  placeholder="Value"/></td></tr>';
            });
          table +='</table></div>';
        $('#moreRevenue').append(table);
        $('#GrwothYearSelect_'+rand).select2({placeholder:'Please select year'});
        $('.deleteBtn').click(function(){
          $(this).remove();
          $('#box_'+$(this).attr('recordId')).remove();
        });
    }

    $scope.addMoreSegment=function(){

      var rand = Math.floor((Math.random() * 100) + 1);
      var table = '<button type="button" class="btn btn-danger btn-xs deleteBtn" recordId="'+rand+'"  style="float:left">Delete</button><div id="box_'+rand+'"><select id="RevenueYearSelect_'+rand+'" name="RevenueYearSelect[]" class="pull-right" style="width:50%!important;margin-bottom:10px"><option></option><option value="2010">2010</option><option value="2011">2011</option><option value="2012">2012</option><option value="2013">2013</option><option value="2014">2014</option><option value="2015">2015</option><option value="2016">2016</option><option value="2017">2017</option><option value="2018">2018</option><option value="2019">2019</option></select></h3><table class="table table-striped"><th>Segment Type</th><th>Value</th>';
            $(companyModel.revenues).each(function(index,element){
              table +='<tr><td>'+element.name+'</td><td><input type="hidden" name="RevenueIds[]" class="moreGrowthIds" value="'+element.id+'"/><input type="text" class="form-control moreGrowthValues" name="RevenueValue[]" id="nofdcs"  placeholder="Value"/></td></tr>';
            });
          table +='</table></div>';
        $('#moreSegment').append(table);
        $('#RevenueYearSelect_'+rand).select2({placeholder:'Please select year'});
        $('.deleteBtn').click(function(){
          $(this).remove();
          $('#box_'+$(this).attr('recordId')).remove();
        });
    }

    $scope.addMoreGeo=function(){

      var rand = Math.floor((Math.random() * 100) + 1);
      var table = '<button type="button" class="btn btn-danger btn-xs deleteBtn" recordId="'+rand+'"  style="float:left">Delete</button><div id="box_'+rand+'"><select id="GeoYearSelect_'+rand+'" name="GeoYearSelect[]" class="pull-right" style="width:50%!important;margin-bottom:10px"><option></option><option value="2010">2010</option><option value="2011">2011</option><option value="2012">2012</option><option value="2013">2013</option><option value="2014">2014</option><option value="2015">2015</option><option value="2016">2016</option><option value="2017">2017</option><option value="2018">2018</option><option value="2019">2019</option></select></h3><table class="table table-striped"><th>Geo Type</th><th>Value</th>';
            $(companyModel.geos).each(function(index,element){
              table +='<tr><td>'+element.name+'</td><td><input type="hidden" name="GeoIds[]" class="moreGrowthIds" value="'+element.id+'"/><input type="text" class="form-control moreGrowthValues" name="GeoValue[]" id="nofdcs"  placeholder="Value"/></td></tr>';
            });
          table +='</table></div>';
        $('#moreGeo').append(table);
        $('#GeoYearSelect_'+rand).select2({placeholder:'Please select year'});
        $('.deleteBtn').click(function(){
          $(this).remove();
          $('#box_'+$(this).attr('recordId')).remove();
        });
    }

    $scope.authenticate = function(){
      $http({method: 'POST', url: CONFIGS.URL+'sessions/login',data:$scope.companyModel}).
      success(function(data, status, headers, config) {
        if(typeof data.success != 'undefined'){
          companyModel = data.user;
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
          
      };
  });