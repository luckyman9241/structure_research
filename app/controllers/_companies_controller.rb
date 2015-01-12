class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
    #result

    if @companies.count>0
      render :json => @companies.to_json(:include =>[:confidenceLevel,:nda,:country,:region,:state,:city,:company_type,:company_investors]), :status=>:ok
    else
      render :json => "No companies found.".to_json
    end
  end


  # GET /companies/settings
  # GET /companies/settings.json


  #GET /companies/getWidgetDetail widget Detail
  def getWidgetDetail
    @companies = Company.all
    @company_growth = BaseValue.where(["revenue_type = 1 AND year = '2014'"]).sum(:base_value)
    @user = User.where(["user_type_id = 2"])
    @growth = 0

    @result = Hash.new

    @result[:companies] = @companies.count
    @result[:company_revenue] = @company_growth
    @result[:users] = @user.count
    render :json=>@result
  end

  

  #get master data
  def masterData
    @companies = Company.find(:all, :order => "Name ASC")
    @company_classifications = CompanyClassification.all
    @ndas = Nda.all
    @statuses = Status.all
    @analysts = Analyst.all
    @country = Country.all
    @state = State.all
    @city = City.all
    @region = Region.all
    @companyType = CompanyType.all
    @confidence_levels = ConfidenceLevel.all
    @classifications = Classification.all
    @currencies = Legend.all
    @currency_year_values = LegendValue.all
    @company_growths = CompanyGrowth.all
    @growths = Growth.all
    @geos = Geo.all
    @revenues = Revenue.find(:all, :order => "id ASC")
    @user_types = UserType.all
    @users = User.all
    @result = Hash.new

    

    #Fetching data of linked tables
    @result[:companies] = @companies
    @result[:company_classifications] = @company_classifications.to_json(:include =>[:company, :classification])
    @result[:ndas] = @ndas
    @result[:statuses] = @statuses
    @result[:analysts] = @analysts
    @result[:countries] = @country
    @result[:states] = @state
    @result[:cities] = @city
    @result[:regions] = @region
    @result[:companyTypes] = @companyType
    @result[:confidence_levels] = @confidence_levels
    @result[:classifications] = @classifications
    @result[:currencies]=@currencies
    @result[:currency_year_values]=@currency_year_values.to_json(:include =>[:legend])
    @result[:company_growths]=@company_growths
    @result[:growths]=@growths
    @result[:geos] = @geos
    @result[:revenues] = @revenues
    @result[:user_types] = @user_types
    @result[:users] = @users.to_json(:include =>[:user_type])
    #result
    if @result.count>0
      render :json => @result, :status=>:ok
    else
      render :json => "No companies found.".to_json
    end
  end


  #get company by id
  def getbyId
    begin
      @company = Company.find(params[:id])
      render :json => @company.to_json(:include =>[:confidenceLevel,:nda,:country,:region,:state,:city,:company_type,:companyInvestors,:classifications,:companyGeos,:companyRevenues,:companyGrowths]), :status=>:ok
    rescue
      render :json=>"No company found"
    end
  end

  #get company by id
  def getbyName
    @country = params[:country]
    @region = params[:region]
    @year = params[:year]

    if params[:name] =='All' and @country=='All' and @region=='All'
      @company = Company.all

      
    
    elsif params[:name]=='All' and @country=='All' and @region!='All'
      @company = Company.where(["region_id = ?",@region])
      
      

    elsif params[:name]!='All' and @country=='All' and @region!='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE ? AND region_id = ?","#{@keyword}%",@region])
      
      

    elsif params[:name]!='All' and @country!='All' and @region=='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE ? AND  country_id = ?","#{@keyword}%",@country])
      
      

    elsif params[:name]=='All' and @country!='All' and @region=='All'
      @company = Company.where(["country_id = ?",@country])
      
      
    
    elsif params[:name]=='All' and @country!='All' and @region!='All'
      @company = Company.where(["region_id = ? AND country_id = ?",@region,@country])
      
      
    
    elsif params[:name]!='All' and @country=='All' and @region=='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE  ?", "#{@keyword}%"])
      
      

    else
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE  ? AND country_id = ? AND region_id = ?","#{@keyword}%",@country,@region])
      #render :json => @company.to_json(:include =>[:confidenceLevel,:nda,:country,:region,:state,:city,:company_type,:companyInvestors,:classifications])
      
    end
    @company_names_array = []
    @count = 0
    @company.each_with_index do |value, index|
      
      #@company_growths = CompanyGrowth.where('value BETWEEN ? AND ? AND year = ? AND company_id = ? AND growth_id = 1',params[:min],params[:max],@year,value.id)
      @company_growths = BaseValue.where('base_value BETWEEN ? AND ? AND year = ? AND company_id = ? AND revenue_type = 1',params[:min],params[:max],@year,value.id)
      
      if @year == 'All'
          @company = Company.where(["id = ?",value.id]).first
          @company_names_array[index] = @company.to_json(:include =>[:confidenceLevel,:nda,:country,:region,:state,:city,:company_type,:companyInvestors,:classifications])
      else
        if @company_growths.count > 0
          @company = Company.where(["id = ?",value.id]).first
          @company_names_array[index] = @company.to_json(:include =>[:confidenceLevel,:nda,:country,:region,:state,:city,:company_type,:companyInvestors,:classifications])
        end
      end
    end

    @company_names_array = @company_names_array-["",nil]
    render :json =>@company_names_array
    
  end

  #get growth
  def getGrowthbyName
    if params[:name]=='All'
      @company_growths = CompanyGrowth.all
      render :json => @company_growths.to_json(:include =>[:company,:growth])
    elsif params[:growth]=='All' && params[:name]=='All'
      @company_growths = CompanyGrowth.all
      render :json => @company_growths.to_json(:include =>[:company,:growth])
    else
      @keyword = params[:name].downcase
      if params[:growth]=='All'
        @company_growths = CompanyGrowth.joins(:company).where("lower(companies.name) LIKE '#{@keyword}%' AND year = '#{params[:year]}'")
      else
        @company_growths = CompanyGrowth.joins(:company).where("lower(companies.name) LIKE '#{@keyword}%' AND growth_id = '#{params[:growth]}'  AND year = '#{params[:year]}'")
      end
      render :json => @company_growths.to_json(:include =>[:company,:growth]);
    end
  end

  def getGeobyName
    if params[:name]=='All'
      @company_geo= CompanyGeo.all
      render :json => @company_geo.to_json(:include =>[:company,:geo])
    elsif params[:geo]=='All' && params[:name]=='All'
      @company_geo = CompanyGeo.all
      render :json => @company_geo.to_json(:include =>[:company,:geo])
    else
      @keyword = params[:name].downcase
      if params[:geo]=='All'
        @company_geo = CompanyGeo.joins(:company).where("lower(companies.name) LIKE '#{@keyword}%' AND year = '#{params[:year]}'")
      else
        @company_geo = CompanyGeo.joins(:company).where("lower(companies.name) LIKE '#{@keyword}%' AND geo_id = '#{params[:geo]}'  AND year = '#{params[:year]}'")
      end
      
      render :json => @company_geo.to_json(:include =>[:company,:geo]);
    end
  end

  def getRevenuebyName
    if params[:name]=='All'
      @company_revenues = CompanyRevenue.all
      render :json => @company_revenues.to_json(:include =>[:company,:revenue])
    elsif params[:revenue]=='All' && params[:name]=='All'
      @company_revenues = CompanyRevenue.all
      render :json => @company_revenues.to_json(:include =>[:company,:revenue])
    else
      @keyword = params[:name].downcase
      if params[:revenue]=='All'
        @company_revenues = CompanyRevenue.joins(:company).where("lower(companies.name) LIKE '#{@keyword}%' AND year = '#{params[:year]}'")
      else
        @company_revenues = CompanyRevenue.joins(:company).where("lower(companies.name) LIKE '#{@keyword}%' AND revenue_id = '#{params[:revenue]}'  AND year = '#{params[:year]}'")
      end
      
      render :json => @company_revenues.to_json(:include =>[:company,:revenue]);
    end

  end


  def getCompaniesGrowthFirst
    
    @company_growths_array = []
    @country = params[:country]
    @region = params[:region]

    @company = CompanyGrowth.where(["value BETWEEN ? AND ? AND year = ? AND growth_id=1",params[:min],params[:max],params[:year]])
    
    @year = params[:year]
    
    @company.each_with_index do |value, index|
      @company_growths = CompanyGrowth.where(:company_id=>value.company_id,:year=>@year)
      @preGrowth = CompanyGrowth.where(["company_id = ? AND year = ?",value.id,(@year.to_i - 1).to_s])

      if @company_growths
        
        @curGrowthVal = 0
        count = 0
        @company_growths_hash = Hash.new  
        @company_growths_hash[:company_name] = value.company.name
        @company_growths_hash[:company_revenue] = value.value
        
        if @preGrowth.empty?
          @company_growths_hash[:previous_company_revenue] = 1
          @pre = 0
        else
          @company_growths_hash[:previous_company_revenue] = @preGrowth.value  
          @pre = @preGrowth.value
        end
        
        @company_growths.each_with_index do |v,i|
          
          if(v.growth_id==1)
            @company_growths_hash[:index_1] = (v.value==0)?0:v.value 
          elsif(v.growth_id==2)
            @company_growths_hash[:index_2] = (v.value==0)?0:v.value
          elsif(v.growth_id==3)
            @company_growths_hash[:index_3] = (v.value==0)?0:v.value
          elsif(v.growth_id==4)
            @company_growths_hash[:index_4] = (v.value==0)?0:v.value
          elsif(v.growth_id==5)
            @company_growths_hash[:index_5] = (v.value==0)?0:v.value
          end

        end
        
        if @preGrowth.count != 0
          @GrowthRate =  (sprintf('%.3f',(sprintf('%.2f',(@company_growths_hash[:company_revenue] - @pre)).to_f) / @company_growths_hash[:previous_company_revenue])) 
          @company_growths_hash[:GrowthRate] = ((@GrowthRate.to_f) * 100)
        else
          @company_growths_hash[:GrowthRate] = 0
        end

      end
        
        if(params[:min].to_f <= value.value.to_f && value.value.to_f <= params[:max].to_f )
          @company_growths_array[index] = @company_growths_hash
        end
    end

    @company_growths_array = @company_growths_array-["",nil]
    render :json => @company_growths_array
  end

  #addcompany
  def getCompaniesGrowth
    
    @company_growths_array = []
    @country = params[:country]
    @region = params[:region]

    if params[:name] =='All' and @country=='All' and @region=='All'
      @company = Company.all
    
    elsif params[:name]=='All' and @country=='All' and @region!='All'
      @company = Company.where(["region_id = ?",@region])
      

    elsif params[:name]!='All' and @country=='All' and @region!='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE ? AND region_id = ?","#{@keyword}%",@region])
      

    elsif params[:name]!='All' and @country!='All' and @region=='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE ? AND  country_id = ?","#{@keyword}%",@country])
      

    elsif params[:name]=='All' and @country!='All' and @region=='All'
      @company = Company.where(["country_id = ?",@country])
      
    
    elsif params[:name]=='All' and @country!='All' and @region!='All'
      @company = Company.where(["region_id = ? AND country_id = ?",@region,@country])
      
    
    elsif params[:name]!='All' and @country=='All' and @region=='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE  ?", "#{@keyword}%"])
      

    else
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE  ? AND country_id = ? AND region_id = ?","#{@keyword}%",@country,@region])
      
    end 
    
    @year = params[:year]
    
    @company.each_with_index do |value, index|
      #@currentGROWTH = CompanyGrowth.where(["company_id = ? AND year = ? AND value BETWEEN ? AND ? AND growth_id = 1 ",value.id,@year,params[:min],params[:max]])
      if params[:max].to_i < 1000
        @currentGROWTH = BaseValue.where('base_value BETWEEN ? AND ? AND year = ? AND company_id = ? AND revenue_type = 1',params[:min],params[:max],@year,value.id)
      else
        @currentGROWTH = BaseValue.where('year = ? AND company_id = ? AND revenue_type = 1',@year,value.id)
      end
      
      if @year == 'All'
          @company_growths = BaseValue.where(["company_id = ? AND year = ?",value.id,2014])
          @curGrowth = BaseValue.where(["company_id = ? AND year = ? AND revenue_type = 1",value.id,2014]).first
          @preGrowth = BaseValue.where(["company_id = ? AND year = ? AND revenue_type = 1",value.id,2013]).first
          
          @company_growths_hash = Hash.new  
          @company_growths_hash[:company_name] = value.name
          #@company_growths_hash[:GrowthRate] = value.base_growth_value
          
          @company_growths.each_with_index do |v,i|
            
            if(v.revenue_type==1)
              @company_growths_hash[:"index_1"] = (v.base_value==0)?0:v.base_value 
            elsif(v.revenue_type==2)
              @company_growths_hash[:"index_2"] = (v.base_value==0)?0:v.base_value
            elsif(v.revenue_type==3)
              @company_growths_hash[:"index_3"] = (v.base_value==0)?0:v.base_value
            elsif(v.revenue_type==4)
              @company_growths_hash[:"index_4"] = (v.base_value==0)?0:v.base_value
            elsif(v.revenue_type==5)
              @company_growths_hash[:"index_5"] = (v.base_value==0)?0:v.base_value
            end
          end
          #adding all geo in array
          @growth = Growth.find(:all, :order => "id ASC")
          @growth.each_with_index do |v,i|
            if @company_growths_hash[:"index_#{v.id}"]
                @company_growths_hash[:"index_#{v.id}"]
            else
              @company_growths_hash[:"index_#{v.id}"] = 0
            end
          end
          @company_growths_hash[:GrowthRate] = (@curGrowth)? (( (@curGrowth.base_growth_value).to_f / (@preGrowth.base_growth_value).to_f ) -1)*100:0
          @company_growths_array[index] = @company_growths_hash
      else
        if @currentGROWTH.count > 0
          
          @company_growths = BaseValue.where(["company_id = ? AND year = ?",value.id,@year])
          @curGrowth = BaseValue.where(["company_id = ? AND year = ? AND revenue_type = 1",value.id,@year]).first
          @preGrowth = BaseValue.where(["company_id = ? AND year = ? AND revenue_type = 1",value.id,(@year.to_i - 1).to_s]).first
          
          @company_growths_hash = Hash.new  
          @company_growths_hash[:company_name] = value.name
          #@company_growths_hash[:GrowthRate] = value.base_growth_value
          
          @company_growths.each_with_index do |v,i|
            
            if(v.revenue_type==1)
              @company_growths_hash[:"index_1"] = (v.base_value==0)?0:v.base_value 
            elsif(v.revenue_type==2)
              @company_growths_hash[:"index_2"] = (v.base_value==0)?0:v.base_value
            elsif(v.revenue_type==3)
              @company_growths_hash[:"index_3"] = (v.base_value==0)?0:v.base_value
            elsif(v.revenue_type==4)
              @company_growths_hash[:"index_4"] = (v.base_value==0)?0:v.base_value
            elsif(v.revenue_type==5)
              @company_growths_hash[:"index_5"] = (v.base_value==0)?0:v.base_value
            end
          end
          #adding all geo in array
          @growth = Growth.find(:all, :order => "id ASC")
          @growth.each_with_index do |v,i|
            if @company_growths_hash[:"index_#{v.id}"]
                @company_growths_hash[:"index_#{v.id}"]
            else
              @company_growths_hash[:"index_#{v.id}"] = 0
            end
          end
          @company_growths_hash[:GrowthRate] = (@preGrowth)?(( (@curGrowth.base_growth_value).to_f / (@preGrowth.base_growth_value).to_f ) -1)*100:0
          @company_growths_array[index] = @company_growths_hash
        end
      end 
    end
    @company_growths_array = @company_growths_array-["",nil]
    render :json => @company_growths_array
  end

  def getCompaniesRevenue
    @company_revenue_array = Hash.new
    @company_revenue_array_dollar = []
    @company_revenue_array_percent = []


    @country = params[:country]
    @region = params[:region]

    if params[:name] =='All' and @country=='All' and @region=='All'
      @company = Company.all
    
    elsif params[:name]=='All' and @country=='All' and @region!='All'
      @company = Company.where(["region_id = ?",@region])
      

    elsif params[:name]!='All' and @country=='All' and @region!='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE ? AND region_id = ?","#{@keyword}%",@region])
      

    elsif params[:name]!='All' and @country!='All' and @region=='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE ? AND  country_id = ?","#{@keyword}%",@country])
      

    elsif params[:name]=='All' and @country!='All' and @region=='All'
      @company = Company.where(["country_id = ?",@country])
      
    
    elsif params[:name]=='All' and @country!='All' and @region!='All'
      @company = Company.where(["region_id = ? AND country_id = ?",@region,@country])
      
    
    elsif params[:name]!='All' and @country=='All' and @region=='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE  ?", "#{@keyword}%"])
      

    else
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE  ? AND country_id = ? AND region_id = ?","#{@keyword}%",@country,@region])
      
    end  
    
    @year = params[:year]
    @company.each_with_index do |value, index|
      
      
      #@company_growths = CompanyGrowth.where('value BETWEEN ? AND ? AND year = ? AND company_id = ? AND growth_id = 1',params[:min],params[:max],@year,value.id).first
      
      
      if @year == 'All'
      if params[:max].to_i < 1000
        @company_growths = BaseValue.where('base_value BETWEEN ? AND ? AND year = ? AND company_id = ? AND revenue_type = 1',params[:min],params[:max],2014,value.id)
      else
        @company_growths = BaseValue.where('year = ? AND company_id = ? AND revenue_type = 1',2014,value.id)
      end

        @compRev =  BaseValue.where('year = ? AND company_id = ? AND revenue_type = 1',2014,value.id).first
        @company_revenue = CompanyRevenue.where(:company_id=>value.id,:year=>2014)
          
          if @company_revenue

            @company_revenue_hashDollar = Hash.new  
            @company_revenue_hashPercent = Hash.new  

            @company_revenue_hashDollar[:company_name] = value.name
            @company_revenue_hashPercent[:company_name] = value.name

            @company_revenue.each_with_index do |v,i|
            
              @company_revenue_hashDollar[:"sindex_#{v.revenue_id}"] = (v.value==0)?0:v.value.to_i 
              @company_revenue_hashPercent[:"sindex_#{v.revenue_id}"] = (@compRev)?((@compRev.base_value / 100) * ((v.value==0)?0:v.value).to_i):0
            end
            #adding all geo in array
            @revenue = Revenue.find(:all, :order => "id ASC")
            @revenue.each_with_index do |v,i|
              if @company_revenue_hashDollar[:"sindex_#{v.id}"]
                  @company_revenue_hashDollar[:"sindex_#{v.id}"]
              else
                @company_revenue_hashDollar[:"sindex_#{v.id}"] = 0
                @company_revenue_hashPercent[:"sindex_#{v.id}"] = 0
              end
            end
            
            @company_revenue_array_dollar[index] = @company_revenue_hashDollar
            @company_revenue_array_percent[index] = @company_revenue_hashPercent
          end

      else
      
      if params[:max].to_i < 1000
        @company_growths = BaseValue.where('base_value BETWEEN ? AND ? AND year = ? AND company_id = ? AND revenue_type = 1',params[:min],params[:max],@year,value.id)
      else
        @company_growths = BaseValue.where('year = ? AND company_id = ? AND revenue_type = 1',@year,value.id)
      end

        @compRev =  BaseValue.where('year = ? AND company_id = ? AND revenue_type = 1',@year,value.id).first
        if @company_growths.count > 0
          @company_revenue = CompanyRevenue.where(:company_id=>value.id,:year=>@year)
          
          if @company_revenue
            @company_revenue_hashDollar = Hash.new  
            @company_revenue_hashPercent = Hash.new  

            @company_revenue_hashDollar[:company_name] = value.name
            @company_revenue_hashPercent[:company_name] = value.name

            @company_revenue.each_with_index do |v,i|
            
              #@company_revenue_hashDollar[:"#{(i+1)}"] = (v.value==0)?0:v.value 
              #@company_revenue_hashPercent[:"#{(i+1)}"] = (@compRev)?((@compRev.base_value / 100) * ((v.value==0)?0:v.value).to_i):0
              @company_revenue_hashDollar[:"sindex_#{v.revenue_id}"] = (v.value==0)?0:v.value.to_i 
              @company_revenue_hashPercent[:"sindex_#{v.revenue_id}"] = (@compRev)?((@compRev.base_value / 100) * ((v.value==0)?0:v.value).to_i):0
            end
            #adding all geo in array
            @revenue = Revenue.find(:all, :order => "id ASC")
            @revenue.each_with_index do |v,i|
              if @company_revenue_hashDollar[:"sindex_#{v.id}"]
                  @company_revenue_hashDollar[:"sindex_#{v.id}"]
              else
                @company_revenue_hashDollar[:"sindex_#{v.id}"] = 0
                @company_revenue_hashPercent[:"sindex_#{v.id}"] = 0
              end
            end
            
            @company_revenue_array_dollar[index] = @company_revenue_hashDollar
            @company_revenue_array_percent[index] = @company_revenue_hashPercent
          end 
        end
      end
    end
    @company_revenue_array_dollar = @company_revenue_array_dollar-["",nil]
    @company_revenue_array_percent = @company_revenue_array_percent-["",nil]
    @company_revenue_array[:dollar] = @company_revenue_array_dollar
    @company_revenue_array[:percent] = @company_revenue_array_percent
    render :json => @company_revenue_array
  end

  def getCompaniesGeo
    @company_geo_array = Hash.new
    @company_geo_array_dollar = []
    @company_geo_array_percent = []
    @country = params[:country]
    @region = params[:region]

    if params[:name] =='All' and @country=='All' and @region=='All'
      @company = Company.all
    
    elsif params[:name]=='All' and @country=='All' and @region!='All'
      @company = Company.where(["region_id = ?",@region])
      

    elsif params[:name]!='All' and @country=='All' and @region!='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE ? AND region_id = ?","#{@keyword}%",@region])
      

    elsif params[:name]!='All' and @country!='All' and @region=='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE ? AND  country_id = ?","#{@keyword}%",@country])
      

    elsif params[:name]=='All' and @country!='All' and @region=='All'
      @company = Company.where(["country_id = ?",@country])
      
    
    elsif params[:name]=='All' and @country!='All' and @region!='All'
      @company = Company.where(["region_id = ? AND country_id = ?",@region,@country])
      
    
    elsif params[:name]!='All' and @country=='All' and @region=='All'
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE  ?", "#{@keyword}%"])
      

    else
      @keyword = params[:name].downcase
      @company = Company.where(["lower(name) LIKE  ? AND country_id = ? AND region_id = ?","#{@keyword}%",@country,@region])
      
    end 
    
    @year = params[:year]
    @company.each_with_index do |value, index|
      
      #@company_growths = CompanyGrowth.where('value BETWEEN ? AND ? AND year = ? AND company_id = ? AND growth_id = 1',params[:min],params[:max],@year,value.id).first
        
      
      if @year == 'All'
      if params[:max].to_i < 1000
        @company_growths = BaseValue.where('base_value BETWEEN ? AND ? AND year = ? AND company_id = ? AND revenue_type = 1',params[:min],params[:max],2014,value.id)
      else
        @company_growths = BaseValue.where('year = ? AND company_id = ? AND revenue_type = 1',2014,value.id)
      end

      
      @compRev =  BaseValue.where('year = ? AND company_id = ? AND revenue_type = 1',2014,value.id).first
          @company_geo = CompanyGeo.where(:company_id=>value.id,:year=>2014)
          @geos = Geo.all
          if @company_geo
            @company_geo_hashDollar = Hash.new  
            @company_geo_hashPercent = Hash.new  

            @company_geo_hashDollar[:company_name] = value.name
            @company_geo_hashPercent[:company_name] = value.name

            @company_geo.each_with_index do |v,i|
              #@company_geo_hashDollar[:"#{v.geo_id}"] = (v.value==0)?0:v.value 
              #@company_geo_hashPercent[:"#{v.geo_id}"] = (@compRev)?((@compRev.base_value / 100) * ((v.value==0)?0:v.value).to_i):0
              @company_geo_hashDollar[:"gindex_#{v.geo_id}"] = (v.value==0 || v.value=='')?0:v.value.to_i 
              @company_geo_hashPercent[:"gindex_#{v.geo_id}"] = (@compRev)?((@compRev.base_value / 100) * ((v.value==0)?0:v.value).to_i):0
            end
            #adding all geo in array
            @geos = Geo.find(:all, :order => "id ASC")
            @geos.each_with_index do |v,i|
              if @company_geo_hashDollar[:"gindex_#{v.id}"]
                  @company_geo_hashDollar[:"gindex_#{v.id}"]
              else
                @company_geo_hashDollar[:"gindex_#{v.id}"] = 0
                @company_geo_hashPercent[:"gindex_#{v.id}"] = 0
              end
            end
            
            @company_geo_array_dollar[index] = @company_geo_hashDollar
            @company_geo_array_percent[index] = @company_geo_hashPercent
          end
          
      else
        
      if params[:max].to_i < 1000
        @company_growths = BaseValue.where('base_value BETWEEN ? AND ? AND year = ? AND company_id = ? AND revenue_type = 1',params[:min],params[:max],@year,value.id)
      else
        @company_growths = BaseValue.where('year = ? AND company_id = ? AND revenue_type = 1',@year,value.id)
      end
        @compRev =  BaseValue.where('year = ? AND company_id = ? AND revenue_type = 1',@year,value.id).first
        if @company_growths.count > 0
          @company_geo = CompanyGeo.where(:company_id=>value.id,:year=>@year)
          if @company_geo
           @company_geo_hashDollar = Hash.new  
            @company_geo_hashPercent = Hash.new  

            @company_geo_hashDollar[:company_name] = value.name
            @company_geo_hashPercent[:company_name] = value.name

            @company_geo.each_with_index do |v,i|
            
              #@company_geo_hashDollar[:"#{(i+1)}"] = (v.value==0)?0:v.value 
              #@company_geo_hashPercent[:"#{(i+1)}"] = (@compRev)?((@compRev.base_value / 100) * ((v.value==0)?0:v.value).to_i):0
              @company_geo_hashDollar[:"gindex_#{v.geo_id}"] = (v.value==0 || v.value=='')?0:v.value.to_i 
              @company_geo_hashPercent[:"gindex_#{v.geo_id}"] = (@compRev)?((@compRev.base_value / 100) * ((v.value==0)?0:v.value).to_i):0
            end
            #adding all geo in array
            @geos = Geo.find(:all, :order => "id ASC")
            @geos.each_with_index do |v,i|
              if @company_geo_hashDollar[:"gindex_#{v.id}"]
                  @company_geo_hashDollar[:"gindex_#{v.id}"]
              else
                @company_geo_hashDollar[:"gindex_#{v.id}"] = 0
                @company_geo_hashPercent[:"gindex_#{v.id}"] = 0
              end
            end


            @company_geo_array_dollar[index] = @company_geo_hashDollar
            @company_geo_array_percent[index] = @company_geo_hashPercent
          end
        end
      end
    end
    #@company_geo_array = @company_geo_array-["",nil]
    @company_geo_array_dollar = @company_geo_array_dollar-["",nil]
    @company_geo_array_percent = @company_geo_array_percent-["",nil]
    @company_geo_array[:dollar] = @company_geo_array_dollar
    @company_geo_array[:percent] = @company_geo_array_percent

    render :json => @company_geo_array
  end
  
  
  
  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def updateCompany
    @company = Company.find(params[:edit_company_id])
    @company.name =params[:name];
    @company.analyst_id =params[:selected_analyst]
    @company.status_id =params[:selected_status]
    @company.confidence_level_id =params[:selected_confidence_level]
    @company.nda_id =params[:selected_nda]
    @company.country_id =params[:selected_country]
    @company.region_id =params[:selected_region]
    @company.city_id = params[:selected_city]
    @company.state_id = params[:selected_state]
    @company.website =params[:website]
    @company.parent_company =params[:parent_company]
    @company.company_type_id =params[:selected_companyType]
    @company.CEO =params[:ceo]
    @company.PSL =params[:psl]
    @company.no_of_DCS =params[:nofdcs]
    @company.dclocation =params[:dclocation]
    @company.dcpartner =params[:dcpartner]
    @company.save


    #classification
      if(params[:selectedClassifications])
        @CompanyClassification = CompanyClassification.where(["company_id = ?", @company.id])
        @CompanyClassification.delete_all
        params[:selectedClassifications].each_with_index do |value, index|
          @company_classification = CompanyClassification.new
          @company_classification.company_id = @company.id #params[:]
          @company_classification.classification_id =value #params[:]
          @company_classification.status = 1
          @company_classification.save
        end
      end

    #investor
    if(params[:investor])
      @company_investor = CompanyInvestor.where(["company_id = ?", @company.id]).first
      if @company_investor
        @company_investor.investor = params[:investor]
        @company_investor.status = 1
        @company_investor.createdOn = Time.now.getutc;
        @company_investor.save
      else
        @company_investor = CompanyInvestor.new
        @company_investor.company_id =@company.id
        @company_investor.investor = params[:investor]
        @company_investor.status = 1
        @company_investor.createdOn = Time.now.getutc;
        @company_investor.save
      end
    end

    #company growth
    if(params[:companyGrowthData])
        params[:companyGrowthData].each_with_index do |value, index|
        x = value.split('-')
        @CompanyGrowth = CompanyGrowth.where(["company_id = ? AND growth_id = ? AND year = ?", @company.id,x[0],x[1]]).first
        @CompanyGrowth.value = x[2]
        @CompanyGrowth.save;
      end
    end

    #company segment
    if(params[:companyRevenueData])
      params[:companyRevenueData].each_with_index do |value, index|
        x = value.split('-')
        @company_revenue = CompanyRevenue.where(["company_id = ? AND revenue_id = ? AND year = ?", @company.id,x[0],x[1]]).first
        @company_revenue.value = x[2]
        @company_revenue.save
        
      end
    end
    
    #company geo
    if(params[:companyGeoData])
      params[:companyGeoData].each_with_index do |value, index|
        x = value.split('-')
        @company_geo = CompanyGeo.where(["company_id = ? AND geo_id = ? AND year = ?", @company.id,x[0],x[1]]).first
        @company_geo.value=x[2]
        @company_geo.save
      end
    end

    render :json => @company

  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create

    @company = Company.new
    @company.name =params[:name];
    @company.analyst_id =params[:selected_analyst]
    @company.status_id =params[:selected_status]
    @company.confidence_level_id =params[:selected_confidence_level]
    @company.nda_id =params[:selected_nda]
    @company.country_id =params[:selected_country]
    @company.region_id =params[:selected_region]
    @company.city_id = params[:selected_city]
    @company.state_id = params[:selected_state]
    @company.website =params[:website]
    @company.parent_company =params[:parent_company]
    @company.company_type_id =params[:selected_companyType]
    @company.CEO =params[:ceo]
    @company.PSL =params[:psl]
    @company.no_of_DCS =params[:nofdcs]
    @company.dclocation =params[:dclocation]
    @company.dcpartner =params[:dcpartner]
    if @company.save

      #classification
      if(params[:selected_classifications]!='')
        params[:selected_classifications].each_with_index do |value, index|
          @company_classification = CompanyClassification.new
          @company_classification.company_id = @company.id #params[:]
          @company_classification.classification_id =value #params[:]
          @company_classification.status = 1
          @company_classification.save
        end
      end

      #investor
      if(params[:investor])
        @company_investor = CompanyInvestor.new
        @company_investor.company_id =@company.id
        @company_investor.investor = params[:investor]
        @company_investor.status = 1
        @company_investor.createdOn = Time.now.getutc;
        @company_investor.save
      end

      `#company growth
      if(params[:companyGrowthData])
          params[:companyGrowthData].each_with_index do |value, index|
          x = value.split('-')
          @CompanyGrowth = CompanyGrowth.new
          @CompanyGrowth.company_id = @company.id
          @CompanyGrowth.growth_id = x[0]
          @CompanyGrowth.value = x[2]
          @CompanyGrowth.year = x[1]
          @CompanyGrowth.status =1;
          @CompanyGrowth.createdOn = Time.now.getutc;
          @CompanyGrowth.save;
        end
      end`

      #company segment
      if(params[:companyRevenueData])
        if params[:SegmentApplyAll]==true
          for current_iteration_number in 2010..2025 do
            params[:companyRevenueData].each_with_index do |value, index|
              x = value.split('-')
              @company_revenue = CompanyRevenue.new
              @company_revenue.company_id = @company.id
              @company_revenue.revenue_id = x[0]
              @company_revenue.year = current_iteration_number
              @company_revenue.value = x[2]
              @company_revenue.status = 1
              @company_revenue.save
            end
          end
        else
          params[:companyRevenueData].each_with_index do |value, index|
            x = value.split('-')
            @company_revenue = CompanyRevenue.new
            @company_revenue.company_id = @company.id
            @company_revenue.revenue_id = x[0]
            @company_revenue.year = x[1]
            @company_revenue.value = x[2]
            @company_revenue.status = 1
            @company_revenue.save
          end
        end
      end

      #company geo
      if(params[:companyGeoData])
        if params[:GeoApplyAll]==true
          for current_iteration_number in 2010..2025 do
            params[:companyGeoData].each_with_index do |value, index|
              x = value.split('-')
              @company_geo = CompanyGeo.new
              @company_geo.company_id=@company.id
              @company_geo.geo_id=x[0]
              @company_geo.year=current_iteration_number
              @company_geo.value=x[2]
              @company_geo.status=1
              @company_geo.save
            end
          end
        else
          params[:companyGeoData].each_with_index do |value, index|
            x = value.split('-')
            @company_geo = CompanyGeo.new
            @company_geo.company_id=@company.id
            @company_geo.geo_id=x[0]
            @company_geo.year=x[1]
            @company_geo.value=x[2]
            @company_geo.status=1
            @company_geo.save
          end
        end
      end
      #company growth section
      if params[:base_values]
        `year = params[:selected_base_year].to_i
        company_id = @company.id
        baseValue = params[:base_values]
        revenuesValues = params[:revenues_values]
        growthValue = 0
        
        #first delete all records against company
        model = BaseValue.where("company_id = ?",company_id)  
        model.delete_all

        #loop on selected growth types
        baseValue.each_with_index do |baseValue, baseIndex|
        baseX = baseValue.split('-')
          for current_iteration_number in 2010..2025 do
              diff = current_iteration_number - baseX[1].to_i
              if current_iteration_number==baseX[1].to_i
                addCompanyGrowth(baseX[3].to_i,callApi(current_iteration_number,baseX[1].to_i,baseX[2].to_i,baseX[3].to_i,diff),current_iteration_number,company_id,baseX[0].to_i,1,baseX[3],baseX[2])
                growthValue = callApi(current_iteration_number,baseX[1].to_i,baseX[2].to_i,baseX[3].to_i,diff)
              else
                addCompanyGrowth(baseX[3].to_i,callApi(current_iteration_number,baseX[1].to_i,baseX[2].to_i,baseX[3].to_i,diff),current_iteration_number,company_id,baseX[0].to_i,0,0,0)
                growthValue = callApi(current_iteration_number,baseX[1].to_i,baseX[2].to_i,baseX[3].to_i,diff)
              end
          end
        end`
        year = params[:selected_year].to_i
        company_id = @company.id
        baseValue = params[:base_values]
        revenuesValues = params[:revenues_values]
        growthValue = 0
        #first delete all records against company
        model = BaseValue.where("company_id = ?",company_id)  
        model.delete_all
        
        #loop on selected growth types
        baseValue.each_with_index do |baseValue, baseIndex|
        baseX = baseValue.split('-')
        growthValue = baseX[2].to_f
          for current_iteration_number in 2010..2020 do
            x = revenuesValues[baseIndex].split('-')
              diff = current_iteration_number - baseX[1].to_i
              
              if diff == 0
                growthValue = baseX[2].to_f
                addCompanyGrowth(baseX[2].to_i,growthValue,current_iteration_number,company_id,baseX[0].to_i,1,baseX[3],baseX[2])
              elsif diff < 0
                growthValue = callApi(baseX[2].to_f,baseX[3].to_i,diff)
                addCompanyGrowth(baseX[2].to_i,growthValue,current_iteration_number,company_id,baseX[0].to_i,0,baseX[3],baseX[2])
              elsif diff > 0
                if current_iteration_number==x[1].to_i
                  growthValue = (findPer(growthValue,x[2].to_f)).to_f
                  addCompanyGrowth(baseX[2].to_i,growthValue,current_iteration_number,company_id,baseX[0].to_i,0,x[2],baseX[2])
                else
                  growthValue = (findPer(growthValue,baseX[3].to_f)).to_f
                  addCompanyGrowth(baseX[2].to_i,growthValue,current_iteration_number,company_id,baseX[0].to_i,0,baseX[3],baseX[2])
                end
              else
              
              end
          end
        end
      end
      render :json => @company

    else
      render :json => @company.errors.full_messages, status: :unprocessable_entity
    end
      
  end
  

  def findPer(value,percent)
    growthValue = value
    val = (growthValue * percent) / 100
    growthValue = ((growthValue + val).to_f).round(2)
    return growthValue.to_f
  end

  def findPerMi(value,percent)
    growthValue = value
    val = (growthValue * percent) / 100
    growthValue = ((growthValue - val).to_f).round(2)
    return growthValue.to_f
  end

  def callApi(value,percent,diff)
    growthValue = value
    if diff > 0
      if diff == 0
        #for growth in 1..diff do
          val = (growthValue * percent) / 100
          growthValue = ((growthValue + val).to_f).round(2)
        #end
      else
        for growth in 1..diff do
          val = (growthValue * percent) / 100
          growthValue = ((growthValue + val).to_f).round(2)
        end
      end
      
    else
      for growth in 1..diff.abs do
        val = (growthValue * percent) / 100
        growthValue = ((growthValue - val).to_f).round(2)
      end
    end
    return growthValue.to_f
  end

  def addCompanyGrowth(basePercent,baseGrowth,year,comapny_id,growth_id,is_base,percent,growth)
      @baseValue = BaseValue.new
      @baseValue.company_id = comapny_id
      @baseValue.revenue_type  = growth_id
      @baseValue.base_growth_value = basePercent
      @baseValue.base_value = baseGrowth
      @baseValue.growth_value = percent
      @baseValue.value = growth
      @baseValue.year = year
      @baseValue.is_base = is_base
      @baseValue.save  
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @BaseValue = BaseValue.where("company_id = ?",params[:id])
    @BaseValue.delete_all
    @CompanyClassification = CompanyClassification.where("company_id = ?",params[:id])
    @BaseValue.delete_all
    @CompanyGeo = CompanyGeo.where("company_id = ?",params[:id])
    @CompanyGeo.delete_all
    @CompanyGrowth = CompanyGrowth.where("company_id = ?",params[:id])
    @CompanyGrowth.delete_all
    @CompanyInvestor = CompanyInvestor.where("company_id = ?",params[:id])
    @CompanyInvestor.delete_all
    @CompanyRegionsGrowth = CompanyRegionsGrowth.where("company_id = ?",params[:id])
    @CompanyRegionsGrowth.delete_all
    @CompanyRevenue = CompanyRevenue.where("company_id = ?",params[:id])
    @CompanyRevenue.delete_all
    @company = Company.where("id = ?",params[:id])
    @company.delete_all
    render :json =>'success',:status=>:ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      #params.require(:company).permit(:analyst, :states, :conf_level_id, :NDA_id, :country_id, :region_id, :HQcity_id, :HQstate_id, :website, :parentcom_id, :comtype_id, :CEO, :PSL, :no_of_DCS, :DClocation_id)
    end
end
