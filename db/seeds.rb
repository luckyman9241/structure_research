# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Country = Country.create([{ name: 'United States',status: 1 }, { name: 'China',status: 1 },{ name: 'Singapore',status: 1 }])
City = City.create([{ name: 'Cambridge',status: 1 }, { name: 'Beijing',status: 1 }])
Classification = Classification.create([{ name: 'CSP',description: 'Communication Service Provider (Telco)',status: 1 }, { name: 'HSP',description: 'Hosting Service Provider',status: 1 }, { name: 'MSP',description: 'Managed Service Provider',status: 1 }, { name: 'SSP',description: 'Software Service Provider (SaaS)',status: 1 }, { name: 'DCSP',description: 'Data Centre Service Provider (Colocation)',status: 1 }])
ConfidenceLevel = ConfidenceLevel.create([{ name: 'High',status: 1 }, { name: 'Low',status: 1 }])
Nda = Nda.create([{ name: 'Yes',status: 1 }, { name: 'No',status: 1 }])
Analyst = Analyst.create([{ name: 'Analyst' }])
Status = Status.create([{ name: 'Yes'}, { name: 'No'}])
Region = Region.create([{ name: 'US',status: 1 }, { name: 'PRC',status: 1 }, { name: 'SEA',status: 1 }])
State = State.create([{ name: 'MA',status: 1 }, { name: 'CO',status: 1 }, { name: 'CO',status: 1 }])
CompanyType = CompanyType.create([{ name: 'Public',status: 1 }, { name: 'Private',status: 1 }])
UserType = UserType.create([{ name: 'Administrator',status: 1 }, { name: 'User',status: 1 }])
Geo = Geo.create([{name:'US',description:'United state',status:'1'},{name:'CA',description:'canada',status:'1'},{name:'UK',description:'United kingdom',status:'1'},{name:'EU',description:'Euorpe',status:'1'},{name:'ANZ',description:'Australia,Newzealand',status:'1'},{name:'SEA',description:'SouthEast Asia',status:'1'},{name:'SA',description:'South Africa ',status:'1'},
	{name:'PRC',description:'Peoples Of republic china ',status:'1'},{name:'EA',description:'',status:'1'},{name:'LA',description:'Las Angeles ',status:'1'},{name:'MEA',description:'',status:'1'}])
Company = Company.create([{analyst_id: 1,status_id: 1,confidence_level_id: '1',nda_id: '1',country_id: '1',region_id: '1',city_id: '1',state_id: '1',website: 'akamai.com',parent_company: '',company_type_id: '1', CEO: 'F. Thomson Leighton',PSL: 'CDN',no_of_DCS: '1',dclocation: 'Biejing',dcpartner: 'China Telecom',name: 'Akamai Technologies',revenue: 100,revenue_year: '2014'},
	{analyst_id: 1,status_id: 1,confidence_level_id: '2',nda_id: '2',country_id: '2',region_id: '2',city_id: '2',state_id: '2',website: 'en.21vianet.com',parent_company: '',company_type_id: '2',CEO: 'F. Thomson Leighton',PSL: 'Colocation, Hosting, Network servies',no_of_DCS: '80',dclocation: 'Germany',dcpartner: 'Digital Realty Trust',name: '21Vianet',revenue: 100,revenue_year: '2014'},
	{analyst_id: 1,status_id: 1,confidence_level_id: '3',nda_id: '1',country_id: '3',region_id: '3',city_id: '3',state_id: '3',website: 'eunetworks.com',parent_company: '',company_type_id: '1',CEO: 'Brady Reid Rafuse',PSL: 'Colocation, network services',no_of_DCS: '28',dclocation: 'Atlanta',dcpartner: 'ALOG do Brasil',name: 'euNetworks',revenue: 100,revenue_year: '2014'}])


Growth = Growth.create([{name:'Total Revenue',status: 1},{name:'Headcount',status: 1},{name:'Customer',status: 1},{name:'Server',status: 1},{name:'Domain',status: 1}])
Revenue = Revenue.create([
	{name:'shared hosting',status:1},
	{name:'Standard Managed',status:1},
	{name:'Complex Managed',status:1},
	{name:'Utility Hosting',status:1},
	{name:'Application Hosting',status:1},
	{name:'Cloud',status:1},
	{name:'Colocation',status:1},
	{name:'Interconnection',status:1}
])

CompanyGrowth=CompanyGrowth.create([
	{company_id: 1,growth_id: 1,year: '2014',value: 10, status: 1},
	{company_id: 1,growth_id: 2,year: '2014',value: 10, status: 1},
	{company_id: 1,growth_id: 3,year: '2014',value: 10, status: 1},
	{company_id: 1,growth_id: 4,year: '2014',value: 10, status: 1},
	{company_id: 1,growth_id: 5,year: '2014',value: 10, status: 1},

	{company_id: 2,growth_id: 1,year: '2014',value: 10, status: 1},
	{company_id: 2,growth_id: 2,year: '2014',value: 10, status: 1},
	{company_id: 2,growth_id: 3,year: '2014',value: 10, status: 1},
	{company_id: 2,growth_id: 4,year: '2014',value: 10, status: 1},
	{company_id: 2,growth_id: 5,year: '2014',value: 10, status: 1},

	{company_id: 3,growth_id: 1,year: '2014',value: 10, status: 1},
	{company_id: 3,growth_id: 2,year: '2014',value: 10, status: 1},
	{company_id: 3,growth_id: 3,year: '2014',value: 10, status: 1},
	{company_id: 3,growth_id: 4,year: '2014',value: 10, status: 1},
	{company_id: 3,growth_id: 5,year: '2014',value: 10, status: 1},

])


CompanyRevenue=CompanyRevenue.create([
	{company_id: 1,revenue_id: 1,year: '2014',value: 10,status: 1},
	{company_id: 1,revenue_id: 2,year: '2014',value: 10,status: 1},
	{company_id: 1,revenue_id: 3,year: '2014',value: 10,status: 1},
	{company_id: 1,revenue_id: 4,year: '2014',value: 10,status: 1},
	{company_id: 1,revenue_id: 5,year: '2014',value: 10,status: 1},
	{company_id: 1,revenue_id: 6,year: '2014',value: 10,status: 1},
	{company_id: 1,revenue_id: 7,year: '2014',value: 10,status: 1},
	{company_id: 1,revenue_id: 8,year: '2014',value: 10,status: 1},
	
	{company_id: 2,revenue_id: 1,year: '2014',value: 10,status: 1},
	{company_id: 2,revenue_id: 2,year: '2014',value: 10,status: 1},
	{company_id: 2,revenue_id: 3,year: '2014',value: 10,status: 1},
	{company_id: 2,revenue_id: 4,year: '2014',value: 10,status: 1},
	{company_id: 2,revenue_id: 5,year: '2014',value: 10,status: 1},
	{company_id: 2,revenue_id: 6,year: '2014',value: 10,status: 1},
	{company_id: 2,revenue_id: 7,year: '2014',value: 10,status: 1},
	{company_id: 2,revenue_id: 8,year: '2014',value: 10,status: 1},

	{company_id: 3,revenue_id: 1,year: '2014',value: 10,status: 1},
	{company_id: 3,revenue_id: 2,year: '2014',value: 10,status: 1},
	{company_id: 3,revenue_id: 3,year: '2014',value: 10,status: 1},
	{company_id: 3,revenue_id: 4,year: '2014',value: 10,status: 1},
	{company_id: 3,revenue_id: 5,year: '2014',value: 10,status: 1},
	{company_id: 3,revenue_id: 6,year: '2014',value: 10,status: 1},
	{company_id: 3,revenue_id: 7,year: '2014',value: 10,status: 1},
	{company_id: 3,revenue_id: 8,year: '2014',value: 10,status: 1},
])



CompanyGeo = CompanyGeo.create([
	{company_id: 1,geo_id:'1',year: '2014',value:'10',status:'1'},
	{company_id: 1,geo_id:'2',year: '2014',value:'10',status:'1'},
	{company_id: 2,geo_id:'3',year: '2014',value:'10',status:'1'},
	{company_id: 2,geo_id:'4',year: '2014',value:'10',status:'1'},
	{company_id: 3,geo_id:'2',year: '2014',value:'10',status:'1'},
	{company_id: 3,geo_id:'6',year: '2014',value:'10',status:'1'}
])

CompanyBase=BaseValue.create([
	{company_id: 1,revenue_type: 1,base_growth_value: 10,base_value: 81,growth_value: 0,value: 0,year: '2012',is_base: 0},
	{company_id: 1,revenue_type: 1,base_growth_value: 10,base_value: 90,growth_value: 0,value: 0,year: '2013',is_base: 0},
	{company_id: 1,revenue_type: 1,base_growth_value: 1,base_value: 90.9,growth_value: 10,value: 100,year: '2014',is_base: 0},
	{company_id: 1,revenue_type: 1,base_growth_value: 10,base_value: 110,growth_value: 0,value: 0,year: '2015',is_base: 1},
	{company_id: 1,revenue_type: 1,base_growth_value: 10,base_value: 121,growth_value: 0,value: 0,year: '2016',is_base: 0},

	{company_id: 1,revenue_type: 2,base_growth_value: 10,base_value: 81,growth_value: 0,value: 0,year: '2012',is_base: 0},
	{company_id: 1,revenue_type: 2,base_growth_value: 10,base_value: 90,growth_value: 0,value: 0,year: '2013',is_base: 0},
	{company_id: 1,revenue_type: 2,base_growth_value: 1,base_value: 90.9,growth_value: 10,value: 100,year: '2014',is_base: 0},
	{company_id: 1,revenue_type: 2,base_growth_value: 10,base_value: 110,growth_value: 0,value: 0,year: '2015',is_base: 1},
	{company_id: 1,revenue_type: 2,base_growth_value: 10,base_value: 121,growth_value: 0,value: 0,year: '2016',is_base: 0},

	{company_id: 1,revenue_type: 3,base_growth_value: 10,base_value: 81,growth_value: 0,value: 0,year: '2012',is_base: 0},
	{company_id: 1,revenue_type: 3,base_growth_value: 10,base_value: 90,growth_value: 0,value: 0,year: '2013',is_base: 0},
	{company_id: 1,revenue_type: 3,base_growth_value: 1,base_value: 90.9,growth_value: 10,value: 100,year: '2014',is_base: 0},
	{company_id: 1,revenue_type: 3,base_growth_value: 10,base_value: 110,growth_value: 0,value: 0,year: '2015',is_base: 1},
	{company_id: 1,revenue_type: 3,base_growth_value: 10,base_value: 121,growth_value: 0,value: 0,year: '2016',is_base: 0},

	{company_id: 2,revenue_type: 1,base_growth_value: 10,base_value: 81,growth_value: 0,value: 0,year: '2012',is_base: 0},
	{company_id: 2,revenue_type: 1,base_growth_value: 10,base_value: 90,growth_value: 0,value: 0,year: '2013',is_base: 0},
	{company_id: 2,revenue_type: 1,base_growth_value: 1,base_value: 90.9,growth_value: 10,value: 100,year: '2014',is_base: 0},
	{company_id: 2,revenue_type: 1,base_growth_value: 10,base_value: 110,growth_value: 0,value: 0,year: '2015',is_base: 1},
	{company_id: 2,revenue_type: 1,base_growth_value: 10,base_value: 121,growth_value: 0,value: 0,year: '2016',is_base: 0},

	{company_id: 2,revenue_type: 2,base_growth_value: 10,base_value: 81,growth_value: 0,value: 0,year: '2012',is_base: 0},
	{company_id: 2,revenue_type: 2,base_growth_value: 10,base_value: 90,growth_value: 0,value: 0,year: '2013',is_base: 0},
	{company_id: 2,revenue_type: 2,base_growth_value: 1,base_value: 90.9,growth_value: 10,value: 100,year: '2014',is_base: 0},
	{company_id: 2,revenue_type: 2,base_growth_value: 10,base_value: 110,growth_value: 0,value: 0,year: '2015',is_base: 1},
	{company_id: 2,revenue_type: 2,base_growth_value: 10,base_value: 121,growth_value: 0,value: 0,year: '2016',is_base: 0},

	{company_id: 2,revenue_type: 3,base_growth_value: 10,base_value: 81,growth_value: 0,value: 0,year: '2012',is_base: 0},
	{company_id: 2,revenue_type: 3,base_growth_value: 10,base_value: 90,growth_value: 0,value: 0,year: '2013',is_base: 0},
	{company_id: 2,revenue_type: 3,base_growth_value: 1,base_value: 90.9,growth_value: 10,value: 100,year: '2014',is_base: 0},
	{company_id: 2,revenue_type: 3,base_growth_value: 10,base_value: 110,growth_value: 0,value: 0,year: '2015',is_base: 1},
	{company_id: 2,revenue_type: 3,base_growth_value: 10,base_value: 121,growth_value: 0,value: 0,year: '2016',is_base: 0},

	{company_id: 3,revenue_type: 1,base_growth_value: 10,base_value: 81,growth_value: 0,value: 0,year: '2012',is_base: 0},
	{company_id: 3,revenue_type: 1,base_growth_value: 10,base_value: 90,growth_value: 0,value: 0,year: '2013',is_base: 0},
	{company_id: 3,revenue_type: 1,base_growth_value: 1,base_value: 90.9,growth_value: 10,value: 100,year: '2014',is_base: 0},
	{company_id: 3,revenue_type: 1,base_growth_value: 10,base_value: 110,growth_value: 0,value: 0,year: '2015',is_base: 1},
	{company_id: 3,revenue_type: 1,base_growth_value: 10,base_value: 121,growth_value: 0,value: 0,year: '2016',is_base: 0},

	{company_id: 3,revenue_type: 2,base_growth_value: 10,base_value: 81,growth_value: 0,value: 0,year: '2012',is_base: 0},
	{company_id: 3,revenue_type: 2,base_growth_value: 10,base_value: 90,growth_value: 0,value: 0,year: '2013',is_base: 0},
	{company_id: 3,revenue_type: 2,base_growth_value: 1,base_value: 90.9,growth_value: 10,value: 100,year: '2014',is_base: 0},
	{company_id: 3,revenue_type: 2,base_growth_value: 10,base_value: 110,growth_value: 0,value: 0,year: '2015',is_base: 1},
	{company_id: 3,revenue_type: 2,base_growth_value: 10,base_value: 121,growth_value: 0,value: 0,year: '2016',is_base: 0},

	{company_id: 3,revenue_type: 3,base_growth_value: 10,base_value: 81,growth_value: 0,value: 0,year: '2012',is_base: 0},
	{company_id: 3,revenue_type: 3,base_growth_value: 10,base_value: 90,growth_value: 0,value: 0,year: '2013',is_base: 0},
	{company_id: 3,revenue_type: 3,base_growth_value: 1,base_value: 90.9,growth_value: 10,value: 100,year: '2014',is_base: 0},
	{company_id: 3,revenue_type: 3,base_growth_value: 10,base_value: 110,growth_value: 0,value: 0,year: '2015',is_base: 1},
	{company_id: 3,revenue_type: 3,base_growth_value: 10,base_value: 121,growth_value: 0,value: 0,year: '2016',is_base: 0},
])
	


User = User.create([{fullname:'Administrator', username:'admin',password:'d033e22ae348aeb5660fc2140aec35850c4da997',user_type_id:1,status:1},{fullname:'User', username:'user',password:'12dea96fec20593566ab75692c9949596833adc9',user_type_id:2,status:1}])