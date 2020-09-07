				
%let data_area = U:\e_Team Members\Zoe Hartland\Population Projections\dvc504\SAS_data;
%let filin1 = data2001_2018.xls;


/*import and sort each year's worth of data - this section for MYEs only */
PROC IMPORT OUT= WORK.temp2001
            DATAFILE= "&data_area.\&filin1." 
            DBMS=EXCEL REPLACE;
     RANGE="'2001$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2002
            DATAFILE= "&data_area.\&filin1." 
            DBMS=EXCEL REPLACE;
     RANGE="'2002$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.TEMP2003 
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2003$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2004
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2004$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2005
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2005$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2006
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2006$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2007
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2007$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2008
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2008$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2009
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2009$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2010
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2010$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2011
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2011$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2012
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2012$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2013
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2013$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2014
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2014$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2015
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2015$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2016
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2016$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2017
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2017$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

PROC IMPORT OUT= WORK.temp2018
            DATAFILE= "&data_area.\&filin1."
            DBMS=EXCEL REPLACE;
     RANGE="'2018$'" ; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/*for one year of data, create percentages etc*/
/*output each variable with tot pop in order to calculate percentages properly*/
/*first merge all files together so all years are combined*/

%macro sortstuff (year);

PROC SORT data = temp&year.;
	BY variable;
RUN;

%let yr = %substr(&year.,3,2);

DATA temp&year.;
	SET temp&year.;
	tot_&yr._al = m_&yr._al + f_&yr._al;
    maxagegrpnumM_&yr. = MAX(of m_&yr._0--m_&yr._90);
	maxagegrpnumF_&yr. = MAX(of f_&yr._0--f_&yr._90);
	maxagegrpnum_&yr. = MAX(maxagegrpnumM_&yr.,maxagegrpnumF_&yr.);

RUN;

%mend sortstuff;
%sortstuff(2001)
%sortstuff(2002)
%sortstuff(2003)
%sortstuff(2004)
%sortstuff(2005)
%sortstuff(2006)
%sortstuff(2007)
%sortstuff(2008)
%sortstuff(2009)
%sortstuff(2010)
%sortstuff(2011)
%sortstuff(2012)
%sortstuff(2013)
%sortstuff(2014)
%sortstuff(2015)
%sortstuff(2016)
%sortstuff(2017)
%sortstuff(2018);


DATA allyears;
	MERGE temp2001 temp2002  temp2003 temp2004 temp2005 temp2006 temp2007 temp2008 temp2009 temp2010 temp2011 temp2012 temp2013 temp2014 temp2015 temp2016 temp2017 temp2018;
	BY VARIABLE;
RUN;

/*divide data so local authority*/

DATA hartlepool	middlesbrough	redcarandcleveland	stocktonontees	darlington	halton	warrington	blackburnwithdarwen	blackpool	kingstonuponhullcityof	eastridingofyorkshire	northeastlincolnshire	northlincolnshire	york	derby	leicester	rutland	nottingham	herefordshirecountyof	telfordandwrekin	stokeontrent	bathandnortheastsomerset	bristolcityof	northsomerset	southgloucestershire	plymouth	torbay	bournemouth	poole	swindon	peterborough	luton	southendonsea	thurrock	medway	bracknellforest	westberkshire	reading	slough	windsorandmaidenhead	wokingham	miltonkeynes	brightonandhove	portsmouth	southampton	isleofwight	countydurham	cheshireeast	cheshirewestandchester	shropshire	cornwall	islesofscilly	wiltshire	bedford	centralbedfordshire	northumberland	aylesburyvale	chiltern	southbucks	wycombe	cambridge	eastcambridgeshire	fenland	huntingdonshire	southcambridgeshire	allerdale	barrowinfurness	carlisle	copeland	eden	southlakeland	ambervalley	bolsover	chesterfield	derbyshiredales	erewash	highpeak	northeastderbyshire	southderbyshire	eastdevon	exeter	middevon	northdevon	southhams	teignbridge	torridge	westdevon	christchurch	eastdorset	northdorset	purbeck	westdorset	weymouthandportland	eastbourne	hastings	lewes	rother	wealden	basildon	braintree	brentwood	castlepoint	chelmsford	colchester	eppingforest	harlow	maldon	rochford	tendring	uttlesford	cheltenham	cotswold	forestofdean	gloucester	stroud	tewkesbury	basingstokeanddeane	easthampshire	eastleigh	fareham	gosport	hart	havant	newforest	rushmoor	testvalley	winchester	broxbourne	dacorum	hertsmere	northhertfordshire	threerivers	watford	ashford	canterbury	dartford	dover	gravesham	maidstone	sevenoaks	shepway	swale	thanet	tonbridgeandmalling	tunbridgewells	burnley	chorley	fylde	hyndburn	lancaster	pendle	preston	ribblevalley	rossendale	southribble	westlancashire	wyre	blaby	charnwood	harborough	hinckleyandbosworth	melton	northwestleicestershire	oadbyandwigston	boston	eastlindsey	lincoln	northkesteven	southholland	southkesteven	westlindsey	breckland	broadland	greatyarmouth	kingslynnandwestnorfolk	northnorfolk	norwich	southnorfolk	corby	daventry	eastnorthamptonshire	kettering	northampton	southnorthamptonshire	wellingborough	craven	hambleton	harrogate	richmondshire	ryedale	scarborough	selby	ashfield	bassetlaw	broxtowe	gedling	mansfield	newarkandsherwood	rushcliffe	cherwell	oxford	southoxfordshire	valeofwhitehorse	westoxfordshire	mendip	sedgemoor	southsomerset	tauntondeane	westsomerset	cannockchase	eaststaffordshire	lichfield	newcastleunderlyme	southstaffordshire	stafford	staffordshiremoorlands	tamworth	babergh	forestheath	ipswich	midsuffolk	stedmundsbury	suffolkcoastal	waveney	elmbridge	epsomandewell	guildford	molevalley	reigateandbanstead	runnymede	spelthorne	surreyheath	tandridge	waverley	woking	northwarwickshire	nuneatonandbedworth	rugby	stratfordonavon	warwick	adur	arun	chichester	crawley	horsham	midsussex	worthing	bromsgrove	malvernhills	redditch	worcester	wychavon	wyreforest	stalbans	welwynhatfield	easthertfordshire	stevenage	bolton	bury	manchester	oldham	rochdale	salford	stockport	tameside	trafford	wigan	knowsley	liverpool	sthelens	sefton	wirral	barnsley	doncaster	rotherham	sheffield	newcastleupontyne	northtyneside	southtyneside	sunderland	birmingham	coventry	dudley	sandwell	solihull	walsall	wolverhampton	bradford	calderdale	kirklees	leeds	wakefield	gateshead	cityoflondon	barkinganddagenham	barnet	bexley	brent	bromley	camden	croydon	ealing	enfield	greenwich	hackney	hammersmithandfulham	haringey	harrow	havering	hillingdon	hounslow	islington	kensingtonandchelsea	kingstonuponthames	lambeth	lewisham	merton	newham	redbridge	richmonduponthames	southwark	sutton	towerhamlets	walthamforest	wandsworth	westminster	buckinghamshire	cambridgeshire	cumbria	derbyshire	devon	dorset	eastsussex	essex	gloucestershire	hampshire	hertfordshire	kent	lancashire	leicestershire	lincolnshire	norfolk	northamptonshire	northyorkshire	nottinghamshire	oxfordshire	somerset	staffordshire	suffolk	surrey	warwickshire	westsussex	worcestershire	greatermanchester	merseyside	southyorkshire	westmidlands	westyorkshire	tyneandwear	antrimandnewtownabbey	armaghcitybanbridgeandcraigavon	belfast	causewaycoastandglens	derrycityandstrabane	fermanaghandomagh	lisburnandcastlereagh	midandeastantrim	midulster	newrymourneanddown	ardsandnorthdown	clackmannanshire	dumfriesandgalloway	eastayrshire	eastlothian	eastrenfrewshire	naheileanansiar	falkirk	fife	highland	inverclyde	midlothian	moray	northayrshire	orkneyislands	perthandkinross	scottishborders	shetlandislands	southayrshire	southlanarkshire	stirling	aberdeencity	aberdeenshire	argyllandbute	cityofedinburgh	renfrewshire	westdunbartonshire	westlothian	angus	dundeecity	northlanarkshire	eastdunbartonshire	glasgowcity	isleofanglesey	gwynedd	conwy	denbighshire	flintshire	wrexham	ceredigion	pembrokeshire	carmarthenshire	swansea	neathporttalbot	bridgend	valeofglamorgan	cardiff	rhonddacynontaf	caerphilly	blaenaugwent	torfaen	monmouthshire	newport	powys	merthyrtydfil	northeast	northwest	yorkshireandhumber	eastmidlands	westmidlandsregion	east	london	southeast	southwest	england	northernireland	scotland	wales	englandandwales	greatbritian	unitedkingdom;
	SET allyears;
if VARIABLE = "hartlepool" THEN OUTPUT hartlepool;
if VARIABLE = "middlesbrough" THEN OUTPUT middlesbrough;
if VARIABLE = "redcarandcleveland" THEN OUTPUT redcarandcleveland;
if VARIABLE = "stocktonontees" THEN OUTPUT stocktonontees;
if VARIABLE = "darlington" THEN OUTPUT darlington;
if VARIABLE = "halton" THEN OUTPUT halton;
if VARIABLE = "warrington" THEN OUTPUT warrington;
if VARIABLE = "blackburnwithdarwen" THEN OUTPUT blackburnwithdarwen;
if VARIABLE = "blackpool" THEN OUTPUT blackpool;
if VARIABLE = "kingstonuponhullcityof" THEN OUTPUT kingstonuponhullcityof;
if VARIABLE = "eastridingofyorkshire" THEN OUTPUT eastridingofyorkshire;
if VARIABLE = "northeastlincolnshire" THEN OUTPUT northeastlincolnshire;
if VARIABLE = "northlincolnshire" THEN OUTPUT northlincolnshire;
if VARIABLE = "york" THEN OUTPUT york;
if VARIABLE = "derby" THEN OUTPUT derby;
if VARIABLE = "leicester" THEN OUTPUT leicester;
if VARIABLE = "rutland" THEN OUTPUT rutland;
if VARIABLE = "nottingham" THEN OUTPUT nottingham;
if VARIABLE = "herefordshirecountyof" THEN OUTPUT herefordshirecountyof;
if VARIABLE = "telfordandwrekin" THEN OUTPUT telfordandwrekin;
if VARIABLE = "stokeontrent" THEN OUTPUT stokeontrent;
if VARIABLE = "bathandnortheastsomerset" THEN OUTPUT bathandnortheastsomerset;
if VARIABLE = "bristolcityof" THEN OUTPUT bristolcityof;
if VARIABLE = "northsomerset" THEN OUTPUT northsomerset;
if VARIABLE = "southgloucestershire" THEN OUTPUT southgloucestershire;
if VARIABLE = "plymouth" THEN OUTPUT plymouth;
if VARIABLE = "torbay" THEN OUTPUT torbay;
if VARIABLE = "bournemouth" THEN OUTPUT bournemouth;
if VARIABLE = "poole" THEN OUTPUT poole;
if VARIABLE = "swindon" THEN OUTPUT swindon;
if VARIABLE = "peterborough" THEN OUTPUT peterborough;
if VARIABLE = "luton" THEN OUTPUT luton;
if VARIABLE = "southendonsea" THEN OUTPUT southendonsea;
if VARIABLE = "thurrock" THEN OUTPUT thurrock;
if VARIABLE = "medway" THEN OUTPUT medway;
if VARIABLE = "bracknellforest" THEN OUTPUT bracknellforest;
if VARIABLE = "westberkshire" THEN OUTPUT westberkshire;
if VARIABLE = "reading" THEN OUTPUT reading;
if VARIABLE = "slough" THEN OUTPUT slough;
if VARIABLE = "windsorandmaidenhead" THEN OUTPUT windsorandmaidenhead;
if VARIABLE = "wokingham" THEN OUTPUT wokingham;
if VARIABLE = "miltonkeynes" THEN OUTPUT miltonkeynes;
if VARIABLE = "brightonandhove" THEN OUTPUT brightonandhove;
if VARIABLE = "portsmouth" THEN OUTPUT portsmouth;
if VARIABLE = "southampton" THEN OUTPUT southampton;
if VARIABLE = "isleofwight" THEN OUTPUT isleofwight;
if VARIABLE = "countydurham" THEN OUTPUT countydurham;
if VARIABLE = "northumberland" THEN OUTPUT northumberland;
if VARIABLE = "cheshireeast" THEN OUTPUT cheshireeast;
if VARIABLE = "cheshirewestandchester" THEN OUTPUT cheshirewestandchester;
if VARIABLE = "shropshire" THEN OUTPUT shropshire;
if VARIABLE = "cornwall" THEN OUTPUT cornwall;
if VARIABLE = "islesofscilly" THEN OUTPUT islesofscilly;
if VARIABLE = "wiltshire" THEN OUTPUT wiltshire;
if VARIABLE = "bedford" THEN OUTPUT bedford;
if VARIABLE = "centralbedfordshire" THEN OUTPUT centralbedfordshire;
if VARIABLE = "aylesburyvale" THEN OUTPUT aylesburyvale;
if VARIABLE = "chiltern" THEN OUTPUT chiltern;
if VARIABLE = "southbucks" THEN OUTPUT southbucks;
if VARIABLE = "wycombe" THEN OUTPUT wycombe;
if VARIABLE = "cambridge" THEN OUTPUT cambridge;
if VARIABLE = "eastcambridgeshire" THEN OUTPUT eastcambridgeshire;
if VARIABLE = "fenland" THEN OUTPUT fenland;
if VARIABLE = "huntingdonshire" THEN OUTPUT huntingdonshire;
if VARIABLE = "southcambridgeshire" THEN OUTPUT southcambridgeshire;
if VARIABLE = "allerdale" THEN OUTPUT allerdale;
if VARIABLE = "barrowinfurness" THEN OUTPUT barrowinfurness;
if VARIABLE = "carlisle" THEN OUTPUT carlisle;
if VARIABLE = "copeland" THEN OUTPUT copeland;
if VARIABLE = "eden" THEN OUTPUT eden;
if VARIABLE = "southlakeland" THEN OUTPUT southlakeland;
if VARIABLE = "ambervalley" THEN OUTPUT ambervalley;
if VARIABLE = "bolsover" THEN OUTPUT bolsover;
if VARIABLE = "chesterfield" THEN OUTPUT chesterfield;
if VARIABLE = "derbyshiredales" THEN OUTPUT derbyshiredales;
if VARIABLE = "erewash" THEN OUTPUT erewash;
if VARIABLE = "highpeak" THEN OUTPUT highpeak;
if VARIABLE = "northeastderbyshire" THEN OUTPUT northeastderbyshire;
if VARIABLE = "southderbyshire" THEN OUTPUT southderbyshire;
if VARIABLE = "eastdevon" THEN OUTPUT eastdevon;
if VARIABLE = "exeter" THEN OUTPUT exeter;
if VARIABLE = "middevon" THEN OUTPUT middevon;
if VARIABLE = "northdevon" THEN OUTPUT northdevon;
if VARIABLE = "southhams" THEN OUTPUT southhams;
if VARIABLE = "teignbridge" THEN OUTPUT teignbridge;
if VARIABLE = "torridge" THEN OUTPUT torridge;
if VARIABLE = "westdevon" THEN OUTPUT westdevon;
if VARIABLE = "christchurch" THEN OUTPUT christchurch;
if VARIABLE = "eastdorset" THEN OUTPUT eastdorset;
if VARIABLE = "northdorset" THEN OUTPUT northdorset;
if VARIABLE = "purbeck" THEN OUTPUT purbeck;
if VARIABLE = "westdorset" THEN OUTPUT westdorset;
if VARIABLE = "weymouthandportland" THEN OUTPUT weymouthandportland;
if VARIABLE = "eastbourne" THEN OUTPUT eastbourne;
if VARIABLE = "hastings" THEN OUTPUT hastings;
if VARIABLE = "lewes" THEN OUTPUT lewes;
if VARIABLE = "rother" THEN OUTPUT rother;
if VARIABLE = "wealden" THEN OUTPUT wealden;
if VARIABLE = "basildon" THEN OUTPUT basildon;
if VARIABLE = "braintree" THEN OUTPUT braintree;
if VARIABLE = "brentwood" THEN OUTPUT brentwood;
if VARIABLE = "castlepoint" THEN OUTPUT castlepoint;
if VARIABLE = "chelmsford" THEN OUTPUT chelmsford;
if VARIABLE = "colchester" THEN OUTPUT colchester;
if VARIABLE = "eppingforest" THEN OUTPUT eppingforest;
if VARIABLE = "harlow" THEN OUTPUT harlow;
if VARIABLE = "maldon" THEN OUTPUT maldon;
if VARIABLE = "rochford" THEN OUTPUT rochford;
if VARIABLE = "tendring" THEN OUTPUT tendring;
if VARIABLE = "uttlesford" THEN OUTPUT uttlesford;
if VARIABLE = "cheltenham" THEN OUTPUT cheltenham;
if VARIABLE = "cotswold" THEN OUTPUT cotswold;
if VARIABLE = "forestofdean" THEN OUTPUT forestofdean;
if VARIABLE = "gloucester" THEN OUTPUT gloucester;
if VARIABLE = "stroud" THEN OUTPUT stroud;
if VARIABLE = "tewkesbury" THEN OUTPUT tewkesbury;
if VARIABLE = "basingstokeanddeane" THEN OUTPUT basingstokeanddeane;
if VARIABLE = "easthampshire" THEN OUTPUT easthampshire;
if VARIABLE = "eastleigh" THEN OUTPUT eastleigh;
if VARIABLE = "fareham" THEN OUTPUT fareham;
if VARIABLE = "gosport" THEN OUTPUT gosport;
if VARIABLE = "hart" THEN OUTPUT hart;
if VARIABLE = "havant" THEN OUTPUT havant;
if VARIABLE = "newforest" THEN OUTPUT newforest;
if VARIABLE = "rushmoor" THEN OUTPUT rushmoor;
if VARIABLE = "testvalley" THEN OUTPUT testvalley;
if VARIABLE = "winchester" THEN OUTPUT winchester;
if VARIABLE = "broxbourne" THEN OUTPUT broxbourne;
if VARIABLE = "dacorum" THEN OUTPUT dacorum;
if VARIABLE = "easthertfordshire" THEN OUTPUT easthertfordshire;
if VARIABLE = "hertsmere" THEN OUTPUT hertsmere;
if VARIABLE = "northhertfordshire" THEN OUTPUT northhertfordshire;
if VARIABLE = "stevenage" THEN OUTPUT stevenage;
if VARIABLE = "threerivers" THEN OUTPUT threerivers;
if VARIABLE = "watford" THEN OUTPUT watford;
if VARIABLE = "ashford" THEN OUTPUT ashford;
if VARIABLE = "canterbury" THEN OUTPUT canterbury;
if VARIABLE = "dartford" THEN OUTPUT dartford;
if VARIABLE = "dover" THEN OUTPUT dover;
if VARIABLE = "gravesham" THEN OUTPUT gravesham;
if VARIABLE = "maidstone" THEN OUTPUT maidstone;
if VARIABLE = "sevenoaks" THEN OUTPUT sevenoaks;
if VARIABLE = "shepway" THEN OUTPUT shepway;
if VARIABLE = "swale" THEN OUTPUT swale;
if VARIABLE = "thanet" THEN OUTPUT thanet;
if VARIABLE = "tonbridgeandmalling" THEN OUTPUT tonbridgeandmalling;
if VARIABLE = "tunbridgewells" THEN OUTPUT tunbridgewells;
if VARIABLE = "burnley" THEN OUTPUT burnley;
if VARIABLE = "chorley" THEN OUTPUT chorley;
if VARIABLE = "fylde" THEN OUTPUT fylde;
if VARIABLE = "hyndburn" THEN OUTPUT hyndburn;
if VARIABLE = "lancaster" THEN OUTPUT lancaster;
if VARIABLE = "pendle" THEN OUTPUT pendle;
if VARIABLE = "preston" THEN OUTPUT preston;
if VARIABLE = "ribblevalley" THEN OUTPUT ribblevalley;
if VARIABLE = "rossendale" THEN OUTPUT rossendale;
if VARIABLE = "southribble" THEN OUTPUT southribble;
if VARIABLE = "westlancashire" THEN OUTPUT westlancashire;
if VARIABLE = "wyre" THEN OUTPUT wyre;
if VARIABLE = "blaby" THEN OUTPUT blaby;
if VARIABLE = "charnwood" THEN OUTPUT charnwood;
if VARIABLE = "harborough" THEN OUTPUT harborough;
if VARIABLE = "hinckleyandbosworth" THEN OUTPUT hinckleyandbosworth;
if VARIABLE = "melton" THEN OUTPUT melton;
if VARIABLE = "northwestleicestershire" THEN OUTPUT northwestleicestershire;
if VARIABLE = "oadbyandwigston" THEN OUTPUT oadbyandwigston;
if VARIABLE = "boston" THEN OUTPUT boston;
if VARIABLE = "eastlindsey" THEN OUTPUT eastlindsey;
if VARIABLE = "lincoln" THEN OUTPUT lincoln;
if VARIABLE = "northkesteven" THEN OUTPUT northkesteven;
if VARIABLE = "southholland" THEN OUTPUT southholland;
if VARIABLE = "southkesteven" THEN OUTPUT southkesteven;
if VARIABLE = "westlindsey" THEN OUTPUT westlindsey;
if VARIABLE = "breckland" THEN OUTPUT breckland;
if VARIABLE = "broadland" THEN OUTPUT broadland;
if VARIABLE = "greatyarmouth" THEN OUTPUT greatyarmouth;
if VARIABLE = "kingslynnandwestnorfolk" THEN OUTPUT kingslynnandwestnorfolk;
if VARIABLE = "northnorfolk" THEN OUTPUT northnorfolk;
if VARIABLE = "norwich" THEN OUTPUT norwich;
if VARIABLE = "southnorfolk" THEN OUTPUT southnorfolk;
if VARIABLE = "corby" THEN OUTPUT corby;
if VARIABLE = "daventry" THEN OUTPUT daventry;
if VARIABLE = "eastnorthamptonshire" THEN OUTPUT eastnorthamptonshire;
if VARIABLE = "kettering" THEN OUTPUT kettering;
if VARIABLE = "northampton" THEN OUTPUT northampton;
if VARIABLE = "southnorthamptonshire" THEN OUTPUT southnorthamptonshire;
if VARIABLE = "wellingborough" THEN OUTPUT wellingborough;
if VARIABLE = "craven" THEN OUTPUT craven;
if VARIABLE = "hambleton" THEN OUTPUT hambleton;
if VARIABLE = "harrogate" THEN OUTPUT harrogate;
if VARIABLE = "richmondshire" THEN OUTPUT richmondshire;
if VARIABLE = "ryedale" THEN OUTPUT ryedale;
if VARIABLE = "scarborough" THEN OUTPUT scarborough;
if VARIABLE = "selby" THEN OUTPUT selby;
if VARIABLE = "ashfield" THEN OUTPUT ashfield;
if VARIABLE = "bassetlaw" THEN OUTPUT bassetlaw;
if VARIABLE = "broxtowe" THEN OUTPUT broxtowe;
if VARIABLE = "gedling" THEN OUTPUT gedling;
if VARIABLE = "mansfield" THEN OUTPUT mansfield;
if VARIABLE = "newarkandsherwood" THEN OUTPUT newarkandsherwood;
if VARIABLE = "rushcliffe" THEN OUTPUT rushcliffe;
if VARIABLE = "cherwell" THEN OUTPUT cherwell;
if VARIABLE = "oxford" THEN OUTPUT oxford;
if VARIABLE = "southoxfordshire" THEN OUTPUT southoxfordshire;
if VARIABLE = "valeofwhitehorse" THEN OUTPUT valeofwhitehorse;
if VARIABLE = "westoxfordshire" THEN OUTPUT westoxfordshire;
if VARIABLE = "mendip" THEN OUTPUT mendip;
if VARIABLE = "sedgemoor" THEN OUTPUT sedgemoor;
if VARIABLE = "southsomerset" THEN OUTPUT southsomerset;
if VARIABLE = "tauntondeane" THEN OUTPUT tauntondeane;
if VARIABLE = "westsomerset" THEN OUTPUT westsomerset;
if VARIABLE = "cannockchase" THEN OUTPUT cannockchase;
if VARIABLE = "eaststaffordshire" THEN OUTPUT eaststaffordshire;
if VARIABLE = "lichfield" THEN OUTPUT lichfield;
if VARIABLE = "newcastleunderlyme" THEN OUTPUT newcastleunderlyme;
if VARIABLE = "southstaffordshire" THEN OUTPUT southstaffordshire;
if VARIABLE = "stafford" THEN OUTPUT stafford;
if VARIABLE = "staffordshiremoorlands" THEN OUTPUT staffordshiremoorlands;
if VARIABLE = "tamworth" THEN OUTPUT tamworth;
if VARIABLE = "babergh" THEN OUTPUT babergh;
if VARIABLE = "forestheath" THEN OUTPUT forestheath;
if VARIABLE = "ipswich" THEN OUTPUT ipswich;
if VARIABLE = "midsuffolk" THEN OUTPUT midsuffolk;
if VARIABLE = "stedmundsbury" THEN OUTPUT stedmundsbury;
if VARIABLE = "suffolkcoastal" THEN OUTPUT suffolkcoastal;
if VARIABLE = "waveney" THEN OUTPUT waveney;
if VARIABLE = "elmbridge" THEN OUTPUT elmbridge;
if VARIABLE = "epsomandewell" THEN OUTPUT epsomandewell;
if VARIABLE = "guildford" THEN OUTPUT guildford;
if VARIABLE = "molevalley" THEN OUTPUT molevalley;
if VARIABLE = "reigateandbanstead" THEN OUTPUT reigateandbanstead;
if VARIABLE = "runnymede" THEN OUTPUT runnymede;
if VARIABLE = "spelthorne" THEN OUTPUT spelthorne;
if VARIABLE = "surreyheath" THEN OUTPUT surreyheath;
if VARIABLE = "tandridge" THEN OUTPUT tandridge;
if VARIABLE = "waverley" THEN OUTPUT waverley;
if VARIABLE = "woking" THEN OUTPUT woking;
if VARIABLE = "northwarwickshire" THEN OUTPUT northwarwickshire;
if VARIABLE = "nuneatonandbedworth" THEN OUTPUT nuneatonandbedworth;
if VARIABLE = "rugby" THEN OUTPUT rugby;
if VARIABLE = "stratfordonavon" THEN OUTPUT stratfordonavon;
if VARIABLE = "warwick" THEN OUTPUT warwick;
if VARIABLE = "adur" THEN OUTPUT adur;
if VARIABLE = "arun" THEN OUTPUT arun;
if VARIABLE = "chichester" THEN OUTPUT chichester;
if VARIABLE = "crawley" THEN OUTPUT crawley;
if VARIABLE = "horsham" THEN OUTPUT horsham;
if VARIABLE = "midsussex" THEN OUTPUT midsussex;
if VARIABLE = "worthing" THEN OUTPUT worthing;
if VARIABLE = "bromsgrove" THEN OUTPUT bromsgrove;
if VARIABLE = "malvernhills" THEN OUTPUT malvernhills;
if VARIABLE = "redditch" THEN OUTPUT redditch;
if VARIABLE = "worcester" THEN OUTPUT worcester;
if VARIABLE = "wychavon" THEN OUTPUT wychavon;
if VARIABLE = "wyreforest" THEN OUTPUT wyreforest;
if VARIABLE = "stalbans" THEN OUTPUT stalbans;
if VARIABLE = "welwynhatfield" THEN OUTPUT welwynhatfield;
if VARIABLE = "bolton" THEN OUTPUT bolton;
if VARIABLE = "bury" THEN OUTPUT bury;
if VARIABLE = "manchester" THEN OUTPUT manchester;
if VARIABLE = "oldham" THEN OUTPUT oldham;
if VARIABLE = "rochdale" THEN OUTPUT rochdale;
if VARIABLE = "salford" THEN OUTPUT salford;
if VARIABLE = "stockport" THEN OUTPUT stockport;
if VARIABLE = "tameside" THEN OUTPUT tameside;
if VARIABLE = "trafford" THEN OUTPUT trafford;
if VARIABLE = "wigan" THEN OUTPUT wigan;
if VARIABLE = "knowsley" THEN OUTPUT knowsley;
if VARIABLE = "liverpool" THEN OUTPUT liverpool;
if VARIABLE = "sthelens" THEN OUTPUT sthelens;
if VARIABLE = "sefton" THEN OUTPUT sefton;
if VARIABLE = "wirral" THEN OUTPUT wirral;
if VARIABLE = "barnsley" THEN OUTPUT barnsley;
if VARIABLE = "doncaster" THEN OUTPUT doncaster;
if VARIABLE = "rotherham" THEN OUTPUT rotherham;
if VARIABLE = "sheffield" THEN OUTPUT sheffield;
if VARIABLE = "gateshead" THEN OUTPUT gateshead;
if VARIABLE = "newcastleupontyne" THEN OUTPUT newcastleupontyne;
if VARIABLE = "northtyneside" THEN OUTPUT northtyneside;
if VARIABLE = "southtyneside" THEN OUTPUT southtyneside;
if VARIABLE = "sunderland" THEN OUTPUT sunderland;
if VARIABLE = "birmingham" THEN OUTPUT birmingham;
if VARIABLE = "coventry" THEN OUTPUT coventry;
if VARIABLE = "dudley" THEN OUTPUT dudley;
if VARIABLE = "sandwell" THEN OUTPUT sandwell;
if VARIABLE = "solihull" THEN OUTPUT solihull;
if VARIABLE = "walsall" THEN OUTPUT walsall;
if VARIABLE = "wolverhampton" THEN OUTPUT wolverhampton;
if VARIABLE = "bradford" THEN OUTPUT bradford;
if VARIABLE = "calderdale" THEN OUTPUT calderdale;
if VARIABLE = "kirklees" THEN OUTPUT kirklees;
if VARIABLE = "leeds" THEN OUTPUT leeds;
if VARIABLE = "wakefield" THEN OUTPUT wakefield;
if VARIABLE = "cityoflondon" THEN OUTPUT cityoflondon;
if VARIABLE = "barkinganddagenham" THEN OUTPUT barkinganddagenham;
if VARIABLE = "barnet" THEN OUTPUT barnet;
if VARIABLE = "bexley" THEN OUTPUT bexley;
if VARIABLE = "brent" THEN OUTPUT brent;
if VARIABLE = "bromley" THEN OUTPUT bromley;
if VARIABLE = "camden" THEN OUTPUT camden;
if VARIABLE = "croydon" THEN OUTPUT croydon;
if VARIABLE = "ealing" THEN OUTPUT ealing;
if VARIABLE = "enfield" THEN OUTPUT enfield;
if VARIABLE = "greenwich" THEN OUTPUT greenwich;
if VARIABLE = "hackney" THEN OUTPUT hackney;
if VARIABLE = "hammersmithandfulham" THEN OUTPUT hammersmithandfulham;
if VARIABLE = "haringey" THEN OUTPUT haringey;
if VARIABLE = "harrow" THEN OUTPUT harrow;
if VARIABLE = "havering" THEN OUTPUT havering;
if VARIABLE = "hillingdon" THEN OUTPUT hillingdon;
if VARIABLE = "hounslow" THEN OUTPUT hounslow;
if VARIABLE = "islington" THEN OUTPUT islington;
if VARIABLE = "kensingtonandchelsea" THEN OUTPUT kensingtonandchelsea;
if VARIABLE = "kingstonuponthames" THEN OUTPUT kingstonuponthames;
if VARIABLE = "lambeth" THEN OUTPUT lambeth;
if VARIABLE = "lewisham" THEN OUTPUT lewisham;
if VARIABLE = "merton" THEN OUTPUT merton;
if VARIABLE = "newham" THEN OUTPUT newham;
if VARIABLE = "redbridge" THEN OUTPUT redbridge;
if VARIABLE = "richmonduponthames" THEN OUTPUT richmonduponthames;
if VARIABLE = "southwark" THEN OUTPUT southwark;
if VARIABLE = "sutton" THEN OUTPUT sutton;
if VARIABLE = "towerhamlets" THEN OUTPUT towerhamlets;
if VARIABLE = "walthamforest" THEN OUTPUT walthamforest;
if VARIABLE = "wandsworth" THEN OUTPUT wandsworth;
if VARIABLE = "westminster" THEN OUTPUT westminster;
if VARIABLE = "cambridgeshire" THEN OUTPUT cambridgeshire;
if VARIABLE = "cumbria" THEN OUTPUT cumbria;
if VARIABLE = "derbyshire" THEN OUTPUT derbyshire;
if VARIABLE = "devon" THEN OUTPUT devon;
if VARIABLE = "dorset" THEN OUTPUT dorset;
if VARIABLE = "eastsussex" THEN OUTPUT eastsussex;
if VARIABLE = "essex" THEN OUTPUT essex;
if VARIABLE = "gloucestershire" THEN OUTPUT gloucestershire;
if VARIABLE = "hampshire" THEN OUTPUT hampshire;
if VARIABLE = "hertfordshire" THEN OUTPUT hertfordshire;
if VARIABLE = "kent" THEN OUTPUT kent;
if VARIABLE = "lancashire" THEN OUTPUT lancashire;
if VARIABLE = "leicestershire" THEN OUTPUT leicestershire;
if VARIABLE = "lincolnshire" THEN OUTPUT lincolnshire;
if VARIABLE = "norfolk" THEN OUTPUT norfolk;
if VARIABLE = "northamptonshire" THEN OUTPUT northamptonshire;
if VARIABLE = "northyorkshire" THEN OUTPUT northyorkshire;
if VARIABLE = "nottinghamshire" THEN OUTPUT nottinghamshire;
if VARIABLE = "oxfordshire" THEN OUTPUT oxfordshire;
if VARIABLE = "somerset" THEN OUTPUT somerset;
if VARIABLE = "staffordshire" THEN OUTPUT staffordshire;
if VARIABLE = "suffolk" THEN OUTPUT suffolk;
if VARIABLE = "surrey" THEN OUTPUT surrey;
if VARIABLE = "warwickshire" THEN OUTPUT warwickshire;
if VARIABLE = "westsussex" THEN OUTPUT westsussex;
if VARIABLE = "worcestershire" THEN OUTPUT worcestershire;
if VARIABLE = "greatermanchester" THEN OUTPUT greatermanchester;
if VARIABLE = "merseyside" THEN OUTPUT merseyside;
if VARIABLE = "southyorkshire" THEN OUTPUT southyorkshire;
if VARIABLE = "tyneandwear" THEN OUTPUT tyneandwear;
if VARIABLE = "westmidlands" THEN OUTPUT westmidlands;
if VARIABLE = "westyorkshire" THEN OUTPUT westyorkshire;
if VARIABLE = "northeast" THEN OUTPUT northeast;
if VARIABLE = "northwest" THEN OUTPUT northwest;
if VARIABLE = "yorkshireandhumber" THEN OUTPUT yorkshireandhumber;
if VARIABLE = "eastmidlands" THEN OUTPUT eastmidlands;
if VARIABLE = "westmidlandsregion" THEN OUTPUT westmidlandsregion;
if VARIABLE = "east" THEN OUTPUT east;
if VARIABLE = "buckinghamshire" THEN OUTPUT buckinghamshire;
if VARIABLE = "london" THEN OUTPUT london;
if VARIABLE = "southeast" THEN OUTPUT southeast;
if VARIABLE = "southwest" THEN OUTPUT southwest;
if VARIABLE = "england" THEN OUTPUT england;
if VARIABLE = "antrimandnewtownabbey" THEN OUTPUT antrimandnewtownabbey;
if VARIABLE = "armaghcitybanbridgeandcraigavon" THEN OUTPUT armaghcitybanbridgeandcraigavon;
if VARIABLE = "belfast" THEN OUTPUT belfast;
if VARIABLE = "causewaycoastandglens" THEN OUTPUT causewaycoastandglens;
if VARIABLE = "derrycityandstrabane" THEN OUTPUT derrycityandstrabane;
if VARIABLE = "fermanaghandomagh" THEN OUTPUT fermanaghandomagh;
if VARIABLE = "lisburnandcastlereagh" THEN OUTPUT lisburnandcastlereagh;
if VARIABLE = "midandeastantrim" THEN OUTPUT midandeastantrim;
if VARIABLE = "midulster" THEN OUTPUT midulster;
if VARIABLE = "newrymourneanddown" THEN OUTPUT newrymourneanddown;
if VARIABLE = "ardsandnorthdown" THEN OUTPUT ardsandnorthdown;
if VARIABLE = "clackmannanshire" THEN OUTPUT clackmannanshire;
if VARIABLE = "dumfriesandgalloway" THEN OUTPUT dumfriesandgalloway;
if VARIABLE = "eastayrshire" THEN OUTPUT eastayrshire;
if VARIABLE = "eastlothian" THEN OUTPUT eastlothian;
if VARIABLE = "eastrenfrewshire" THEN OUTPUT eastrenfrewshire;
if VARIABLE = "naheileanansiar" THEN OUTPUT naheileanansiar;
if VARIABLE = "falkirk" THEN OUTPUT falkirk;
if VARIABLE = "fife" THEN OUTPUT fife;
if VARIABLE = "highland" THEN OUTPUT highland;
if VARIABLE = "inverclyde" THEN OUTPUT inverclyde;
if VARIABLE = "midlothian" THEN OUTPUT midlothian;
if VARIABLE = "moray" THEN OUTPUT moray;
if VARIABLE = "northayrshire" THEN OUTPUT northayrshire;
if VARIABLE = "orkneyislands" THEN OUTPUT orkneyislands;
if VARIABLE = "perthandkinross" THEN OUTPUT perthandkinross;
if VARIABLE = "scottishborders" THEN OUTPUT scottishborders;
if VARIABLE = "shetlandislands" THEN OUTPUT shetlandislands;
if VARIABLE = "southayrshire" THEN OUTPUT southayrshire;
if VARIABLE = "southlanarkshire" THEN OUTPUT southlanarkshire;
if VARIABLE = "stirling" THEN OUTPUT stirling;
if VARIABLE = "aberdeencity" THEN OUTPUT aberdeencity;
if VARIABLE = "aberdeenshire" THEN OUTPUT aberdeenshire;
if VARIABLE = "argyllandbute" THEN OUTPUT argyllandbute;
if VARIABLE = "cityofedinburgh" THEN OUTPUT cityofedinburgh;
if VARIABLE = "renfrewshire" THEN OUTPUT renfrewshire;
if VARIABLE = "westdunbartonshire" THEN OUTPUT westdunbartonshire;
if VARIABLE = "westlothian" THEN OUTPUT westlothian;
if VARIABLE = "angus" THEN OUTPUT angus;
if VARIABLE = "dundeecity" THEN OUTPUT dundeecity;
if VARIABLE = "northlanarkshire" THEN OUTPUT northlanarkshire;
if VARIABLE = "eastdunbartonshire" THEN OUTPUT eastdunbartonshire;
if VARIABLE = "glasgowcity" THEN OUTPUT glasgowcity;
if VARIABLE = "isleofanglesey" THEN OUTPUT isleofanglesey;
if VARIABLE = "gwynedd" THEN OUTPUT gwynedd;
if VARIABLE = "conwy" THEN OUTPUT conwy;
if VARIABLE = "denbighshire" THEN OUTPUT denbighshire;
if VARIABLE = "flintshire" THEN OUTPUT flintshire;
if VARIABLE = "wrexham" THEN OUTPUT wrexham;
if VARIABLE = "ceredigion" THEN OUTPUT ceredigion;
if VARIABLE = "pembrokeshire" THEN OUTPUT pembrokeshire;
if VARIABLE = "carmarthenshire" THEN OUTPUT carmarthenshire;
if VARIABLE = "swansea" THEN OUTPUT swansea;
if VARIABLE = "neathporttalbot" THEN OUTPUT neathporttalbot;
if VARIABLE = "bridgend" THEN OUTPUT bridgend;
if VARIABLE = "valeofglamorgan" THEN OUTPUT valeofglamorgan;
if VARIABLE = "cardiff" THEN OUTPUT cardiff;
if VARIABLE = "rhonddacynontaf" THEN OUTPUT rhonddacynontaf;
if VARIABLE = "caerphilly" THEN OUTPUT caerphilly;
if VARIABLE = "blaenaugwent" THEN OUTPUT blaenaugwent;
if VARIABLE = "torfaen" THEN OUTPUT torfaen;
if VARIABLE = "monmouthshire" THEN OUTPUT monmouthshire;
if VARIABLE = "newport" THEN OUTPUT newport;
if VARIABLE = "powys" THEN OUTPUT powys;
if VARIABLE = "merthyrtydfil" THEN OUTPUT merthyrtydfil;
if VARIABLE = "northernireland" THEN OUTPUT northernireland;
if VARIABLE = "scotland" THEN OUTPUT scotland;
if VARIABLE = "wales" THEN OUTPUT wales;
if VARIABLE = "englandandwales" THEN OUTPUT englandandwales;
if VARIABLE = "greatbritian" THEN OUTPUT greatbritian;
if VARIABLE = "unitedkingdom" THEN OUTPUT unitedkingdom;

RUN;

/*calculate percentages*/
/*for some reason I've had to include 2011 as a valid year in the macro to*/
/*get it to output 2010.  I've tried taking away 2010 and 2011 and 2009 then*/
/*becomes missing from the final datasets*/

%macro calcperc (variable, year);

%let yr = %substr(&year.,3,2);

DATA &variable.;
	SET &variable.;
  array m_&yr. {91} m_&yr._0--m_&yr._90;
  array f_&yr. {91} f_&yr._0--f_&yr._90;
  array m_&yr._perc{91};
  array f_&yr._perc{91};
DO i=1 to 91;
  m_&yr._perc(i) = Round((m_&yr. (i)/ tot_&yr._al)*100,.01); /*Note that the new percentage variables are 1 age group higher than they should be*/
  f_&yr._perc(i) = Round((f_&yr. (i)/ tot_&yr._al)*100,.01);/*Note that the new percentage variables are 1 age group higher than they should be*/
END;
%mend;


%calcperc (hartlepool, 2001) 	%calcperc (middlesbrough, 2001) 	%calcperc (redcarandcleveland, 2001) 	%calcperc (stocktonontees, 2001) 	%calcperc (darlington, 2001) 	%calcperc (halton, 2001) 	%calcperc (warrington, 2001) 	%calcperc (blackburnwithdarwen, 2001) 	%calcperc (blackpool, 2001) 	%calcperc (kingstonuponhullcityof, 2001) 	%calcperc (eastridingofyorkshire, 2001) 	%calcperc (northeastlincolnshire, 2001) 	%calcperc (northlincolnshire, 2001) 	%calcperc (york, 2001) 	%calcperc (derby, 2001) 	%calcperc (leicester, 2001) 	%calcperc (rutland, 2001) 	%calcperc (nottingham, 2001) 	%calcperc (herefordshirecountyof, 2001) 	%calcperc (telfordandwrekin, 2001) 	%calcperc (stokeontrent, 2001) 	%calcperc (bathandnortheastsomerset, 2001) 	%calcperc (bristolcityof, 2001) 	%calcperc (northsomerset, 2001) 	%calcperc (southgloucestershire, 2001) 	%calcperc (plymouth, 2001) 	%calcperc (torbay, 2001) 	%calcperc (bournemouth, 2001) 	%calcperc (poole, 2001) 	%calcperc (swindon, 2001) 	%calcperc (peterborough, 2001) 	%calcperc (luton, 2001) 	%calcperc (southendonsea, 2001) 	%calcperc (thurrock, 2001) 	%calcperc (medway, 2001) 	%calcperc (bracknellforest, 2001) 	%calcperc (westberkshire, 2001) 	%calcperc (reading, 2001) 	%calcperc (slough, 2001) 	%calcperc (windsorandmaidenhead, 2001) 	%calcperc (wokingham, 2001) 	%calcperc (miltonkeynes, 2001) 	%calcperc (brightonandhove, 2001) 	%calcperc (portsmouth, 2001) 	%calcperc (southampton, 2001) 	%calcperc (isleofwight, 2001) 	%calcperc (countydurham, 2001) 	%calcperc (cheshireeast, 2001) 	%calcperc (cheshirewestandchester, 2001) 	%calcperc (shropshire, 2001) 	%calcperc (cornwall, 2001) 	%calcperc (islesofscilly, 2001) 	%calcperc (wiltshire, 2001) 	%calcperc (bedford, 2001) 	%calcperc (centralbedfordshire, 2001) 	%calcperc (northumberland, 2001) 	%calcperc (aylesburyvale, 2001) 	%calcperc (chiltern, 2001) 	%calcperc (southbucks, 2001) 	%calcperc (wycombe, 2001) 	%calcperc (cambridge, 2001) 	%calcperc (eastcambridgeshire, 2001) 	%calcperc (fenland, 2001) 	%calcperc (huntingdonshire, 2001) 	%calcperc (southcambridgeshire, 2001) 	%calcperc (allerdale, 2001) 	%calcperc (barrowinfurness, 2001) 	%calcperc (carlisle, 2001) 	%calcperc (copeland, 2001) 	%calcperc (eden, 2001) 	%calcperc (southlakeland, 2001) 	%calcperc (ambervalley, 2001) 	%calcperc (bolsover, 2001) 	%calcperc (chesterfield, 2001) 	%calcperc (derbyshiredales, 2001) 	%calcperc (erewash, 2001) 	%calcperc (highpeak, 2001) 	%calcperc (northeastderbyshire, 2001) 	%calcperc (southderbyshire, 2001) 	%calcperc (eastdevon, 2001) 	%calcperc (exeter, 2001) 	%calcperc (middevon, 2001) 	%calcperc (northdevon, 2001) 	%calcperc (southhams, 2001) 	%calcperc (teignbridge, 2001) 	%calcperc (torridge, 2001) 	%calcperc (westdevon, 2001) 	%calcperc (christchurch, 2001) 	%calcperc (eastdorset, 2001) 	%calcperc (northdorset, 2001) 	%calcperc (purbeck, 2001) 	%calcperc (westdorset, 2001) 	%calcperc (weymouthandportland, 2001) 	%calcperc (eastbourne, 2001) 	%calcperc (hastings, 2001) 	%calcperc (lewes, 2001) 	%calcperc (rother, 2001) 	%calcperc (wealden, 2001) 	%calcperc (basildon, 2001) 	%calcperc (braintree, 2001) 	%calcperc (brentwood, 2001) 	%calcperc (castlepoint, 2001) 	%calcperc (chelmsford, 2001) 	%calcperc (colchester, 2001) 	
%calcperc (eppingforest, 2001) 	%calcperc (harlow, 2001) 	%calcperc (maldon, 2001) 	%calcperc (rochford, 2001) 	%calcperc (tendring, 2001) 	%calcperc (uttlesford, 2001) 	%calcperc (cheltenham, 2001) 	%calcperc (cotswold, 2001) 	%calcperc (forestofdean, 2001) 	%calcperc (gloucester, 2001) 	%calcperc (stroud, 2001) 	%calcperc (tewkesbury, 2001) 	%calcperc (basingstokeanddeane, 2001) 	%calcperc (easthampshire, 2001) 	%calcperc (eastleigh, 2001) 	%calcperc (fareham, 2001) 	%calcperc (gosport, 2001) 	%calcperc (hart, 2001) 	%calcperc (havant, 2001) 	%calcperc (newforest, 2001) 	%calcperc (rushmoor, 2001) 	%calcperc (testvalley, 2001) 	%calcperc (winchester, 2001) 	%calcperc (broxbourne, 2001) 	%calcperc (dacorum, 2001) 	%calcperc (hertsmere, 2001) 	%calcperc (northhertfordshire, 2001) 	%calcperc (threerivers, 2001) 	%calcperc (watford, 2001) 	%calcperc (ashford, 2001) 	%calcperc (canterbury, 2001) 	%calcperc (dartford, 2001) 	%calcperc (dover, 2001) 	%calcperc (gravesham, 2001) 	%calcperc (maidstone, 2001) 	%calcperc (sevenoaks, 2001) 	%calcperc (shepway, 2001) 	%calcperc (swale, 2001) 	%calcperc (thanet, 2001) 	%calcperc (tonbridgeandmalling, 2001) 	%calcperc (tunbridgewells, 2001) 	%calcperc (burnley, 2001) 	%calcperc (chorley, 2001) 	%calcperc (fylde, 2001) 	%calcperc (hyndburn, 2001) 	%calcperc (lancaster, 2001) 	%calcperc (pendle, 2001) 	%calcperc (preston, 2001) 	%calcperc (ribblevalley, 2001) 	%calcperc (rossendale, 2001) 	%calcperc (southribble, 2001) 	%calcperc (westlancashire, 2001) 	%calcperc (wyre, 2001) 	%calcperc (blaby, 2001) 	%calcperc (charnwood, 2001) 	%calcperc (harborough, 2001) 	%calcperc (hinckleyandbosworth, 2001) 	%calcperc (melton, 2001) 	%calcperc (northwestleicestershire, 2001) 	%calcperc (oadbyandwigston, 2001) 	%calcperc (boston, 2001) 	%calcperc (eastlindsey, 2001) 	%calcperc (lincoln, 2001) 	%calcperc (northkesteven, 2001) 	%calcperc (southholland, 2001) 	%calcperc (southkesteven, 2001) 	%calcperc (westlindsey, 2001) 	%calcperc (breckland, 2001) 	%calcperc (broadland, 2001) 	%calcperc (greatyarmouth, 2001) 	%calcperc (kingslynnandwestnorfolk, 2001) 	%calcperc (northnorfolk, 2001) 	%calcperc (norwich, 2001) 	%calcperc (southnorfolk, 2001) 	%calcperc (corby, 2001) 	%calcperc (daventry, 2001) 	%calcperc (eastnorthamptonshire, 2001) 	%calcperc (kettering, 2001) 	%calcperc (northampton, 2001) 	%calcperc (southnorthamptonshire, 2001) 	%calcperc (wellingborough, 2001) 	%calcperc (craven, 2001) 	%calcperc (hambleton, 2001) 	%calcperc (harrogate, 2001) 	%calcperc (richmondshire, 2001) 	%calcperc (ryedale, 2001) 	%calcperc (scarborough, 2001) 	%calcperc (selby, 2001) 	%calcperc (ashfield, 2001) 	%calcperc (bassetlaw, 2001) 	%calcperc (broxtowe, 2001) 	%calcperc (gedling, 2001) 	%calcperc (mansfield, 2001) 	%calcperc (newarkandsherwood, 2001) 	%calcperc (rushcliffe, 2001) 	%calcperc (cherwell, 2001) 	%calcperc (oxford, 2001) 	%calcperc (southoxfordshire, 2001) 	%calcperc (valeofwhitehorse, 2001) 	%calcperc (westoxfordshire, 2001) 	%calcperc (mendip, 2001) 	%calcperc (sedgemoor, 2001) 	%calcperc (southsomerset, 2001) 	%calcperc (tauntondeane, 2001) 	%calcperc (westsomerset, 2001) 	%calcperc (cannockchase, 2001) 	%calcperc (eaststaffordshire, 2001) 	
%calcperc (lichfield, 2001) 	%calcperc (newcastleunderlyme, 2001) 	%calcperc (southstaffordshire, 2001) 	%calcperc (stafford, 2001) 	%calcperc (staffordshiremoorlands, 2001) 	%calcperc (tamworth, 2001) 	%calcperc (babergh, 2001) 	%calcperc (forestheath, 2001) 	%calcperc (ipswich, 2001) 	%calcperc (midsuffolk, 2001) 	%calcperc (stedmundsbury, 2001) 	%calcperc (suffolkcoastal, 2001) 	
%calcperc (waveney, 2001) 	%calcperc (elmbridge, 2001) %calcperc (epsomandewell, 2001) 	%calcperc (guildford, 2001) 	%calcperc (molevalley, 2001) 	%calcperc (reigateandbanstead, 2001) 	%calcperc (runnymede, 2001) 	%calcperc (spelthorne, 2001) 	%calcperc (surreyheath, 2001) 	%calcperc (tandridge, 2001) 	%calcperc (waverley, 2001) 	%calcperc (woking, 2001) 	%calcperc (northwarwickshire, 2001) 	%calcperc (nuneatonandbedworth, 2001) 	%calcperc (rugby, 2001) 	%calcperc (stratfordonavon, 2001) 	%calcperc (warwick, 2001) 	%calcperc (adur, 2001) 	%calcperc (arun, 2001) 	%calcperc (chichester, 2001) 	%calcperc (crawley, 2001) 	%calcperc (horsham, 2001) 	%calcperc (midsussex, 2001) 	%calcperc (worthing, 2001) 	%calcperc (bromsgrove, 2001) 	%calcperc (malvernhills, 2001) 	%calcperc (redditch, 2001) 	%calcperc (worcester, 2001) 	%calcperc (wychavon, 2001) 	%calcperc (wyreforest, 2001) 	%calcperc (stalbans, 2001) 	%calcperc (welwynhatfield, 2001) 	%calcperc (easthertfordshire, 2001) 	%calcperc (stevenage, 2001) 	%calcperc (bolton, 2001) 	%calcperc (bury, 2001) 	%calcperc (manchester, 2001) 	%calcperc (oldham, 2001) 	%calcperc (rochdale, 2001) 	%calcperc (salford, 2001) 	%calcperc (stockport, 2001) 	%calcperc (tameside, 2001) 	%calcperc (trafford, 2001) 	%calcperc (wigan, 2001) 	%calcperc (knowsley, 2001) 	%calcperc (liverpool, 2001) 	%calcperc (sthelens, 2001) 	%calcperc (sefton, 2001) 	%calcperc (wirral, 2001) 	%calcperc (barnsley, 2001) 	%calcperc (doncaster, 2001) 	%calcperc (rotherham, 2001) 	%calcperc (sheffield, 2001) 	%calcperc (newcastleupontyne, 2001) 	%calcperc (northtyneside, 2001) 	%calcperc (southtyneside, 2001) 	%calcperc (sunderland, 2001) 	%calcperc (birmingham, 2001) 	%calcperc (coventry, 2001) 	%calcperc (dudley, 2001) 	%calcperc (sandwell, 2001) 	%calcperc (solihull, 2001) 	%calcperc (walsall, 2001) 	%calcperc (wolverhampton, 2001) 	%calcperc (bradford, 2001) 	%calcperc (calderdale, 2001) 	%calcperc (kirklees, 2001) 	%calcperc (leeds, 2001) 	%calcperc (wakefield, 2001) 	%calcperc (gateshead, 2001) 	%calcperc (cityoflondon, 2001) 	%calcperc (barkinganddagenham, 2001) 	%calcperc (barnet, 2001) 	%calcperc (bexley, 2001) 	%calcperc (brent, 2001) 	%calcperc (bromley, 2001) 	%calcperc (camden, 2001) 	%calcperc (croydon, 2001) 	%calcperc (ealing, 2001) 	%calcperc (enfield, 2001) 	%calcperc (greenwich, 2001) 	%calcperc (hackney, 2001) 	%calcperc (hammersmithandfulham, 2001) 	%calcperc (haringey, 2001) 	%calcperc (harrow, 2001) 	%calcperc (havering, 2001) 	%calcperc (hillingdon, 2001) 	%calcperc (hounslow, 2001) 	%calcperc (islington, 2001) 	%calcperc (kensingtonandchelsea, 2001) 	%calcperc (kingstonuponthames, 2001) 	%calcperc (lambeth, 2001) 	%calcperc (lewisham, 2001) 	%calcperc (merton, 2001) 	%calcperc (newham, 2001) 	%calcperc (redbridge, 2001) 	%calcperc (richmonduponthames, 2001) 	%calcperc (southwark, 2001) 	%calcperc (sutton, 2001) 	%calcperc (towerhamlets, 2001) 	%calcperc (walthamforest, 2001) 	%calcperc (wandsworth, 2001) 	%calcperc (westminster, 2001) 	%calcperc (buckinghamshire, 2001) 	%calcperc (cambridgeshire, 2001) 	%calcperc (cumbria, 2001) 	%calcperc (derbyshire, 2001) 	%calcperc (devon, 2001) 	%calcperc (dorset, 2001) 	%calcperc (eastsussex, 2001) 	
%calcperc (essex, 2001) 	%calcperc (gloucestershire, 2001) 	%calcperc (hampshire, 2001) 	%calcperc (hertfordshire, 2001) 	%calcperc (kent, 2001) 	%calcperc (lancashire, 2001) 	%calcperc (leicestershire, 2001) 	%calcperc (lincolnshire, 2001) 	%calcperc (norfolk, 2001) 	%calcperc (northamptonshire, 2001) 	%calcperc (northyorkshire, 2001) 	%calcperc (nottinghamshire, 2001) 	%calcperc (oxfordshire, 2001) 	%calcperc (somerset, 2001) 	%calcperc (staffordshire, 2001) 	%calcperc (suffolk, 2001) 	%calcperc (surrey, 2001) 	%calcperc (warwickshire, 2001) 	%calcperc (westsussex, 2001) 	%calcperc (worcestershire, 2001) 	%calcperc (greatermanchester, 2001) 	%calcperc (merseyside, 2001) 	%calcperc (southyorkshire, 2001) 	%calcperc (westmidlands, 2001) 	%calcperc (westyorkshire, 2001) 	%calcperc (tyneandwear, 2001) 	%calcperc (antrimandnewtownabbey, 2001) 	%calcperc (armaghcitybanbridgeandcraigavon, 2001) 	%calcperc (belfast, 2001) 	%calcperc (causewaycoastandglens, 2001) 	%calcperc (derrycityandstrabane, 2001) 	%calcperc (fermanaghandomagh, 2001) 	%calcperc (lisburnandcastlereagh, 2001) 	%calcperc (midandeastantrim, 2001) 	%calcperc (midulster, 2001) 	%calcperc (newrymourneanddown, 2001) 	%calcperc (ardsandnorthdown, 2001) 	%calcperc (clackmannanshire, 2001) 	%calcperc (dumfriesandgalloway, 2001) 	%calcperc (eastayrshire, 2001) 	%calcperc (eastlothian, 2001) 	%calcperc (eastrenfrewshire, 2001) 	%calcperc (naheileanansiar, 2001) 	%calcperc (falkirk, 2001) 	%calcperc (fife, 2001) 	%calcperc (highland, 2001) 	%calcperc (inverclyde, 2001) 	%calcperc (midlothian, 2001) 	%calcperc (moray, 2001) 	%calcperc (northayrshire, 2001) 	%calcperc (orkneyislands, 2001) 	%calcperc (perthandkinross, 2001) 	%calcperc (scottishborders, 2001) 	%calcperc (shetlandislands, 2001) 	%calcperc (southayrshire, 2001) 	%calcperc (southlanarkshire, 2001) 	%calcperc (stirling, 2001) 	%calcperc (aberdeencity, 2001) 	%calcperc (aberdeenshire, 2001) 	%calcperc (argyllandbute, 2001) 	%calcperc (cityofedinburgh, 2001) 	%calcperc (renfrewshire, 2001) 	%calcperc (westdunbartonshire, 2001) 	%calcperc (westlothian, 2001) 	%calcperc (angus, 2001) 	%calcperc (dundeecity, 2001) 	%calcperc (northlanarkshire, 2001) 	%calcperc (eastdunbartonshire, 2001) 	%calcperc (glasgowcity, 2001) 	%calcperc (isleofanglesey, 2001) 	%calcperc (gwynedd, 2001) 	%calcperc (conwy, 2001) 	%calcperc (denbighshire, 2001) 	%calcperc (flintshire, 2001) 	%calcperc (wrexham, 2001) 	%calcperc (ceredigion, 2001) 	%calcperc (pembrokeshire, 2001) 	%calcperc (carmarthenshire, 2001) 	%calcperc (swansea, 2001) 	%calcperc (neathporttalbot, 2001) 	%calcperc (bridgend, 2001) 	%calcperc (valeofglamorgan, 2001) 	%calcperc (cardiff, 2001) 	%calcperc (rhonddacynontaf, 2001) 	%calcperc (caerphilly, 2001) 	%calcperc (blaenaugwent, 2001) 	%calcperc (torfaen, 2001) 	%calcperc (monmouthshire, 2001) 	%calcperc (newport, 2001) 	%calcperc (powys, 2001) 	%calcperc (merthyrtydfil, 2001) 	%calcperc (northeast, 2001) 	%calcperc (northwest, 2001) 	%calcperc (yorkshireandhumber, 2001) 	%calcperc (eastmidlands, 2001) 	%calcperc (westmidlandsregion, 2001) 	%calcperc (east, 2001) 	%calcperc (london, 2001) 	%calcperc (southeast, 2001) 	%calcperc (southwest, 2001) 	%calcperc (england, 2001) 	
%calcperc (northernireland, 2001) 	%calcperc (scotland, 2001) 	%calcperc (wales, 2001) 	%calcperc (englandandwales, 2001) 	%calcperc (greatbritian, 2001) 	%calcperc (unitedkingdom, 2001); 
%calcperc (hartlepool, 2002) 	%calcperc (middlesbrough, 2002) 	%calcperc (redcarandcleveland, 2002) 	%calcperc (stocktonontees, 2002) 	%calcperc (darlington, 2002) 	%calcperc (halton, 2002) 	%calcperc (warrington, 2002) 	%calcperc (blackburnwithdarwen, 2002) 	%calcperc (blackpool, 2002) 	%calcperc (kingstonuponhullcityof, 2002) 	%calcperc (eastridingofyorkshire, 2002) 	%calcperc (northeastlincolnshire, 2002) 	%calcperc (northlincolnshire, 2002) 	%calcperc (york, 2002) 	%calcperc (derby, 2002) 	%calcperc (leicester, 2002) 	%calcperc (rutland, 2002) 	%calcperc (nottingham, 2002) 	%calcperc (herefordshirecountyof, 2002) 	%calcperc (telfordandwrekin, 2002) 	%calcperc (stokeontrent, 2002) 	%calcperc (bathandnortheastsomerset, 2002) 	%calcperc (bristolcityof, 2002) 	%calcperc (northsomerset, 2002) 	%calcperc (southgloucestershire, 2002) 	%calcperc (plymouth, 2002) 	%calcperc (torbay, 2002) 	%calcperc (bournemouth, 2002) 	%calcperc (poole, 2002) 	%calcperc (swindon, 2002) 	%calcperc (peterborough, 2002) 	%calcperc (luton, 2002) 	%calcperc (southendonsea, 2002) 	%calcperc (thurrock, 2002) 	%calcperc (medway, 2002) 	%calcperc (bracknellforest, 2002) 	%calcperc (westberkshire, 2002) 	%calcperc (reading, 2002) 	%calcperc (slough, 2002) 	%calcperc (windsorandmaidenhead, 2002) 	%calcperc (wokingham, 2002) 	%calcperc (miltonkeynes, 2002) 	%calcperc (brightonandhove, 2002) 	%calcperc (portsmouth, 2002) 	%calcperc (southampton, 2002) 	%calcperc (isleofwight, 2002) 	%calcperc (countydurham, 2002) 	%calcperc (cheshireeast, 2002) 	%calcperc (cheshirewestandchester, 2002) 	%calcperc (shropshire, 2002) 	%calcperc (cornwall, 2002) 	%calcperc (islesofscilly, 2002) 	%calcperc (wiltshire, 2002) 	%calcperc (bedford, 2002) 	%calcperc (centralbedfordshire, 2002) 	%calcperc (northumberland, 2002) 	%calcperc (aylesburyvale, 2002) 	%calcperc (chiltern, 2002) 	%calcperc (southbucks, 2002) 	%calcperc (wycombe, 2002) 	%calcperc (cambridge, 2002) 	%calcperc (eastcambridgeshire, 2002) 	%calcperc (fenland, 2002) 	%calcperc (huntingdonshire, 2002) 	%calcperc (southcambridgeshire, 2002) 	%calcperc (allerdale, 2002) 	%calcperc (barrowinfurness, 2002) 	%calcperc (carlisle, 2002) 	%calcperc (copeland, 2002) 	%calcperc (eden, 2002) 	%calcperc (southlakeland, 2002) 	%calcperc (ambervalley, 2002) 	%calcperc (bolsover, 2002) 	%calcperc (chesterfield, 2002) 	%calcperc (derbyshiredales, 2002) 	%calcperc (erewash, 2002) 	%calcperc (highpeak, 2002) 	%calcperc (northeastderbyshire, 2002) 	%calcperc (southderbyshire, 2002) 	%calcperc (eastdevon, 2002) 	%calcperc (exeter, 2002) 	%calcperc (middevon, 2002) 	%calcperc (northdevon, 2002) 	%calcperc (southhams, 2002) 	%calcperc (teignbridge, 2002) 	%calcperc (torridge, 2002) 	%calcperc (westdevon, 2002) 	%calcperc (christchurch, 2002) 	%calcperc (eastdorset, 2002) 	%calcperc (northdorset, 2002) 	%calcperc (purbeck, 2002) 	%calcperc (westdorset, 2002) 	%calcperc (weymouthandportland, 2002) 	%calcperc (eastbourne, 2002) 	%calcperc (hastings, 2002) 	%calcperc (lewes, 2002) 	%calcperc (rother, 2002) 	%calcperc (wealden, 2002) 	%calcperc (basildon, 2002) 	%calcperc (braintree, 2002) 	%calcperc (brentwood, 2002) 	%calcperc (castlepoint, 2002) 	%calcperc (chelmsford, 2002) 	%calcperc (colchester, 2002) 	
%calcperc (eppingforest, 2002) 	%calcperc (harlow, 2002) 	%calcperc (maldon, 2002) 	%calcperc (rochford, 2002) 	%calcperc (tendring, 2002) 	%calcperc (uttlesford, 2002) 	%calcperc (cheltenham, 2002) 	%calcperc (cotswold, 2002) 	%calcperc (forestofdean, 2002) 	%calcperc (gloucester, 2002) 	%calcperc (stroud, 2002) 	%calcperc (tewkesbury, 2002) 	%calcperc (basingstokeanddeane, 2002) 	%calcperc (easthampshire, 2002) 	%calcperc (eastleigh, 2002) 	%calcperc (fareham, 2002) 	%calcperc (gosport, 2002) 	%calcperc (hart, 2002) 	%calcperc (havant, 2002) 	%calcperc (newforest, 2002) 	%calcperc (rushmoor, 2002) 	%calcperc (testvalley, 2002) 	%calcperc (winchester, 2002) 	%calcperc (broxbourne, 2002) 	%calcperc (dacorum, 2002) 	%calcperc (hertsmere, 2002) 	%calcperc (northhertfordshire, 2002) 	%calcperc (threerivers, 2002) 	%calcperc (watford, 2002) 	%calcperc (ashford, 2002) 	%calcperc (canterbury, 2002) 	%calcperc (dartford, 2002) 	%calcperc (dover, 2002) 	%calcperc (gravesham, 2002) 	%calcperc (maidstone, 2002) 	%calcperc (sevenoaks, 2002) 	%calcperc (shepway, 2002) 	%calcperc (swale, 2002) 	%calcperc (thanet, 2002) 	%calcperc (tonbridgeandmalling, 2002) 	%calcperc (tunbridgewells, 2002) 	%calcperc (burnley, 2002) 	%calcperc (chorley, 2002) 	%calcperc (fylde, 2002) 	%calcperc (hyndburn, 2002) 	%calcperc (lancaster, 2002) 	%calcperc (pendle, 2002) 	%calcperc (preston, 2002) 	%calcperc (ribblevalley, 2002) 	%calcperc (rossendale, 2002) 	%calcperc (southribble, 2002) 	%calcperc (westlancashire, 2002) 	%calcperc (wyre, 2002) 	%calcperc (blaby, 2002) 	%calcperc (charnwood, 2002) 	%calcperc (harborough, 2002) 	%calcperc (hinckleyandbosworth, 2002) 	%calcperc (melton, 2002) 	%calcperc (northwestleicestershire, 2002) 	%calcperc (oadbyandwigston, 2002) 	%calcperc (boston, 2002) 	%calcperc (eastlindsey, 2002) 	%calcperc (lincoln, 2002) 	%calcperc (northkesteven, 2002) 	%calcperc (southholland, 2002) 	%calcperc (southkesteven, 2002) 	%calcperc (westlindsey, 2002) 	%calcperc (breckland, 2002) 	%calcperc (broadland, 2002) 	%calcperc (greatyarmouth, 2002) 	%calcperc (kingslynnandwestnorfolk, 2002) 	%calcperc (northnorfolk, 2002) 	%calcperc (norwich, 2002) 	%calcperc (southnorfolk, 2002) 	%calcperc (corby, 2002) 	%calcperc (daventry, 2002) 	%calcperc (eastnorthamptonshire, 2002) 	%calcperc (kettering, 2002) 	%calcperc (northampton, 2002) 	%calcperc (southnorthamptonshire, 2002) 	%calcperc (wellingborough, 2002) 	%calcperc (craven, 2002) 	%calcperc (hambleton, 2002) 	%calcperc (harrogate, 2002) 	%calcperc (richmondshire, 2002) 	%calcperc (ryedale, 2002) 	%calcperc (scarborough, 2002) 	%calcperc (selby, 2002) 	%calcperc (ashfield, 2002) 	%calcperc (bassetlaw, 2002) 	%calcperc (broxtowe, 2002) 	%calcperc (gedling, 2002) 	%calcperc (mansfield, 2002) 	%calcperc (newarkandsherwood, 2002) 	%calcperc (rushcliffe, 2002) 	%calcperc (cherwell, 2002) 	%calcperc (oxford, 2002) 	%calcperc (southoxfordshire, 2002) 	%calcperc (valeofwhitehorse, 2002) 	%calcperc (westoxfordshire, 2002) 	%calcperc (mendip, 2002) 	%calcperc (sedgemoor, 2002) 	%calcperc (southsomerset, 2002) 	%calcperc (tauntondeane, 2002) 	%calcperc (westsomerset, 2002) 	%calcperc (cannockchase, 2002) 	%calcperc (eaststaffordshire, 2002) 	
%calcperc (lichfield, 2002) 	%calcperc (newcastleunderlyme, 2002) 	%calcperc (southstaffordshire, 2002) 	%calcperc (stafford, 2002) 	%calcperc (staffordshiremoorlands, 2002) 	%calcperc (tamworth, 2002) 	%calcperc (babergh, 2002) 	%calcperc (forestheath, 2002) 	%calcperc (ipswich, 2002) 	%calcperc (midsuffolk, 2002) 	%calcperc (stedmundsbury, 2002) 	%calcperc (suffolkcoastal, 2002) 	
%calcperc (waveney, 2002) 	%calcperc (elmbridge, 2002) 	%calcperc (epsomandewell, 2002) 	%calcperc (guildford, 2002) 	%calcperc (molevalley, 2002) 	%calcperc (reigateandbanstead, 2002) 	%calcperc (runnymede, 2002) 	%calcperc (spelthorne, 2002) 	%calcperc (surreyheath, 2002) 	%calcperc (tandridge, 2002) 	%calcperc (waverley, 2002) 	%calcperc (woking, 2002) 	%calcperc (northwarwickshire, 2002) 	%calcperc (nuneatonandbedworth, 2002) 	%calcperc (rugby, 2002) 	%calcperc (stratfordonavon, 2002) 	%calcperc (warwick, 2002) 	%calcperc (adur, 2002) 	%calcperc (arun, 2002) 	%calcperc (chichester, 2002) 	%calcperc (crawley, 2002) 	%calcperc (horsham, 2002) 	%calcperc (midsussex, 2002) 	%calcperc (worthing, 2002) 	%calcperc (bromsgrove, 2002) 	%calcperc (malvernhills, 2002) 	%calcperc (redditch, 2002) 	%calcperc (worcester, 2002) 	%calcperc (wychavon, 2002) 	%calcperc (wyreforest, 2002) 	%calcperc (stalbans, 2002) 	%calcperc (welwynhatfield, 2002) 	%calcperc (easthertfordshire, 2002) 	%calcperc (stevenage, 2002) 	%calcperc (bolton, 2002) 	%calcperc (bury, 2002) 	%calcperc (manchester, 2002) 	%calcperc (oldham, 2002) 	%calcperc (rochdale, 2002) 	%calcperc (salford, 2002) 	%calcperc (stockport, 2002) 	%calcperc (tameside, 2002) 	%calcperc (trafford, 2002) 	%calcperc (wigan, 2002) 	%calcperc (knowsley, 2002) 	%calcperc (liverpool, 2002) 	%calcperc (sthelens, 2002) 	%calcperc (sefton, 2002) 	%calcperc (wirral, 2002) 	%calcperc (barnsley, 2002) 	%calcperc (doncaster, 2002) 	%calcperc (rotherham, 2002) 	%calcperc (sheffield, 2002) 	%calcperc (newcastleupontyne, 2002) 	%calcperc (northtyneside, 2002) 	%calcperc (southtyneside, 2002) 	%calcperc (sunderland, 2002) 	%calcperc (birmingham, 2002) 	%calcperc (coventry, 2002) 	%calcperc (dudley, 2002) 	%calcperc (sandwell, 2002) 	%calcperc (solihull, 2002) 	%calcperc (walsall, 2002) 	%calcperc (wolverhampton, 2002) 	%calcperc (bradford, 2002) 	%calcperc (calderdale, 2002) 	%calcperc (kirklees, 2002) 	%calcperc (leeds, 2002) 	%calcperc (wakefield, 2002) 	%calcperc (gateshead, 2002) 	%calcperc (cityoflondon, 2002) 	%calcperc (barkinganddagenham, 2002) 	%calcperc (barnet, 2002) 	%calcperc (bexley, 2002) 	%calcperc (brent, 2002) 	%calcperc (bromley, 2002) 	%calcperc (camden, 2002) 	%calcperc (croydon, 2002) 	%calcperc (ealing, 2002) 	%calcperc (enfield, 2002) 	%calcperc (greenwich, 2002) 	%calcperc (hackney, 2002) 	%calcperc (hammersmithandfulham, 2002) 	%calcperc (haringey, 2002) 	%calcperc (harrow, 2002) 	%calcperc (havering, 2002) 	%calcperc (hillingdon, 2002) 	%calcperc (hounslow, 2002) 	%calcperc (islington, 2002) 	%calcperc (kensingtonandchelsea, 2002) 	%calcperc (kingstonuponthames, 2002) 	%calcperc (lambeth, 2002) 	%calcperc (lewisham, 2002) 	%calcperc (merton, 2002) 	%calcperc (newham, 2002) 	%calcperc (redbridge, 2002) 	%calcperc (richmonduponthames, 2002) 	%calcperc (southwark, 2002) 	%calcperc (sutton, 2002) 	%calcperc (towerhamlets, 2002) 	%calcperc (walthamforest, 2002) 	%calcperc (wandsworth, 2002) 	%calcperc (westminster, 2002) 	%calcperc (buckinghamshire, 2002) 	%calcperc (cambridgeshire, 2002) 	%calcperc (cumbria, 2002) 	%calcperc (derbyshire, 2002) 	%calcperc (devon, 2002) 	%calcperc (dorset, 2002) 	%calcperc (eastsussex, 2002) 	
%calcperc (essex, 2002) 	%calcperc (gloucestershire, 2002) 	%calcperc (hampshire, 2002) 	%calcperc (hertfordshire, 2002) 	%calcperc (kent, 2002) 	%calcperc (lancashire, 2002) 	%calcperc (leicestershire, 2002) 	%calcperc (lincolnshire, 2002) 	%calcperc (norfolk, 2002) 	%calcperc (northamptonshire, 2002) 	%calcperc (northyorkshire, 2002) 	%calcperc (nottinghamshire, 2002) 	%calcperc (oxfordshire, 2002) 	%calcperc (somerset, 2002) 	%calcperc (staffordshire, 2002) 	%calcperc (suffolk, 2002) 	%calcperc (surrey, 2002) 	%calcperc (warwickshire, 2002) 	%calcperc (westsussex, 2002) 	%calcperc (worcestershire, 2002) 	%calcperc (greatermanchester, 2002) 	%calcperc (merseyside, 2002) 	%calcperc (southyorkshire, 2002) 	%calcperc (westmidlands, 2002) 	%calcperc (westyorkshire, 2002) 	%calcperc (tyneandwear, 2002) 	%calcperc (antrimandnewtownabbey, 2002) 	%calcperc (armaghcitybanbridgeandcraigavon, 2002) 	%calcperc (belfast, 2002) 	%calcperc (causewaycoastandglens, 2002) 	%calcperc (derrycityandstrabane, 2002) 	%calcperc (fermanaghandomagh, 2002) 	%calcperc (lisburnandcastlereagh, 2002) 	%calcperc (midandeastantrim, 2002) 	%calcperc (midulster, 2002) 	%calcperc (newrymourneanddown, 2002) 	%calcperc (ardsandnorthdown, 2002) 	%calcperc (clackmannanshire, 2002) 	%calcperc (dumfriesandgalloway, 2002) 	%calcperc (eastayrshire, 2002) 	%calcperc (eastlothian, 2002) 	%calcperc (eastrenfrewshire, 2002) 	%calcperc (naheileanansiar, 2002) 	%calcperc (falkirk, 2002) 	%calcperc (fife, 2002) 	%calcperc (highland, 2002) 	%calcperc (inverclyde, 2002) 	%calcperc (midlothian, 2002) 	%calcperc (moray, 2002) 	%calcperc (northayrshire, 2002) 	%calcperc (orkneyislands, 2002) 	%calcperc (perthandkinross, 2002) 	%calcperc (scottishborders, 2002) 	%calcperc (shetlandislands, 2002) 	%calcperc (southayrshire, 2002) 	%calcperc (southlanarkshire, 2002) 	%calcperc (stirling, 2002) 	%calcperc (aberdeencity, 2002) 	%calcperc (aberdeenshire, 2002) 	%calcperc (argyllandbute, 2002) 	%calcperc (cityofedinburgh, 2002) 	%calcperc (renfrewshire, 2002) 	%calcperc (westdunbartonshire, 2002) 	%calcperc (westlothian, 2002) 	%calcperc (angus, 2002) 	%calcperc (dundeecity, 2002) 	%calcperc (northlanarkshire, 2002) 	%calcperc (eastdunbartonshire, 2002) 	%calcperc (glasgowcity, 2002) 	%calcperc (isleofanglesey, 2002) 	%calcperc (gwynedd, 2002) 	%calcperc (conwy, 2002) 	%calcperc (denbighshire, 2002) 	%calcperc (flintshire, 2002) 	%calcperc (wrexham, 2002) 	%calcperc (ceredigion, 2002) 	%calcperc (pembrokeshire, 2002) 	%calcperc (carmarthenshire, 2002) 	%calcperc (swansea, 2002) 	%calcperc (neathporttalbot, 2002) 	%calcperc (bridgend, 2002) 	%calcperc (valeofglamorgan, 2002) 	%calcperc (cardiff, 2002) 	%calcperc (rhonddacynontaf, 2002) 	%calcperc (caerphilly, 2002) 	%calcperc (blaenaugwent, 2002) 	%calcperc (torfaen, 2002) 	%calcperc (monmouthshire, 2002) 	%calcperc (newport, 2002) 	%calcperc (powys, 2002) 	%calcperc (merthyrtydfil, 2002) 	%calcperc (northeast, 2002) 	%calcperc (northwest, 2002) 	%calcperc (yorkshireandhumber, 2002) 	%calcperc (eastmidlands, 2002) 	%calcperc (westmidlandsregion, 2002) 	%calcperc (east, 2002) 	%calcperc (london, 2002) 	%calcperc (southeast, 2002) 	%calcperc (southwest, 2002) 	%calcperc (england, 2002) 	
%calcperc (northernireland, 2002) 	%calcperc (scotland, 2002) 	%calcperc (wales, 2002) 	%calcperc (englandandwales, 2002) 	%calcperc (greatbritian, 2002) 	%calcperc (unitedkingdom, 2002); 
%calcperc (hartlepool, 2003) 	%calcperc (middlesbrough, 2003) 	%calcperc (redcarandcleveland, 2003) 	%calcperc (stocktonontees, 2003) 	%calcperc (darlington, 2003) 	%calcperc (halton, 2003) 	%calcperc (warrington, 2003) 	%calcperc (blackburnwithdarwen, 2003) 	%calcperc (blackpool, 2003) 	%calcperc (kingstonuponhullcityof, 2003) 	%calcperc (eastridingofyorkshire, 2003) 	%calcperc (northeastlincolnshire, 2003) 	%calcperc (northlincolnshire, 2003) 	%calcperc (york, 2003) 	%calcperc (derby, 2003) 	%calcperc (leicester, 2003) 	%calcperc (rutland, 2003) 	%calcperc (nottingham, 2003) 	%calcperc (herefordshirecountyof, 2003) 	%calcperc (telfordandwrekin, 2003) 	%calcperc (stokeontrent, 2003) 	%calcperc (bathandnortheastsomerset, 2003) 	%calcperc (bristolcityof, 2003) 	%calcperc (northsomerset, 2003) 	%calcperc (southgloucestershire, 2003) 	%calcperc (plymouth, 2003) 	%calcperc (torbay, 2003) 	%calcperc (bournemouth, 2003) 	%calcperc (poole, 2003) 	%calcperc (swindon, 2003) 	%calcperc (peterborough, 2003) 	%calcperc (luton, 2003) 	%calcperc (southendonsea, 2003) 	%calcperc (thurrock, 2003) 	%calcperc (medway, 2003) 	%calcperc (bracknellforest, 2003) 	%calcperc (westberkshire, 2003) 	%calcperc (reading, 2003) 	%calcperc (slough, 2003) 	%calcperc (windsorandmaidenhead, 2003) 	%calcperc (wokingham, 2003) 	%calcperc (miltonkeynes, 2003) 	%calcperc (brightonandhove, 2003) 	%calcperc (portsmouth, 2003) 	%calcperc (southampton, 2003) 	%calcperc (isleofwight, 2003) 	%calcperc (countydurham, 2003) 	%calcperc (cheshireeast, 2003) 	%calcperc (cheshirewestandchester, 2003) 	%calcperc (shropshire, 2003) 	%calcperc (cornwall, 2003) 	%calcperc (islesofscilly, 2003) 	%calcperc (wiltshire, 2003) 	%calcperc (bedford, 2003) 	%calcperc (centralbedfordshire, 2003) 	%calcperc (northumberland, 2003) 	%calcperc (aylesburyvale, 2003) 	%calcperc (chiltern, 2003) 	%calcperc (southbucks, 2003) 	%calcperc (wycombe, 2003) 	%calcperc (cambridge, 2003) 	%calcperc (eastcambridgeshire, 2003) 	%calcperc (fenland, 2003) 	%calcperc (huntingdonshire, 2003) 	%calcperc (southcambridgeshire, 2003) 	%calcperc (allerdale, 2003) 	%calcperc (barrowinfurness, 2003) 	%calcperc (carlisle, 2003) 	%calcperc (copeland, 2003) 	%calcperc (eden, 2003) 	%calcperc (southlakeland, 2003) 	%calcperc (ambervalley, 2003) 	%calcperc (bolsover, 2003) 	%calcperc (chesterfield, 2003) 	%calcperc (derbyshiredales, 2003) 	%calcperc (erewash, 2003) 	%calcperc (highpeak, 2003) 	%calcperc (northeastderbyshire, 2003) 	%calcperc (southderbyshire, 2003) 	%calcperc (eastdevon, 2003) 	%calcperc (exeter, 2003) 	%calcperc (middevon, 2003) 	%calcperc (northdevon, 2003) 	%calcperc (southhams, 2003) 	%calcperc (teignbridge, 2003) 	%calcperc (torridge, 2003) 	%calcperc (westdevon, 2003) 	%calcperc (christchurch, 2003) 	%calcperc (eastdorset, 2003) 	%calcperc (northdorset, 2003) 	%calcperc (purbeck, 2003) 	%calcperc (westdorset, 2003) 	%calcperc (weymouthandportland, 2003) 	%calcperc (eastbourne, 2003) 	%calcperc (hastings, 2003) 	%calcperc (lewes, 2003) 	%calcperc (rother, 2003) 	%calcperc (wealden, 2003) 	%calcperc (basildon, 2003) 	%calcperc (braintree, 2003) 	%calcperc (brentwood, 2003) 	%calcperc (castlepoint, 2003) 	%calcperc (chelmsford, 2003) 	%calcperc (colchester, 2003) 	
%calcperc (eppingforest, 2003) 	%calcperc (harlow, 2003) 	%calcperc (maldon, 2003) 	%calcperc (rochford, 2003) 	%calcperc (tendring, 2003) 	%calcperc (uttlesford, 2003) 	%calcperc (cheltenham, 2003) 	%calcperc (cotswold, 2003) 	%calcperc (forestofdean, 2003) 	%calcperc (gloucester, 2003) 	%calcperc (stroud, 2003) 	%calcperc (tewkesbury, 2003) 	%calcperc (basingstokeanddeane, 2003) 	%calcperc (easthampshire, 2003) 	%calcperc (eastleigh, 2003) 	%calcperc (fareham, 2003) 	%calcperc (gosport, 2003) 	%calcperc (hart, 2003) 	%calcperc (havant, 2003) 	%calcperc (newforest, 2003) 	%calcperc (rushmoor, 2003) 	%calcperc (testvalley, 2003) 	%calcperc (winchester, 2003) 	%calcperc (broxbourne, 2003) 	%calcperc (dacorum, 2003) 	%calcperc (hertsmere, 2003) 	%calcperc (northhertfordshire, 2003) 	%calcperc (threerivers, 2003) 	%calcperc (watford, 2003) 	%calcperc (ashford, 2003) 	%calcperc (canterbury, 2003) 	%calcperc (dartford, 2003) 	%calcperc (dover, 2003) 	%calcperc (gravesham, 2003) 	%calcperc (maidstone, 2003) 	%calcperc (sevenoaks, 2003) 	%calcperc (shepway, 2003) 	%calcperc (swale, 2003) 	%calcperc (thanet, 2003) 	%calcperc (tonbridgeandmalling, 2003) 	%calcperc (tunbridgewells, 2003) 	%calcperc (burnley, 2003) 	%calcperc (chorley, 2003) 	%calcperc (fylde, 2003) 	%calcperc (hyndburn, 2003) 	%calcperc (lancaster, 2003) 	%calcperc (pendle, 2003) 	%calcperc (preston, 2003) 	%calcperc (ribblevalley, 2003) 	%calcperc (rossendale, 2003) 	%calcperc (southribble, 2003) 	%calcperc (westlancashire, 2003) 	%calcperc (wyre, 2003) 	%calcperc (blaby, 2003) 	%calcperc (charnwood, 2003) 	%calcperc (harborough, 2003) 	%calcperc (hinckleyandbosworth, 2003) 	%calcperc (melton, 2003) 	%calcperc (northwestleicestershire, 2003) 	%calcperc (oadbyandwigston, 2003) 	%calcperc (boston, 2003) 	%calcperc (eastlindsey, 2003) 	%calcperc (lincoln, 2003) 	%calcperc (northkesteven, 2003) 	%calcperc (southholland, 2003) 	%calcperc (southkesteven, 2003) 	%calcperc (westlindsey, 2003) 	%calcperc (breckland, 2003) 	%calcperc (broadland, 2003) 	%calcperc (greatyarmouth, 2003) 	%calcperc (kingslynnandwestnorfolk, 2003) 	%calcperc (northnorfolk, 2003) 	%calcperc (norwich, 2003) 	%calcperc (southnorfolk, 2003) 	%calcperc (corby, 2003) 	%calcperc (daventry, 2003) 	%calcperc (eastnorthamptonshire, 2003) 	%calcperc (kettering, 2003) 	%calcperc (northampton, 2003) 	%calcperc (southnorthamptonshire, 2003) 	%calcperc (wellingborough, 2003) 	%calcperc (craven, 2003) 	%calcperc (hambleton, 2003) 	%calcperc (harrogate, 2003) 	%calcperc (richmondshire, 2003) 	%calcperc (ryedale, 2003) 	%calcperc (scarborough, 2003) 	%calcperc (selby, 2003) 	%calcperc (ashfield, 2003) 	%calcperc (bassetlaw, 2003) 	%calcperc (broxtowe, 2003) 	%calcperc (gedling, 2003) 	%calcperc (mansfield, 2003) 	%calcperc (newarkandsherwood, 2003) 	%calcperc (rushcliffe, 2003) 	%calcperc (cherwell, 2003) 	%calcperc (oxford, 2003) 	%calcperc (southoxfordshire, 2003) 	%calcperc (valeofwhitehorse, 2003) 	%calcperc (westoxfordshire, 2003) 	%calcperc (mendip, 2003) 	%calcperc (sedgemoor, 2003) 	%calcperc (southsomerset, 2003) 	%calcperc (tauntondeane, 2003) 	%calcperc (westsomerset, 2003) 	%calcperc (cannockchase, 2003) 	%calcperc (eaststaffordshire, 2003) 	
%calcperc (lichfield, 2003) 	%calcperc (newcastleunderlyme, 2003) 	%calcperc (southstaffordshire, 2003) 	%calcperc (stafford, 2003) 	%calcperc (staffordshiremoorlands, 2003) 	%calcperc (tamworth, 2003) 	%calcperc (babergh, 2003) 	%calcperc (forestheath, 2003) 	%calcperc (ipswich, 2003) 	%calcperc (midsuffolk, 2003) 	%calcperc (stedmundsbury, 2003) 	%calcperc (suffolkcoastal, 2003) 	
%calcperc (waveney, 2003) 	%calcperc (elmbridge, 2003) %calcperc (epsomandewell, 2003) 	%calcperc (guildford, 2003) 	%calcperc (molevalley, 2003) 	%calcperc (reigateandbanstead, 2003) 	%calcperc (runnymede, 2003) 	%calcperc (spelthorne, 2003) 	%calcperc (surreyheath, 2003) 	%calcperc (tandridge, 2003) 	%calcperc (waverley, 2003) 	%calcperc (woking, 2003) 	%calcperc (northwarwickshire, 2003) 	%calcperc (nuneatonandbedworth, 2003) 	%calcperc (rugby, 2003) 	%calcperc (stratfordonavon, 2003) 	%calcperc (warwick, 2003) 	%calcperc (adur, 2003) 	%calcperc (arun, 2003) 	%calcperc (chichester, 2003) 	%calcperc (crawley, 2003) 	%calcperc (horsham, 2003) 	%calcperc (midsussex, 2003) 	%calcperc (worthing, 2003) 	%calcperc (bromsgrove, 2003) 	%calcperc (malvernhills, 2003) 	%calcperc (redditch, 2003) 	%calcperc (worcester, 2003) 	%calcperc (wychavon, 2003) 	%calcperc (wyreforest, 2003) 	%calcperc (stalbans, 2003) 	%calcperc (welwynhatfield, 2003) 	%calcperc (easthertfordshire, 2003) 	%calcperc (stevenage, 2003) 	%calcperc (bolton, 2003) 	%calcperc (bury, 2003) 	%calcperc (manchester, 2003) 	%calcperc (oldham, 2003) 	%calcperc (rochdale, 2003) 	%calcperc (salford, 2003) 	%calcperc (stockport, 2003) 	%calcperc (tameside, 2003) 	%calcperc (trafford, 2003) 	%calcperc (wigan, 2003) 	%calcperc (knowsley, 2003) 	%calcperc (liverpool, 2003) 	%calcperc (sthelens, 2003) 	%calcperc (sefton, 2003) 	%calcperc (wirral, 2003) 	%calcperc (barnsley, 2003) 	%calcperc (doncaster, 2003) 	%calcperc (rotherham, 2003) 	%calcperc (sheffield, 2003) 	%calcperc (newcastleupontyne, 2003) 	%calcperc (northtyneside, 2003) 	%calcperc (southtyneside, 2003) 	%calcperc (sunderland, 2003) 	%calcperc (birmingham, 2003) 	%calcperc (coventry, 2003) 	%calcperc (dudley, 2003) 	%calcperc (sandwell, 2003) 	%calcperc (solihull, 2003) 	%calcperc (walsall, 2003) 	%calcperc (wolverhampton, 2003) 	%calcperc (bradford, 2003) 	%calcperc (calderdale, 2003) 	%calcperc (kirklees, 2003) 	%calcperc (leeds, 2003) 	%calcperc (wakefield, 2003) 	%calcperc (gateshead, 2003) 	%calcperc (cityoflondon, 2003) 	%calcperc (barkinganddagenham, 2003) 	%calcperc (barnet, 2003) 	%calcperc (bexley, 2003) 	%calcperc (brent, 2003) 	%calcperc (bromley, 2003) 	%calcperc (camden, 2003) 	%calcperc (croydon, 2003) 	%calcperc (ealing, 2003) 	%calcperc (enfield, 2003) 	%calcperc (greenwich, 2003) 	%calcperc (hackney, 2003) 	%calcperc (hammersmithandfulham, 2003) 	%calcperc (haringey, 2003) 	%calcperc (harrow, 2003) 	%calcperc (havering, 2003) 	%calcperc (hillingdon, 2003) 	%calcperc (hounslow, 2003) 	%calcperc (islington, 2003) 	%calcperc (kensingtonandchelsea, 2003) 	%calcperc (kingstonuponthames, 2003) 	%calcperc (lambeth, 2003) 	%calcperc (lewisham, 2003) 	%calcperc (merton, 2003) 	%calcperc (newham, 2003) 	%calcperc (redbridge, 2003) 	%calcperc (richmonduponthames, 2003) 	%calcperc (southwark, 2003) 	%calcperc (sutton, 2003) 	%calcperc (towerhamlets, 2003) 	%calcperc (walthamforest, 2003) 	%calcperc (wandsworth, 2003) 	%calcperc (westminster, 2003) 	%calcperc (buckinghamshire, 2003) 	%calcperc (cambridgeshire, 2003) 	%calcperc (cumbria, 2003) 	%calcperc (derbyshire, 2003) 	%calcperc (devon, 2003) 	%calcperc (dorset, 2003) 	%calcperc (eastsussex, 2003) 	
%calcperc (essex, 2003) 	%calcperc (gloucestershire, 2003) 	%calcperc (hampshire, 2003) 	%calcperc (hertfordshire, 2003) 	%calcperc (kent, 2003) 	%calcperc (lancashire, 2003) 	%calcperc (leicestershire, 2003) 	%calcperc (lincolnshire, 2003) 	%calcperc (norfolk, 2003) 	%calcperc (northamptonshire, 2003) 	%calcperc (northyorkshire, 2003) 	%calcperc (nottinghamshire, 2003) 	%calcperc (oxfordshire, 2003) 	%calcperc (somerset, 2003) 	%calcperc (staffordshire, 2003) 	%calcperc (suffolk, 2003) 	%calcperc (surrey, 2003) 	%calcperc (warwickshire, 2003) 	%calcperc (westsussex, 2003) 	%calcperc (worcestershire, 2003) 	%calcperc (greatermanchester, 2003) 	%calcperc (merseyside, 2003) 	%calcperc (southyorkshire, 2003) 	%calcperc (westmidlands, 2003) 	%calcperc (westyorkshire, 2003) 	%calcperc (tyneandwear, 2003) 	%calcperc (antrimandnewtownabbey, 2003) 	%calcperc (armaghcitybanbridgeandcraigavon, 2003) 	%calcperc (belfast, 2003) 	%calcperc (causewaycoastandglens, 2003) 	%calcperc (derrycityandstrabane, 2003) 	%calcperc (fermanaghandomagh, 2003) 	%calcperc (lisburnandcastlereagh, 2003) 	%calcperc (midandeastantrim, 2003) 	%calcperc (midulster, 2003) 	%calcperc (newrymourneanddown, 2003) 	%calcperc (ardsandnorthdown, 2003) 	%calcperc (clackmannanshire, 2003) 	%calcperc (dumfriesandgalloway, 2003) 	%calcperc (eastayrshire, 2003) 	%calcperc (eastlothian, 2003) 	%calcperc (eastrenfrewshire, 2003) 	%calcperc (naheileanansiar, 2003) 	%calcperc (falkirk, 2003) 	%calcperc (fife, 2003) 	%calcperc (highland, 2003) 	%calcperc (inverclyde, 2003) 	%calcperc (midlothian, 2003) 	%calcperc (moray, 2003) 	%calcperc (northayrshire, 2003) 	%calcperc (orkneyislands, 2003) 	%calcperc (perthandkinross, 2003) 	%calcperc (scottishborders, 2003) 	%calcperc (shetlandislands, 2003) 	%calcperc (southayrshire, 2003) 	%calcperc (southlanarkshire, 2003) 	%calcperc (stirling, 2003) 	%calcperc (aberdeencity, 2003) 	%calcperc (aberdeenshire, 2003) 	%calcperc (argyllandbute, 2003) 	%calcperc (cityofedinburgh, 2003) 	%calcperc (renfrewshire, 2003) 	%calcperc (westdunbartonshire, 2003) 	%calcperc (westlothian, 2003) 	%calcperc (angus, 2003) 	%calcperc (dundeecity, 2003) 	%calcperc (northlanarkshire, 2003) 	%calcperc (eastdunbartonshire, 2003) 	%calcperc (glasgowcity, 2003) 	%calcperc (isleofanglesey, 2003) 	%calcperc (gwynedd, 2003) 	%calcperc (conwy, 2003) 	%calcperc (denbighshire, 2003) 	%calcperc (flintshire, 2003) 	%calcperc (wrexham, 2003) 	%calcperc (ceredigion, 2003) 	%calcperc (pembrokeshire, 2003) 	%calcperc (carmarthenshire, 2003) 	%calcperc (swansea, 2003) 	%calcperc (neathporttalbot, 2003) 	%calcperc (bridgend, 2003) 	%calcperc (valeofglamorgan, 2003) 	%calcperc (cardiff, 2003) 	%calcperc (rhonddacynontaf, 2003) 	%calcperc (caerphilly, 2003) 	%calcperc (blaenaugwent, 2003) 	%calcperc (torfaen, 2003) 	%calcperc (monmouthshire, 2003) 	%calcperc (newport, 2003) 	%calcperc (powys, 2003) 	%calcperc (merthyrtydfil, 2003) 	%calcperc (northeast, 2003) 	%calcperc (northwest, 2003) 	%calcperc (yorkshireandhumber, 2003) 	%calcperc (eastmidlands, 2003) 	%calcperc (westmidlandsregion, 2003) 	%calcperc (east, 2003) 	%calcperc (london, 2003) 	%calcperc (southeast, 2003) 	%calcperc (southwest, 2003) 	%calcperc (england, 2003) 	
%calcperc (northernireland, 2003) 	%calcperc (scotland, 2003) 	%calcperc (wales, 2003) 	%calcperc (englandandwales, 2003) 	%calcperc (greatbritian, 2003) 	%calcperc (unitedkingdom, 2003); 
%calcperc (hartlepool, 2004) 	%calcperc (middlesbrough, 2004) 	%calcperc (redcarandcleveland, 2004) 	%calcperc (stocktonontees, 2004) 	%calcperc (darlington, 2004) 	%calcperc (halton, 2004) 	%calcperc (warrington, 2004) 	%calcperc (blackburnwithdarwen, 2004) 	%calcperc (blackpool, 2004) 	%calcperc (kingstonuponhullcityof, 2004) 	%calcperc (eastridingofyorkshire, 2004) 	%calcperc (northeastlincolnshire, 2004) 	%calcperc (northlincolnshire, 2004) 	%calcperc (york, 2004) 	%calcperc (derby, 2004) 	%calcperc (leicester, 2004) 	%calcperc (rutland, 2004) 	%calcperc (nottingham, 2004) 	%calcperc (herefordshirecountyof, 2004) 	%calcperc (telfordandwrekin, 2004) 	%calcperc (stokeontrent, 2004) 	%calcperc (bathandnortheastsomerset, 2004) 	%calcperc (bristolcityof, 2004) 	%calcperc (northsomerset, 2004) 	%calcperc (southgloucestershire, 2004) 	%calcperc (plymouth, 2004) 	%calcperc (torbay, 2004) 	%calcperc (bournemouth, 2004) 	%calcperc (poole, 2004) 	%calcperc (swindon, 2004) 	%calcperc (peterborough, 2004) 	%calcperc (luton, 2004) 	%calcperc (southendonsea, 2004) 	%calcperc (thurrock, 2004) 	%calcperc (medway, 2004) 	%calcperc (bracknellforest, 2004) 	%calcperc (westberkshire, 2004) 	%calcperc (reading, 2004) 	%calcperc (slough, 2004) 	%calcperc (windsorandmaidenhead, 2004) 	%calcperc (wokingham, 2004) 	%calcperc (miltonkeynes, 2004) 	%calcperc (brightonandhove, 2004) 	%calcperc (portsmouth, 2004) 	%calcperc (southampton, 2004) 	%calcperc (isleofwight, 2004) 	%calcperc (countydurham, 2004) 	%calcperc (cheshireeast, 2004) 	%calcperc (cheshirewestandchester, 2004) 	%calcperc (shropshire, 2004) 	%calcperc (cornwall, 2004) 	%calcperc (islesofscilly, 2004) 	%calcperc (wiltshire, 2004) 	%calcperc (bedford, 2004) 	%calcperc (centralbedfordshire, 2004) 	%calcperc (northumberland, 2004) 	%calcperc (aylesburyvale, 2004) 	%calcperc (chiltern, 2004) 	%calcperc (southbucks, 2004) 	%calcperc (wycombe, 2004) 	%calcperc (cambridge, 2004) 	%calcperc (eastcambridgeshire, 2004) 	%calcperc (fenland, 2004) 	%calcperc (huntingdonshire, 2004) 	%calcperc (southcambridgeshire, 2004) 	%calcperc (allerdale, 2004) 	%calcperc (barrowinfurness, 2004) 	%calcperc (carlisle, 2004) 	%calcperc (copeland, 2004) 	%calcperc (eden, 2004) 	%calcperc (southlakeland, 2004) 	%calcperc (ambervalley, 2004) 	%calcperc (bolsover, 2004) 	%calcperc (chesterfield, 2004) 	%calcperc (derbyshiredales, 2004) 	%calcperc (erewash, 2004) 	%calcperc (highpeak, 2004) 	%calcperc (northeastderbyshire, 2004) 	%calcperc (southderbyshire, 2004) 	%calcperc (eastdevon, 2004) 	%calcperc (exeter, 2004) 	%calcperc (middevon, 2004) 	%calcperc (northdevon, 2004) 	%calcperc (southhams, 2004) 	%calcperc (teignbridge, 2004) 	%calcperc (torridge, 2004) 	%calcperc (westdevon, 2004) 	%calcperc (christchurch, 2004) 	%calcperc (eastdorset, 2004) 	%calcperc (northdorset, 2004) 	%calcperc (purbeck, 2004) 	%calcperc (westdorset, 2004) 	%calcperc (weymouthandportland, 2004) 	%calcperc (eastbourne, 2004) 	%calcperc (hastings, 2004) 	%calcperc (lewes, 2004) 	%calcperc (rother, 2004) 	%calcperc (wealden, 2004) 	%calcperc (basildon, 2004) 	%calcperc (braintree, 2004) 	%calcperc (brentwood, 2004) 	%calcperc (castlepoint, 2004) 	%calcperc (chelmsford, 2004) 	
%calcperc (colchester, 2004) 	%calcperc (eppingforest, 2004) 	%calcperc (harlow, 2004) 	%calcperc (maldon, 2004) 	%calcperc (rochford, 2004) 	%calcperc (tendring, 2004) 	%calcperc (uttlesford, 2004) 	%calcperc (cheltenham, 2004) 	%calcperc (cotswold, 2004) 	%calcperc (forestofdean, 2004) 	%calcperc (gloucester, 2004) 	%calcperc (stroud, 2004) 	%calcperc (tewkesbury, 2004) 	%calcperc (basingstokeanddeane, 2004) 	%calcperc (easthampshire, 2004) 	%calcperc (eastleigh, 2004) 	%calcperc (fareham, 2004) 	%calcperc (gosport, 2004) 	%calcperc (hart, 2004) 	%calcperc (havant, 2004) 	%calcperc (newforest, 2004) 	%calcperc (rushmoor, 2004) 	%calcperc (testvalley, 2004) 	%calcperc (winchester, 2004) 	%calcperc (broxbourne, 2004) 	%calcperc (dacorum, 2004) 	%calcperc (hertsmere, 2004) 	%calcperc (northhertfordshire, 2004) 	%calcperc (threerivers, 2004) 	%calcperc (watford, 2004) 	%calcperc (ashford, 2004) 	%calcperc (canterbury, 2004) 	%calcperc (dartford, 2004) 	%calcperc (dover, 2004) 	%calcperc (gravesham, 2004) 	%calcperc (maidstone, 2004) 	%calcperc (sevenoaks, 2004) 	%calcperc (shepway, 2004) 	%calcperc (swale, 2004) 	%calcperc (thanet, 2004) 	%calcperc (tonbridgeandmalling, 2004) 	%calcperc (tunbridgewells, 2004) 	%calcperc (burnley, 2004) 	%calcperc (chorley, 2004) 	%calcperc (fylde, 2004) 	%calcperc (hyndburn, 2004) 	%calcperc (lancaster, 2004) 	%calcperc (pendle, 2004) 	%calcperc (preston, 2004) 	%calcperc (ribblevalley, 2004) 	%calcperc (rossendale, 2004) 	%calcperc (southribble, 2004) 	%calcperc (westlancashire, 2004) 	%calcperc (wyre, 2004) 	%calcperc (blaby, 2004) 	%calcperc (charnwood, 2004) 	%calcperc (harborough, 2004) 	%calcperc (hinckleyandbosworth, 2004) 	%calcperc (melton, 2004) 	%calcperc (northwestleicestershire, 2004) 	%calcperc (oadbyandwigston, 2004) 	%calcperc (boston, 2004) 	%calcperc (eastlindsey, 2004) 	%calcperc (lincoln, 2004) 	%calcperc (northkesteven, 2004) 	%calcperc (southholland, 2004) 	%calcperc (southkesteven, 2004) 	%calcperc (westlindsey, 2004) 	%calcperc (breckland, 2004) 	%calcperc (broadland, 2004) 	%calcperc (greatyarmouth, 2004) 	%calcperc (kingslynnandwestnorfolk, 2004) 	%calcperc (northnorfolk, 2004) 	%calcperc (norwich, 2004) 	%calcperc (southnorfolk, 2004) 	%calcperc (corby, 2004) 	%calcperc (daventry, 2004) 	%calcperc (eastnorthamptonshire, 2004) 	%calcperc (kettering, 2004) 	%calcperc (northampton, 2004) 	%calcperc (southnorthamptonshire, 2004) 	%calcperc (wellingborough, 2004) 	%calcperc (craven, 2004) 	%calcperc (hambleton, 2004) 	%calcperc (harrogate, 2004) 	%calcperc (richmondshire, 2004) 	%calcperc (ryedale, 2004) 	%calcperc (scarborough, 2004) 	%calcperc (selby, 2004) 	%calcperc (ashfield, 2004) 	%calcperc (bassetlaw, 2004) 	%calcperc (broxtowe, 2004) 	%calcperc (gedling, 2004) 	%calcperc (mansfield, 2004) 	%calcperc (newarkandsherwood, 2004) 	%calcperc (rushcliffe, 2004) 	%calcperc (cherwell, 2004) 	%calcperc (oxford, 2004) 	%calcperc (southoxfordshire, 2004) 	%calcperc (valeofwhitehorse, 2004) 	%calcperc (westoxfordshire, 2004) 	%calcperc (mendip, 2004) 	%calcperc (sedgemoor, 2004) 	%calcperc (southsomerset, 2004) 	%calcperc (tauntondeane, 2004) 	%calcperc (westsomerset, 2004) 	
%calcperc (cannockchase, 2004) 	%calcperc (eaststaffordshire, 2004) 	%calcperc (lichfield, 2004) 	%calcperc (newcastleunderlyme, 2004) 	%calcperc (southstaffordshire, 2004) 	%calcperc (stafford, 2004) 	%calcperc (staffordshiremoorlands, 2004) 	%calcperc (tamworth, 2004) 	%calcperc (babergh, 2004) 	%calcperc (forestheath, 2004) 	%calcperc (ipswich, 2004) 	%calcperc (midsuffolk, 2004) 	%calcperc (stedmundsbury, 2004) 	%calcperc (suffolkcoastal, 2004) 	
%calcperc (waveney, 2004) 	%calcperc (elmbridge, 2004) 	%calcperc (epsomandewell, 2004) 	%calcperc (guildford, 2004) 	%calcperc (molevalley, 2004) 	%calcperc (reigateandbanstead, 2004) 	%calcperc (runnymede, 2004) 	%calcperc (spelthorne, 2004) 	%calcperc (surreyheath, 2004) 	%calcperc (tandridge, 2004) 	%calcperc (waverley, 2004) 	%calcperc (woking, 2004) 	%calcperc (northwarwickshire, 2004) 	%calcperc (nuneatonandbedworth, 2004) 	%calcperc (rugby, 2004) 	%calcperc (stratfordonavon, 2004) 	%calcperc (warwick, 2004) 	%calcperc (adur, 2004) 	%calcperc (arun, 2004) 	%calcperc (chichester, 2004) 	%calcperc (crawley, 2004) 	%calcperc (horsham, 2004) 	%calcperc (midsussex, 2004) 	%calcperc (worthing, 2004) 	%calcperc (bromsgrove, 2004) 	%calcperc (malvernhills, 2004) 	%calcperc (redditch, 2004) 	%calcperc (worcester, 2004) 	%calcperc (wychavon, 2004) 	%calcperc (wyreforest, 2004) 	%calcperc (stalbans, 2004) 	%calcperc (welwynhatfield, 2004) 	%calcperc (easthertfordshire, 2004) 	%calcperc (stevenage, 2004) 	%calcperc (bolton, 2004) 	%calcperc (bury, 2004) 	%calcperc (manchester, 2004) 	%calcperc (oldham, 2004) 	%calcperc (rochdale, 2004) 	%calcperc (salford, 2004) 	%calcperc (stockport, 2004) 	%calcperc (tameside, 2004) 	%calcperc (trafford, 2004) 	%calcperc (wigan, 2004) 	%calcperc (knowsley, 2004) 	%calcperc (liverpool, 2004) 	%calcperc (sthelens, 2004) 	%calcperc (sefton, 2004) 	%calcperc (wirral, 2004) 	%calcperc (barnsley, 2004) 	%calcperc (doncaster, 2004) 	%calcperc (rotherham, 2004) 	%calcperc (sheffield, 2004) 	%calcperc (newcastleupontyne, 2004) 	%calcperc (northtyneside, 2004) 	%calcperc (southtyneside, 2004) 	%calcperc (sunderland, 2004) 	%calcperc (birmingham, 2004) 	%calcperc (coventry, 2004) 	%calcperc (dudley, 2004) 	%calcperc (sandwell, 2004) 	%calcperc (solihull, 2004) 	%calcperc (walsall, 2004) 	%calcperc (wolverhampton, 2004) 	%calcperc (bradford, 2004) 	%calcperc (calderdale, 2004) 	%calcperc (kirklees, 2004) 	%calcperc (leeds, 2004) 	%calcperc (wakefield, 2004) 	%calcperc (gateshead, 2004) 	%calcperc (cityoflondon, 2004) 	%calcperc (barkinganddagenham, 2004) 	%calcperc (barnet, 2004) 	%calcperc (bexley, 2004) 	%calcperc (brent, 2004) 	%calcperc (bromley, 2004) 	%calcperc (camden, 2004) 	%calcperc (croydon, 2004) 	%calcperc (ealing, 2004) 	%calcperc (enfield, 2004) 	%calcperc (greenwich, 2004) 	%calcperc (hackney, 2004) 	%calcperc (hammersmithandfulham, 2004) 	%calcperc (haringey, 2004) 	%calcperc (harrow, 2004) 	%calcperc (havering, 2004) 	%calcperc (hillingdon, 2004) 	%calcperc (hounslow, 2004) 	%calcperc (islington, 2004) 	%calcperc (kensingtonandchelsea, 2004) 	%calcperc (kingstonuponthames, 2004) 	%calcperc (lambeth, 2004) 	%calcperc (lewisham, 2004) 	%calcperc (merton, 2004) 	%calcperc (newham, 2004) 	%calcperc (redbridge, 2004) 	%calcperc (richmonduponthames, 2004) 	%calcperc (southwark, 2004) 	%calcperc (sutton, 2004) 	%calcperc (towerhamlets, 2004) 	%calcperc (walthamforest, 2004) 	%calcperc (wandsworth, 2004) 	%calcperc (westminster, 2004) 	%calcperc (buckinghamshire, 2004) 	%calcperc (cambridgeshire, 2004) 	%calcperc (cumbria, 2004) 	%calcperc (derbyshire, 2004) 	%calcperc (devon, 2004) 	
%calcperc (dorset, 2004) 	%calcperc (eastsussex, 2004) 	%calcperc (essex, 2004) 	%calcperc (gloucestershire, 2004) 	%calcperc (hampshire, 2004) 	%calcperc (hertfordshire, 2004) 	%calcperc (kent, 2004) 	%calcperc (lancashire, 2004) 	%calcperc (leicestershire, 2004) 	%calcperc (lincolnshire, 2004) 	%calcperc (norfolk, 2004) 	%calcperc (northamptonshire, 2004) 	%calcperc (northyorkshire, 2004) 	%calcperc (nottinghamshire, 2004) 	%calcperc (oxfordshire, 2004) 	%calcperc (somerset, 2004) 	%calcperc (staffordshire, 2004) 	%calcperc (suffolk, 2004) 	%calcperc (surrey, 2004) 	%calcperc (warwickshire, 2004) 	%calcperc (westsussex, 2004) 	%calcperc (worcestershire, 2004) 	%calcperc (greatermanchester, 2004) 	%calcperc (merseyside, 2004) 	%calcperc (southyorkshire, 2004) 	%calcperc (westmidlands, 2004) 	%calcperc (westyorkshire, 2004) 	%calcperc (tyneandwear, 2004) 	%calcperc (antrimandnewtownabbey, 2004) 	%calcperc (armaghcitybanbridgeandcraigavon, 2004) 	%calcperc (belfast, 2004) 	%calcperc (causewaycoastandglens, 2004) 	%calcperc (derrycityandstrabane, 2004) 	%calcperc (fermanaghandomagh, 2004) 	%calcperc (lisburnandcastlereagh, 2004) 	%calcperc (midandeastantrim, 2004) 	%calcperc (midulster, 2004) 	%calcperc (newrymourneanddown, 2004) 	%calcperc (ardsandnorthdown, 2004) 	%calcperc (clackmannanshire, 2004) 	%calcperc (dumfriesandgalloway, 2004) 	%calcperc (eastayrshire, 2004) 	%calcperc (eastlothian, 2004) 	%calcperc (eastrenfrewshire, 2004) 	%calcperc (naheileanansiar, 2004) 	%calcperc (falkirk, 2004) 	%calcperc (fife, 2004) 	%calcperc (highland, 2004) 	%calcperc (inverclyde, 2004) 	%calcperc (midlothian, 2004) 	%calcperc (moray, 2004) 	%calcperc (northayrshire, 2004) 	%calcperc (orkneyislands, 2004) 	%calcperc (perthandkinross, 2004) 	%calcperc (scottishborders, 2004) 	%calcperc (shetlandislands, 2004) 	%calcperc (southayrshire, 2004) 	%calcperc (southlanarkshire, 2004) 	%calcperc (stirling, 2004) 	%calcperc (aberdeencity, 2004) 	%calcperc (aberdeenshire, 2004) 	%calcperc (argyllandbute, 2004) 	%calcperc (cityofedinburgh, 2004) 	%calcperc (renfrewshire, 2004) 	%calcperc (westdunbartonshire, 2004) 	%calcperc (westlothian, 2004) 	%calcperc (angus, 2004) 	%calcperc (dundeecity, 2004) 	%calcperc (northlanarkshire, 2004) 	%calcperc (eastdunbartonshire, 2004) 	%calcperc (glasgowcity, 2004) 	%calcperc (isleofanglesey, 2004) 	%calcperc (gwynedd, 2004) 	%calcperc (conwy, 2004) 	%calcperc (denbighshire, 2004) 	%calcperc (flintshire, 2004) 	%calcperc (wrexham, 2004) 	%calcperc (ceredigion, 2004) 	%calcperc (pembrokeshire, 2004) 	%calcperc (carmarthenshire, 2004) 	%calcperc (swansea, 2004) 	%calcperc (neathporttalbot, 2004) 	%calcperc (bridgend, 2004) 	%calcperc (valeofglamorgan, 2004) 	%calcperc (cardiff, 2004) 	%calcperc (rhonddacynontaf, 2004) 	%calcperc (caerphilly, 2004) 	%calcperc (blaenaugwent, 2004) 	%calcperc (torfaen, 2004) 	%calcperc (monmouthshire, 2004) 	%calcperc (newport, 2004) 	%calcperc (powys, 2004) 	%calcperc (merthyrtydfil, 2004) 	%calcperc (northeast, 2004) 	%calcperc (northwest, 2004) 	%calcperc (yorkshireandhumber, 2004) 	%calcperc (eastmidlands, 2004) 	%calcperc (westmidlandsregion, 2004) 	%calcperc (east, 2004) 	%calcperc (london, 2004) 	%calcperc (southeast, 2004) 	
%calcperc (southwest, 2004) 	%calcperc (england, 2004) 	%calcperc (northernireland, 2004) 	%calcperc (scotland, 2004) 	%calcperc (wales, 2004) 	%calcperc (englandandwales, 2004) 	%calcperc (greatbritian, 2004) 	%calcperc (unitedkingdom, 2004); 
%calcperc (hartlepool, 2005) 	%calcperc (middlesbrough, 2005) 	%calcperc (redcarandcleveland, 2005) 	%calcperc (stocktonontees, 2005) 	%calcperc (darlington, 2005) 	%calcperc (halton, 2005) 	%calcperc (warrington, 2005) 	%calcperc (blackburnwithdarwen, 2005) 	%calcperc (blackpool, 2005) 	%calcperc (kingstonuponhullcityof, 2005) 	%calcperc (eastridingofyorkshire, 2005) 	%calcperc (northeastlincolnshire, 2005) 	%calcperc (northlincolnshire, 2005) 	%calcperc (york, 2005) 	%calcperc (derby, 2005) 	%calcperc (leicester, 2005) 	%calcperc (rutland, 2005) 	%calcperc (nottingham, 2005) 	%calcperc (herefordshirecountyof, 2005) 	%calcperc (telfordandwrekin, 2005) 	%calcperc (stokeontrent, 2005) 	%calcperc (bathandnortheastsomerset, 2005) 	%calcperc (bristolcityof, 2005) 	%calcperc (northsomerset, 2005) 	%calcperc (southgloucestershire, 2005) 	%calcperc (plymouth, 2005) 	%calcperc (torbay, 2005) 	%calcperc (bournemouth, 2005) 	%calcperc (poole, 2005) 	%calcperc (swindon, 2005) 	%calcperc (peterborough, 2005) 	%calcperc (luton, 2005) 	%calcperc (southendonsea, 2005) 	%calcperc (thurrock, 2005) 	%calcperc (medway, 2005) 	%calcperc (bracknellforest, 2005) 	%calcperc (westberkshire, 2005) 	%calcperc (reading, 2005) 	%calcperc (slough, 2005) 	%calcperc (windsorandmaidenhead, 2005) 	%calcperc (wokingham, 2005) 	%calcperc (miltonkeynes, 2005) 	%calcperc (brightonandhove, 2005) 	%calcperc (portsmouth, 2005) 	%calcperc (southampton, 2005) 	%calcperc (isleofwight, 2005) 	%calcperc (countydurham, 2005) 	%calcperc (cheshireeast, 2005) 	%calcperc (cheshirewestandchester, 2005) 	%calcperc (shropshire, 2005) 	%calcperc (cornwall, 2005) 	%calcperc (islesofscilly, 2005) 	%calcperc (wiltshire, 2005) 	%calcperc (bedford, 2005) 	%calcperc (centralbedfordshire, 2005) 	%calcperc (northumberland, 2005) 	%calcperc (aylesburyvale, 2005) 	%calcperc (chiltern, 2005) 	%calcperc (southbucks, 2005) 	%calcperc (wycombe, 2005) 	%calcperc (cambridge, 2005) 	%calcperc (eastcambridgeshire, 2005) 	%calcperc (fenland, 2005) 	%calcperc (huntingdonshire, 2005) 	%calcperc (southcambridgeshire, 2005) 	%calcperc (allerdale, 2005) 	%calcperc (barrowinfurness, 2005) 	%calcperc (carlisle, 2005) 	%calcperc (copeland, 2005) 	%calcperc (eden, 2005) 	%calcperc (southlakeland, 2005) 	%calcperc (ambervalley, 2005) 	%calcperc (bolsover, 2005) 	%calcperc (chesterfield, 2005) 	%calcperc (derbyshiredales, 2005) 	%calcperc (erewash, 2005) 	%calcperc (highpeak, 2005) 	%calcperc (northeastderbyshire, 2005) 	%calcperc (southderbyshire, 2005) 	%calcperc (eastdevon, 2005) 	%calcperc (exeter, 2005) 	%calcperc (middevon, 2005) 	%calcperc (northdevon, 2005) 	%calcperc (southhams, 2005) 	%calcperc (teignbridge, 2005) 	%calcperc (torridge, 2005) 	%calcperc (westdevon, 2005) 	%calcperc (christchurch, 2005) 	%calcperc (eastdorset, 2005) 	%calcperc (northdorset, 2005) 	%calcperc (purbeck, 2005) 	%calcperc (westdorset, 2005) 	%calcperc (weymouthandportland, 2005) 	%calcperc (eastbourne, 2005) 	%calcperc (hastings, 2005) 	%calcperc (lewes, 2005) 	%calcperc (rother, 2005) 	%calcperc (wealden, 2005) 	%calcperc (basildon, 2005) 	%calcperc (braintree, 2005) 	%calcperc (brentwood, 2005) 	%calcperc (castlepoint, 2005) 	%calcperc (chelmsford, 2005) 	
%calcperc (colchester, 2005) 	%calcperc (eppingforest, 2005) 	%calcperc (harlow, 2005) 	%calcperc (maldon, 2005) 	%calcperc (rochford, 2005) 	%calcperc (tendring, 2005) 	%calcperc (uttlesford, 2005) 	%calcperc (cheltenham, 2005) 	%calcperc (cotswold, 2005) 	%calcperc (forestofdean, 2005) 	%calcperc (gloucester, 2005) 	%calcperc (stroud, 2005) 	%calcperc (tewkesbury, 2005) 	%calcperc (basingstokeanddeane, 2005) 	%calcperc (easthampshire, 2005) 	%calcperc (eastleigh, 2005) 	%calcperc (fareham, 2005) 	%calcperc (gosport, 2005) 	%calcperc (hart, 2005) 	%calcperc (havant, 2005) 	%calcperc (newforest, 2005) 	%calcperc (rushmoor, 2005) 	%calcperc (testvalley, 2005) 	%calcperc (winchester, 2005) 	%calcperc (broxbourne, 2005) 	%calcperc (dacorum, 2005) 	%calcperc (hertsmere, 2005) 	%calcperc (northhertfordshire, 2005) 	%calcperc (threerivers, 2005) 	%calcperc (watford, 2005) 	%calcperc (ashford, 2005) 	%calcperc (canterbury, 2005) 	%calcperc (dartford, 2005) 	%calcperc (dover, 2005) 	%calcperc (gravesham, 2005) 	%calcperc (maidstone, 2005) 	%calcperc (sevenoaks, 2005) 	%calcperc (shepway, 2005) 	%calcperc (swale, 2005) 	%calcperc (thanet, 2005) 	%calcperc (tonbridgeandmalling, 2005) 	%calcperc (tunbridgewells, 2005) 	%calcperc (burnley, 2005) 	%calcperc (chorley, 2005) 	%calcperc (fylde, 2005) 	%calcperc (hyndburn, 2005) 	%calcperc (lancaster, 2005) 	%calcperc (pendle, 2005) 	%calcperc (preston, 2005) 	%calcperc (ribblevalley, 2005) 	%calcperc (rossendale, 2005) 	%calcperc (southribble, 2005) 	%calcperc (westlancashire, 2005) 	%calcperc (wyre, 2005) 	%calcperc (blaby, 2005) 	%calcperc (charnwood, 2005) 	%calcperc (harborough, 2005) 	%calcperc (hinckleyandbosworth, 2005) 	%calcperc (melton, 2005) 	%calcperc (northwestleicestershire, 2005) 	%calcperc (oadbyandwigston, 2005) 	%calcperc (boston, 2005) 	%calcperc (eastlindsey, 2005) 	%calcperc (lincoln, 2005) 	%calcperc (northkesteven, 2005) 	%calcperc (southholland, 2005) 	%calcperc (southkesteven, 2005) 	%calcperc (westlindsey, 2005) 	%calcperc (breckland, 2005) 	%calcperc (broadland, 2005) 	%calcperc (greatyarmouth, 2005) 	%calcperc (kingslynnandwestnorfolk, 2005) 	%calcperc (northnorfolk, 2005) 	%calcperc (norwich, 2005) 	%calcperc (southnorfolk, 2005) 	%calcperc (corby, 2005) 	%calcperc (daventry, 2005) 	%calcperc (eastnorthamptonshire, 2005) 	%calcperc (kettering, 2005) 	%calcperc (northampton, 2005) 	%calcperc (southnorthamptonshire, 2005) 	%calcperc (wellingborough, 2005) 	%calcperc (craven, 2005) 	%calcperc (hambleton, 2005) 	%calcperc (harrogate, 2005) 	%calcperc (richmondshire, 2005) 	%calcperc (ryedale, 2005) 	%calcperc (scarborough, 2005) 	%calcperc (selby, 2005) 	%calcperc (ashfield, 2005) 	%calcperc (bassetlaw, 2005) 	%calcperc (broxtowe, 2005) 	%calcperc (gedling, 2005) 	%calcperc (mansfield, 2005) 	%calcperc (newarkandsherwood, 2005) 	%calcperc (rushcliffe, 2005) 	%calcperc (cherwell, 2005) 	%calcperc (oxford, 2005) 	%calcperc (southoxfordshire, 2005) 	%calcperc (valeofwhitehorse, 2005) 	%calcperc (westoxfordshire, 2005) 	%calcperc (mendip, 2005) 	%calcperc (sedgemoor, 2005) 	%calcperc (southsomerset, 2005) 	%calcperc (tauntondeane, 2005) 	%calcperc (westsomerset, 2005) 	%calcperc (cannockchase, 2005) 	
%calcperc (eaststaffordshire, 2005) 	%calcperc (lichfield, 2005) 	%calcperc (newcastleunderlyme, 2005) 	%calcperc (southstaffordshire, 2005) 	%calcperc (stafford, 2005) 	%calcperc (staffordshiremoorlands, 2005) 	%calcperc (tamworth, 2005) 	%calcperc (babergh, 2005) 	%calcperc (forestheath, 2005) 	%calcperc (ipswich, 2005) 	%calcperc (midsuffolk, 2005) 	%calcperc (stedmundsbury, 2005) 	%calcperc (suffolkcoastal, 2005) 	
%calcperc (waveney, 2005) 	%calcperc (elmbridge, 2005) %calcperc (epsomandewell, 2005) 	%calcperc (guildford, 2005) 	%calcperc (molevalley, 2005) 	%calcperc (reigateandbanstead, 2005) 	%calcperc (runnymede, 2005) 	%calcperc (spelthorne, 2005) 	%calcperc (surreyheath, 2005) 	%calcperc (tandridge, 2005) 	%calcperc (waverley, 2005) 	%calcperc (woking, 2005) 	%calcperc (northwarwickshire, 2005) 	%calcperc (nuneatonandbedworth, 2005) 	%calcperc (rugby, 2005) 	%calcperc (stratfordonavon, 2005) 	%calcperc (warwick, 2005) 	%calcperc (adur, 2005) 	%calcperc (arun, 2005) 	%calcperc (chichester, 2005) 	%calcperc (crawley, 2005) 	%calcperc (horsham, 2005) 	%calcperc (midsussex, 2005) 	%calcperc (worthing, 2005) 	%calcperc (bromsgrove, 2005) 	%calcperc (malvernhills, 2005) 	%calcperc (redditch, 2005) 	%calcperc (worcester, 2005) 	%calcperc (wychavon, 2005) 	%calcperc (wyreforest, 2005) 	%calcperc (stalbans, 2005) 	%calcperc (welwynhatfield, 2005) 	%calcperc (easthertfordshire, 2005) 	%calcperc (stevenage, 2005) 	%calcperc (bolton, 2005) 	%calcperc (bury, 2005) 	%calcperc (manchester, 2005) 	%calcperc (oldham, 2005) 	%calcperc (rochdale, 2005) 	%calcperc (salford, 2005) 	%calcperc (stockport, 2005) 	%calcperc (tameside, 2005) 	%calcperc (trafford, 2005) 	%calcperc (wigan, 2005) 	%calcperc (knowsley, 2005) 	%calcperc (liverpool, 2005) 	%calcperc (sthelens, 2005) 	%calcperc (sefton, 2005) 	%calcperc (wirral, 2005) 	%calcperc (barnsley, 2005) 	%calcperc (doncaster, 2005) 	%calcperc (rotherham, 2005) 	%calcperc (sheffield, 2005) 	%calcperc (newcastleupontyne, 2005) 	%calcperc (northtyneside, 2005) 	%calcperc (southtyneside, 2005) 	%calcperc (sunderland, 2005) 	%calcperc (birmingham, 2005) 	%calcperc (coventry, 2005) 	%calcperc (dudley, 2005) 	%calcperc (sandwell, 2005) 	%calcperc (solihull, 2005) 	%calcperc (walsall, 2005) 	%calcperc (wolverhampton, 2005) 	%calcperc (bradford, 2005) 	%calcperc (calderdale, 2005) 	%calcperc (kirklees, 2005) 	%calcperc (leeds, 2005) 	%calcperc (wakefield, 2005) 	%calcperc (gateshead, 2005) 	%calcperc (cityoflondon, 2005) 	%calcperc (barkinganddagenham, 2005) 	%calcperc (barnet, 2005) 	%calcperc (bexley, 2005) 	%calcperc (brent, 2005) 	%calcperc (bromley, 2005) 	%calcperc (camden, 2005) 	%calcperc (croydon, 2005) 	%calcperc (ealing, 2005) 	%calcperc (enfield, 2005) 	%calcperc (greenwich, 2005) 	%calcperc (hackney, 2005) 	%calcperc (hammersmithandfulham, 2005) 	%calcperc (haringey, 2005) 	%calcperc (harrow, 2005) 	%calcperc (havering, 2005) 	%calcperc (hillingdon, 2005) 	%calcperc (hounslow, 2005) 	%calcperc (islington, 2005) 	%calcperc (kensingtonandchelsea, 2005) 	%calcperc (kingstonuponthames, 2005) 	%calcperc (lambeth, 2005) 	%calcperc (lewisham, 2005) 	%calcperc (merton, 2005) 	%calcperc (newham, 2005) 	%calcperc (redbridge, 2005) 	%calcperc (richmonduponthames, 2005) 	%calcperc (southwark, 2005) 	%calcperc (sutton, 2005) 	%calcperc (towerhamlets, 2005) 	%calcperc (walthamforest, 2005) 	%calcperc (wandsworth, 2005) 	%calcperc (westminster, 2005) 	%calcperc (buckinghamshire, 2005) 	%calcperc (cambridgeshire, 2005) 	%calcperc (cumbria, 2005) 	%calcperc (derbyshire, 2005) 	%calcperc (devon, 2005) 	%calcperc (dorset, 2005) 	
%calcperc (eastsussex, 2005) 	%calcperc (essex, 2005) 	%calcperc (gloucestershire, 2005) 	%calcperc (hampshire, 2005) 	%calcperc (hertfordshire, 2005) 	%calcperc (kent, 2005) 	%calcperc (lancashire, 2005) 	%calcperc (leicestershire, 2005) 	%calcperc (lincolnshire, 2005) 	%calcperc (norfolk, 2005) 	%calcperc (northamptonshire, 2005) 	%calcperc (northyorkshire, 2005) 	%calcperc (nottinghamshire, 2005) 	%calcperc (oxfordshire, 2005) 	%calcperc (somerset, 2005) 	%calcperc (staffordshire, 2005) 	%calcperc (suffolk, 2005) 	%calcperc (surrey, 2005) 	%calcperc (warwickshire, 2005) 	%calcperc (westsussex, 2005) 	%calcperc (worcestershire, 2005) 	%calcperc (greatermanchester, 2005) 	%calcperc (merseyside, 2005) 	%calcperc (southyorkshire, 2005) 	%calcperc (westmidlands, 2005) 	%calcperc (westyorkshire, 2005) 	%calcperc (tyneandwear, 2005) 	%calcperc (antrimandnewtownabbey, 2005) 	%calcperc (armaghcitybanbridgeandcraigavon, 2005) 	%calcperc (belfast, 2005) 	%calcperc (causewaycoastandglens, 2005) 	%calcperc (derrycityandstrabane, 2005) 	%calcperc (fermanaghandomagh, 2005) 	%calcperc (lisburnandcastlereagh, 2005) 	%calcperc (midandeastantrim, 2005) 	%calcperc (midulster, 2005) 	%calcperc (newrymourneanddown, 2005) 	%calcperc (ardsandnorthdown, 2005) 	%calcperc (clackmannanshire, 2005) 	%calcperc (dumfriesandgalloway, 2005) 	%calcperc (eastayrshire, 2005) 	%calcperc (eastlothian, 2005) 	%calcperc (eastrenfrewshire, 2005) 	%calcperc (naheileanansiar, 2005) 	%calcperc (falkirk, 2005) 	%calcperc (fife, 2005) 	%calcperc (highland, 2005) 	%calcperc (inverclyde, 2005) 	%calcperc (midlothian, 2005) 	%calcperc (moray, 2005) 	%calcperc (northayrshire, 2005) 	%calcperc (orkneyislands, 2005) 	%calcperc (perthandkinross, 2005) 	%calcperc (scottishborders, 2005) 	%calcperc (shetlandislands, 2005) 	%calcperc (southayrshire, 2005) 	%calcperc (southlanarkshire, 2005) 	%calcperc (stirling, 2005) 	%calcperc (aberdeencity, 2005) 	%calcperc (aberdeenshire, 2005) 	%calcperc (argyllandbute, 2005) 	%calcperc (cityofedinburgh, 2005) 	%calcperc (renfrewshire, 2005) 	%calcperc (westdunbartonshire, 2005) 	%calcperc (westlothian, 2005) 	%calcperc (angus, 2005) 	%calcperc (dundeecity, 2005) 	%calcperc (northlanarkshire, 2005) 	%calcperc (eastdunbartonshire, 2005) 	%calcperc (glasgowcity, 2005) 	%calcperc (isleofanglesey, 2005) 	%calcperc (gwynedd, 2005) 	%calcperc (conwy, 2005) 	%calcperc (denbighshire, 2005) 	%calcperc (flintshire, 2005) 	%calcperc (wrexham, 2005) 	%calcperc (ceredigion, 2005) 	%calcperc (pembrokeshire, 2005) 	%calcperc (carmarthenshire, 2005) 	%calcperc (swansea, 2005) 	%calcperc (neathporttalbot, 2005) 	%calcperc (bridgend, 2005) 	%calcperc (valeofglamorgan, 2005) 	%calcperc (cardiff, 2005) 	%calcperc (rhonddacynontaf, 2005) 	%calcperc (caerphilly, 2005) 	%calcperc (blaenaugwent, 2005) 	%calcperc (torfaen, 2005) 	%calcperc (monmouthshire, 2005) 	%calcperc (newport, 2005) 	%calcperc (powys, 2005) 	%calcperc (merthyrtydfil, 2005) 	%calcperc (northeast, 2005) 	%calcperc (northwest, 2005) 	%calcperc (yorkshireandhumber, 2005) 	%calcperc (eastmidlands, 2005) 	%calcperc (westmidlandsregion, 2005) 	%calcperc (east, 2005) 	%calcperc (london, 2005) 	%calcperc (southeast, 2005) 	%calcperc (southwest, 2005) 	
%calcperc (england, 2005) 	%calcperc (northernireland, 2005) 	%calcperc (scotland, 2005) 	%calcperc (wales, 2005) 	%calcperc (englandandwales, 2005) 	%calcperc (greatbritian, 2005) 	%calcperc (unitedkingdom, 2005); 
%calcperc (hartlepool, 2006) 	%calcperc (middlesbrough, 2006) 	%calcperc (redcarandcleveland, 2006) 	%calcperc (stocktonontees, 2006) 	%calcperc (darlington, 2006) 	%calcperc (halton, 2006) 	%calcperc (warrington, 2006) 	%calcperc (blackburnwithdarwen, 2006) 	%calcperc (blackpool, 2006) 	%calcperc (kingstonuponhullcityof, 2006) 	%calcperc (eastridingofyorkshire, 2006) 	%calcperc (northeastlincolnshire, 2006) 	%calcperc (northlincolnshire, 2006) 	%calcperc (york, 2006) 	%calcperc (derby, 2006) 	%calcperc (leicester, 2006) 	%calcperc (rutland, 2006) 	%calcperc (nottingham, 2006) 	%calcperc (herefordshirecountyof, 2006) 	%calcperc (telfordandwrekin, 2006) 	%calcperc (stokeontrent, 2006) 	%calcperc (bathandnortheastsomerset, 2006) 	%calcperc (bristolcityof, 2006) 	%calcperc (northsomerset, 2006) 	%calcperc (southgloucestershire, 2006) 	%calcperc (plymouth, 2006) 	%calcperc (torbay, 2006) 	%calcperc (bournemouth, 2006) 	%calcperc (poole, 2006) 	%calcperc (swindon, 2006) 	%calcperc (peterborough, 2006) 	%calcperc (luton, 2006) 	%calcperc (southendonsea, 2006) 	%calcperc (thurrock, 2006) 	%calcperc (medway, 2006) 	%calcperc (bracknellforest, 2006) 	%calcperc (westberkshire, 2006) 	%calcperc (reading, 2006) 	%calcperc (slough, 2006) 	%calcperc (windsorandmaidenhead, 2006) 	%calcperc (wokingham, 2006) 	%calcperc (miltonkeynes, 2006) 	%calcperc (brightonandhove, 2006) 	%calcperc (portsmouth, 2006) 	%calcperc (southampton, 2006) 	%calcperc (isleofwight, 2006) 	%calcperc (countydurham, 2006) 	%calcperc (cheshireeast, 2006) 	%calcperc (cheshirewestandchester, 2006) 	%calcperc (shropshire, 2006) 	%calcperc (cornwall, 2006) 	%calcperc (islesofscilly, 2006) 	%calcperc (wiltshire, 2006) 	%calcperc (bedford, 2006) 	%calcperc (centralbedfordshire, 2006) 	%calcperc (northumberland, 2006) 	%calcperc (aylesburyvale, 2006) 	%calcperc (chiltern, 2006) 	%calcperc (southbucks, 2006) 	%calcperc (wycombe, 2006) 	%calcperc (cambridge, 2006) 	%calcperc (eastcambridgeshire, 2006) 	%calcperc (fenland, 2006) 	%calcperc (huntingdonshire, 2006) 	%calcperc (southcambridgeshire, 2006) 	%calcperc (allerdale, 2006) 	%calcperc (barrowinfurness, 2006) 	%calcperc (carlisle, 2006) 	%calcperc (copeland, 2006) 	%calcperc (eden, 2006) 	%calcperc (southlakeland, 2006) 	%calcperc (ambervalley, 2006) 	%calcperc (bolsover, 2006) 	%calcperc (chesterfield, 2006) 	%calcperc (derbyshiredales, 2006) 	%calcperc (erewash, 2006) 	%calcperc (highpeak, 2006) 	%calcperc (northeastderbyshire, 2006) 	%calcperc (southderbyshire, 2006) 	%calcperc (eastdevon, 2006) 	%calcperc (exeter, 2006) 	%calcperc (middevon, 2006) 	%calcperc (northdevon, 2006) 	%calcperc (southhams, 2006) 	%calcperc (teignbridge, 2006) 	%calcperc (torridge, 2006) 	%calcperc (westdevon, 2006) 	%calcperc (christchurch, 2006) 	%calcperc (eastdorset, 2006) 	%calcperc (northdorset, 2006) 	%calcperc (purbeck, 2006) 	%calcperc (westdorset, 2006) 	%calcperc (weymouthandportland, 2006) 	%calcperc (eastbourne, 2006) 	%calcperc (hastings, 2006) 	%calcperc (lewes, 2006) 	%calcperc (rother, 2006) 	%calcperc (wealden, 2006) 	%calcperc (basildon, 2006) 	%calcperc (braintree, 2006) 	%calcperc (brentwood, 2006) 	%calcperc (castlepoint, 2006) 	%calcperc (chelmsford, 2006) 	
%calcperc (colchester, 2006) 	%calcperc (eppingforest, 2006) 	%calcperc (harlow, 2006) 	%calcperc (maldon, 2006) 	%calcperc (rochford, 2006) 	%calcperc (tendring, 2006) 	%calcperc (uttlesford, 2006) 	%calcperc (cheltenham, 2006) 	%calcperc (cotswold, 2006) 	%calcperc (forestofdean, 2006) 	%calcperc (gloucester, 2006) 	%calcperc (stroud, 2006) 	%calcperc (tewkesbury, 2006) 	%calcperc (basingstokeanddeane, 2006) 	%calcperc (easthampshire, 2006) 	%calcperc (eastleigh, 2006) 	%calcperc (fareham, 2006) 	%calcperc (gosport, 2006) 	%calcperc (hart, 2006) 	%calcperc (havant, 2006) 	%calcperc (newforest, 2006) 	%calcperc (rushmoor, 2006) 	%calcperc (testvalley, 2006) 	%calcperc (winchester, 2006) 	%calcperc (broxbourne, 2006) 	%calcperc (dacorum, 2006) 	%calcperc (hertsmere, 2006) 	%calcperc (northhertfordshire, 2006) 	%calcperc (threerivers, 2006) 	%calcperc (watford, 2006) 	%calcperc (ashford, 2006) 	%calcperc (canterbury, 2006) 	%calcperc (dartford, 2006) 	%calcperc (dover, 2006) 	%calcperc (gravesham, 2006) 	%calcperc (maidstone, 2006) 	%calcperc (sevenoaks, 2006) 	%calcperc (shepway, 2006) 	%calcperc (swale, 2006) 	%calcperc (thanet, 2006) 	%calcperc (tonbridgeandmalling, 2006) 	%calcperc (tunbridgewells, 2006) 	%calcperc (burnley, 2006) 	%calcperc (chorley, 2006) 	%calcperc (fylde, 2006) 	%calcperc (hyndburn, 2006) 	%calcperc (lancaster, 2006) 	%calcperc (pendle, 2006) 	%calcperc (preston, 2006) 	%calcperc (ribblevalley, 2006) 	%calcperc (rossendale, 2006) 	%calcperc (southribble, 2006) 	%calcperc (westlancashire, 2006) 	%calcperc (wyre, 2006) 	%calcperc (blaby, 2006) 	%calcperc (charnwood, 2006) 	%calcperc (harborough, 2006) 	%calcperc (hinckleyandbosworth, 2006) 	%calcperc (melton, 2006) 	%calcperc (northwestleicestershire, 2006) 	%calcperc (oadbyandwigston, 2006) 	%calcperc (boston, 2006) 	%calcperc (eastlindsey, 2006) 	%calcperc (lincoln, 2006) 	%calcperc (northkesteven, 2006) 	%calcperc (southholland, 2006) 	%calcperc (southkesteven, 2006) 	%calcperc (westlindsey, 2006) 	%calcperc (breckland, 2006) 	%calcperc (broadland, 2006) 	%calcperc (greatyarmouth, 2006) 	%calcperc (kingslynnandwestnorfolk, 2006) 	%calcperc (northnorfolk, 2006) 	%calcperc (norwich, 2006) 	%calcperc (southnorfolk, 2006) 	%calcperc (corby, 2006) 	%calcperc (daventry, 2006) 	%calcperc (eastnorthamptonshire, 2006) 	%calcperc (kettering, 2006) 	%calcperc (northampton, 2006) 	%calcperc (southnorthamptonshire, 2006) 	%calcperc (wellingborough, 2006) 	%calcperc (craven, 2006) 	%calcperc (hambleton, 2006) 	%calcperc (harrogate, 2006) 	%calcperc (richmondshire, 2006) 	%calcperc (ryedale, 2006) 	%calcperc (scarborough, 2006) 	%calcperc (selby, 2006) 	%calcperc (ashfield, 2006) 	%calcperc (bassetlaw, 2006) 	%calcperc (broxtowe, 2006) 	%calcperc (gedling, 2006) 	%calcperc (mansfield, 2006) 	%calcperc (newarkandsherwood, 2006) 	%calcperc (rushcliffe, 2006) 	%calcperc (cherwell, 2006) 	%calcperc (oxford, 2006) 	%calcperc (southoxfordshire, 2006) 	%calcperc (valeofwhitehorse, 2006) 	%calcperc (westoxfordshire, 2006) 	%calcperc (mendip, 2006) 	%calcperc (sedgemoor, 2006) 	%calcperc (southsomerset, 2006) 	%calcperc (tauntondeane, 2006) 	%calcperc (westsomerset, 2006) 	%calcperc (cannockchase, 2006) 
%calcperc (eaststaffordshire, 2006) 	%calcperc (lichfield, 2006) 	%calcperc (newcastleunderlyme, 2006) 	%calcperc (southstaffordshire, 2006) 	%calcperc (stafford, 2006) 	%calcperc (staffordshiremoorlands, 2006) 	%calcperc (tamworth, 2006) 	%calcperc (babergh, 2006) 	%calcperc (forestheath, 2006) 	%calcperc (ipswich, 2006) 	%calcperc (midsuffolk, 2006) 	%calcperc (stedmundsbury, 2006) 	%calcperc (suffolkcoastal, 2006) 	
%calcperc (waveney, 2006) 	%calcperc (elmbridge, 2006) 	%calcperc (epsomandewell, 2006) 	%calcperc (guildford, 2006) 	%calcperc (molevalley, 2006) 	%calcperc (reigateandbanstead, 2006) 	%calcperc (runnymede, 2006) 	%calcperc (spelthorne, 2006) 	%calcperc (surreyheath, 2006) 	%calcperc (tandridge, 2006) 	%calcperc (waverley, 2006) 	%calcperc (woking, 2006) 	%calcperc (northwarwickshire, 2006) 	%calcperc (nuneatonandbedworth, 2006) 	%calcperc (rugby, 2006) 	%calcperc (stratfordonavon, 2006) 	%calcperc (warwick, 2006) 	%calcperc (adur, 2006) 	%calcperc (arun, 2006) 	%calcperc (chichester, 2006) 	%calcperc (crawley, 2006) 	%calcperc (horsham, 2006) 	%calcperc (midsussex, 2006) 	%calcperc (worthing, 2006) 	%calcperc (bromsgrove, 2006) 	%calcperc (malvernhills, 2006) 	%calcperc (redditch, 2006) 	%calcperc (worcester, 2006) 	%calcperc (wychavon, 2006) 	%calcperc (wyreforest, 2006) 	%calcperc (stalbans, 2006) 	%calcperc (welwynhatfield, 2006) 	%calcperc (easthertfordshire, 2006) 	%calcperc (stevenage, 2006) 	%calcperc (bolton, 2006) 	%calcperc (bury, 2006) 	%calcperc (manchester, 2006) 	%calcperc (oldham, 2006) 	%calcperc (rochdale, 2006) 	%calcperc (salford, 2006) 	%calcperc (stockport, 2006) 	%calcperc (tameside, 2006) 	%calcperc (trafford, 2006) 	%calcperc (wigan, 2006) 	%calcperc (knowsley, 2006) 	%calcperc (liverpool, 2006) 	%calcperc (sthelens, 2006) 	%calcperc (sefton, 2006) 	%calcperc (wirral, 2006) 	%calcperc (barnsley, 2006) 	%calcperc (doncaster, 2006) 	%calcperc (rotherham, 2006) 	%calcperc (sheffield, 2006) 	%calcperc (newcastleupontyne, 2006) 	%calcperc (northtyneside, 2006) 	%calcperc (southtyneside, 2006) 	%calcperc (sunderland, 2006) 	%calcperc (birmingham, 2006) 	%calcperc (coventry, 2006) 	%calcperc (dudley, 2006) 	%calcperc (sandwell, 2006) 	%calcperc (solihull, 2006) 	%calcperc (walsall, 2006) 	%calcperc (wolverhampton, 2006) 	%calcperc (bradford, 2006) 	%calcperc (calderdale, 2006) 	%calcperc (kirklees, 2006) 	%calcperc (leeds, 2006) 	%calcperc (wakefield, 2006) 	%calcperc (gateshead, 2006) 	%calcperc (cityoflondon, 2006) 	%calcperc (barkinganddagenham, 2006) 	%calcperc (barnet, 2006) 	%calcperc (bexley, 2006) 	%calcperc (brent, 2006) 	%calcperc (bromley, 2006) 	%calcperc (camden, 2006) 	%calcperc (croydon, 2006) 	%calcperc (ealing, 2006) 	%calcperc (enfield, 2006) 	%calcperc (greenwich, 2006) 	%calcperc (hackney, 2006) 	%calcperc (hammersmithandfulham, 2006) 	%calcperc (haringey, 2006) 	%calcperc (harrow, 2006) 	%calcperc (havering, 2006) 	%calcperc (hillingdon, 2006) 	%calcperc (hounslow, 2006) 	%calcperc (islington, 2006) 	%calcperc (kensingtonandchelsea, 2006) 	%calcperc (kingstonuponthames, 2006) 	%calcperc (lambeth, 2006) 	%calcperc (lewisham, 2006) 	%calcperc (merton, 2006) 	%calcperc (newham, 2006) 	%calcperc (redbridge, 2006) 	%calcperc (richmonduponthames, 2006) 	%calcperc (southwark, 2006) 	%calcperc (sutton, 2006) 	%calcperc (towerhamlets, 2006) 	%calcperc (walthamforest, 2006) 	%calcperc (wandsworth, 2006) 	%calcperc (westminster, 2006) 	%calcperc (buckinghamshire, 2006) 	%calcperc (cambridgeshire, 2006) 	%calcperc (cumbria, 2006) 	%calcperc (derbyshire, 2006) 	%calcperc (devon, 2006) 	%calcperc (dorset, 2006) 	
%calcperc (eastsussex, 2006) 	%calcperc (essex, 2006) 	%calcperc (gloucestershire, 2006) 	%calcperc (hampshire, 2006) 	%calcperc (hertfordshire, 2006) 	%calcperc (kent, 2006) 	%calcperc (lancashire, 2006) 	%calcperc (leicestershire, 2006) 	%calcperc (lincolnshire, 2006) 	%calcperc (norfolk, 2006) 	%calcperc (northamptonshire, 2006) 	%calcperc (northyorkshire, 2006) 	%calcperc (nottinghamshire, 2006) 	%calcperc (oxfordshire, 2006) 	%calcperc (somerset, 2006) 	%calcperc (staffordshire, 2006) 	%calcperc (suffolk, 2006) 	%calcperc (surrey, 2006) 	%calcperc (warwickshire, 2006) 	%calcperc (westsussex, 2006) 	%calcperc (worcestershire, 2006) 	%calcperc (greatermanchester, 2006) 	%calcperc (merseyside, 2006) 	%calcperc (southyorkshire, 2006) 	%calcperc (westmidlands, 2006) 	%calcperc (westyorkshire, 2006) 	%calcperc (tyneandwear, 2006) 	%calcperc (antrimandnewtownabbey, 2006) 	%calcperc (armaghcitybanbridgeandcraigavon, 2006) 	%calcperc (belfast, 2006) 	%calcperc (causewaycoastandglens, 2006) 	%calcperc (derrycityandstrabane, 2006) 	%calcperc (fermanaghandomagh, 2006) 	%calcperc (lisburnandcastlereagh, 2006) 	%calcperc (midandeastantrim, 2006) 	%calcperc (midulster, 2006) 	%calcperc (newrymourneanddown, 2006) 	%calcperc (ardsandnorthdown, 2006) 	%calcperc (clackmannanshire, 2006) 	%calcperc (dumfriesandgalloway, 2006) 	%calcperc (eastayrshire, 2006) 	%calcperc (eastlothian, 2006) 	%calcperc (eastrenfrewshire, 2006) 	%calcperc (naheileanansiar, 2006) 	%calcperc (falkirk, 2006) 	%calcperc (fife, 2006) 	%calcperc (highland, 2006) 	%calcperc (inverclyde, 2006) 	%calcperc (midlothian, 2006) 	%calcperc (moray, 2006) 	%calcperc (northayrshire, 2006) 	%calcperc (orkneyislands, 2006) 	%calcperc (perthandkinross, 2006) 	%calcperc (scottishborders, 2006) 	%calcperc (shetlandislands, 2006) 	%calcperc (southayrshire, 2006) 	%calcperc (southlanarkshire, 2006) 	%calcperc (stirling, 2006) 	%calcperc (aberdeencity, 2006) 	%calcperc (aberdeenshire, 2006) 	%calcperc (argyllandbute, 2006) 	%calcperc (cityofedinburgh, 2006) 	%calcperc (renfrewshire, 2006) 	%calcperc (westdunbartonshire, 2006) 	%calcperc (westlothian, 2006) 	%calcperc (angus, 2006) 	%calcperc (dundeecity, 2006) 	%calcperc (northlanarkshire, 2006) 	%calcperc (eastdunbartonshire, 2006) 	%calcperc (glasgowcity, 2006) 	%calcperc (isleofanglesey, 2006) 	%calcperc (gwynedd, 2006) 	%calcperc (conwy, 2006) 	%calcperc (denbighshire, 2006) 	%calcperc (flintshire, 2006) 	%calcperc (wrexham, 2006) 	%calcperc (ceredigion, 2006) 	%calcperc (pembrokeshire, 2006) 	%calcperc (carmarthenshire, 2006) 	%calcperc (swansea, 2006) 	%calcperc (neathporttalbot, 2006) 	%calcperc (bridgend, 2006) 	%calcperc (valeofglamorgan, 2006) 	%calcperc (cardiff, 2006) 	%calcperc (rhonddacynontaf, 2006) 	%calcperc (caerphilly, 2006) 	%calcperc (blaenaugwent, 2006) 	%calcperc (torfaen, 2006) 	%calcperc (monmouthshire, 2006) 	%calcperc (newport, 2006) 	%calcperc (powys, 2006) 	%calcperc (merthyrtydfil, 2006) 	%calcperc (northeast, 2006) 	%calcperc (northwest, 2006) 	%calcperc (yorkshireandhumber, 2006) 	%calcperc (eastmidlands, 2006) 	%calcperc (westmidlandsregion, 2006) 	%calcperc (east, 2006) 	%calcperc (london, 2006) 	%calcperc (southeast, 2006) 	
%calcperc (southwest, 2006) 	%calcperc (england, 2006) 	%calcperc (northernireland, 2006) 	%calcperc (scotland, 2006) 	%calcperc (wales, 2006) 	%calcperc (englandandwales, 2006) 	%calcperc (greatbritian, 2006) 	%calcperc (unitedkingdom, 2006); 
%calcperc (hartlepool, 2007) 	%calcperc (middlesbrough, 2007) 	%calcperc (redcarandcleveland, 2007) 	%calcperc (stocktonontees, 2007) 	%calcperc (darlington, 2007) 	%calcperc (halton, 2007) 	%calcperc (warrington, 2007) 	%calcperc (blackburnwithdarwen, 2007) 	%calcperc (blackpool, 2007) 	%calcperc (kingstonuponhullcityof, 2007) 	%calcperc (eastridingofyorkshire, 2007) 	%calcperc (northeastlincolnshire, 2007) 	%calcperc (northlincolnshire, 2007) 	%calcperc (york, 2007) 	%calcperc (derby, 2007) 	%calcperc (leicester, 2007) 	%calcperc (rutland, 2007) 	%calcperc (nottingham, 2007) 	%calcperc (herefordshirecountyof, 2007) 	%calcperc (telfordandwrekin, 2007) 	%calcperc (stokeontrent, 2007) 	%calcperc (bathandnortheastsomerset, 2007) 	%calcperc (bristolcityof, 2007) 	%calcperc (northsomerset, 2007) 	%calcperc (southgloucestershire, 2007) 	%calcperc (plymouth, 2007) 	%calcperc (torbay, 2007) 	%calcperc (bournemouth, 2007) 	%calcperc (poole, 2007) 	%calcperc (swindon, 2007) 	%calcperc (peterborough, 2007) 	%calcperc (luton, 2007) 	%calcperc (southendonsea, 2007) 	%calcperc (thurrock, 2007) 	%calcperc (medway, 2007) 	%calcperc (bracknellforest, 2007) 	%calcperc (westberkshire, 2007) 	%calcperc (reading, 2007) 	%calcperc (slough, 2007) 	%calcperc (windsorandmaidenhead, 2007) 	%calcperc (wokingham, 2007) 	%calcperc (miltonkeynes, 2007) 	%calcperc (brightonandhove, 2007) 	%calcperc (portsmouth, 2007) 	%calcperc (southampton, 2007) 	%calcperc (isleofwight, 2007) 	%calcperc (countydurham, 2007) 	%calcperc (cheshireeast, 2007) 	%calcperc (cheshirewestandchester, 2007) 	%calcperc (shropshire, 2007) 	%calcperc (cornwall, 2007) 	%calcperc (islesofscilly, 2007) 	%calcperc (wiltshire, 2007) 	%calcperc (bedford, 2007) 	%calcperc (centralbedfordshire, 2007) 	%calcperc (northumberland, 2007) 	%calcperc (aylesburyvale, 2007) 	%calcperc (chiltern, 2007) 	%calcperc (southbucks, 2007) 	%calcperc (wycombe, 2007) 	%calcperc (cambridge, 2007) 	%calcperc (eastcambridgeshire, 2007) 	%calcperc (fenland, 2007) 	%calcperc (huntingdonshire, 2007) 	%calcperc (southcambridgeshire, 2007) 	%calcperc (allerdale, 2007) 	%calcperc (barrowinfurness, 2007) 	%calcperc (carlisle, 2007) 	%calcperc (copeland, 2007) 	%calcperc (eden, 2007) 	%calcperc (southlakeland, 2007) 	%calcperc (ambervalley, 2007) 	%calcperc (bolsover, 2007) 	%calcperc (chesterfield, 2007) 	%calcperc (derbyshiredales, 2007) 	%calcperc (erewash, 2007) 	%calcperc (highpeak, 2007) 	%calcperc (northeastderbyshire, 2007) 	%calcperc (southderbyshire, 2007) 	%calcperc (eastdevon, 2007) 	%calcperc (exeter, 2007) 	%calcperc (middevon, 2007) 	%calcperc (northdevon, 2007) 	%calcperc (southhams, 2007) 	%calcperc (teignbridge, 2007) 	%calcperc (torridge, 2007) 	%calcperc (westdevon, 2007) 	%calcperc (christchurch, 2007) 	%calcperc (eastdorset, 2007) 	%calcperc (northdorset, 2007) 	%calcperc (purbeck, 2007) 	%calcperc (westdorset, 2007) 	%calcperc (weymouthandportland, 2007) 	%calcperc (eastbourne, 2007) 	%calcperc (hastings, 2007) 	%calcperc (lewes, 2007) 	%calcperc (rother, 2007) 	%calcperc (wealden, 2007) 	%calcperc (basildon, 2007) 	%calcperc (braintree, 2007) 	%calcperc (brentwood, 2007) 	%calcperc (castlepoint, 2007) 	%calcperc (chelmsford, 2007) 	
%calcperc (colchester, 2007) 	%calcperc (eppingforest, 2007) 	%calcperc (harlow, 2007) 	%calcperc (maldon, 2007) 	%calcperc (rochford, 2007) 	%calcperc (tendring, 2007) 	%calcperc (uttlesford, 2007) 	%calcperc (cheltenham, 2007) 	%calcperc (cotswold, 2007) 	%calcperc (forestofdean, 2007) 	%calcperc (gloucester, 2007) 	%calcperc (stroud, 2007) 	%calcperc (tewkesbury, 2007) 	%calcperc (basingstokeanddeane, 2007) 	%calcperc (easthampshire, 2007) 	%calcperc (eastleigh, 2007) 	%calcperc (fareham, 2007) 	%calcperc (gosport, 2007) 	%calcperc (hart, 2007) 	%calcperc (havant, 2007) 	%calcperc (newforest, 2007) 	%calcperc (rushmoor, 2007) 	%calcperc (testvalley, 2007) 	%calcperc (winchester, 2007) 	%calcperc (broxbourne, 2007) 	%calcperc (dacorum, 2007) 	%calcperc (hertsmere, 2007) 	%calcperc (northhertfordshire, 2007) 	%calcperc (threerivers, 2007) 	%calcperc (watford, 2007) 	%calcperc (ashford, 2007) 	%calcperc (canterbury, 2007) 	%calcperc (dartford, 2007) 	%calcperc (dover, 2007) 	%calcperc (gravesham, 2007) 	%calcperc (maidstone, 2007) 	%calcperc (sevenoaks, 2007) 	%calcperc (shepway, 2007) 	%calcperc (swale, 2007) 	%calcperc (thanet, 2007) 	%calcperc (tonbridgeandmalling, 2007) 	%calcperc (tunbridgewells, 2007) 	%calcperc (burnley, 2007) 	%calcperc (chorley, 2007) 	%calcperc (fylde, 2007) 	%calcperc (hyndburn, 2007) 	%calcperc (lancaster, 2007) 	%calcperc (pendle, 2007) 	%calcperc (preston, 2007) 	%calcperc (ribblevalley, 2007) 	%calcperc (rossendale, 2007) 	%calcperc (southribble, 2007) 	%calcperc (westlancashire, 2007) 	%calcperc (wyre, 2007) 	%calcperc (blaby, 2007) 	%calcperc (charnwood, 2007) 	%calcperc (harborough, 2007) 	%calcperc (hinckleyandbosworth, 2007) 	%calcperc (melton, 2007) 	%calcperc (northwestleicestershire, 2007) 	%calcperc (oadbyandwigston, 2007) 	%calcperc (boston, 2007) 	%calcperc (eastlindsey, 2007) 	%calcperc (lincoln, 2007) 	%calcperc (northkesteven, 2007) 	%calcperc (southholland, 2007) 	%calcperc (southkesteven, 2007) 	%calcperc (westlindsey, 2007) 	%calcperc (breckland, 2007) 	%calcperc (broadland, 2007) 	%calcperc (greatyarmouth, 2007) 	%calcperc (kingslynnandwestnorfolk, 2007) 	%calcperc (northnorfolk, 2007) 	%calcperc (norwich, 2007) 	%calcperc (southnorfolk, 2007) 	%calcperc (corby, 2007) 	%calcperc (daventry, 2007) 	%calcperc (eastnorthamptonshire, 2007) 	%calcperc (kettering, 2007) 	%calcperc (northampton, 2007) 	%calcperc (southnorthamptonshire, 2007) 	%calcperc (wellingborough, 2007) 	%calcperc (craven, 2007) 	%calcperc (hambleton, 2007) 	%calcperc (harrogate, 2007) 	%calcperc (richmondshire, 2007) 	%calcperc (ryedale, 2007) 	%calcperc (scarborough, 2007) 	%calcperc (selby, 2007) 	%calcperc (ashfield, 2007) 	%calcperc (bassetlaw, 2007) 	%calcperc (broxtowe, 2007) 	%calcperc (gedling, 2007) 	%calcperc (mansfield, 2007) 	%calcperc (newarkandsherwood, 2007) 	%calcperc (rushcliffe, 2007) 	%calcperc (cherwell, 2007) 	%calcperc (oxford, 2007) 	%calcperc (southoxfordshire, 2007) 	%calcperc (valeofwhitehorse, 2007) 	%calcperc (westoxfordshire, 2007) 	%calcperc (mendip, 2007) 	%calcperc (sedgemoor, 2007) 	%calcperc (southsomerset, 2007) 	%calcperc (tauntondeane, 2007) 	%calcperc (westsomerset, 2007) 	%calcperc (cannockchase, 2007) 	
%calcperc (eaststaffordshire, 2007) 	%calcperc (lichfield, 2007) 	%calcperc (newcastleunderlyme, 2007) 	%calcperc (southstaffordshire, 2007) 	%calcperc (stafford, 2007) 	%calcperc (staffordshiremoorlands, 2007) 	%calcperc (tamworth, 2007) 	%calcperc (babergh, 2007) 	%calcperc (forestheath, 2007) 	%calcperc (ipswich, 2007) 	%calcperc (midsuffolk, 2007) 	%calcperc (stedmundsbury, 2007) 	%calcperc (suffolkcoastal, 2007) 	
%calcperc (waveney, 2007) 	%calcperc (elmbridge, 2007) 	%calcperc (epsomandewell, 2007) 	%calcperc (guildford, 2007) 	%calcperc (molevalley, 2007) 	%calcperc (reigateandbanstead, 2007) 	%calcperc (runnymede, 2007) 	%calcperc (spelthorne, 2007) 	%calcperc (surreyheath, 2007) 	%calcperc (tandridge, 2007) 	%calcperc (waverley, 2007) 	%calcperc (woking, 2007) 	%calcperc (northwarwickshire, 2007) 	%calcperc (nuneatonandbedworth, 2007) 	%calcperc (rugby, 2007) 	%calcperc (stratfordonavon, 2007) 	%calcperc (warwick, 2007) 	%calcperc (adur, 2007) 	%calcperc (arun, 2007) 	%calcperc (chichester, 2007) 	%calcperc (crawley, 2007) 	%calcperc (horsham, 2007) 	%calcperc (midsussex, 2007) 	%calcperc (worthing, 2007) 	%calcperc (bromsgrove, 2007) 	%calcperc (malvernhills, 2007) 	%calcperc (redditch, 2007) 	%calcperc (worcester, 2007) 	%calcperc (wychavon, 2007) 	%calcperc (wyreforest, 2007) 	%calcperc (stalbans, 2007) 	%calcperc (welwynhatfield, 2007) 	%calcperc (easthertfordshire, 2007) 	%calcperc (stevenage, 2007) 	%calcperc (bolton, 2007) 	%calcperc (bury, 2007) 	%calcperc (manchester, 2007) 	%calcperc (oldham, 2007) 	%calcperc (rochdale, 2007) 	%calcperc (salford, 2007) 	%calcperc (stockport, 2007) 	%calcperc (tameside, 2007) 	%calcperc (trafford, 2007) 	%calcperc (wigan, 2007) 	%calcperc (knowsley, 2007) 	%calcperc (liverpool, 2007) 	%calcperc (sthelens, 2007) 	%calcperc (sefton, 2007) 	%calcperc (wirral, 2007) 	%calcperc (barnsley, 2007) 	%calcperc (doncaster, 2007) 	%calcperc (rotherham, 2007) 	%calcperc (sheffield, 2007) 	%calcperc (newcastleupontyne, 2007) 	%calcperc (northtyneside, 2007) 	%calcperc (southtyneside, 2007) 	%calcperc (sunderland, 2007) 	%calcperc (birmingham, 2007) 	%calcperc (coventry, 2007) 	%calcperc (dudley, 2007) 	%calcperc (sandwell, 2007) 	%calcperc (solihull, 2007) 	%calcperc (walsall, 2007) 	%calcperc (wolverhampton, 2007) 	%calcperc (bradford, 2007) 	%calcperc (calderdale, 2007) 	%calcperc (kirklees, 2007) 	%calcperc (leeds, 2007) 	%calcperc (wakefield, 2007) 	%calcperc (gateshead, 2007) 	%calcperc (cityoflondon, 2007) 	%calcperc (barkinganddagenham, 2007) 	%calcperc (barnet, 2007) 	%calcperc (bexley, 2007) 	%calcperc (brent, 2007) 	%calcperc (bromley, 2007) 	%calcperc (camden, 2007) 	%calcperc (croydon, 2007) 	%calcperc (ealing, 2007) 	%calcperc (enfield, 2007) 	%calcperc (greenwich, 2007) 	%calcperc (hackney, 2007) 	%calcperc (hammersmithandfulham, 2007) 	%calcperc (haringey, 2007) 	%calcperc (harrow, 2007) 	%calcperc (havering, 2007) 	%calcperc (hillingdon, 2007) 	%calcperc (hounslow, 2007) 	%calcperc (islington, 2007) 	%calcperc (kensingtonandchelsea, 2007) 	%calcperc (kingstonuponthames, 2007) 	%calcperc (lambeth, 2007) 	%calcperc (lewisham, 2007) 	%calcperc (merton, 2007) 	%calcperc (newham, 2007) 	%calcperc (redbridge, 2007) 	%calcperc (richmonduponthames, 2007) 	%calcperc (southwark, 2007) 	%calcperc (sutton, 2007) 	%calcperc (towerhamlets, 2007) 	%calcperc (walthamforest, 2007) 	%calcperc (wandsworth, 2007) 	%calcperc (westminster, 2007) 	%calcperc (buckinghamshire, 2007) 	%calcperc (cambridgeshire, 2007) 	%calcperc (cumbria, 2007) 	%calcperc (derbyshire, 2007) 	%calcperc (devon, 2007) 	%calcperc (dorset, 2007) 	
%calcperc (eastsussex, 2007) 	%calcperc (essex, 2007) 	%calcperc (gloucestershire, 2007) 	%calcperc (hampshire, 2007) 	%calcperc (hertfordshire, 2007) 	%calcperc (kent, 2007) 	%calcperc (lancashire, 2007) 	%calcperc (leicestershire, 2007) 	%calcperc (lincolnshire, 2007) 	%calcperc (norfolk, 2007) 	%calcperc (northamptonshire, 2007) 	%calcperc (northyorkshire, 2007) 	%calcperc (nottinghamshire, 2007) 	%calcperc (oxfordshire, 2007) 	%calcperc (somerset, 2007) 	%calcperc (staffordshire, 2007) 	%calcperc (suffolk, 2007) 	%calcperc (surrey, 2007) 	%calcperc (warwickshire, 2007) 	%calcperc (westsussex, 2007) 	%calcperc (worcestershire, 2007) 	%calcperc (greatermanchester, 2007) 	%calcperc (merseyside, 2007) 	%calcperc (southyorkshire, 2007) 	%calcperc (westmidlands, 2007) 	%calcperc (westyorkshire, 2007) 	%calcperc (tyneandwear, 2007) 	%calcperc (antrimandnewtownabbey, 2007) 	%calcperc (armaghcitybanbridgeandcraigavon, 2007) 	%calcperc (belfast, 2007) 	%calcperc (causewaycoastandglens, 2007) 	%calcperc (derrycityandstrabane, 2007) 	%calcperc (fermanaghandomagh, 2007) 	%calcperc (lisburnandcastlereagh, 2007) 	%calcperc (midandeastantrim, 2007) 	%calcperc (midulster, 2007) 	%calcperc (newrymourneanddown, 2007) 	%calcperc (ardsandnorthdown, 2007) 	%calcperc (clackmannanshire, 2007) 	%calcperc (dumfriesandgalloway, 2007) 	%calcperc (eastayrshire, 2007) 	%calcperc (eastlothian, 2007) 	%calcperc (eastrenfrewshire, 2007) 	%calcperc (naheileanansiar, 2007) 	%calcperc (falkirk, 2007) 	%calcperc (fife, 2007) 	%calcperc (highland, 2007) 	%calcperc (inverclyde, 2007) 	%calcperc (midlothian, 2007) 	%calcperc (moray, 2007) 	%calcperc (northayrshire, 2007) 	%calcperc (orkneyislands, 2007) 	%calcperc (perthandkinross, 2007) 	%calcperc (scottishborders, 2007) 	%calcperc (shetlandislands, 2007) 	%calcperc (southayrshire, 2007) 	%calcperc (southlanarkshire, 2007) 	%calcperc (stirling, 2007) 	%calcperc (aberdeencity, 2007) 	%calcperc (aberdeenshire, 2007) 	%calcperc (argyllandbute, 2007) 	%calcperc (cityofedinburgh, 2007) 	%calcperc (renfrewshire, 2007) 	%calcperc (westdunbartonshire, 2007) 	%calcperc (westlothian, 2007) 	%calcperc (angus, 2007) 	%calcperc (dundeecity, 2007) 	%calcperc (northlanarkshire, 2007) 	%calcperc (eastdunbartonshire, 2007) 	%calcperc (glasgowcity, 2007) 	%calcperc (isleofanglesey, 2007) 	%calcperc (gwynedd, 2007) 	%calcperc (conwy, 2007) 	%calcperc (denbighshire, 2007) 	%calcperc (flintshire, 2007) 	%calcperc (wrexham, 2007) 	%calcperc (ceredigion, 2007) 	%calcperc (pembrokeshire, 2007) 	%calcperc (carmarthenshire, 2007) 	%calcperc (swansea, 2007) 	%calcperc (neathporttalbot, 2007) 	%calcperc (bridgend, 2007) 	%calcperc (valeofglamorgan, 2007) 	%calcperc (cardiff, 2007) 	%calcperc (rhonddacynontaf, 2007) 	%calcperc (caerphilly, 2007) 	%calcperc (blaenaugwent, 2007) 	%calcperc (torfaen, 2007) 	%calcperc (monmouthshire, 2007) 	%calcperc (newport, 2007) 	%calcperc (powys, 2007) 	%calcperc (merthyrtydfil, 2007) 	%calcperc (northeast, 2007) 	%calcperc (northwest, 2007) 	%calcperc (yorkshireandhumber, 2007) 	%calcperc (eastmidlands, 2007) 	%calcperc (westmidlandsregion, 2007) 	%calcperc (east, 2007) 	%calcperc (london, 2007) 	%calcperc (southeast, 2007) 	
%calcperc (southwest, 2007) 
%calcperc (england, 2007) 	%calcperc (northernireland, 2007) 	%calcperc (scotland, 2007) 	%calcperc (wales, 2007) 	%calcperc (englandandwales, 2007) 	%calcperc (greatbritian, 2007) 	%calcperc (unitedkingdom, 2007); 
%calcperc (hartlepool, 2008) 	%calcperc (middlesbrough, 2008) 	%calcperc (redcarandcleveland, 2008) 	%calcperc (stocktonontees, 2008) 	%calcperc (darlington, 2008) 	%calcperc (halton, 2008) 	%calcperc (warrington, 2008) 	%calcperc (blackburnwithdarwen, 2008) 	%calcperc (blackpool, 2008) 	%calcperc (kingstonuponhullcityof, 2008) 	%calcperc (eastridingofyorkshire, 2008) 	%calcperc (northeastlincolnshire, 2008) 	%calcperc (northlincolnshire, 2008) 	%calcperc (york, 2008) 	%calcperc (derby, 2008) 	%calcperc (leicester, 2008) 	%calcperc (rutland, 2008) 	%calcperc (nottingham, 2008) 	%calcperc (herefordshirecountyof, 2008) 	%calcperc (telfordandwrekin, 2008) 	%calcperc (stokeontrent, 2008) 	%calcperc (bathandnortheastsomerset, 2008) 	%calcperc (bristolcityof, 2008) 	%calcperc (northsomerset, 2008) 	%calcperc (southgloucestershire, 2008) 	%calcperc (plymouth, 2008) 	%calcperc (torbay, 2008) 	%calcperc (bournemouth, 2008) 	%calcperc (poole, 2008) 	%calcperc (swindon, 2008) 	%calcperc (peterborough, 2008) 	%calcperc (luton, 2008) 	%calcperc (southendonsea, 2008) 	%calcperc (thurrock, 2008) 	%calcperc (medway, 2008) 	%calcperc (bracknellforest, 2008) 	%calcperc (westberkshire, 2008) 	%calcperc (reading, 2008) 	%calcperc (slough, 2008) 	%calcperc (windsorandmaidenhead, 2008) 	%calcperc (wokingham, 2008) 	%calcperc (miltonkeynes, 2008) 	%calcperc (brightonandhove, 2008) 	%calcperc (portsmouth, 2008) 	%calcperc (southampton, 2008) 	%calcperc (isleofwight, 2008) 	%calcperc (countydurham, 2008) 	%calcperc (cheshireeast, 2008) 	%calcperc (cheshirewestandchester, 2008) 	%calcperc (shropshire, 2008) 	%calcperc (cornwall, 2008) 	%calcperc (islesofscilly, 2008) 	%calcperc (wiltshire, 2008) 	%calcperc (bedford, 2008) 	%calcperc (centralbedfordshire, 2008) 	%calcperc (northumberland, 2008) 	%calcperc (aylesburyvale, 2008) 	%calcperc (chiltern, 2008) 	%calcperc (southbucks, 2008) 	%calcperc (wycombe, 2008) 	%calcperc (cambridge, 2008) 	%calcperc (eastcambridgeshire, 2008) 	%calcperc (fenland, 2008) 	%calcperc (huntingdonshire, 2008) 	%calcperc (southcambridgeshire, 2008) 	%calcperc (allerdale, 2008) 	%calcperc (barrowinfurness, 2008) 	%calcperc (carlisle, 2008) 	%calcperc (copeland, 2008) 	%calcperc (eden, 2008) 	%calcperc (southlakeland, 2008) 	%calcperc (ambervalley, 2008) 	%calcperc (bolsover, 2008) 	%calcperc (chesterfield, 2008) 	%calcperc (derbyshiredales, 2008) 	%calcperc (erewash, 2008) 	%calcperc (highpeak, 2008) 	%calcperc (northeastderbyshire, 2008) 	%calcperc (southderbyshire, 2008) 	%calcperc (eastdevon, 2008) 	%calcperc (exeter, 2008) 	%calcperc (middevon, 2008) 	%calcperc (northdevon, 2008) 	%calcperc (southhams, 2008) 	%calcperc (teignbridge, 2008) 	%calcperc (torridge, 2008) 	%calcperc (westdevon, 2008) 	%calcperc (christchurch, 2008) 	%calcperc (eastdorset, 2008) 	%calcperc (northdorset, 2008) 	%calcperc (purbeck, 2008) 	%calcperc (westdorset, 2008) 	%calcperc (weymouthandportland, 2008) 	%calcperc (eastbourne, 2008) 	%calcperc (hastings, 2008) 	%calcperc (lewes, 2008) 	%calcperc (rother, 2008) 	%calcperc (wealden, 2008) 	%calcperc (basildon, 2008) 	%calcperc (braintree, 2008) 	%calcperc (brentwood, 2008) 	%calcperc (castlepoint, 2008) 	%calcperc (chelmsford, 2008) 
%calcperc (colchester, 2008) 	%calcperc (eppingforest, 2008) 	%calcperc (harlow, 2008) 	%calcperc (maldon, 2008) 	%calcperc (rochford, 2008) 	%calcperc (tendring, 2008) 	%calcperc (uttlesford, 2008) 	%calcperc (cheltenham, 2008) 	%calcperc (cotswold, 2008) 	%calcperc (forestofdean, 2008) 	%calcperc (gloucester, 2008) 	%calcperc (stroud, 2008) 	%calcperc (tewkesbury, 2008) 	%calcperc (basingstokeanddeane, 2008) 	%calcperc (easthampshire, 2008) 	%calcperc (eastleigh, 2008) 	%calcperc (fareham, 2008) 	%calcperc (gosport, 2008) 	%calcperc (hart, 2008) 	%calcperc (havant, 2008) 	%calcperc (newforest, 2008) 	%calcperc (rushmoor, 2008) 	%calcperc (testvalley, 2008) 	%calcperc (winchester, 2008) 	%calcperc (broxbourne, 2008) 	%calcperc (dacorum, 2008) 	%calcperc (hertsmere, 2008) 	%calcperc (northhertfordshire, 2008) 	%calcperc (threerivers, 2008) 	%calcperc (watford, 2008) 	%calcperc (ashford, 2008) 	%calcperc (canterbury, 2008) 	%calcperc (dartford, 2008) 	%calcperc (dover, 2008) 	%calcperc (gravesham, 2008) 	%calcperc (maidstone, 2008) 	%calcperc (sevenoaks, 2008) 	%calcperc (shepway, 2008) 	%calcperc (swale, 2008) 	%calcperc (thanet, 2008) 	%calcperc (tonbridgeandmalling, 2008) 	%calcperc (tunbridgewells, 2008) 	%calcperc (burnley, 2008) 	%calcperc (chorley, 2008) 	%calcperc (fylde, 2008) 	%calcperc (hyndburn, 2008) 	%calcperc (lancaster, 2008) 	%calcperc (pendle, 2008) 	%calcperc (preston, 2008) 	%calcperc (ribblevalley, 2008) 	%calcperc (rossendale, 2008) 	%calcperc (southribble, 2008) 	%calcperc (westlancashire, 2008) 	%calcperc (wyre, 2008) 	%calcperc (blaby, 2008) 	%calcperc (charnwood, 2008) 	%calcperc (harborough, 2008) 	%calcperc (hinckleyandbosworth, 2008) 	%calcperc (melton, 2008) 	%calcperc (northwestleicestershire, 2008) 	%calcperc (oadbyandwigston, 2008) 	%calcperc (boston, 2008) 	%calcperc (eastlindsey, 2008) 	%calcperc (lincoln, 2008) 	%calcperc (northkesteven, 2008) 	%calcperc (southholland, 2008) 	%calcperc (southkesteven, 2008) 	%calcperc (westlindsey, 2008) 	%calcperc (breckland, 2008) 	%calcperc (broadland, 2008) 	%calcperc (greatyarmouth, 2008) 	%calcperc (kingslynnandwestnorfolk, 2008) 	%calcperc (northnorfolk, 2008) 	%calcperc (norwich, 2008) 	%calcperc (southnorfolk, 2008) 	%calcperc (corby, 2008) 	%calcperc (daventry, 2008) 	%calcperc (eastnorthamptonshire, 2008) 	%calcperc (kettering, 2008) 	%calcperc (northampton, 2008) 	%calcperc (southnorthamptonshire, 2008) 	%calcperc (wellingborough, 2008) 	%calcperc (craven, 2008) 	%calcperc (hambleton, 2008) 	%calcperc (harrogate, 2008) 	%calcperc (richmondshire, 2008) 	%calcperc (ryedale, 2008) 	%calcperc (scarborough, 2008) 	%calcperc (selby, 2008) 	%calcperc (ashfield, 2008) 	%calcperc (bassetlaw, 2008) 	%calcperc (broxtowe, 2008) 	%calcperc (gedling, 2008) 	%calcperc (mansfield, 2008) 	%calcperc (newarkandsherwood, 2008) 	%calcperc (rushcliffe, 2008) 	%calcperc (cherwell, 2008) 	%calcperc (oxford, 2008) 	%calcperc (southoxfordshire, 2008) 	%calcperc (valeofwhitehorse, 2008) 	%calcperc (westoxfordshire, 2008) 	%calcperc (mendip, 2008) 	%calcperc (sedgemoor, 2008) 	%calcperc (southsomerset, 2008) 	%calcperc (tauntondeane, 2008) 	%calcperc (westsomerset, 2008) 	%calcperc (cannockchase, 2008) 
%calcperc (eaststaffordshire, 2008) 	%calcperc (lichfield, 2008) 	%calcperc (newcastleunderlyme, 2008) 	%calcperc (southstaffordshire, 2008) 	%calcperc (stafford, 2008) 	%calcperc (staffordshiremoorlands, 2008) 	%calcperc (tamworth, 2008) 	%calcperc (babergh, 2008) 	%calcperc (forestheath, 2008) 	%calcperc (ipswich, 2008) 	%calcperc (midsuffolk, 2008) 	%calcperc (stedmundsbury, 2008) 	%calcperc (suffolkcoastal, 2008) 	
%calcperc (waveney, 2008) 	%calcperc (elmbridge, 2008) 	%calcperc (epsomandewell, 2008) 	%calcperc (guildford, 2008) 	%calcperc (molevalley, 2008) 	%calcperc (reigateandbanstead, 2008) 	%calcperc (runnymede, 2008) 	%calcperc (spelthorne, 2008) 	%calcperc (surreyheath, 2008) 	%calcperc (tandridge, 2008) 	%calcperc (waverley, 2008) 	%calcperc (woking, 2008) 	%calcperc (northwarwickshire, 2008) 	%calcperc (nuneatonandbedworth, 2008) 	%calcperc (rugby, 2008) 	%calcperc (stratfordonavon, 2008) 	%calcperc (warwick, 2008) 	%calcperc (adur, 2008) 	%calcperc (arun, 2008) 	%calcperc (chichester, 2008) 	%calcperc (crawley, 2008) 	%calcperc (horsham, 2008) 	%calcperc (midsussex, 2008) 	%calcperc (worthing, 2008) 	%calcperc (bromsgrove, 2008) 	%calcperc (malvernhills, 2008) 	%calcperc (redditch, 2008) 	%calcperc (worcester, 2008) 	%calcperc (wychavon, 2008) 	%calcperc (wyreforest, 2008) 	%calcperc (stalbans, 2008) 	%calcperc (welwynhatfield, 2008) 	%calcperc (easthertfordshire, 2008) 	%calcperc (stevenage, 2008) 	%calcperc (bolton, 2008) 	%calcperc (bury, 2008) 	%calcperc (manchester, 2008) 	%calcperc (oldham, 2008) 	%calcperc (rochdale, 2008) 	%calcperc (salford, 2008) 	%calcperc (stockport, 2008) 	%calcperc (tameside, 2008) 	%calcperc (trafford, 2008) 	%calcperc (wigan, 2008) 	%calcperc (knowsley, 2008) 	%calcperc (liverpool, 2008) 	%calcperc (sthelens, 2008) 	%calcperc (sefton, 2008) 	%calcperc (wirral, 2008) 	%calcperc (barnsley, 2008) 	%calcperc (doncaster, 2008) 	%calcperc (rotherham, 2008) 	%calcperc (sheffield, 2008) 	%calcperc (newcastleupontyne, 2008) 	%calcperc (northtyneside, 2008) 	%calcperc (southtyneside, 2008) 	%calcperc (sunderland, 2008) 	%calcperc (birmingham, 2008) 	%calcperc (coventry, 2008) 	%calcperc (dudley, 2008) 	%calcperc (sandwell, 2008) 	%calcperc (solihull, 2008) 	%calcperc (walsall, 2008) 	%calcperc (wolverhampton, 2008) 	%calcperc (bradford, 2008) 	%calcperc (calderdale, 2008) 	%calcperc (kirklees, 2008) 	%calcperc (leeds, 2008) 	%calcperc (wakefield, 2008) 	%calcperc (gateshead, 2008) 	%calcperc (cityoflondon, 2008) 	%calcperc (barkinganddagenham, 2008) 	%calcperc (barnet, 2008) 	%calcperc (bexley, 2008) 	%calcperc (brent, 2008) 	%calcperc (bromley, 2008) 	%calcperc (camden, 2008) 	%calcperc (croydon, 2008) 	%calcperc (ealing, 2008) 	%calcperc (enfield, 2008) 	%calcperc (greenwich, 2008) 	%calcperc (hackney, 2008) 	%calcperc (hammersmithandfulham, 2008) 	%calcperc (haringey, 2008) 	%calcperc (harrow, 2008) 	%calcperc (havering, 2008) 	%calcperc (hillingdon, 2008) 	%calcperc (hounslow, 2008) 	%calcperc (islington, 2008) 	%calcperc (kensingtonandchelsea, 2008) 	%calcperc (kingstonuponthames, 2008) 	%calcperc (lambeth, 2008) 	%calcperc (lewisham, 2008) 	%calcperc (merton, 2008) 	%calcperc (newham, 2008) 	%calcperc (redbridge, 2008) 	%calcperc (richmonduponthames, 2008) 	%calcperc (southwark, 2008) 	%calcperc (sutton, 2008) 	%calcperc (towerhamlets, 2008) 	%calcperc (walthamforest, 2008) 	%calcperc (wandsworth, 2008) 	%calcperc (westminster, 2008) 	%calcperc (buckinghamshire, 2008) 	%calcperc (cambridgeshire, 2008) 	%calcperc (cumbria, 2008) 	%calcperc (derbyshire, 2008) 	%calcperc (devon, 2008) 	%calcperc (dorset, 2008) 	
%calcperc (eastsussex, 2008) 	%calcperc (essex, 2008) 	%calcperc (gloucestershire, 2008) 	%calcperc (hampshire, 2008) 	%calcperc (hertfordshire, 2008) 	%calcperc (kent, 2008) 	%calcperc (lancashire, 2008) 	%calcperc (leicestershire, 2008) 	%calcperc (lincolnshire, 2008) 	%calcperc (norfolk, 2008) 	%calcperc (northamptonshire, 2008) 	%calcperc (northyorkshire, 2008) 	%calcperc (nottinghamshire, 2008) 	%calcperc (oxfordshire, 2008) 	%calcperc (somerset, 2008) 	%calcperc (staffordshire, 2008) 	%calcperc (suffolk, 2008) 	%calcperc (surrey, 2008) 	%calcperc (warwickshire, 2008) 	%calcperc (westsussex, 2008) 	%calcperc (worcestershire, 2008) 	%calcperc (greatermanchester, 2008) 	%calcperc (merseyside, 2008) 	%calcperc (southyorkshire, 2008) 	%calcperc (westmidlands, 2008) 	%calcperc (westyorkshire, 2008) 	%calcperc (tyneandwear, 2008) 	%calcperc (antrimandnewtownabbey, 2008) 	%calcperc (armaghcitybanbridgeandcraigavon, 2008) 	%calcperc (belfast, 2008) 	%calcperc (causewaycoastandglens, 2008) 	%calcperc (derrycityandstrabane, 2008) 	%calcperc (fermanaghandomagh, 2008) 	%calcperc (lisburnandcastlereagh, 2008) 	%calcperc (midandeastantrim, 2008) 	%calcperc (midulster, 2008) 	%calcperc (newrymourneanddown, 2008) 	%calcperc (ardsandnorthdown, 2008) 	%calcperc (clackmannanshire, 2008) 	%calcperc (dumfriesandgalloway, 2008) 	%calcperc (eastayrshire, 2008) 	%calcperc (eastlothian, 2008) 	%calcperc (eastrenfrewshire, 2008) 	%calcperc (naheileanansiar, 2008) 	%calcperc (falkirk, 2008) 	%calcperc (fife, 2008) 	%calcperc (highland, 2008) 	%calcperc (inverclyde, 2008) 	%calcperc (midlothian, 2008) 	%calcperc (moray, 2008) 	%calcperc (northayrshire, 2008) 	%calcperc (orkneyislands, 2008) 	%calcperc (perthandkinross, 2008) 	%calcperc (scottishborders, 2008) 	%calcperc (shetlandislands, 2008) 	%calcperc (southayrshire, 2008) 	%calcperc (southlanarkshire, 2008) 	%calcperc (stirling, 2008) 	%calcperc (aberdeencity, 2008) 	%calcperc (aberdeenshire, 2008) 	%calcperc (argyllandbute, 2008) 	%calcperc (cityofedinburgh, 2008) 	%calcperc (renfrewshire, 2008) 	%calcperc (westdunbartonshire, 2008) 	%calcperc (westlothian, 2008) 	%calcperc (angus, 2008) 	%calcperc (dundeecity, 2008) 	%calcperc (northlanarkshire, 2008) 	%calcperc (eastdunbartonshire, 2008) 	%calcperc (glasgowcity, 2008) 	%calcperc (isleofanglesey, 2008) 	%calcperc (gwynedd, 2008) 	%calcperc (conwy, 2008) 	%calcperc (denbighshire, 2008) 	%calcperc (flintshire, 2008) 	%calcperc (wrexham, 2008) 	%calcperc (ceredigion, 2008) 	%calcperc (pembrokeshire, 2008) 	%calcperc (carmarthenshire, 2008) 	%calcperc (swansea, 2008) 	%calcperc (neathporttalbot, 2008) 	%calcperc (bridgend, 2008) 	%calcperc (valeofglamorgan, 2008) 	%calcperc (cardiff, 2008) 	%calcperc (rhonddacynontaf, 2008) 	%calcperc (caerphilly, 2008) 	%calcperc (blaenaugwent, 2008) 	%calcperc (torfaen, 2008) 	%calcperc (monmouthshire, 2008) 	%calcperc (newport, 2008) 	%calcperc (powys, 2008) 	%calcperc (merthyrtydfil, 2008) 	%calcperc (northeast, 2008) 	%calcperc (northwest, 2008) 	%calcperc (yorkshireandhumber, 2008) 	%calcperc (eastmidlands, 2008) 	%calcperc (westmidlandsregion, 2008) 	%calcperc (east, 2008) 	%calcperc (london, 2008) 	%calcperc (southeast, 2008) 	
%calcperc (southwest, 2008) 	%calcperc (england, 2008) 	%calcperc (northernireland, 2008) 	%calcperc (scotland, 2008) 	%calcperc (wales, 2008) 	%calcperc (englandandwales, 2008) 	%calcperc (greatbritian, 2008) 	%calcperc (unitedkingdom, 2008); 
%calcperc (hartlepool, 2009) 	%calcperc (middlesbrough, 2009) 	%calcperc (redcarandcleveland, 2009) 	%calcperc (stocktonontees, 2009) 	%calcperc (darlington, 2009) 	%calcperc (halton, 2009) 	%calcperc (warrington, 2009) 	%calcperc (blackburnwithdarwen, 2009) 	%calcperc (blackpool, 2009) 	%calcperc (kingstonuponhullcityof, 2009) 	%calcperc (eastridingofyorkshire, 2009) 	%calcperc (northeastlincolnshire, 2009) 	%calcperc (northlincolnshire, 2009) 	%calcperc (york, 2009) 	%calcperc (derby, 2009) 	%calcperc (leicester, 2009) 	%calcperc (rutland, 2009) 	%calcperc (nottingham, 2009) 	%calcperc (herefordshirecountyof, 2009) 	%calcperc (telfordandwrekin, 2009) 	%calcperc (stokeontrent, 2009) 	%calcperc (bathandnortheastsomerset, 2009) 	%calcperc (bristolcityof, 2009) 	%calcperc (northsomerset, 2009) 	%calcperc (southgloucestershire, 2009) 	%calcperc (plymouth, 2009) 	%calcperc (torbay, 2009) 	%calcperc (bournemouth, 2009) 	%calcperc (poole, 2009) 	%calcperc (swindon, 2009) 	%calcperc (peterborough, 2009) 	%calcperc (luton, 2009) 	%calcperc (southendonsea, 2009) 	%calcperc (thurrock, 2009) 	%calcperc (medway, 2009) 	%calcperc (bracknellforest, 2009) 	%calcperc (westberkshire, 2009) 	%calcperc (reading, 2009) 	%calcperc (slough, 2009) 	%calcperc (windsorandmaidenhead, 2009) 	%calcperc (wokingham, 2009) 	%calcperc (miltonkeynes, 2009) 	%calcperc (brightonandhove, 2009) 	%calcperc (portsmouth, 2009) 	%calcperc (southampton, 2009) 	%calcperc (isleofwight, 2009) 	%calcperc (countydurham, 2009) 	%calcperc (cheshireeast, 2009) 	%calcperc (cheshirewestandchester, 2009) 	%calcperc (shropshire, 2009) 	%calcperc (cornwall, 2009) 	%calcperc (islesofscilly, 2009) 	%calcperc (wiltshire, 2009) 	%calcperc (bedford, 2009) 	%calcperc (centralbedfordshire, 2009) 	%calcperc (northumberland, 2009) 	%calcperc (aylesburyvale, 2009) 	%calcperc (chiltern, 2009) 	%calcperc (southbucks, 2009) 	%calcperc (wycombe, 2009) 	%calcperc (cambridge, 2009) 	%calcperc (eastcambridgeshire, 2009) 	%calcperc (fenland, 2009) 	%calcperc (huntingdonshire, 2009) 	%calcperc (southcambridgeshire, 2009) 	%calcperc (allerdale, 2009) 	%calcperc (barrowinfurness, 2009) 	%calcperc (carlisle, 2009) 	%calcperc (copeland, 2009) 	%calcperc (eden, 2009) 	%calcperc (southlakeland, 2009) 	%calcperc (ambervalley, 2009) 	%calcperc (bolsover, 2009) 	%calcperc (chesterfield, 2009) 	%calcperc (derbyshiredales, 2009) 	%calcperc (erewash, 2009) 	%calcperc (highpeak, 2009) 	%calcperc (northeastderbyshire, 2009) 	%calcperc (southderbyshire, 2009) 	%calcperc (eastdevon, 2009) 	%calcperc (exeter, 2009) 	%calcperc (middevon, 2009) 	%calcperc (northdevon, 2009) 	%calcperc (southhams, 2009) 	%calcperc (teignbridge, 2009) 	%calcperc (torridge, 2009) 	%calcperc (westdevon, 2009) 	%calcperc (christchurch, 2009) 	%calcperc (eastdorset, 2009) 	%calcperc (northdorset, 2009) 	%calcperc (purbeck, 2009) 	%calcperc (westdorset, 2009) 	%calcperc (weymouthandportland, 2009) 	%calcperc (eastbourne, 2009) 	%calcperc (hastings, 2009) 	%calcperc (lewes, 2009) 	%calcperc (rother, 2009) 	%calcperc (wealden, 2009) 	%calcperc (basildon, 2009) 	%calcperc (braintree, 2009) 	%calcperc (brentwood, 2009) 	%calcperc (castlepoint, 2009) 	%calcperc (chelmsford, 2009) 	
%calcperc (colchester, 2009) 	%calcperc (eppingforest, 2009) 	%calcperc (harlow, 2009) 	%calcperc (maldon, 2009) 	%calcperc (rochford, 2009) 	%calcperc (tendring, 2009) 	%calcperc (uttlesford, 2009) 	%calcperc (cheltenham, 2009) 	%calcperc (cotswold, 2009) 	%calcperc (forestofdean, 2009) 	%calcperc (gloucester, 2009) 	%calcperc (stroud, 2009) 	%calcperc (tewkesbury, 2009) 	%calcperc (basingstokeanddeane, 2009) 	%calcperc (easthampshire, 2009) 	%calcperc (eastleigh, 2009) 	%calcperc (fareham, 2009) 	%calcperc (gosport, 2009) 	%calcperc (hart, 2009) 	%calcperc (havant, 2009) 	%calcperc (newforest, 2009) 	%calcperc (rushmoor, 2009) 	%calcperc (testvalley, 2009) 	%calcperc (winchester, 2009) 	%calcperc (broxbourne, 2009) 	%calcperc (dacorum, 2009) 	%calcperc (hertsmere, 2009) 	%calcperc (northhertfordshire, 2009) 	%calcperc (threerivers, 2009) 	%calcperc (watford, 2009) 	%calcperc (ashford, 2009) 	%calcperc (canterbury, 2009) 	%calcperc (dartford, 2009) 	%calcperc (dover, 2009) 	%calcperc (gravesham, 2009) 	%calcperc (maidstone, 2009) 	%calcperc (sevenoaks, 2009) 	%calcperc (shepway, 2009) 	%calcperc (swale, 2009) 	%calcperc (thanet, 2009) 	%calcperc (tonbridgeandmalling, 2009) 	%calcperc (tunbridgewells, 2009) 	%calcperc (burnley, 2009) 	%calcperc (chorley, 2009) 	%calcperc (fylde, 2009) 	%calcperc (hyndburn, 2009) 	%calcperc (lancaster, 2009) 	%calcperc (pendle, 2009) 	%calcperc (preston, 2009) 	%calcperc (ribblevalley, 2009) 	%calcperc (rossendale, 2009) 	%calcperc (southribble, 2009) 	%calcperc (westlancashire, 2009) 	%calcperc (wyre, 2009) 	%calcperc (blaby, 2009) 	%calcperc (charnwood, 2009) 	%calcperc (harborough, 2009) 	%calcperc (hinckleyandbosworth, 2009) 	%calcperc (melton, 2009) 	%calcperc (northwestleicestershire, 2009) 	%calcperc (oadbyandwigston, 2009) 	%calcperc (boston, 2009) 	%calcperc (eastlindsey, 2009) 	%calcperc (lincoln, 2009) 	%calcperc (northkesteven, 2009) 	%calcperc (southholland, 2009) 	%calcperc (southkesteven, 2009) 	%calcperc (westlindsey, 2009) 	%calcperc (breckland, 2009) 	%calcperc (broadland, 2009) 	%calcperc (greatyarmouth, 2009) 	%calcperc (kingslynnandwestnorfolk, 2009) 	%calcperc (northnorfolk, 2009) 	%calcperc (norwich, 2009) 	%calcperc (southnorfolk, 2009) 	%calcperc (corby, 2009) 	%calcperc (daventry, 2009) 	%calcperc (eastnorthamptonshire, 2009) 	%calcperc (kettering, 2009) 	%calcperc (northampton, 2009) 	%calcperc (southnorthamptonshire, 2009) 	%calcperc (wellingborough, 2009) 	%calcperc (craven, 2009) 	%calcperc (hambleton, 2009) 	%calcperc (harrogate, 2009) 	%calcperc (richmondshire, 2009) 	%calcperc (ryedale, 2009) 	%calcperc (scarborough, 2009) 	%calcperc (selby, 2009) 	%calcperc (ashfield, 2009) 	%calcperc (bassetlaw, 2009) 	%calcperc (broxtowe, 2009) 	%calcperc (gedling, 2009) 	%calcperc (mansfield, 2009) 	%calcperc (newarkandsherwood, 2009) 	%calcperc (rushcliffe, 2009) 	%calcperc (cherwell, 2009) 	%calcperc (oxford, 2009) 	%calcperc (southoxfordshire, 2009) 	%calcperc (valeofwhitehorse, 2009) 	%calcperc (westoxfordshire, 2009) 	%calcperc (mendip, 2009) 	%calcperc (sedgemoor, 2009) 	%calcperc (southsomerset, 2009) 	%calcperc (tauntondeane, 2009) 	%calcperc (westsomerset, 2009) 	%calcperc (cannockchase, 2009) 	
%calcperc (eaststaffordshire, 2009) 	%calcperc (lichfield, 2009) 	%calcperc (newcastleunderlyme, 2009) 	%calcperc (southstaffordshire, 2009) 	%calcperc (stafford, 2009) 	%calcperc (staffordshiremoorlands, 2009) 	%calcperc (tamworth, 2009) 	%calcperc (babergh, 2009) 	%calcperc (forestheath, 2009) 	%calcperc (ipswich, 2009) 	%calcperc (midsuffolk, 2009) 	%calcperc (stedmundsbury, 2009) 	%calcperc (suffolkcoastal, 2009) 	
%calcperc (waveney, 2009) 	%calcperc (elmbridge, 2009) 	%calcperc (epsomandewell, 2009) 	%calcperc (guildford, 2009) 	%calcperc (molevalley, 2009) 	%calcperc (reigateandbanstead, 2009) 	%calcperc (runnymede, 2009) 	%calcperc (spelthorne, 2009) 	%calcperc (surreyheath, 2009) 	%calcperc (tandridge, 2009) 	%calcperc (waverley, 2009) 	%calcperc (woking, 2009) 	%calcperc (northwarwickshire, 2009) 	%calcperc (nuneatonandbedworth, 2009) 	%calcperc (rugby, 2009) 	%calcperc (stratfordonavon, 2009) 	%calcperc (warwick, 2009) 	%calcperc (adur, 2009) 	%calcperc (arun, 2009) 	%calcperc (chichester, 2009) 	%calcperc (crawley, 2009) 	%calcperc (horsham, 2009) 	%calcperc (midsussex, 2009) 	%calcperc (worthing, 2009) 	%calcperc (bromsgrove, 2009) 	%calcperc (malvernhills, 2009) 	%calcperc (redditch, 2009) 	%calcperc (worcester, 2009) 	%calcperc (wychavon, 2009) 	%calcperc (wyreforest, 2009) 	%calcperc (stalbans, 2009) 	%calcperc (welwynhatfield, 2009) 	%calcperc (easthertfordshire, 2009) 	%calcperc (stevenage, 2009) 	%calcperc (bolton, 2009) 	%calcperc (bury, 2009) 	%calcperc (manchester, 2009) 	%calcperc (oldham, 2009) 	%calcperc (rochdale, 2009) 	%calcperc (salford, 2009) 	%calcperc (stockport, 2009) 	%calcperc (tameside, 2009) 	%calcperc (trafford, 2009) 	%calcperc (wigan, 2009) 	%calcperc (knowsley, 2009) 	%calcperc (liverpool, 2009) 	%calcperc (sthelens, 2009) 	%calcperc (sefton, 2009) 	%calcperc (wirral, 2009) 	%calcperc (barnsley, 2009) 	%calcperc (doncaster, 2009) 	%calcperc (rotherham, 2009) 	%calcperc (sheffield, 2009) 	%calcperc (newcastleupontyne, 2009) 	%calcperc (northtyneside, 2009) 	%calcperc (southtyneside, 2009) 	%calcperc (sunderland, 2009) 	%calcperc (birmingham, 2009) 	%calcperc (coventry, 2009) 	%calcperc (dudley, 2009) 	%calcperc (sandwell, 2009) 	%calcperc (solihull, 2009) 	%calcperc (walsall, 2009) 	%calcperc (wolverhampton, 2009) 	%calcperc (bradford, 2009) 	%calcperc (calderdale, 2009) 	%calcperc (kirklees, 2009) 	%calcperc (leeds, 2009) 	%calcperc (wakefield, 2009) 	%calcperc (gateshead, 2009) 	%calcperc (cityoflondon, 2009) 	%calcperc (barkinganddagenham, 2009) 	%calcperc (barnet, 2009) 	%calcperc (bexley, 2009) 	%calcperc (brent, 2009) 	%calcperc (bromley, 2009) 	%calcperc (camden, 2009) 	%calcperc (croydon, 2009) 	%calcperc (ealing, 2009) 	%calcperc (enfield, 2009) 	%calcperc (greenwich, 2009) 	%calcperc (hackney, 2009) 	%calcperc (hammersmithandfulham, 2009) 	%calcperc (haringey, 2009) 	%calcperc (harrow, 2009) 	%calcperc (havering, 2009) 	%calcperc (hillingdon, 2009) 	%calcperc (hounslow, 2009) 	%calcperc (islington, 2009) 	%calcperc (kensingtonandchelsea, 2009) 	%calcperc (kingstonuponthames, 2009) 	%calcperc (lambeth, 2009) 	%calcperc (lewisham, 2009) 	%calcperc (merton, 2009) 	%calcperc (newham, 2009) 	%calcperc (redbridge, 2009) 	%calcperc (richmonduponthames, 2009) 	%calcperc (southwark, 2009) 	%calcperc (sutton, 2009) 	%calcperc (towerhamlets, 2009) 	%calcperc (walthamforest, 2009) 	%calcperc (wandsworth, 2009) 	%calcperc (westminster, 2009) 	%calcperc (buckinghamshire, 2009) 	%calcperc (cambridgeshire, 2009) 	%calcperc (cumbria, 2009) 	%calcperc (derbyshire, 2009) 	%calcperc (devon, 2009) 	%calcperc (dorset, 2009) 	
%calcperc (eastsussex, 2009) 	%calcperc (essex, 2009) 	%calcperc (gloucestershire, 2009) 	%calcperc (hampshire, 2009) 	%calcperc (hertfordshire, 2009) 	%calcperc (kent, 2009) 	%calcperc (lancashire, 2009) 	%calcperc (leicestershire, 2009) 	%calcperc (lincolnshire, 2009) 	%calcperc (norfolk, 2009) 	%calcperc (northamptonshire, 2009) 	%calcperc (northyorkshire, 2009) 	%calcperc (nottinghamshire, 2009) 	%calcperc (oxfordshire, 2009) 	%calcperc (somerset, 2009) 	%calcperc (staffordshire, 2009) 	%calcperc (suffolk, 2009) 	%calcperc (surrey, 2009) 	%calcperc (warwickshire, 2009) 	%calcperc (westsussex, 2009) 	%calcperc (worcestershire, 2009) 	%calcperc (greatermanchester, 2009) 	%calcperc (merseyside, 2009) 	%calcperc (southyorkshire, 2009) 	%calcperc (westmidlands, 2009) 	%calcperc (westyorkshire, 2009) 	%calcperc (tyneandwear, 2009) 	%calcperc (antrimandnewtownabbey, 2009) 	%calcperc (armaghcitybanbridgeandcraigavon, 2009) 	%calcperc (belfast, 2009) 	%calcperc (causewaycoastandglens, 2009) 	%calcperc (derrycityandstrabane, 2009) 	%calcperc (fermanaghandomagh, 2009) 	%calcperc (lisburnandcastlereagh, 2009) 	%calcperc (midandeastantrim, 2009) 	%calcperc (midulster, 2009) 	%calcperc (newrymourneanddown, 2009) 	%calcperc (ardsandnorthdown, 2009) 	%calcperc (clackmannanshire, 2009) 	%calcperc (dumfriesandgalloway, 2009) 	%calcperc (eastayrshire, 2009) 	%calcperc (eastlothian, 2009) 	%calcperc (eastrenfrewshire, 2009) 	%calcperc (naheileanansiar, 2009) 	%calcperc (falkirk, 2009) 	%calcperc (fife, 2009) 	%calcperc (highland, 2009) 	%calcperc (inverclyde, 2009) 	%calcperc (midlothian, 2009) 	%calcperc (moray, 2009) 	%calcperc (northayrshire, 2009) 	%calcperc (orkneyislands, 2009) 	%calcperc (perthandkinross, 2009) 	%calcperc (scottishborders, 2009) 	%calcperc (shetlandislands, 2009) 	%calcperc (southayrshire, 2009) 	%calcperc (southlanarkshire, 2009) 	%calcperc (stirling, 2009) 	%calcperc (aberdeencity, 2009) 	%calcperc (aberdeenshire, 2009) 	%calcperc (argyllandbute, 2009) 	%calcperc (cityofedinburgh, 2009) 	%calcperc (renfrewshire, 2009) 	%calcperc (westdunbartonshire, 2009) 	%calcperc (westlothian, 2009) 	%calcperc (angus, 2009) 	%calcperc (dundeecity, 2009) 	%calcperc (northlanarkshire, 2009) 	%calcperc (eastdunbartonshire, 2009) 	%calcperc (glasgowcity, 2009) 	%calcperc (isleofanglesey, 2009) 	%calcperc (gwynedd, 2009) 	%calcperc (conwy, 2009) 	%calcperc (denbighshire, 2009) 	%calcperc (flintshire, 2009) 	%calcperc (wrexham, 2009) 	%calcperc (ceredigion, 2009) 	%calcperc (pembrokeshire, 2009) 	%calcperc (carmarthenshire, 2009) 	%calcperc (swansea, 2009) 	%calcperc (neathporttalbot, 2009) 	%calcperc (bridgend, 2009) 	%calcperc (valeofglamorgan, 2009) 	%calcperc (cardiff, 2009) 	%calcperc (rhonddacynontaf, 2009) 	%calcperc (caerphilly, 2009) 	%calcperc (blaenaugwent, 2009) 	%calcperc (torfaen, 2009) 	%calcperc (monmouthshire, 2009) 	%calcperc (newport, 2009) 	%calcperc (powys, 2009) 	%calcperc (merthyrtydfil, 2009) %calcperc (northeast, 2009) 	%calcperc (northwest, 2009) 	%calcperc (yorkshireandhumber, 2009) 	%calcperc (eastmidlands, 2009) 	%calcperc (westmidlandsregion, 2009) 	%calcperc (east, 2009) 	%calcperc (london, 2009) 	%calcperc (southeast, 2009) 	%calcperc (southwest, 2009) 
%calcperc (england, 2009) 	%calcperc (northernireland, 2009) 	%calcperc (scotland, 2009) 	%calcperc (wales, 2009) 	%calcperc (englandandwales, 2009) 	%calcperc (greatbritian, 2009) 	%calcperc (unitedkingdom, 2009); 
%calcperc (hartlepool, 2010) 	%calcperc (middlesbrough, 2010) 	%calcperc (redcarandcleveland, 2010) 	%calcperc (stocktonontees, 2010) 	%calcperc (darlington, 2010) 	%calcperc (halton, 2010) 	%calcperc (warrington, 2010) 	%calcperc (blackburnwithdarwen, 2010) 	%calcperc (blackpool, 2010) 	%calcperc (kingstonuponhullcityof, 2010) 	%calcperc (eastridingofyorkshire, 2010) 	%calcperc (northeastlincolnshire, 2010) 	%calcperc (northlincolnshire, 2010) 	%calcperc (york, 2010) 	%calcperc (derby, 2010) 	%calcperc (leicester, 2010) 	%calcperc (rutland, 2010) 	%calcperc (nottingham, 2010) 	%calcperc (herefordshirecountyof, 2010) 	%calcperc (telfordandwrekin, 2010) 	%calcperc (stokeontrent, 2010) 	%calcperc (bathandnortheastsomerset, 2010) 	%calcperc (bristolcityof, 2010) 	%calcperc (northsomerset, 2010) 	%calcperc (southgloucestershire, 2010) 	%calcperc (plymouth, 2010) 	%calcperc (torbay, 2010) 	%calcperc (bournemouth, 2010) 	%calcperc (poole, 2010) 	%calcperc (swindon, 2010) 	%calcperc (peterborough, 2010) 	%calcperc (luton, 2010) 	%calcperc (southendonsea, 2010) 	%calcperc (thurrock, 2010) 	%calcperc (medway, 2010) 	%calcperc (bracknellforest, 2010) 	%calcperc (westberkshire, 2010) 	%calcperc (reading, 2010) 	%calcperc (slough, 2010) 	%calcperc (windsorandmaidenhead, 2010) 	%calcperc (wokingham, 2010) 	%calcperc (miltonkeynes, 2010) 	%calcperc (brightonandhove, 2010) 	%calcperc (portsmouth, 2010) 	%calcperc (southampton, 2010) 	%calcperc (isleofwight, 2010) 	%calcperc (countydurham, 2010) 	%calcperc (cheshireeast, 2010) 	%calcperc (cheshirewestandchester, 2010) 	%calcperc (shropshire, 2010) 	%calcperc (cornwall, 2010) 	%calcperc (islesofscilly, 2010) 	%calcperc (wiltshire, 2010) 	%calcperc (bedford, 2010) 	%calcperc (centralbedfordshire, 2010) 	%calcperc (northumberland, 2010) 	%calcperc (aylesburyvale, 2010) 	%calcperc (chiltern, 2010) 	%calcperc (southbucks, 2010) 	%calcperc (wycombe, 2010) 	%calcperc (cambridge, 2010) 	%calcperc (eastcambridgeshire, 2010) 	%calcperc (fenland, 2010) 	%calcperc (huntingdonshire, 2010) 	%calcperc (southcambridgeshire, 2010) 	%calcperc (allerdale, 2010) 	%calcperc (barrowinfurness, 2010) 	%calcperc (carlisle, 2010) 	%calcperc (copeland, 2010) 	%calcperc (eden, 2010) 	%calcperc (southlakeland, 2010) 	%calcperc (ambervalley, 2010) 	%calcperc (bolsover, 2010) 	%calcperc (chesterfield, 2010) 	%calcperc (derbyshiredales, 2010) 	%calcperc (erewash, 2010) 	%calcperc (highpeak, 2010) 	%calcperc (northeastderbyshire, 2010) 	%calcperc (southderbyshire, 2010) 	%calcperc (eastdevon, 2010) 	%calcperc (exeter, 2010) 	%calcperc (middevon, 2010) 	%calcperc (northdevon, 2010) 	%calcperc (southhams, 2010) 	%calcperc (teignbridge, 2010) 	%calcperc (torridge, 2010) 	%calcperc (westdevon, 2010) 	%calcperc (christchurch, 2010) 	%calcperc (eastdorset, 2010) 	%calcperc (northdorset, 2010) 	%calcperc (purbeck, 2010) 	%calcperc (westdorset, 2010) 	%calcperc (weymouthandportland, 2010) 	%calcperc (eastbourne, 2010) 	%calcperc (hastings, 2010) 	%calcperc (lewes, 2010) 	%calcperc (rother, 2010) 	%calcperc (wealden, 2010) 	%calcperc (basildon, 2010) 	%calcperc (braintree, 2010) 	%calcperc (brentwood, 2010) 	%calcperc (castlepoint, 2010) 	%calcperc (chelmsford, 2010) 	
%calcperc (colchester, 2010) 	%calcperc (eppingforest, 2010) 	%calcperc (harlow, 2010) 	%calcperc (maldon, 2010) 	%calcperc (rochford, 2010) 	%calcperc (tendring, 2010) 	%calcperc (uttlesford, 2010) 	%calcperc (cheltenham, 2010) 	%calcperc (cotswold, 2010) 	%calcperc (forestofdean, 2010) 	%calcperc (gloucester, 2010) 	%calcperc (stroud, 2010) 	%calcperc (tewkesbury, 2010) 	%calcperc (basingstokeanddeane, 2010) 	%calcperc (easthampshire, 2010) 	%calcperc (eastleigh, 2010) 	%calcperc (fareham, 2010) 	%calcperc (gosport, 2010) 	%calcperc (hart, 2010) 	%calcperc (havant, 2010) 	%calcperc (newforest, 2010) 	%calcperc (rushmoor, 2010) 	%calcperc (testvalley, 2010) 	%calcperc (winchester, 2010) 	%calcperc (broxbourne, 2010) 	%calcperc (dacorum, 2010) 	%calcperc (hertsmere, 2010) 	%calcperc (northhertfordshire, 2010) 	%calcperc (threerivers, 2010) 	%calcperc (watford, 2010) 	%calcperc (ashford, 2010) 	%calcperc (canterbury, 2010) 	%calcperc (dartford, 2010) 	%calcperc (dover, 2010) 	%calcperc (gravesham, 2010) 	%calcperc (maidstone, 2010) 	%calcperc (sevenoaks, 2010) 	%calcperc (shepway, 2010) 	%calcperc (swale, 2010) 	%calcperc (thanet, 2010) 	%calcperc (tonbridgeandmalling, 2010) 	%calcperc (tunbridgewells, 2010) 	%calcperc (burnley, 2010) 	%calcperc (chorley, 2010) 	%calcperc (fylde, 2010) 	%calcperc (hyndburn, 2010) 	%calcperc (lancaster, 2010) 	%calcperc (pendle, 2010) 	%calcperc (preston, 2010) 	%calcperc (ribblevalley, 2010) 	%calcperc (rossendale, 2010) 	%calcperc (southribble, 2010) 	%calcperc (westlancashire, 2010) 	%calcperc (wyre, 2010) 	%calcperc (blaby, 2010) 	%calcperc (charnwood, 2010) 	%calcperc (harborough, 2010) 	%calcperc (hinckleyandbosworth, 2010) 	%calcperc (melton, 2010) 	%calcperc (northwestleicestershire, 2010) 	%calcperc (oadbyandwigston, 2010) 	%calcperc (boston, 2010) 	%calcperc (eastlindsey, 2010) 	%calcperc (lincoln, 2010) 	%calcperc (northkesteven, 2010) 	%calcperc (southholland, 2010) 	%calcperc (southkesteven, 2010) 	%calcperc (westlindsey, 2010) 	%calcperc (breckland, 2010) 	%calcperc (broadland, 2010) 	%calcperc (greatyarmouth, 2010) 	%calcperc (kingslynnandwestnorfolk, 2010) 	%calcperc (northnorfolk, 2010) 	%calcperc (norwich, 2010) 	%calcperc (southnorfolk, 2010) 	%calcperc (corby, 2010) 	%calcperc (daventry, 2010) 	%calcperc (eastnorthamptonshire, 2010) 	%calcperc (kettering, 2010) 	%calcperc (northampton, 2010) 	%calcperc (southnorthamptonshire, 2010) 	%calcperc (wellingborough, 2010) 	%calcperc (craven, 2010) 	%calcperc (hambleton, 2010) 	%calcperc (harrogate, 2010) 	%calcperc (richmondshire, 2010) 	%calcperc (ryedale, 2010) 	%calcperc (scarborough, 2010) 	%calcperc (selby, 2010) 	%calcperc (ashfield, 2010) 	%calcperc (bassetlaw, 2010) 	%calcperc (broxtowe, 2010) 	%calcperc (gedling, 2010) 	%calcperc (mansfield, 2010) 	%calcperc (newarkandsherwood, 2010) 	%calcperc (rushcliffe, 2010) 	%calcperc (cherwell, 2010) 	%calcperc (oxford, 2010) 	%calcperc (southoxfordshire, 2010) 	%calcperc (valeofwhitehorse, 2010) 	%calcperc (westoxfordshire, 2010) 	%calcperc (mendip, 2010) 	%calcperc (sedgemoor, 2010) 	%calcperc (southsomerset, 2010) 	%calcperc (tauntondeane, 2010) 	%calcperc (westsomerset, 2010) 	%calcperc (cannockchase, 2010) 	
%calcperc (eaststaffordshire, 2010) 	%calcperc (lichfield, 2010) 	%calcperc (newcastleunderlyme, 2010) 	%calcperc (southstaffordshire, 2010) 	%calcperc (stafford, 2010) 	%calcperc (staffordshiremoorlands, 2010) 	%calcperc (tamworth, 2010) 	%calcperc (babergh, 2010) 	%calcperc (forestheath, 2010) 	%calcperc (ipswich, 2010) 	%calcperc (midsuffolk, 2010) 	%calcperc (stedmundsbury, 2010) 	%calcperc (suffolkcoastal, 2010) 	
%calcperc (waveney, 2010) 	%calcperc (elmbridge, 2010) 	%calcperc (epsomandewell, 2010) 	%calcperc (guildford, 2010) 	%calcperc (molevalley, 2010) 	%calcperc (reigateandbanstead, 2010) 	%calcperc (runnymede, 2010) 	%calcperc (spelthorne, 2010) 	%calcperc (surreyheath, 2010) 	%calcperc (tandridge, 2010) 	%calcperc (waverley, 2010) 	%calcperc (woking, 2010) 	%calcperc (northwarwickshire, 2010) 	%calcperc (nuneatonandbedworth, 2010) 	%calcperc (rugby, 2010) 	%calcperc (stratfordonavon, 2010) 	%calcperc (warwick, 2010) 	%calcperc (adur, 2010) 	%calcperc (arun, 2010) 	%calcperc (chichester, 2010) 	%calcperc (crawley, 2010) 	%calcperc (horsham, 2010) 	%calcperc (midsussex, 2010) 	%calcperc (worthing, 2010) 	%calcperc (bromsgrove, 2010) 	%calcperc (malvernhills, 2010) 	%calcperc (redditch, 2010) 	%calcperc (worcester, 2010) 	%calcperc (wychavon, 2010) 	%calcperc (wyreforest, 2010) 	%calcperc (stalbans, 2010) 	%calcperc (welwynhatfield, 2010) 	%calcperc (easthertfordshire, 2010) 	%calcperc (stevenage, 2010) 	%calcperc (bolton, 2010) 	%calcperc (bury, 2010) 	%calcperc (manchester, 2010) 	%calcperc (oldham, 2010) 	%calcperc (rochdale, 2010) 	%calcperc (salford, 2010) 	%calcperc (stockport, 2010) 	%calcperc (tameside, 2010) 	%calcperc (trafford, 2010) 	%calcperc (wigan, 2010) 	%calcperc (knowsley, 2010) 	%calcperc (liverpool, 2010) 	%calcperc (sthelens, 2010) 	%calcperc (sefton, 2010) 	%calcperc (wirral, 2010) 	%calcperc (barnsley, 2010) 	%calcperc (doncaster, 2010) 	%calcperc (rotherham, 2010) 	%calcperc (sheffield, 2010) 	%calcperc (newcastleupontyne, 2010) 	%calcperc (northtyneside, 2010) 	%calcperc (southtyneside, 2010) 	%calcperc (sunderland, 2010) 	%calcperc (birmingham, 2010) 	%calcperc (coventry, 2010) 	%calcperc (dudley, 2010) 	%calcperc (sandwell, 2010) 	%calcperc (solihull, 2010) 	%calcperc (walsall, 2010) 	%calcperc (wolverhampton, 2010) 	%calcperc (bradford, 2010) 	%calcperc (calderdale, 2010) 	%calcperc (kirklees, 2010) 	%calcperc (leeds, 2010) 	%calcperc (wakefield, 2010) 	%calcperc (gateshead, 2010) 	%calcperc (cityoflondon, 2010) 	%calcperc (barkinganddagenham, 2010) 	%calcperc (barnet, 2010) 	%calcperc (bexley, 2010) 	%calcperc (brent, 2010) 	%calcperc (bromley, 2010) 	%calcperc (camden, 2010) 	%calcperc (croydon, 2010) 	%calcperc (ealing, 2010) 	%calcperc (enfield, 2010) 	%calcperc (greenwich, 2010) 	%calcperc (hackney, 2010) 	%calcperc (hammersmithandfulham, 2010) 	%calcperc (haringey, 2010) 	%calcperc (harrow, 2010) 	%calcperc (havering, 2010) 	%calcperc (hillingdon, 2010) 	%calcperc (hounslow, 2010) 	%calcperc (islington, 2010) 	%calcperc (kensingtonandchelsea, 2010) 	%calcperc (kingstonuponthames, 2010) 	%calcperc (lambeth, 2010) 	%calcperc (lewisham, 2010) 	%calcperc (merton, 2010) 	%calcperc (newham, 2010) 	%calcperc (redbridge, 2010) 	%calcperc (richmonduponthames, 2010) 	%calcperc (southwark, 2010) 	%calcperc (sutton, 2010) 	%calcperc (towerhamlets, 2010) 	%calcperc (walthamforest, 2010) 	%calcperc (wandsworth, 2010) 	%calcperc (westminster, 2010) 	%calcperc (buckinghamshire, 2010) 	%calcperc (cambridgeshire, 2010) 	%calcperc (cumbria, 2010) 	%calcperc (derbyshire, 2010) 	%calcperc (devon, 2010) 	%calcperc (dorset, 2010) 	
%calcperc (eastsussex, 2010) 	%calcperc (essex, 2010) 	%calcperc (gloucestershire, 2010) 	%calcperc (hampshire, 2010) 	%calcperc (hertfordshire, 2010) 	%calcperc (kent, 2010) 	%calcperc (lancashire, 2010) 	%calcperc (leicestershire, 2010) 	%calcperc (lincolnshire, 2010) 	%calcperc (norfolk, 2010) 	%calcperc (northamptonshire, 2010) 	%calcperc (northyorkshire, 2010) 	%calcperc (nottinghamshire, 2010) 	%calcperc (oxfordshire, 2010) 	%calcperc (somerset, 2010) 	%calcperc (staffordshire, 2010) 	%calcperc (suffolk, 2010) 	%calcperc (surrey, 2010) 	%calcperc (warwickshire, 2010) 	%calcperc (westsussex, 2010) 	%calcperc (worcestershire, 2010) 	%calcperc (greatermanchester, 2010) 	%calcperc (merseyside, 2010) 	%calcperc (southyorkshire, 2010) 	%calcperc (westmidlands, 2010) 	%calcperc (westyorkshire, 2010) 	%calcperc (tyneandwear, 2010) 	%calcperc (antrimandnewtownabbey, 2010) 	%calcperc (armaghcitybanbridgeandcraigavon, 2010) 	%calcperc (belfast, 2010) 	%calcperc (causewaycoastandglens, 2010) 	%calcperc (derrycityandstrabane, 2010) 	%calcperc (fermanaghandomagh, 2010) 	%calcperc (lisburnandcastlereagh, 2010) 	%calcperc (midandeastantrim, 2010) 	%calcperc (midulster, 2010) 	%calcperc (newrymourneanddown, 2010) 	%calcperc (ardsandnorthdown, 2010) 	%calcperc (clackmannanshire, 2010) 	%calcperc (dumfriesandgalloway, 2010) 	%calcperc (eastayrshire, 2010) 	%calcperc (eastlothian, 2010) 	%calcperc (eastrenfrewshire, 2010) 	%calcperc (naheileanansiar, 2010) 	%calcperc (falkirk, 2010) 	%calcperc (fife, 2010) 	%calcperc (highland, 2010) 	%calcperc (inverclyde, 2010) 	%calcperc (midlothian, 2010) 	%calcperc (moray, 2010) 	%calcperc (northayrshire, 2010) 	%calcperc (orkneyislands, 2010) 	%calcperc (perthandkinross, 2010) 	%calcperc (scottishborders, 2010) 	%calcperc (shetlandislands, 2010) 	%calcperc (southayrshire, 2010) 	%calcperc (southlanarkshire, 2010) 	%calcperc (stirling, 2010) 	%calcperc (aberdeencity, 2010) 	%calcperc (aberdeenshire, 2010) 	%calcperc (argyllandbute, 2010) 	%calcperc (cityofedinburgh, 2010) 	%calcperc (renfrewshire, 2010) 	%calcperc (westdunbartonshire, 2010) 	%calcperc (westlothian, 2010) 	%calcperc (angus, 2010) 	%calcperc (dundeecity, 2010) 	%calcperc (northlanarkshire, 2010) 	%calcperc (eastdunbartonshire, 2010) 	%calcperc (glasgowcity, 2010) 	%calcperc (isleofanglesey, 2010) 	%calcperc (gwynedd, 2010) 	%calcperc (conwy, 2010) 	%calcperc (denbighshire, 2010) 	%calcperc (flintshire, 2010) 	%calcperc (wrexham, 2010) 	%calcperc (ceredigion, 2010) 	%calcperc (pembrokeshire, 2010) 	%calcperc (carmarthenshire, 2010) 	%calcperc (swansea, 2010) 	%calcperc (neathporttalbot, 2010) 	%calcperc (bridgend, 2010) 	%calcperc (valeofglamorgan, 2010) 	%calcperc (cardiff, 2010) 	%calcperc (rhonddacynontaf, 2010) 	%calcperc (caerphilly, 2010) 	%calcperc (blaenaugwent, 2010) 	%calcperc (torfaen, 2010) 	%calcperc (monmouthshire, 2010) 	%calcperc (newport, 2010) 	%calcperc (powys, 2010) 	%calcperc (merthyrtydfil, 2010) 	%calcperc (northeast, 2010) 	%calcperc (northwest, 2010) 	%calcperc (yorkshireandhumber, 2010) 	%calcperc (eastmidlands, 2010) 	%calcperc (westmidlandsregion, 2010) 	%calcperc (east, 2010) 	%calcperc (london, 2010) 	%calcperc (southeast, 2010) 	%calcperc (southwest, 2010) 	
%calcperc (england, 2010) 	%calcperc (northernireland, 2010) 	%calcperc (scotland, 2010) 	%calcperc (wales, 2010) 	%calcperc (englandandwales, 2010) 	%calcperc (greatbritian, 2010) 	%calcperc (unitedkingdom, 2010); 
%calcperc (hartlepool, 2011) 	%calcperc (middlesbrough, 2011) 	%calcperc (redcarandcleveland, 2011) 	%calcperc (stocktonontees, 2011) 	%calcperc (darlington, 2011) 	%calcperc (halton, 2011) 	%calcperc (warrington, 2011) 	%calcperc (blackburnwithdarwen, 2011) 	%calcperc (blackpool, 2011) 	%calcperc (kingstonuponhullcityof, 2011) 	%calcperc (eastridingofyorkshire, 2011) 	%calcperc (northeastlincolnshire, 2011) 	%calcperc (northlincolnshire, 2011) 	%calcperc (york, 2011) 	%calcperc (derby, 2011) 	%calcperc (leicester, 2011) 	%calcperc (rutland, 2011) 	%calcperc (nottingham, 2011) 	%calcperc (herefordshirecountyof, 2011) 	%calcperc (telfordandwrekin, 2011) 	%calcperc (stokeontrent, 2011) 	%calcperc (bathandnortheastsomerset, 2011) 	%calcperc (bristolcityof, 2011) 	%calcperc (northsomerset, 2011) 	%calcperc (southgloucestershire, 2011) 	%calcperc (plymouth, 2011) 	%calcperc (torbay, 2011) 	%calcperc (bournemouth, 2011) 	%calcperc (poole, 2011) 	%calcperc (swindon, 2011) 	%calcperc (peterborough, 2011) 	%calcperc (luton, 2011) 	%calcperc (southendonsea, 2011) 	%calcperc (thurrock, 2011) 	%calcperc (medway, 2011) 	%calcperc (bracknellforest, 2011) 	%calcperc (westberkshire, 2011) 	%calcperc (reading, 2011) 	%calcperc (slough, 2011) 	%calcperc (windsorandmaidenhead, 2011) 	%calcperc (wokingham, 2011) 	%calcperc (miltonkeynes, 2011) 	%calcperc (brightonandhove, 2011) 	%calcperc (portsmouth, 2011) 	%calcperc (southampton, 2011) 	%calcperc (isleofwight, 2011) 	%calcperc (countydurham, 2011) 	%calcperc (cheshireeast, 2011) 	%calcperc (cheshirewestandchester, 2011) 	%calcperc (shropshire, 2011) 	%calcperc (cornwall, 2011) 	%calcperc (islesofscilly, 2011) 	%calcperc (wiltshire, 2011) 	%calcperc (bedford, 2011) 	%calcperc (centralbedfordshire, 2011) 	%calcperc (northumberland, 2011) 	%calcperc (aylesburyvale, 2011) 	%calcperc (chiltern, 2011) 	%calcperc (southbucks, 2011) 	%calcperc (wycombe, 2011) 	%calcperc (cambridge, 2011) 	%calcperc (eastcambridgeshire, 2011) 	%calcperc (fenland, 2011) 	%calcperc (huntingdonshire, 2011) 	%calcperc (southcambridgeshire, 2011) 	%calcperc (allerdale, 2011) 	%calcperc (barrowinfurness, 2011) 	%calcperc (carlisle, 2011) 	%calcperc (copeland, 2011) 	%calcperc (eden, 2011) 	%calcperc (southlakeland, 2011) 	%calcperc (ambervalley, 2011) 	%calcperc (bolsover, 2011) 	%calcperc (chesterfield, 2011) 	%calcperc (derbyshiredales, 2011) 	%calcperc (erewash, 2011) 	%calcperc (highpeak, 2011) 	%calcperc (northeastderbyshire, 2011) 	%calcperc (southderbyshire, 2011) 	%calcperc (eastdevon, 2011) 	%calcperc (exeter, 2011) 	%calcperc (middevon, 2011) 	%calcperc (northdevon, 2011) 	%calcperc (southhams, 2011) 	%calcperc (teignbridge, 2011) 	%calcperc (torridge, 2011) 	%calcperc (westdevon, 2011) 	%calcperc (christchurch, 2011) 	%calcperc (eastdorset, 2011) 	%calcperc (northdorset, 2011) 	%calcperc (purbeck, 2011) 	%calcperc (westdorset, 2011) 	%calcperc (weymouthandportland, 2011) 	%calcperc (eastbourne, 2011) 	%calcperc (hastings, 2011) 	%calcperc (lewes, 2011) 	%calcperc (rother, 2011) 	%calcperc (wealden, 2011) 	%calcperc (basildon, 2011) 	%calcperc (braintree, 2011) 	%calcperc (brentwood, 2011) 	%calcperc (castlepoint, 2011) 	%calcperc (chelmsford, 2011) 	
%calcperc (colchester, 2011) 	%calcperc (eppingforest, 2011) 	%calcperc (harlow, 2011) 	%calcperc (maldon, 2011) 	%calcperc (rochford, 2011) 	%calcperc (tendring, 2011) 	%calcperc (uttlesford, 2011) 	%calcperc (cheltenham, 2011) 	%calcperc (cotswold, 2011) 	%calcperc (forestofdean, 2011) 	%calcperc (gloucester, 2011) 	%calcperc (stroud, 2011) 	%calcperc (tewkesbury, 2011) 	%calcperc (basingstokeanddeane, 2011) 	%calcperc (easthampshire, 2011) 	%calcperc (eastleigh, 2011) 	%calcperc (fareham, 2011) 	%calcperc (gosport, 2011) 	%calcperc (hart, 2011) 	%calcperc (havant, 2011) 	%calcperc (newforest, 2011) 	%calcperc (rushmoor, 2011) 	%calcperc (testvalley, 2011) 	%calcperc (winchester, 2011) 	%calcperc (broxbourne, 2011) 	%calcperc (dacorum, 2011) 	%calcperc (hertsmere, 2011) 	%calcperc (northhertfordshire, 2011) 	%calcperc (threerivers, 2011) 	%calcperc (watford, 2011) 	%calcperc (ashford, 2011) 	%calcperc (canterbury, 2011) 	%calcperc (dartford, 2011) 	%calcperc (dover, 2011) 	%calcperc (gravesham, 2011) 	%calcperc (maidstone, 2011) 	%calcperc (sevenoaks, 2011) 	%calcperc (shepway, 2011) 	%calcperc (swale, 2011) 	%calcperc (thanet, 2011) 	%calcperc (tonbridgeandmalling, 2011) 	%calcperc (tunbridgewells, 2011) 	%calcperc (burnley, 2011) 	%calcperc (chorley, 2011) 	%calcperc (fylde, 2011) 	%calcperc (hyndburn, 2011) 	%calcperc (lancaster, 2011) 	%calcperc (pendle, 2011) 	%calcperc (preston, 2011) 	%calcperc (ribblevalley, 2011) 	%calcperc (rossendale, 2011) 	%calcperc (southribble, 2011) 	%calcperc (westlancashire, 2011) 	%calcperc (wyre, 2011) 	%calcperc (blaby, 2011) 	%calcperc (charnwood, 2011) 	%calcperc (harborough, 2011) 	%calcperc (hinckleyandbosworth, 2011) 	%calcperc (melton, 2011) 	%calcperc (northwestleicestershire, 2011) 	%calcperc (oadbyandwigston, 2011) 	%calcperc (boston, 2011) 	%calcperc (eastlindsey, 2011) 	%calcperc (lincoln, 2011) 	%calcperc (northkesteven, 2011) 	%calcperc (southholland, 2011) 	%calcperc (southkesteven, 2011) 	%calcperc (westlindsey, 2011) 	%calcperc (breckland, 2011) 	%calcperc (broadland, 2011) 	%calcperc (greatyarmouth, 2011) 	%calcperc (kingslynnandwestnorfolk, 2011) 	%calcperc (northnorfolk, 2011) 	%calcperc (norwich, 2011) 	%calcperc (southnorfolk, 2011) 	%calcperc (corby, 2011) 	%calcperc (daventry, 2011) 	%calcperc (eastnorthamptonshire, 2011) 	%calcperc (kettering, 2011) 	%calcperc (northampton, 2011) 	%calcperc (southnorthamptonshire, 2011) 	%calcperc (wellingborough, 2011) 	%calcperc (craven, 2011) 	%calcperc (hambleton, 2011) 	%calcperc (harrogate, 2011) 	%calcperc (richmondshire, 2011) 	%calcperc (ryedale, 2011) 	%calcperc (scarborough, 2011) 	%calcperc (selby, 2011) 	%calcperc (ashfield, 2011) 	%calcperc (bassetlaw, 2011) 	%calcperc (broxtowe, 2011) 	%calcperc (gedling, 2011) 	%calcperc (mansfield, 2011) 	%calcperc (newarkandsherwood, 2011) 	%calcperc (rushcliffe, 2011) 	%calcperc (cherwell, 2011) 	%calcperc (oxford, 2011) 	%calcperc (southoxfordshire, 2011) 	%calcperc (valeofwhitehorse, 2011) 	%calcperc (westoxfordshire, 2011) 	%calcperc (mendip, 2011) 	%calcperc (sedgemoor, 2011) 	%calcperc (southsomerset, 2011) 	%calcperc (tauntondeane, 2011) 	%calcperc (westsomerset, 2011) 	%calcperc (cannockchase, 2011) 	
%calcperc (eaststaffordshire, 2011) 	%calcperc (lichfield, 2011) 	%calcperc (newcastleunderlyme, 2011) 	%calcperc (southstaffordshire, 2011) 	%calcperc (stafford, 2011) 	%calcperc (staffordshiremoorlands, 2011) 	%calcperc (tamworth, 2011) 	%calcperc (babergh, 2011) 	%calcperc (forestheath, 2011) 	%calcperc (ipswich, 2011) 	%calcperc (midsuffolk, 2011) 	%calcperc (stedmundsbury, 2011) 	%calcperc (suffolkcoastal, 2011) 	
%calcperc (waveney, 2011) 	%calcperc (elmbridge, 2011) 	%calcperc (epsomandewell, 2011) 	%calcperc (guildford, 2011) 	%calcperc (molevalley, 2011) 	%calcperc (reigateandbanstead, 2011) 	%calcperc (runnymede, 2011) 	%calcperc (spelthorne, 2011) 	%calcperc (surreyheath, 2011) 	%calcperc (tandridge, 2011) 	%calcperc (waverley, 2011) 	%calcperc (woking, 2011) 	%calcperc (northwarwickshire, 2011) 	%calcperc (nuneatonandbedworth, 2011) 	%calcperc (rugby, 2011) 	%calcperc (stratfordonavon, 2011) 	%calcperc (warwick, 2011) 	%calcperc (adur, 2011) 	%calcperc (arun, 2011) 	%calcperc (chichester, 2011) 	%calcperc (crawley, 2011) 	%calcperc (horsham, 2011) 	%calcperc (midsussex, 2011) 	%calcperc (worthing, 2011) 	%calcperc (bromsgrove, 2011) 	%calcperc (malvernhills, 2011) 	%calcperc (redditch, 2011) 	%calcperc (worcester, 2011) 	%calcperc (wychavon, 2011) 	%calcperc (wyreforest, 2011) 	%calcperc (stalbans, 2011) 	%calcperc (welwynhatfield, 2011) 	%calcperc (easthertfordshire, 2011) 	%calcperc (stevenage, 2011) 	%calcperc (bolton, 2011) 	%calcperc (bury, 2011) 	%calcperc (manchester, 2011) 	%calcperc (oldham, 2011) 	%calcperc (rochdale, 2011) 	%calcperc (salford, 2011) 	%calcperc (stockport, 2011) 	%calcperc (tameside, 2011) 	%calcperc (trafford, 2011) 	%calcperc (wigan, 2011) 	%calcperc (knowsley, 2011) 	%calcperc (liverpool, 2011) 	%calcperc (sthelens, 2011) 	%calcperc (sefton, 2011) 	%calcperc (wirral, 2011) 	%calcperc (barnsley, 2011) 	%calcperc (doncaster, 2011) 	%calcperc (rotherham, 2011) 	%calcperc (sheffield, 2011) 	%calcperc (newcastleupontyne, 2011) 	%calcperc (northtyneside, 2011) 	%calcperc (southtyneside, 2011) 	%calcperc (sunderland, 2011) 	%calcperc (birmingham, 2011) 	%calcperc (coventry, 2011) 	%calcperc (dudley, 2011) 	%calcperc (sandwell, 2011) 	%calcperc (solihull, 2011) 	%calcperc (walsall, 2011) 	%calcperc (wolverhampton, 2011) 	%calcperc (bradford, 2011) 	%calcperc (calderdale, 2011) 	%calcperc (kirklees, 2011) 	%calcperc (leeds, 2011) 	%calcperc (wakefield, 2011) 	%calcperc (gateshead, 2011) 	%calcperc (cityoflondon, 2011) 	%calcperc (barkinganddagenham, 2011) 	%calcperc (barnet, 2011) 	%calcperc (bexley, 2011) 	%calcperc (brent, 2011) 	%calcperc (bromley, 2011) 	%calcperc (camden, 2011) 	%calcperc (croydon, 2011) 	%calcperc (ealing, 2011) 	%calcperc (enfield, 2011) 	%calcperc (greenwich, 2011) 	%calcperc (hackney, 2011) 	%calcperc (hammersmithandfulham, 2011) 	%calcperc (haringey, 2011) 	%calcperc (harrow, 2011) 	%calcperc (havering, 2011) 	%calcperc (hillingdon, 2011) 	%calcperc (hounslow, 2011) 	%calcperc (islington, 2011) 	%calcperc (kensingtonandchelsea, 2011) 	%calcperc (kingstonuponthames, 2011) 	%calcperc (lambeth, 2011) 	%calcperc (lewisham, 2011) 	%calcperc (merton, 2011) 	%calcperc (newham, 2011) 	%calcperc (redbridge, 2011) 	%calcperc (richmonduponthames, 2011) 	%calcperc (southwark, 2011) 	%calcperc (sutton, 2011) 	%calcperc (towerhamlets, 2011) 	%calcperc (walthamforest, 2011) 	%calcperc (wandsworth, 2011) 	%calcperc (westminster, 2011) 	%calcperc (buckinghamshire, 2011) 	%calcperc (cambridgeshire, 2011) 	%calcperc (cumbria, 2011) 	%calcperc (derbyshire, 2011) 	%calcperc (devon, 2011) 	%calcperc (dorset, 2011) 	
%calcperc (eastsussex, 2011) 	%calcperc (essex, 2011) 	%calcperc (gloucestershire, 2011) 	%calcperc (hampshire, 2011) 	%calcperc (hertfordshire, 2011) 	%calcperc (kent, 2011) 	%calcperc (lancashire, 2011) 	%calcperc (leicestershire, 2011) 	%calcperc (lincolnshire, 2011) 	%calcperc (norfolk, 2011) 	%calcperc (northamptonshire, 2011) 	%calcperc (northyorkshire, 2011) 	%calcperc (nottinghamshire, 2011) 	%calcperc (oxfordshire, 2011) 	%calcperc (somerset, 2011) 	%calcperc (staffordshire, 2011) 	%calcperc (suffolk, 2011) 	%calcperc (surrey, 2011) 	%calcperc (warwickshire, 2011) 	%calcperc (westsussex, 2011) 	%calcperc (worcestershire, 2011) 	%calcperc (greatermanchester, 2011) 	%calcperc (merseyside, 2011) 	%calcperc (southyorkshire, 2011) 	%calcperc (westmidlands, 2011) 	%calcperc (westyorkshire, 2011) 	%calcperc (tyneandwear, 2011) 	%calcperc (antrimandnewtownabbey, 2011) 	%calcperc (armaghcitybanbridgeandcraigavon, 2011) 	%calcperc (belfast, 2011) 	%calcperc (causewaycoastandglens, 2011) 	%calcperc (derrycityandstrabane, 2011) 	%calcperc (fermanaghandomagh, 2011) 	%calcperc (lisburnandcastlereagh, 2011) 	%calcperc (midandeastantrim, 2011) 	%calcperc (midulster, 2011) 	%calcperc (newrymourneanddown, 2011) 	%calcperc (ardsandnorthdown, 2011) 	%calcperc (clackmannanshire, 2011) 	%calcperc (dumfriesandgalloway, 2011) 	%calcperc (eastayrshire, 2011) 	%calcperc (eastlothian, 2011) 	%calcperc (eastrenfrewshire, 2011) 	%calcperc (naheileanansiar, 2011) 	%calcperc (falkirk, 2011) 	%calcperc (fife, 2011) 	%calcperc (highland, 2011) 	%calcperc (inverclyde, 2011) 	%calcperc (midlothian, 2011) 	%calcperc (moray, 2011) 	%calcperc (northayrshire, 2011) 	%calcperc (orkneyislands, 2011) 	%calcperc (perthandkinross, 2011) 	%calcperc (scottishborders, 2011) 	%calcperc (shetlandislands, 2011) 	%calcperc (southayrshire, 2011) 	%calcperc (southlanarkshire, 2011) 	%calcperc (stirling, 2011) 	%calcperc (aberdeencity, 2011) 	%calcperc (aberdeenshire, 2011) 	%calcperc (argyllandbute, 2011) 	%calcperc (cityofedinburgh, 2011) 	%calcperc (renfrewshire, 2011) 	%calcperc (westdunbartonshire, 2011) 	%calcperc (westlothian, 2011) 	%calcperc (angus, 2011) 	%calcperc (dundeecity, 2011) 	%calcperc (northlanarkshire, 2011) 	%calcperc (eastdunbartonshire, 2011) 	%calcperc (glasgowcity, 2011) 	%calcperc (isleofanglesey, 2011) 	%calcperc (gwynedd, 2011) 	%calcperc (conwy, 2011) 	%calcperc (denbighshire, 2011) 	%calcperc (flintshire, 2011) 	%calcperc (wrexham, 2011) 	%calcperc (ceredigion, 2011) 	%calcperc (pembrokeshire, 2011) 	%calcperc (carmarthenshire, 2011) 	%calcperc (swansea, 2011) 	%calcperc (neathporttalbot, 2011) 	%calcperc (bridgend, 2011) 	%calcperc (valeofglamorgan, 2011) 	%calcperc (cardiff, 2011) 	%calcperc (rhonddacynontaf, 2011) 	%calcperc (caerphilly, 2011) 	%calcperc (blaenaugwent, 2011) 	%calcperc (torfaen, 2011) 	%calcperc (monmouthshire, 2011) 	%calcperc (newport, 2011) 	%calcperc (powys, 2011) 	%calcperc (merthyrtydfil, 2011) 	%calcperc (northeast, 2011) 	%calcperc (northwest, 2011) 	%calcperc (yorkshireandhumber, 2011) 	%calcperc (eastmidlands, 2011) 	%calcperc (westmidlandsregion, 2011) 	%calcperc (east, 2011) 	%calcperc (london, 2011) 	%calcperc (southeast, 2011) 	%calcperc (southwest, 2011) 	
%calcperc (england, 2011) 	%calcperc (northernireland, 2011) 	%calcperc (scotland, 2011) 	%calcperc (wales, 2011) 	%calcperc (englandandwales, 2011) 	%calcperc (greatbritian, 2011) 	%calcperc (unitedkingdom, 2011);
%calcperc (hartlepool, 2012) 	%calcperc (middlesbrough, 2012) 	%calcperc (redcarandcleveland, 2012) 	%calcperc (stocktonontees, 2012) 	%calcperc (darlington, 2012) 	%calcperc (halton, 2012) 	%calcperc (warrington, 2012) 	%calcperc (blackburnwithdarwen, 2012) 	%calcperc (blackpool, 2012) 	%calcperc (kingstonuponhullcityof, 2012) 	%calcperc (eastridingofyorkshire, 2012) 	%calcperc (northeastlincolnshire, 2012) 	%calcperc (northlincolnshire, 2012) 	%calcperc (york, 2012) 	%calcperc (derby, 2012) 	%calcperc (leicester, 2012) 	%calcperc (rutland, 2012) 	%calcperc (nottingham, 2012) 	%calcperc (herefordshirecountyof, 2012) 	%calcperc (telfordandwrekin, 2012) 	%calcperc (stokeontrent, 2012) 	%calcperc (bathandnortheastsomerset, 2012) 	%calcperc (bristolcityof, 2012) 	%calcperc (northsomerset, 2012) 	%calcperc (southgloucestershire, 2012) 	%calcperc (plymouth, 2012) 	%calcperc (torbay, 2012) 	%calcperc (bournemouth, 2012) 	%calcperc (poole, 2012) 	%calcperc (swindon, 2012) 	%calcperc (peterborough, 2012) 	%calcperc (luton, 2012) 	%calcperc (southendonsea, 2012) 	%calcperc (thurrock, 2012) 	%calcperc (medway, 2012) 	%calcperc (bracknellforest, 2012) 	%calcperc (westberkshire, 2012) 	%calcperc (reading, 2012) 	%calcperc (slough, 2012) 	%calcperc (windsorandmaidenhead, 2012) 	%calcperc (wokingham, 2012) 	%calcperc (miltonkeynes, 2012) 	%calcperc (brightonandhove, 2012) 	%calcperc (portsmouth, 2012) 	%calcperc (southampton, 2012) 	%calcperc (isleofwight, 2012) 	%calcperc (countydurham, 2012) 	%calcperc (cheshireeast, 2012) 	%calcperc (cheshirewestandchester, 2012) 	%calcperc (shropshire, 2012) 	%calcperc (cornwall, 2012) 	%calcperc (islesofscilly, 2012) 	%calcperc (wiltshire, 2012) 	%calcperc (bedford, 2012) 	%calcperc (centralbedfordshire, 2012) 	%calcperc (northumberland, 2012) 	%calcperc (aylesburyvale, 2012) 	%calcperc (chiltern, 2012) 	%calcperc (southbucks, 2012) 	%calcperc (wycombe, 2012) 	%calcperc (cambridge, 2012) 	%calcperc (eastcambridgeshire, 2012) 	%calcperc (fenland, 2012) 	%calcperc (huntingdonshire, 2012) 	%calcperc (southcambridgeshire, 2012) 	%calcperc (allerdale, 2012) 	%calcperc (barrowinfurness, 2012) 	%calcperc (carlisle, 2012) 	%calcperc (copeland, 2012) 	%calcperc (eden, 2012) 	%calcperc (southlakeland, 2012) 	%calcperc (ambervalley, 2012) 	%calcperc (bolsover, 2012) 	%calcperc (chesterfield, 2012) 	%calcperc (derbyshiredales, 2012) 	%calcperc (erewash, 2012) 	%calcperc (highpeak, 2012) 	%calcperc (northeastderbyshire, 2012) 	%calcperc (southderbyshire, 2012) 	%calcperc (eastdevon, 2012) 	%calcperc (exeter, 2012) 	%calcperc (middevon, 2012) 	%calcperc (northdevon, 2012) 	%calcperc (southhams, 2012) 	%calcperc (teignbridge, 2012) 	%calcperc (torridge, 2012) 	%calcperc (westdevon, 2012) 	%calcperc (christchurch, 2012) 	%calcperc (eastdorset, 2012) 	%calcperc (northdorset, 2012) 	%calcperc (purbeck, 2012) 	%calcperc (westdorset, 2012) 	%calcperc (weymouthandportland, 2012) 	%calcperc (eastbourne, 2012) 	%calcperc (hastings, 2012) 	%calcperc (lewes, 2012) 	%calcperc (rother, 2012) 	%calcperc (wealden, 2012) 	%calcperc (basildon, 2012) 	%calcperc (braintree, 2012) 	%calcperc (brentwood, 2012) 	%calcperc (castlepoint, 2012) 	%calcperc (chelmsford, 2012) 	
%calcperc (colchester, 2012) 	%calcperc (eppingforest, 2012) 	%calcperc (harlow, 2012) 	%calcperc (maldon, 2012) 	%calcperc (rochford, 2012) 	%calcperc (tendring, 2012) 	%calcperc (uttlesford, 2012) 	%calcperc (cheltenham, 2012) 	%calcperc (cotswold, 2012) 	%calcperc (forestofdean, 2012) 	%calcperc (gloucester, 2012) 	%calcperc (stroud, 2012) 	%calcperc (tewkesbury, 2012) 	%calcperc (basingstokeanddeane, 2012) 	%calcperc (easthampshire, 2012) 	%calcperc (eastleigh, 2012) 	%calcperc (fareham, 2012) 	%calcperc (gosport, 2012) 	%calcperc (hart, 2012) 	%calcperc (havant, 2012) 	%calcperc (newforest, 2012) 	%calcperc (rushmoor, 2012) 	%calcperc (testvalley, 2012) 	%calcperc (winchester, 2012) 	%calcperc (broxbourne, 2012) 	%calcperc (dacorum, 2012) 	%calcperc (hertsmere, 2012) 	%calcperc (northhertfordshire, 2012) 	%calcperc (threerivers, 2012) 	%calcperc (watford, 2012) 	%calcperc (ashford, 2012) 	%calcperc (canterbury, 2012) 	%calcperc (dartford, 2012) 	%calcperc (dover, 2012) 	%calcperc (gravesham, 2012) 	%calcperc (maidstone, 2012) 	%calcperc (sevenoaks, 2012) 	%calcperc (shepway, 2012) 	%calcperc (swale, 2012) 	%calcperc (thanet, 2012) 	%calcperc (tonbridgeandmalling, 2012) 	%calcperc (tunbridgewells, 2012) 	%calcperc (burnley, 2012) 	%calcperc (chorley, 2012) 	%calcperc (fylde, 2012) 	%calcperc (hyndburn, 2012) 	%calcperc (lancaster, 2012) 	%calcperc (pendle, 2012) 	%calcperc (preston, 2012) 	%calcperc (ribblevalley, 2012) 	%calcperc (rossendale, 2012) 	%calcperc (southribble, 2012) 	%calcperc (westlancashire, 2012) 	%calcperc (wyre, 2012) 	%calcperc (blaby, 2012) 	%calcperc (charnwood, 2012) 	%calcperc (harborough, 2012) 	%calcperc (hinckleyandbosworth, 2012) 	%calcperc (melton, 2012) 	%calcperc (northwestleicestershire, 2012) 	%calcperc (oadbyandwigston, 2012) 	%calcperc (boston, 2012) 	%calcperc (eastlindsey, 2012) 	%calcperc (lincoln, 2012) 	%calcperc (northkesteven, 2012) 	%calcperc (southholland, 2012) 	%calcperc (southkesteven, 2012) 	%calcperc (westlindsey, 2012) 	%calcperc (breckland, 2012) 	%calcperc (broadland, 2012) 	%calcperc (greatyarmouth, 2012) 	%calcperc (kingslynnandwestnorfolk, 2012) 	%calcperc (northnorfolk, 2012) 	%calcperc (norwich, 2012) 	%calcperc (southnorfolk, 2012) 	%calcperc (corby, 2012) 	%calcperc (daventry, 2012) 	%calcperc (eastnorthamptonshire, 2012) 	%calcperc (kettering, 2012) 	%calcperc (northampton, 2012) 	%calcperc (southnorthamptonshire, 2012) 	%calcperc (wellingborough, 2012) 	%calcperc (craven, 2012) 	%calcperc (hambleton, 2012) 	%calcperc (harrogate, 2012) 	%calcperc (richmondshire, 2012) 	%calcperc (ryedale, 2012) 	%calcperc (scarborough, 2012) 	%calcperc (selby, 2012) 	%calcperc (ashfield, 2012) 	%calcperc (bassetlaw, 2012) 	%calcperc (broxtowe, 2012) 	%calcperc (gedling, 2012) 	%calcperc (mansfield, 2012) 	%calcperc (newarkandsherwood, 2012) 	%calcperc (rushcliffe, 2012) 	%calcperc (cherwell, 2012) 	%calcperc (oxford, 2012) 	%calcperc (southoxfordshire, 2012) 	%calcperc (valeofwhitehorse, 2012) 	%calcperc (westoxfordshire, 2012) 	%calcperc (mendip, 2012) 	%calcperc (sedgemoor, 2012) 	%calcperc (southsomerset, 2012) 	%calcperc (tauntondeane, 2012) 	%calcperc (westsomerset, 2012) 	%calcperc (cannockchase, 2012) 
%calcperc (eaststaffordshire, 2012) 	%calcperc (lichfield, 2012) 	%calcperc (newcastleunderlyme, 2012) 	%calcperc (southstaffordshire, 2012) 	%calcperc (stafford, 2012) 	%calcperc (staffordshiremoorlands, 2012) 	%calcperc (tamworth, 2012) 	%calcperc (babergh, 2012) 	%calcperc (forestheath, 2012) 	%calcperc (ipswich, 2012) 	%calcperc (midsuffolk, 2012) 	%calcperc (stedmundsbury, 2012) 	%calcperc (suffolkcoastal, 2012) 	
%calcperc (waveney, 2012) 	%calcperc (elmbridge, 2012) 	%calcperc (epsomandewell, 2012) 	%calcperc (guildford, 2012) 	%calcperc (molevalley, 2012) 	%calcperc (reigateandbanstead, 2012) 	%calcperc (runnymede, 2012) 	%calcperc (spelthorne, 2012) 	%calcperc (surreyheath, 2012) 	%calcperc (tandridge, 2012) 	%calcperc (waverley, 2012) 	%calcperc (woking, 2012) 	%calcperc (northwarwickshire, 2012) 	%calcperc (nuneatonandbedworth, 2012) 	%calcperc (rugby, 2012) 	%calcperc (stratfordonavon, 2012) 	%calcperc (warwick, 2012) 	%calcperc (adur, 2012) 	%calcperc (arun, 2012) 	%calcperc (chichester, 2012) 	%calcperc (crawley, 2012) 	%calcperc (horsham, 2012) 	%calcperc (midsussex, 2012) 	%calcperc (worthing, 2012) 	%calcperc (bromsgrove, 2012) 	%calcperc (malvernhills, 2012) 	%calcperc (redditch, 2012) 	%calcperc (worcester, 2012) 	%calcperc (wychavon, 2012) 	%calcperc (wyreforest, 2012) 	%calcperc (stalbans, 2012) 	%calcperc (welwynhatfield, 2012) 	%calcperc (easthertfordshire, 2012) 	%calcperc (stevenage, 2012) 	%calcperc (bolton, 2012) 	%calcperc (bury, 2012) 	%calcperc (manchester, 2012) 	%calcperc (oldham, 2012) 	%calcperc (rochdale, 2012) 	%calcperc (salford, 2012) 	%calcperc (stockport, 2012) 	%calcperc (tameside, 2012) 	%calcperc (trafford, 2012) 	%calcperc (wigan, 2012) 	%calcperc (knowsley, 2012) 	%calcperc (liverpool, 2012) 	%calcperc (sthelens, 2012) 	%calcperc (sefton, 2012) 	%calcperc (wirral, 2012) 	%calcperc (barnsley, 2012) 	%calcperc (doncaster, 2012) 	%calcperc (rotherham, 2012) 	%calcperc (sheffield, 2012) 	%calcperc (newcastleupontyne, 2012) 	%calcperc (northtyneside, 2012) 	%calcperc (southtyneside, 2012) 	%calcperc (sunderland, 2012) 	%calcperc (birmingham, 2012) 	%calcperc (coventry, 2012) 	%calcperc (dudley, 2012) 	%calcperc (sandwell, 2012) 	%calcperc (solihull, 2012) 	%calcperc (walsall, 2012) 	%calcperc (wolverhampton, 2012) 	%calcperc (bradford, 2012) 	%calcperc (calderdale, 2012) 	%calcperc (kirklees, 2012) 	%calcperc (leeds, 2012) 	%calcperc (wakefield, 2012) 	%calcperc (gateshead, 2012) 	%calcperc (cityoflondon, 2012) 	%calcperc (barkinganddagenham, 2012) 	%calcperc (barnet, 2012) 	%calcperc (bexley, 2012) 	%calcperc (brent, 2012) 	%calcperc (bromley, 2012) 	%calcperc (camden, 2012) 	%calcperc (croydon, 2012) 	%calcperc (ealing, 2012) 	%calcperc (enfield, 2012) 	%calcperc (greenwich, 2012) 	%calcperc (hackney, 2012) 	%calcperc (hammersmithandfulham, 2012) 	%calcperc (haringey, 2012) 	%calcperc (harrow, 2012) 	%calcperc (havering, 2012) 	%calcperc (hillingdon, 2012) 	%calcperc (hounslow, 2012) 	%calcperc (islington, 2012) 	%calcperc (kensingtonandchelsea, 2012) 	%calcperc (kingstonuponthames, 2012) 	%calcperc (lambeth, 2012) 	%calcperc (lewisham, 2012) 	%calcperc (merton, 2012) 	%calcperc (newham, 2012) 	%calcperc (redbridge, 2012) 	%calcperc (richmonduponthames, 2012) 	%calcperc (southwark, 2012) 	%calcperc (sutton, 2012) 	%calcperc (towerhamlets, 2012) 	%calcperc (walthamforest, 2012) 	%calcperc (wandsworth, 2012) 	%calcperc (westminster, 2012) 	%calcperc (buckinghamshire, 2012) 	%calcperc (cambridgeshire, 2012) 	%calcperc (cumbria, 2012) 	%calcperc (derbyshire, 2012) 	%calcperc (devon, 2012) 	%calcperc (dorset, 2012) 	
%calcperc (eastsussex, 2012) 	%calcperc (essex, 2012) 	%calcperc (gloucestershire, 2012) 	%calcperc (hampshire, 2012) 	%calcperc (hertfordshire, 2012) 	%calcperc (kent, 2012) 	%calcperc (lancashire, 2012) 	%calcperc (leicestershire, 2012) 	%calcperc (lincolnshire, 2012) 	%calcperc (norfolk, 2012) 	%calcperc (northamptonshire, 2012) 	%calcperc (northyorkshire, 2012) 	%calcperc (nottinghamshire, 2012) 	%calcperc (oxfordshire, 2012) 	%calcperc (somerset, 2012) 	%calcperc (staffordshire, 2012) 	%calcperc (suffolk, 2012) 	%calcperc (surrey, 2012) 	%calcperc (warwickshire, 2012) 	%calcperc (westsussex, 2012) 	%calcperc (worcestershire, 2012) 	%calcperc (greatermanchester, 2012) 	%calcperc (merseyside, 2012) 	%calcperc (southyorkshire, 2012) 	%calcperc (westmidlands, 2012) 	%calcperc (westyorkshire, 2012) 	%calcperc (tyneandwear, 2012) 	%calcperc (antrimandnewtownabbey, 2012) 	%calcperc (armaghcitybanbridgeandcraigavon, 2012) 	%calcperc (belfast, 2012) 	%calcperc (causewaycoastandglens, 2012) 	%calcperc (derrycityandstrabane, 2012) 	%calcperc (fermanaghandomagh, 2012) 	%calcperc (lisburnandcastlereagh, 2012) 	%calcperc (midandeastantrim, 2012) 	%calcperc (midulster, 2012) 	%calcperc (newrymourneanddown, 2012) 	%calcperc (ardsandnorthdown, 2012) 	%calcperc (clackmannanshire, 2012) 	%calcperc (dumfriesandgalloway, 2012) 	%calcperc (eastayrshire, 2012) 	%calcperc (eastlothian, 2012) 	%calcperc (eastrenfrewshire, 2012) 	%calcperc (naheileanansiar, 2012) 	%calcperc (falkirk, 2012) 	%calcperc (fife, 2012) 	%calcperc (highland, 2012) 	%calcperc (inverclyde, 2012) 	%calcperc (midlothian, 2012) 	%calcperc (moray, 2012) 	%calcperc (northayrshire, 2012) 	%calcperc (orkneyislands, 2012) 	%calcperc (perthandkinross, 2012) 	%calcperc (scottishborders, 2012) 	%calcperc (shetlandislands, 2012) 	%calcperc (southayrshire, 2012) 	%calcperc (southlanarkshire, 2012) 	%calcperc (stirling, 2012) 	%calcperc (aberdeencity, 2012) 	%calcperc (aberdeenshire, 2012) 	%calcperc (argyllandbute, 2012) 	%calcperc (cityofedinburgh, 2012) 	%calcperc (renfrewshire, 2012) 	%calcperc (westdunbartonshire, 2012) 	%calcperc (westlothian, 2012) 	%calcperc (angus, 2012) 	%calcperc (dundeecity, 2012) 	%calcperc (northlanarkshire, 2012) 	%calcperc (eastdunbartonshire, 2012) 	%calcperc (glasgowcity, 2012) 	%calcperc (isleofanglesey, 2012) 	%calcperc (gwynedd, 2012) 	%calcperc (conwy, 2012) 	%calcperc (denbighshire, 2012) 	%calcperc (flintshire, 2012) 	%calcperc (wrexham, 2012) 	%calcperc (ceredigion, 2012) 	%calcperc (pembrokeshire, 2012) 	%calcperc (carmarthenshire, 2012) 	%calcperc (swansea, 2012) 	%calcperc (neathporttalbot, 2012) 	%calcperc (bridgend, 2012) 	%calcperc (valeofglamorgan, 2012) 	%calcperc (cardiff, 2012) 	%calcperc (rhonddacynontaf, 2012) 	%calcperc (caerphilly, 2012) 	%calcperc (blaenaugwent, 2012) 	%calcperc (torfaen, 2012) 	%calcperc (monmouthshire, 2012) 	%calcperc (newport, 2012) 	%calcperc (powys, 2012) 	%calcperc (merthyrtydfil, 2012) 	%calcperc (northeast, 2012) 	%calcperc (northwest, 2012) 	%calcperc (yorkshireandhumber, 2012) 	%calcperc (eastmidlands, 2012) 	%calcperc (westmidlandsregion, 2012) 	%calcperc (east, 2012) 	%calcperc (london, 2012) 	%calcperc (southeast, 2012) 	%calcperc (southwest, 2012) 	
%calcperc (england, 2012) 	%calcperc (northernireland, 2012) 	%calcperc (scotland, 2012) 	%calcperc (wales, 2012) 	%calcperc (englandandwales, 2012) 	%calcperc (greatbritian, 2012) 	%calcperc (unitedkingdom, 2012);
%calcperc (hartlepool, 2013) 	%calcperc (middlesbrough, 2013) 	%calcperc (redcarandcleveland, 2013) 	%calcperc (stocktonontees, 2013) 	%calcperc (darlington, 2013) 	%calcperc (halton, 2013) 	%calcperc (warrington, 2013) 	%calcperc (blackburnwithdarwen, 2013) 	%calcperc (blackpool, 2013) 	%calcperc (kingstonuponhullcityof, 2013) 	%calcperc (eastridingofyorkshire, 2013) 	%calcperc (northeastlincolnshire, 2013) 	%calcperc (northlincolnshire, 2013) 	%calcperc (york, 2013) 	%calcperc (derby, 2013) 	%calcperc (leicester, 2013) 	%calcperc (rutland, 2013) 	%calcperc (nottingham, 2013) 	%calcperc (herefordshirecountyof, 2013) 	%calcperc (telfordandwrekin, 2013) 	%calcperc (stokeontrent, 2013) 	%calcperc (bathandnortheastsomerset, 2013) 	%calcperc (bristolcityof, 2013) 	%calcperc (northsomerset, 2013) 	%calcperc (southgloucestershire, 2013) 	%calcperc (plymouth, 2013) 	%calcperc (torbay, 2013) 	%calcperc (bournemouth, 2013) 	%calcperc (poole, 2013) 	%calcperc (swindon, 2013) 	%calcperc (peterborough, 2013) 	%calcperc (luton, 2013) 	%calcperc (southendonsea, 2013) 	%calcperc (thurrock, 2013) 	%calcperc (medway, 2013) 	%calcperc (bracknellforest, 2013) 	%calcperc (westberkshire, 2013) 	%calcperc (reading, 2013) 	%calcperc (slough, 2013) 	%calcperc (windsorandmaidenhead, 2013) 	%calcperc (wokingham, 2013) 	%calcperc (miltonkeynes, 2013) 	%calcperc (brightonandhove, 2013) 	%calcperc (portsmouth, 2013) 	%calcperc (southampton, 2013) 	%calcperc (isleofwight, 2013) 	%calcperc (countydurham, 2013) 	%calcperc (cheshireeast, 2013) 	%calcperc (cheshirewestandchester, 2013) 	%calcperc (shropshire, 2013) 	%calcperc (cornwall, 2013) 	%calcperc (islesofscilly, 2013) 	%calcperc (wiltshire, 2013) 	%calcperc (bedford, 2013) 	%calcperc (centralbedfordshire, 2013) 	%calcperc (northumberland, 2013) 	%calcperc (aylesburyvale, 2013) 	%calcperc (chiltern, 2013) 	%calcperc (southbucks, 2013) 	%calcperc (wycombe, 2013) 	%calcperc (cambridge, 2013) 	%calcperc (eastcambridgeshire, 2013) 	%calcperc (fenland, 2013) 	%calcperc (huntingdonshire, 2013) 	%calcperc (southcambridgeshire, 2013) 	%calcperc (allerdale, 2013) 	%calcperc (barrowinfurness, 2013) 	%calcperc (carlisle, 2013) 	%calcperc (copeland, 2013) 	%calcperc (eden, 2013) 	%calcperc (southlakeland, 2013) 	%calcperc (ambervalley, 2013) 	%calcperc (bolsover, 2013) 	%calcperc (chesterfield, 2013) 	%calcperc (derbyshiredales, 2013) 	%calcperc (erewash, 2013) 	%calcperc (highpeak, 2013) 	%calcperc (northeastderbyshire, 2013) 	%calcperc (southderbyshire, 2013) 	%calcperc (eastdevon, 2013) 	%calcperc (exeter, 2013) 	%calcperc (middevon, 2013) 	%calcperc (northdevon, 2013) 	%calcperc (southhams, 2013) 	%calcperc (teignbridge, 2013) 	%calcperc (torridge, 2013) 	%calcperc (westdevon, 2013) 	%calcperc (christchurch, 2013) 	%calcperc (eastdorset, 2013) 	%calcperc (northdorset, 2013) 	%calcperc (purbeck, 2013) 	%calcperc (westdorset, 2013) 	%calcperc (weymouthandportland, 2013) 	%calcperc (eastbourne, 2013) 	%calcperc (hastings, 2013) 	%calcperc (lewes, 2013) 	%calcperc (rother, 2013) 	%calcperc (wealden, 2013) 	%calcperc (basildon, 2013) 	%calcperc (braintree, 2013) 	%calcperc (brentwood, 2013) 	%calcperc (castlepoint, 2013) 	%calcperc (chelmsford, 2013) 	
%calcperc (colchester, 2013) 	%calcperc (eppingforest, 2013) 	%calcperc (harlow, 2013) 	%calcperc (maldon, 2013) 	%calcperc (rochford, 2013) 	%calcperc (tendring, 2013) 	%calcperc (uttlesford, 2013) 	%calcperc (cheltenham, 2013) 	%calcperc (cotswold, 2013) 	%calcperc (forestofdean, 2013) 	%calcperc (gloucester, 2013) 	%calcperc (stroud, 2013) 	%calcperc (tewkesbury, 2013) 	%calcperc (basingstokeanddeane, 2013) 	%calcperc (easthampshire, 2013) 	%calcperc (eastleigh, 2013) 	%calcperc (fareham, 2013) 	%calcperc (gosport, 2013) 	%calcperc (hart, 2013) 	%calcperc (havant, 2013) 	%calcperc (newforest, 2013) 	%calcperc (rushmoor, 2013) 	%calcperc (testvalley, 2013) 	%calcperc (winchester, 2013) 	%calcperc (broxbourne, 2013) 	%calcperc (dacorum, 2013) 	%calcperc (hertsmere, 2013) 	%calcperc (northhertfordshire, 2013) 	%calcperc (threerivers, 2013) 	%calcperc (watford, 2013) 	%calcperc (ashford, 2013) 	%calcperc (canterbury, 2013) 	%calcperc (dartford, 2013) 	%calcperc (dover, 2013) 	%calcperc (gravesham, 2013) 	%calcperc (maidstone, 2013) 	%calcperc (sevenoaks, 2013) 	%calcperc (shepway, 2013) 	%calcperc (swale, 2013) 	%calcperc (thanet, 2013) 	%calcperc (tonbridgeandmalling, 2013) 	%calcperc (tunbridgewells, 2013) 	%calcperc (burnley, 2013) 	%calcperc (chorley, 2013) 	%calcperc (fylde, 2013) 	%calcperc (hyndburn, 2013) 	%calcperc (lancaster, 2013) 	%calcperc (pendle, 2013) 	%calcperc (preston, 2013) 	%calcperc (ribblevalley, 2013) 	%calcperc (rossendale, 2013) 	%calcperc (southribble, 2013) 	%calcperc (westlancashire, 2013) 	%calcperc (wyre, 2013) 	%calcperc (blaby, 2013) 	%calcperc (charnwood, 2013) 	%calcperc (harborough, 2013) 	%calcperc (hinckleyandbosworth, 2013) 	%calcperc (melton, 2013) 	%calcperc (northwestleicestershire, 2013) 	%calcperc (oadbyandwigston, 2013) 	%calcperc (boston, 2013) 	%calcperc (eastlindsey, 2013) 	%calcperc (lincoln, 2013) 	%calcperc (northkesteven, 2013) 	%calcperc (southholland, 2013) 	%calcperc (southkesteven, 2013) 	%calcperc (westlindsey, 2013) 	%calcperc (breckland, 2013) 	%calcperc (broadland, 2013) 	%calcperc (greatyarmouth, 2013) 	%calcperc (kingslynnandwestnorfolk, 2013) 	%calcperc (northnorfolk, 2013) 	%calcperc (norwich, 2013) 	%calcperc (southnorfolk, 2013) 	%calcperc (corby, 2013) 	%calcperc (daventry, 2013) 	%calcperc (eastnorthamptonshire, 2013) 	%calcperc (kettering, 2013) 	%calcperc (northampton, 2013) 	%calcperc (southnorthamptonshire, 2013) 	%calcperc (wellingborough, 2013) 	%calcperc (craven, 2013) 	%calcperc (hambleton, 2013) 	%calcperc (harrogate, 2013) 	%calcperc (richmondshire, 2013) 	%calcperc (ryedale, 2013) 	%calcperc (scarborough, 2013) 	%calcperc (selby, 2013) 	%calcperc (ashfield, 2013) 	%calcperc (bassetlaw, 2013) 	%calcperc (broxtowe, 2013) 	%calcperc (gedling, 2013) 	%calcperc (mansfield, 2013) 	%calcperc (newarkandsherwood, 2013) 	%calcperc (rushcliffe, 2013) 	%calcperc (cherwell, 2013) 	%calcperc (oxford, 2013) 	%calcperc (southoxfordshire, 2013) 	%calcperc (valeofwhitehorse, 2013) 	%calcperc (westoxfordshire, 2013) 	%calcperc (mendip, 2013) 	%calcperc (sedgemoor, 2013) 	%calcperc (southsomerset, 2013) 	%calcperc (tauntondeane, 2013) 	%calcperc (westsomerset, 2013) 	%calcperc (cannockchase, 2013) 	
%calcperc (eaststaffordshire, 2013) 	%calcperc (lichfield, 2013) 	%calcperc (newcastleunderlyme, 2013) 	%calcperc (southstaffordshire, 2013) 	%calcperc (stafford, 2013) 	%calcperc (staffordshiremoorlands, 2013) 	%calcperc (tamworth, 2013) 	%calcperc (babergh, 2013) 	%calcperc (forestheath, 2013) 	%calcperc (ipswich, 2013) 	%calcperc (midsuffolk, 2013) 	%calcperc (stedmundsbury, 2013) 	%calcperc (suffolkcoastal, 2013) 	
%calcperc (waveney, 2013) 	%calcperc (elmbridge, 2013) 	%calcperc (epsomandewell, 2013) 	%calcperc (guildford, 2013) 	%calcperc (molevalley, 2013) 	%calcperc (reigateandbanstead, 2013) 	%calcperc (runnymede, 2013) 	%calcperc (spelthorne, 2013) 	%calcperc (surreyheath, 2013) 	%calcperc (tandridge, 2013) 	%calcperc (waverley, 2013) 	%calcperc (woking, 2013) 	%calcperc (northwarwickshire, 2013) 	%calcperc (nuneatonandbedworth, 2013) 	%calcperc (rugby, 2013) 	%calcperc (stratfordonavon, 2013) 	%calcperc (warwick, 2013) 	%calcperc (adur, 2013) 	%calcperc (arun, 2013) 	%calcperc (chichester, 2013) 	%calcperc (crawley, 2013) 	%calcperc (horsham, 2013) 	%calcperc (midsussex, 2013) 	%calcperc (worthing, 2013) 	%calcperc (bromsgrove, 2013) 	%calcperc (malvernhills, 2013) 	%calcperc (redditch, 2013) 	%calcperc (worcester, 2013) 	%calcperc (wychavon, 2013) 	%calcperc (wyreforest, 2013) 	%calcperc (stalbans, 2013) 	%calcperc (welwynhatfield, 2013) 	%calcperc (easthertfordshire, 2013) 	%calcperc (stevenage, 2013) 	%calcperc (bolton, 2013) 	%calcperc (bury, 2013) 	%calcperc (manchester, 2013) 	%calcperc (oldham, 2013) 	%calcperc (rochdale, 2013) 	%calcperc (salford, 2013) 	%calcperc (stockport, 2013) 	%calcperc (tameside, 2013) 	%calcperc (trafford, 2013) 	%calcperc (wigan, 2013) 	%calcperc (knowsley, 2013) 	%calcperc (liverpool, 2013) 	%calcperc (sthelens, 2013) 	%calcperc (sefton, 2013) 	%calcperc (wirral, 2013) 	%calcperc (barnsley, 2013) 	%calcperc (doncaster, 2013) 	%calcperc (rotherham, 2013) 	%calcperc (sheffield, 2013) 	%calcperc (newcastleupontyne, 2013) 	%calcperc (northtyneside, 2013) 	%calcperc (southtyneside, 2013) 	%calcperc (sunderland, 2013) 	%calcperc (birmingham, 2013) 	%calcperc (coventry, 2013) 	%calcperc (dudley, 2013) 	%calcperc (sandwell, 2013) 	%calcperc (solihull, 2013) 	%calcperc (walsall, 2013) 	%calcperc (wolverhampton, 2013) 	%calcperc (bradford, 2013) 	%calcperc (calderdale, 2013) 	%calcperc (kirklees, 2013) 	%calcperc (leeds, 2013) 	%calcperc (wakefield, 2013) 	%calcperc (gateshead, 2013) 	%calcperc (cityoflondon, 2013) 	%calcperc (barkinganddagenham, 2013) 	%calcperc (barnet, 2013) 	%calcperc (bexley, 2013) 	%calcperc (brent, 2013) 	%calcperc (bromley, 2013) 	%calcperc (camden, 2013) 	%calcperc (croydon, 2013) 	%calcperc (ealing, 2013) 	%calcperc (enfield, 2013) 	%calcperc (greenwich, 2013) 	%calcperc (hackney, 2013) 	%calcperc (hammersmithandfulham, 2013) 	%calcperc (haringey, 2013) 	%calcperc (harrow, 2013) 	%calcperc (havering, 2013) 	%calcperc (hillingdon, 2013) 	%calcperc (hounslow, 2013) 	%calcperc (islington, 2013) 	%calcperc (kensingtonandchelsea, 2013) 	%calcperc (kingstonuponthames, 2013) 	%calcperc (lambeth, 2013) 	%calcperc (lewisham, 2013) 	%calcperc (merton, 2013) 	%calcperc (newham, 2013) 	%calcperc (redbridge, 2013) 	%calcperc (richmonduponthames, 2013) 	%calcperc (southwark, 2013) 	%calcperc (sutton, 2013) 	%calcperc (towerhamlets, 2013) 	%calcperc (walthamforest, 2013) 	%calcperc (wandsworth, 2013) 	%calcperc (westminster, 2013) 	%calcperc (buckinghamshire, 2013) 	%calcperc (cambridgeshire, 2013) 	%calcperc (cumbria, 2013) 	%calcperc (derbyshire, 2013) 	%calcperc (devon, 2013) 	%calcperc (dorset, 2013) 	
%calcperc (eastsussex, 2013) 	%calcperc (essex, 2013) 	%calcperc (gloucestershire, 2013) 	%calcperc (hampshire, 2013) 	%calcperc (hertfordshire, 2013) 	%calcperc (kent, 2013) 	%calcperc (lancashire, 2013) 	%calcperc (leicestershire, 2013) 	%calcperc (lincolnshire, 2013) 	%calcperc (norfolk, 2013) 	%calcperc (northamptonshire, 2013) 	%calcperc (northyorkshire, 2013) 	%calcperc (nottinghamshire, 2013) 	%calcperc (oxfordshire, 2013) 	%calcperc (somerset, 2013) 	%calcperc (staffordshire, 2013) 	%calcperc (suffolk, 2013) 	%calcperc (surrey, 2013) 	%calcperc (warwickshire, 2013) 	%calcperc (westsussex, 2013) 	%calcperc (worcestershire, 2013) 	%calcperc (greatermanchester, 2013) 	%calcperc (merseyside, 2013) 	%calcperc (southyorkshire, 2013) 	%calcperc (westmidlands, 2013) 	%calcperc (westyorkshire, 2013) 	%calcperc (tyneandwear, 2013) 	%calcperc (antrimandnewtownabbey, 2013) 	%calcperc (armaghcitybanbridgeandcraigavon, 2013) 	%calcperc (belfast, 2013) 	%calcperc (causewaycoastandglens, 2013) 	%calcperc (derrycityandstrabane, 2013) 	%calcperc (fermanaghandomagh, 2013) 	%calcperc (lisburnandcastlereagh, 2013) 	%calcperc (midandeastantrim, 2013) 	%calcperc (midulster, 2013) 	%calcperc (newrymourneanddown, 2013) 	%calcperc (ardsandnorthdown, 2013) 	%calcperc (clackmannanshire, 2013) 	%calcperc (dumfriesandgalloway, 2013) 	%calcperc (eastayrshire, 2013) 	%calcperc (eastlothian, 2013) 	%calcperc (eastrenfrewshire, 2013) 	%calcperc (naheileanansiar, 2013) 	%calcperc (falkirk, 2013) 	%calcperc (fife, 2013) 	%calcperc (highland, 2013) 	%calcperc (inverclyde, 2013) 	%calcperc (midlothian, 2013) 	%calcperc (moray, 2013) 	%calcperc (northayrshire, 2013) 	%calcperc (orkneyislands, 2013) 	%calcperc (perthandkinross, 2013) 	%calcperc (scottishborders, 2013) 	%calcperc (shetlandislands, 2013) 	%calcperc (southayrshire, 2013) 	%calcperc (southlanarkshire, 2013) 	%calcperc (stirling, 2013) 	%calcperc (aberdeencity, 2013) 	%calcperc (aberdeenshire, 2013) 	%calcperc (argyllandbute, 2013) 	%calcperc (cityofedinburgh, 2013) 	%calcperc (renfrewshire, 2013) 	%calcperc (westdunbartonshire, 2013) 	%calcperc (westlothian, 2013) 	%calcperc (angus, 2013) 	%calcperc (dundeecity, 2013) 	%calcperc (northlanarkshire, 2013) 	%calcperc (eastdunbartonshire, 2013) 	%calcperc (glasgowcity, 2013) 	%calcperc (isleofanglesey, 2013) 	%calcperc (gwynedd, 2013) 	%calcperc (conwy, 2013) 	%calcperc (denbighshire, 2013) 	%calcperc (flintshire, 2013) 	%calcperc (wrexham, 2013) 	%calcperc (ceredigion, 2013) 	%calcperc (pembrokeshire, 2013) 	%calcperc (carmarthenshire, 2013) 	%calcperc (swansea, 2013) 	%calcperc (neathporttalbot, 2013) 	%calcperc (bridgend, 2013) 	%calcperc (valeofglamorgan, 2013) 	%calcperc (cardiff, 2013) 	%calcperc (rhonddacynontaf, 2013) 	%calcperc (caerphilly, 2013) 	%calcperc (blaenaugwent, 2013) 	%calcperc (torfaen, 2013) 	%calcperc (monmouthshire, 2013) 	%calcperc (newport, 2013) 	%calcperc (powys, 2013) 	%calcperc (merthyrtydfil, 2013) 	%calcperc (northeast, 2013) 	%calcperc (northwest, 2013) 	%calcperc (yorkshireandhumber, 2013) 	%calcperc (eastmidlands, 2013) 	%calcperc (westmidlandsregion, 2013) 	%calcperc (east, 2013) 	%calcperc (london, 2013) 	%calcperc (southeast, 2013) 	%calcperc (southwest, 2013) 	
%calcperc (england, 2013) 	%calcperc (northernireland, 2013) 	%calcperc (scotland, 2013) 	%calcperc (wales, 2013) 	%calcperc (englandandwales, 2013) 	%calcperc (greatbritian, 2013) 	%calcperc (unitedkingdom, 2013);
%calcperc (hartlepool, 2014) 	%calcperc (middlesbrough, 2014) 	%calcperc (redcarandcleveland, 2014) 	%calcperc (stocktonontees, 2014) 	%calcperc (darlington, 2014) 	%calcperc (halton, 2014) 	%calcperc (warrington, 2014) 	%calcperc (blackburnwithdarwen, 2014) 	%calcperc (blackpool, 2014) 	%calcperc (kingstonuponhullcityof, 2014) 	%calcperc (eastridingofyorkshire, 2014) 	%calcperc (northeastlincolnshire, 2014) 	%calcperc (northlincolnshire, 2014) 	%calcperc (york, 2014) 	%calcperc (derby, 2014) 	%calcperc (leicester, 2014) 	%calcperc (rutland, 2014) 	%calcperc (nottingham, 2014) 	%calcperc (herefordshirecountyof, 2014) 	%calcperc (telfordandwrekin, 2014) 	%calcperc (stokeontrent, 2014) 	%calcperc (bathandnortheastsomerset, 2014) 	%calcperc (bristolcityof, 2014) 	%calcperc (northsomerset, 2014) 	%calcperc (southgloucestershire, 2014) 	%calcperc (plymouth, 2014) 	%calcperc (torbay, 2014) 	%calcperc (bournemouth, 2014) 	%calcperc (poole, 2014) 	%calcperc (swindon, 2014) 	%calcperc (peterborough, 2014) 	%calcperc (luton, 2014) 	%calcperc (southendonsea, 2014) 	%calcperc (thurrock, 2014) 	%calcperc (medway, 2014) 	%calcperc (bracknellforest, 2014) 	%calcperc (westberkshire, 2014) 	%calcperc (reading, 2014) 	%calcperc (slough, 2014) 	%calcperc (windsorandmaidenhead, 2014) 	%calcperc (wokingham, 2014) 	%calcperc (miltonkeynes, 2014) 	%calcperc (brightonandhove, 2014) 	%calcperc (portsmouth, 2014) 	%calcperc (southampton, 2014) 	%calcperc (isleofwight, 2014) 	%calcperc (countydurham, 2014) 	%calcperc (cheshireeast, 2014) 	%calcperc (cheshirewestandchester, 2014) 	%calcperc (shropshire, 2014) 	%calcperc (cornwall, 2014) 	%calcperc (islesofscilly, 2014) 	%calcperc (wiltshire, 2014) 	%calcperc (bedford, 2014) 	%calcperc (centralbedfordshire, 2014) 	%calcperc (northumberland, 2014) 	%calcperc (aylesburyvale, 2014) 	%calcperc (chiltern, 2014) 	%calcperc (southbucks, 2014) 	%calcperc (wycombe, 2014) 	%calcperc (cambridge, 2014) 	%calcperc (eastcambridgeshire, 2014) 	%calcperc (fenland, 2014) 	%calcperc (huntingdonshire, 2014) 	%calcperc (southcambridgeshire, 2014) 	%calcperc (allerdale, 2014) 	%calcperc (barrowinfurness, 2014) 	%calcperc (carlisle, 2014) 	%calcperc (copeland, 2014) 	%calcperc (eden, 2014) 	%calcperc (southlakeland, 2014) 	%calcperc (ambervalley, 2014) 	%calcperc (bolsover, 2014) 	%calcperc (chesterfield, 2014) 	%calcperc (derbyshiredales, 2014) 	%calcperc (erewash, 2014) 	%calcperc (highpeak, 2014) 	%calcperc (northeastderbyshire, 2014) 	%calcperc (southderbyshire, 2014) 	%calcperc (eastdevon, 2014) 	%calcperc (exeter, 2014) 	%calcperc (middevon, 2014) 	%calcperc (northdevon, 2014) 	%calcperc (southhams, 2014) 	%calcperc (teignbridge, 2014) 	%calcperc (torridge, 2014) 	%calcperc (westdevon, 2014) 	%calcperc (christchurch, 2014) 	%calcperc (eastdorset, 2014) 	%calcperc (northdorset, 2014) 	%calcperc (purbeck, 2014) 	%calcperc (westdorset, 2014) 	%calcperc (weymouthandportland, 2014) 	%calcperc (eastbourne, 2014) 	%calcperc (hastings, 2014) 	%calcperc (lewes, 2014) 	%calcperc (rother, 2014) 	%calcperc (wealden, 2014) 	%calcperc (basildon, 2014) 	%calcperc (braintree, 2014) 	%calcperc (brentwood, 2014) 	%calcperc (castlepoint, 2014) 	%calcperc (chelmsford, 2014) 	
%calcperc (colchester, 2014) 	%calcperc (eppingforest, 2014) 	%calcperc (harlow, 2014) 	%calcperc (maldon, 2014) 	%calcperc (rochford, 2014) 	%calcperc (tendring, 2014) 	%calcperc (uttlesford, 2014) 	%calcperc (cheltenham, 2014) 	%calcperc (cotswold, 2014) 	%calcperc (forestofdean, 2014) 	%calcperc (gloucester, 2014) 	%calcperc (stroud, 2014) 	%calcperc (tewkesbury, 2014) 	%calcperc (basingstokeanddeane, 2014) 	%calcperc (easthampshire, 2014) 	%calcperc (eastleigh, 2014) 	%calcperc (fareham, 2014) 	%calcperc (gosport, 2014) 	%calcperc (hart, 2014) 	%calcperc (havant, 2014) 	%calcperc (newforest, 2014) 	%calcperc (rushmoor, 2014) 	%calcperc (testvalley, 2014) 	%calcperc (winchester, 2014) 	%calcperc (broxbourne, 2014) 	%calcperc (dacorum, 2014) 	%calcperc (hertsmere, 2014) 	%calcperc (northhertfordshire, 2014) 	%calcperc (threerivers, 2014) 	%calcperc (watford, 2014) 	%calcperc (ashford, 2014) 	%calcperc (canterbury, 2014) 	%calcperc (dartford, 2014) 	%calcperc (dover, 2014) 	%calcperc (gravesham, 2014) 	%calcperc (maidstone, 2014) 	%calcperc (sevenoaks, 2014) 	%calcperc (shepway, 2014) 	%calcperc (swale, 2014) 	%calcperc (thanet, 2014) 	%calcperc (tonbridgeandmalling, 2014) 	%calcperc (tunbridgewells, 2014) 	%calcperc (burnley, 2014) 	%calcperc (chorley, 2014) 	%calcperc (fylde, 2014) 	%calcperc (hyndburn, 2014) 	%calcperc (lancaster, 2014) 	%calcperc (pendle, 2014) 	%calcperc (preston, 2014) 	%calcperc (ribblevalley, 2014) 	%calcperc (rossendale, 2014) 	%calcperc (southribble, 2014) 	%calcperc (westlancashire, 2014) 	%calcperc (wyre, 2014) 	%calcperc (blaby, 2014) 	%calcperc (charnwood, 2014) 	%calcperc (harborough, 2014) 	%calcperc (hinckleyandbosworth, 2014) 	%calcperc (melton, 2014) 	%calcperc (northwestleicestershire, 2014) 	%calcperc (oadbyandwigston, 2014) 	%calcperc (boston, 2014) 	%calcperc (eastlindsey, 2014) 	%calcperc (lincoln, 2014) 	%calcperc (northkesteven, 2014) 	%calcperc (southholland, 2014) 	%calcperc (southkesteven, 2014) 	%calcperc (westlindsey, 2014) 	%calcperc (breckland, 2014) 	%calcperc (broadland, 2014) 	%calcperc (greatyarmouth, 2014) 	%calcperc (kingslynnandwestnorfolk, 2014) 	%calcperc (northnorfolk, 2014) 	%calcperc (norwich, 2014) 	%calcperc (southnorfolk, 2014) 	%calcperc (corby, 2014) 	%calcperc (daventry, 2014) 	%calcperc (eastnorthamptonshire, 2014) 	%calcperc (kettering, 2014) 	%calcperc (northampton, 2014) 	%calcperc (southnorthamptonshire, 2014) 	%calcperc (wellingborough, 2014) 	%calcperc (craven, 2014) 	%calcperc (hambleton, 2014) 	%calcperc (harrogate, 2014) 	%calcperc (richmondshire, 2014) 	%calcperc (ryedale, 2014) 	%calcperc (scarborough, 2014) 	%calcperc (selby, 2014) 	%calcperc (ashfield, 2014) 	%calcperc (bassetlaw, 2014) 	%calcperc (broxtowe, 2014) 	%calcperc (gedling, 2014) 	%calcperc (mansfield, 2014) 	%calcperc (newarkandsherwood, 2014) 	%calcperc (rushcliffe, 2014) 	%calcperc (cherwell, 2014) 	%calcperc (oxford, 2014) 	%calcperc (southoxfordshire, 2014) 	%calcperc (valeofwhitehorse, 2014) 	%calcperc (westoxfordshire, 2014) 	%calcperc (mendip, 2014) 	%calcperc (sedgemoor, 2014) 	%calcperc (southsomerset, 2014) 	%calcperc (tauntondeane, 2014) 	%calcperc (westsomerset, 2014) 	%calcperc (cannockchase, 2014) 	
%calcperc (eaststaffordshire, 2014) 	%calcperc (lichfield, 2014) 	%calcperc (newcastleunderlyme, 2014) 	%calcperc (southstaffordshire, 2014) 	%calcperc (stafford, 2014) 	%calcperc (staffordshiremoorlands, 2014) 	%calcperc (tamworth, 2014) 	%calcperc (babergh, 2014) 	%calcperc (forestheath, 2014) 	%calcperc (ipswich, 2014) 	%calcperc (midsuffolk, 2014) 	%calcperc (stedmundsbury, 2014) 	%calcperc (suffolkcoastal, 2014) 	
%calcperc (waveney, 2014) 	%calcperc (elmbridge, 2014)     %calcperc (epsomandewell, 2014) 	%calcperc (guildford, 2014) 	%calcperc (molevalley, 2014) 	%calcperc (reigateandbanstead, 2014) 	%calcperc (runnymede, 2014) 	%calcperc (spelthorne, 2014) 	%calcperc (surreyheath, 2014) 	%calcperc (tandridge, 2014) 	%calcperc (waverley, 2014) 	%calcperc (woking, 2014) 	%calcperc (northwarwickshire, 2014) 	%calcperc (nuneatonandbedworth, 2014) 	%calcperc (rugby, 2014) 	%calcperc (stratfordonavon, 2014) 	%calcperc (warwick, 2014) 	%calcperc (adur, 2014) 	%calcperc (arun, 2014) 	%calcperc (chichester, 2014) 	%calcperc (crawley, 2014) 	%calcperc (horsham, 2014) 	%calcperc (midsussex, 2014) 	%calcperc (worthing, 2014) 	%calcperc (bromsgrove, 2014) 	%calcperc (malvernhills, 2014) 	%calcperc (redditch, 2014) 	%calcperc (worcester, 2014) 	%calcperc (wychavon, 2014) 	%calcperc (wyreforest, 2014) 	%calcperc (stalbans, 2014) 	%calcperc (welwynhatfield, 2014) 	%calcperc (easthertfordshire, 2014) 	%calcperc (stevenage, 2014) 	%calcperc (bolton, 2014) 	%calcperc (bury, 2014) 	%calcperc (manchester, 2014) 	%calcperc (oldham, 2014) 	%calcperc (rochdale, 2014) 	%calcperc (salford, 2014) 	%calcperc (stockport, 2014) 	%calcperc (tameside, 2014) 	%calcperc (trafford, 2014) 	%calcperc (wigan, 2014) 	%calcperc (knowsley, 2014) 	%calcperc (liverpool, 2014) 	%calcperc (sthelens, 2014) 	%calcperc (sefton, 2014) 	%calcperc (wirral, 2014) 	%calcperc (barnsley, 2014) 	%calcperc (doncaster, 2014) 	%calcperc (rotherham, 2014) 	%calcperc (sheffield, 2014) 	%calcperc (newcastleupontyne, 2014) 	%calcperc (northtyneside, 2014) 	%calcperc (southtyneside, 2014) 	%calcperc (sunderland, 2014) 	%calcperc (birmingham, 2014) 	%calcperc (coventry, 2014) 	%calcperc (dudley, 2014) 	%calcperc (sandwell, 2014) 	%calcperc (solihull, 2014) 	%calcperc (walsall, 2014) 	%calcperc (wolverhampton, 2014) 	%calcperc (bradford, 2014) 	%calcperc (calderdale, 2014) 	%calcperc (kirklees, 2014) 	%calcperc (leeds, 2014) 	%calcperc (wakefield, 2014) 	%calcperc (gateshead, 2014) 	%calcperc (cityoflondon, 2014) 	%calcperc (barkinganddagenham, 2014) 	%calcperc (barnet, 2014) 	%calcperc (bexley, 2014) 	%calcperc (brent, 2014) 	%calcperc (bromley, 2014) 	%calcperc (camden, 2014) 	%calcperc (croydon, 2014) 	%calcperc (ealing, 2014) 	%calcperc (enfield, 2014) 	%calcperc (greenwich, 2014) 	%calcperc (hackney, 2014) 	%calcperc (hammersmithandfulham, 2014) 	%calcperc (haringey, 2014) 	%calcperc (harrow, 2014) 	%calcperc (havering, 2014) 	%calcperc (hillingdon, 2014) 	%calcperc (hounslow, 2014) 	%calcperc (islington, 2014) 	%calcperc (kensingtonandchelsea, 2014) 	%calcperc (kingstonuponthames, 2014) 	%calcperc (lambeth, 2014) 	%calcperc (lewisham, 2014) 	%calcperc (merton, 2014) 	%calcperc (newham, 2014) 	%calcperc (redbridge, 2014) 	%calcperc (richmonduponthames, 2014) 	%calcperc (southwark, 2014) 	%calcperc (sutton, 2014) 	%calcperc (towerhamlets, 2014) 	%calcperc (walthamforest, 2014) 	%calcperc (wandsworth, 2014) 	%calcperc (westminster, 2014) 	%calcperc (buckinghamshire, 2014) 	%calcperc (cambridgeshire, 2014) 	%calcperc (cumbria, 2014) 	%calcperc (derbyshire, 2014) 	%calcperc (devon, 2014) 	%calcperc (dorset, 2014) 	
%calcperc (eastsussex, 2014) 	%calcperc (essex, 2014) 	%calcperc (gloucestershire, 2014) 	%calcperc (hampshire, 2014) 	%calcperc (hertfordshire, 2014) 	%calcperc (kent, 2014) 	%calcperc (lancashire, 2014) 	%calcperc (leicestershire, 2014) 	%calcperc (lincolnshire, 2014) 	%calcperc (norfolk, 2014) 	%calcperc (northamptonshire, 2014) 	%calcperc (northyorkshire, 2014) 	%calcperc (nottinghamshire, 2014) 	%calcperc (oxfordshire, 2014) 	%calcperc (somerset, 2014) 	%calcperc (staffordshire, 2014) 	%calcperc (suffolk, 2014) 	%calcperc (surrey, 2014) 	%calcperc (warwickshire, 2014) 	%calcperc (westsussex, 2014) 	%calcperc (worcestershire, 2014) 	%calcperc (greatermanchester, 2014) 	%calcperc (merseyside, 2014) 	%calcperc (southyorkshire, 2014) 	%calcperc (westmidlands, 2014) 	%calcperc (westyorkshire, 2014) 	%calcperc (tyneandwear, 2014) 	%calcperc (antrimandnewtownabbey, 2014) 	%calcperc (armaghcitybanbridgeandcraigavon, 2014) 	%calcperc (belfast, 2014) 	%calcperc (causewaycoastandglens, 2014) 	%calcperc (derrycityandstrabane, 2014) 	%calcperc (fermanaghandomagh, 2014) 	%calcperc (lisburnandcastlereagh, 2014) 	%calcperc (midandeastantrim, 2014) 	%calcperc (midulster, 2014) 	%calcperc (newrymourneanddown, 2014) 	%calcperc (ardsandnorthdown, 2014) 	%calcperc (clackmannanshire, 2014) 	%calcperc (dumfriesandgalloway, 2014) 	%calcperc (eastayrshire, 2014) 	%calcperc (eastlothian, 2014) 	%calcperc (eastrenfrewshire, 2014) 	%calcperc (naheileanansiar, 2014) 	%calcperc (falkirk, 2014) 	%calcperc (fife, 2014) 	%calcperc (highland, 2014) 	%calcperc (inverclyde, 2014) 	%calcperc (midlothian, 2014) 	%calcperc (moray, 2014) 	%calcperc (northayrshire, 2014) 	%calcperc (orkneyislands, 2014) 	%calcperc (perthandkinross, 2014) 	%calcperc (scottishborders, 2014) 	%calcperc (shetlandislands, 2014) 	%calcperc (southayrshire, 2014) 	%calcperc (southlanarkshire, 2014) 	%calcperc (stirling, 2014) 	%calcperc (aberdeencity, 2014) 	%calcperc (aberdeenshire, 2014) 	%calcperc (argyllandbute, 2014) 	%calcperc (cityofedinburgh, 2014) 	%calcperc (renfrewshire, 2014) 	%calcperc (westdunbartonshire, 2014) 	%calcperc (westlothian, 2014) 	%calcperc (angus, 2014) 	%calcperc (dundeecity, 2014) 	%calcperc (northlanarkshire, 2014) 	%calcperc (eastdunbartonshire, 2014) 	%calcperc (glasgowcity, 2014) 	%calcperc (isleofanglesey, 2014) 	%calcperc (gwynedd, 2014) 	%calcperc (conwy, 2014) 	%calcperc (denbighshire, 2014) 	%calcperc (flintshire, 2014) 	%calcperc (wrexham, 2014) 	%calcperc (ceredigion, 2014) 	%calcperc (pembrokeshire, 2014) 	%calcperc (carmarthenshire, 2014) 	%calcperc (swansea, 2014) 	%calcperc (neathporttalbot, 2014) 	%calcperc (bridgend, 2014) 	%calcperc (valeofglamorgan, 2014) 	%calcperc (cardiff, 2014) 	%calcperc (rhonddacynontaf, 2014) 	%calcperc (caerphilly, 2014) 	%calcperc (blaenaugwent, 2014) 	%calcperc (torfaen, 2014) 	%calcperc (monmouthshire, 2014) 	%calcperc (newport, 2014) 	%calcperc (powys, 2014) 	%calcperc (merthyrtydfil, 2014) 	%calcperc (northeast, 2014) 	%calcperc (northwest, 2014) 	%calcperc (yorkshireandhumber, 2014) 	%calcperc (eastmidlands, 2014) 	%calcperc (westmidlandsregion, 2014) 	%calcperc (east, 2014) 	%calcperc (london, 2014) 	%calcperc (southeast, 2014) 	%calcperc (southwest, 2014) 	
%calcperc (england, 2014) 	%calcperc (northernireland, 2014) 	%calcperc (scotland, 2014) 	%calcperc (wales, 2014) 	%calcperc (englandandwales, 2014) 	%calcperc (greatbritian, 2014) 	%calcperc (unitedkingdom, 2014);
%calcperc (hartlepool, 2015) 	%calcperc (middlesbrough, 2015) 	%calcperc (redcarandcleveland, 2015) 	%calcperc (stocktonontees, 2015) 	%calcperc (darlington, 2015) 	%calcperc (halton, 2015) 	%calcperc (warrington, 2015) 	%calcperc (blackburnwithdarwen, 2015) 	%calcperc (blackpool, 2015) 	%calcperc (kingstonuponhullcityof, 2015) 	%calcperc (eastridingofyorkshire, 2015) 	%calcperc (northeastlincolnshire, 2015) 	%calcperc (northlincolnshire, 2015) 	%calcperc (york, 2015) 	%calcperc (derby, 2015) 	%calcperc (leicester, 2015) 	%calcperc (rutland, 2015) 	%calcperc (nottingham, 2015) 	%calcperc (herefordshirecountyof, 2015) 	%calcperc (telfordandwrekin, 2015) 	%calcperc (stokeontrent, 2015) 	%calcperc (bathandnortheastsomerset, 2015) 	%calcperc (bristolcityof, 2015) 	%calcperc (northsomerset, 2015) 	%calcperc (southgloucestershire, 2015) 	%calcperc (plymouth, 2015) 	%calcperc (torbay, 2015) 	%calcperc (bournemouth, 2015) 	%calcperc (poole, 2015) 	%calcperc (swindon, 2015) 	%calcperc (peterborough, 2015) 	%calcperc (luton, 2015) 	%calcperc (southendonsea, 2015) 	%calcperc (thurrock, 2015) 	%calcperc (medway, 2015) 	%calcperc (bracknellforest, 2015) 	%calcperc (westberkshire, 2015) 	%calcperc (reading, 2015) 	%calcperc (slough, 2015) 	%calcperc (windsorandmaidenhead, 2015) 	%calcperc (wokingham, 2015) 	%calcperc (miltonkeynes, 2015) 	%calcperc (brightonandhove, 2015) 	%calcperc (portsmouth, 2015) 	%calcperc (southampton, 2015) 	%calcperc (isleofwight, 2015) 	%calcperc (countydurham, 2015) 	%calcperc (cheshireeast, 2015) 	%calcperc (cheshirewestandchester, 2015) 	%calcperc (shropshire, 2015) 	%calcperc (cornwall, 2015) 	%calcperc (islesofscilly, 2015) 	%calcperc (wiltshire, 2015) 	%calcperc (bedford, 2015) 	%calcperc (centralbedfordshire, 2015) 	%calcperc (northumberland, 2015) 	%calcperc (aylesburyvale, 2015) 	%calcperc (chiltern, 2015) 	%calcperc (southbucks, 2015) 	%calcperc (wycombe, 2015) 	%calcperc (cambridge, 2015) 	%calcperc (eastcambridgeshire, 2015) 	%calcperc (fenland, 2015) 	%calcperc (huntingdonshire, 2015) 	%calcperc (southcambridgeshire, 2015) 	%calcperc (allerdale, 2015) 	%calcperc (barrowinfurness, 2015) 	%calcperc (carlisle, 2015) 	%calcperc (copeland, 2015) 	%calcperc (eden, 2015) 	%calcperc (southlakeland, 2015) 	%calcperc (ambervalley, 2015) 	%calcperc (bolsover, 2015) 	%calcperc (chesterfield, 2015) 	%calcperc (derbyshiredales, 2015) 	%calcperc (erewash, 2015) 	%calcperc (highpeak, 2015) 	%calcperc (northeastderbyshire, 2015) 	%calcperc (southderbyshire, 2015) 	%calcperc (eastdevon, 2015) 	%calcperc (exeter, 2015) 	%calcperc (middevon, 2015) 	%calcperc (northdevon, 2015) 	%calcperc (southhams, 2015) 	%calcperc (teignbridge, 2015) 	%calcperc (torridge, 2015) 	%calcperc (westdevon, 2015) 	%calcperc (christchurch, 2015) 	%calcperc (eastdorset, 2015) 	%calcperc (northdorset, 2015) 	%calcperc (purbeck, 2015) 	%calcperc (westdorset, 2015) 	%calcperc (weymouthandportland, 2015) 	%calcperc (eastbourne, 2015) 	%calcperc (hastings, 2015) 	%calcperc (lewes, 2015) 	%calcperc (rother, 2015) 	%calcperc (wealden, 2015) 	%calcperc (basildon, 2015) 	%calcperc (braintree, 2015) 	%calcperc (brentwood, 2015) 	%calcperc (castlepoint, 2015) 	%calcperc (chelmsford, 2015) 	
%calcperc (colchester, 2015) 	%calcperc (eppingforest, 2015) 	%calcperc (harlow, 2015) 	%calcperc (maldon, 2015) 	%calcperc (rochford, 2015) 	%calcperc (tendring, 2015) 	%calcperc (uttlesford, 2015) 	%calcperc (cheltenham, 2015) 	%calcperc (cotswold, 2015) 	%calcperc (forestofdean, 2015) 	%calcperc (gloucester, 2015) 	%calcperc (stroud, 2015) 	%calcperc (tewkesbury, 2015) 	%calcperc (basingstokeanddeane, 2015) 	%calcperc (easthampshire, 2015) 	%calcperc (eastleigh, 2015) 	%calcperc (fareham, 2015) 	%calcperc (gosport, 2015) 	%calcperc (hart, 2015) 	%calcperc (havant, 2015) 	%calcperc (newforest, 2015) 	%calcperc (rushmoor, 2015) 	%calcperc (testvalley, 2015) 	%calcperc (winchester, 2015) 	%calcperc (broxbourne, 2015) 	%calcperc (dacorum, 2015) 	%calcperc (hertsmere, 2015) 	%calcperc (northhertfordshire, 2015) 	%calcperc (threerivers, 2015) 	%calcperc (watford, 2015) 	%calcperc (ashford, 2015) 	%calcperc (canterbury, 2015) 	%calcperc (dartford, 2015) 	%calcperc (dover, 2015) 	%calcperc (gravesham, 2015) 	%calcperc (maidstone, 2015) 	%calcperc (sevenoaks, 2015) 	%calcperc (shepway, 2015) 	%calcperc (swale, 2015) 	%calcperc (thanet, 2015) 	%calcperc (tonbridgeandmalling, 2015) 	%calcperc (tunbridgewells, 2015) 	%calcperc (burnley, 2015) 	%calcperc (chorley, 2015) 	%calcperc (fylde, 2015) 	%calcperc (hyndburn, 2015) 	%calcperc (lancaster, 2015) 	%calcperc (pendle, 2015) 	%calcperc (preston, 2015) 	%calcperc (ribblevalley, 2015) 	%calcperc (rossendale, 2015) 	%calcperc (southribble, 2015) 	%calcperc (westlancashire, 2015) 	%calcperc (wyre, 2015) 	%calcperc (blaby, 2015) 	%calcperc (charnwood, 2015) 	%calcperc (harborough, 2015) 	%calcperc (hinckleyandbosworth, 2015) 	%calcperc (melton, 2015) 	%calcperc (northwestleicestershire, 2015) 	%calcperc (oadbyandwigston, 2015) 	%calcperc (boston, 2015) 	%calcperc (eastlindsey, 2015) 	%calcperc (lincoln, 2015) 	%calcperc (northkesteven, 2015) 	%calcperc (southholland, 2015) 	%calcperc (southkesteven, 2015) 	%calcperc (westlindsey, 2015) 	%calcperc (breckland, 2015) 	%calcperc (broadland, 2015) 	%calcperc (greatyarmouth, 2015) 	%calcperc (kingslynnandwestnorfolk, 2015) 	%calcperc (northnorfolk, 2015) 	%calcperc (norwich, 2015) 	%calcperc (southnorfolk, 2015) 	%calcperc (corby, 2015) 	%calcperc (daventry, 2015) 	%calcperc (eastnorthamptonshire, 2015) 	%calcperc (kettering, 2015) 	%calcperc (northampton, 2015) 	%calcperc (southnorthamptonshire, 2015) 	%calcperc (wellingborough, 2015) 	%calcperc (craven, 2015) 	%calcperc (hambleton, 2015) 	%calcperc (harrogate, 2015) 	%calcperc (richmondshire, 2015) 	%calcperc (ryedale, 2015) 	%calcperc (scarborough, 2015) 	%calcperc (selby, 2015) 	%calcperc (ashfield, 2015) 	%calcperc (bassetlaw, 2015) 	%calcperc (broxtowe, 2015) 	%calcperc (gedling, 2015) 	%calcperc (mansfield, 2015) 	%calcperc (newarkandsherwood, 2015) 	%calcperc (rushcliffe, 2015) 	%calcperc (cherwell, 2015) 	%calcperc (oxford, 2015) 	%calcperc (southoxfordshire, 2015) 	%calcperc (valeofwhitehorse, 2015) 	%calcperc (westoxfordshire, 2015) 	%calcperc (mendip, 2015) 	%calcperc (sedgemoor, 2015) 	%calcperc (southsomerset, 2015) 	%calcperc (tauntondeane, 2015) 	%calcperc (westsomerset, 2015) 	%calcperc (cannockchase, 2015) 	
%calcperc (eaststaffordshire, 2015) 	%calcperc (lichfield, 2015) 	%calcperc (newcastleunderlyme, 2015) 	%calcperc (southstaffordshire, 2015) 	%calcperc (stafford, 2015) 	%calcperc (staffordshiremoorlands, 2015) 	%calcperc (tamworth, 2015) 	%calcperc (babergh, 2015) 	%calcperc (forestheath, 2015) 	%calcperc (ipswich, 2015) 	%calcperc (midsuffolk, 2015) 	%calcperc (stedmundsbury, 2015) 	%calcperc (suffolkcoastal, 2015) 	
%calcperc (waveney, 2015) 	%calcperc (elmbridge, 2015) 	%calcperc (epsomandewell, 2015) 	%calcperc (guildford, 2015) 	%calcperc (molevalley, 2015) 	%calcperc (reigateandbanstead, 2015) 	%calcperc (runnymede, 2015) 	%calcperc (spelthorne, 2015) 	%calcperc (surreyheath, 2015) 	%calcperc (tandridge, 2015) 	%calcperc (waverley, 2015) 	%calcperc (woking, 2015) 	%calcperc (northwarwickshire, 2015) 	%calcperc (nuneatonandbedworth, 2015) 	%calcperc (rugby, 2015) 	%calcperc (stratfordonavon, 2015) 	%calcperc (warwick, 2015) 	%calcperc (adur, 2015) 	%calcperc (arun, 2015) 	%calcperc (chichester, 2015) 	%calcperc (crawley, 2015) 	%calcperc (horsham, 2015) 	%calcperc (midsussex, 2015) 	%calcperc (worthing, 2015) 	%calcperc (bromsgrove, 2015) 	%calcperc (malvernhills, 2015) 	%calcperc (redditch, 2015) 	%calcperc (worcester, 2015) 	%calcperc (wychavon, 2015) 	%calcperc (wyreforest, 2015) 	%calcperc (stalbans, 2015) 	%calcperc (welwynhatfield, 2015) 	%calcperc (easthertfordshire, 2015) 	%calcperc (stevenage, 2015) 	%calcperc (bolton, 2015) 	%calcperc (bury, 2015) 	%calcperc (manchester, 2015) 	%calcperc (oldham, 2015) 	%calcperc (rochdale, 2015) 	%calcperc (salford, 2015) 	%calcperc (stockport, 2015) 	%calcperc (tameside, 2015) 	%calcperc (trafford, 2015) 	%calcperc (wigan, 2015) 	%calcperc (knowsley, 2015) 	%calcperc (liverpool, 2015) 	%calcperc (sthelens, 2015) 	%calcperc (sefton, 2015) 	%calcperc (wirral, 2015) 	%calcperc (barnsley, 2015) 	%calcperc (doncaster, 2015) 	%calcperc (rotherham, 2015) 	%calcperc (sheffield, 2015) 	%calcperc (newcastleupontyne, 2015) 	%calcperc (northtyneside, 2015) 	%calcperc (southtyneside, 2015) 	%calcperc (sunderland, 2015) 	%calcperc (birmingham, 2015) 	%calcperc (coventry, 2015) 	%calcperc (dudley, 2015) 	%calcperc (sandwell, 2015) 	%calcperc (solihull, 2015) 	%calcperc (walsall, 2015) 	%calcperc (wolverhampton, 2015) 	%calcperc (bradford, 2015) 	%calcperc (calderdale, 2015) 	%calcperc (kirklees, 2015) 	%calcperc (leeds, 2015) 	%calcperc (wakefield, 2015) 	%calcperc (gateshead, 2015) 	%calcperc (cityoflondon, 2015) 	%calcperc (barkinganddagenham, 2015) 	%calcperc (barnet, 2015) 	%calcperc (bexley, 2015) 	%calcperc (brent, 2015) 	%calcperc (bromley, 2015) 	%calcperc (camden, 2015) 	%calcperc (croydon, 2015) 	%calcperc (ealing, 2015) 	%calcperc (enfield, 2015) 	%calcperc (greenwich, 2015) 	%calcperc (hackney, 2015) 	%calcperc (hammersmithandfulham, 2015) 	%calcperc (haringey, 2015) 	%calcperc (harrow, 2015) 	%calcperc (havering, 2015) 	%calcperc (hillingdon, 2015) 	%calcperc (hounslow, 2015) 	%calcperc (islington, 2015) 	%calcperc (kensingtonandchelsea, 2015) 	%calcperc (kingstonuponthames, 2015) 	%calcperc (lambeth, 2015) 	%calcperc (lewisham, 2015) 	%calcperc (merton, 2015) 	%calcperc (newham, 2015) 	%calcperc (redbridge, 2015) 	%calcperc (richmonduponthames, 2015) 	%calcperc (southwark, 2015) 	%calcperc (sutton, 2015) 	%calcperc (towerhamlets, 2015) 	%calcperc (walthamforest, 2015) 	%calcperc (wandsworth, 2015) 	%calcperc (westminster, 2015) 	%calcperc (buckinghamshire, 2015) 	%calcperc (cambridgeshire, 2015) 	%calcperc (cumbria, 2015) 	%calcperc (derbyshire, 2015) 	%calcperc (devon, 2015) 	%calcperc (dorset, 2015) 	
%calcperc (eastsussex, 2015) 	%calcperc (essex, 2015) 	%calcperc (gloucestershire, 2015) 	%calcperc (hampshire, 2015) 	%calcperc (hertfordshire, 2015) 	%calcperc (kent, 2015) 	%calcperc (lancashire, 2015) 	%calcperc (leicestershire, 2015) 	%calcperc (lincolnshire, 2015) 	%calcperc (norfolk, 2015) 	%calcperc (northamptonshire, 2015) 	%calcperc (northyorkshire, 2015) 	%calcperc (nottinghamshire, 2015) 	%calcperc (oxfordshire, 2015) 	%calcperc (somerset, 2015) 	%calcperc (staffordshire, 2015) 	%calcperc (suffolk, 2015) 	%calcperc (surrey, 2015) 	%calcperc (warwickshire, 2015) 	%calcperc (westsussex, 2015) 	%calcperc (worcestershire, 2015) 	%calcperc (greatermanchester, 2015) 	%calcperc (merseyside, 2015) 	%calcperc (southyorkshire, 2015) 	%calcperc (westmidlands, 2015) 	%calcperc (westyorkshire, 2015) 	%calcperc (tyneandwear, 2015) 	%calcperc (antrimandnewtownabbey, 2015) 	%calcperc (armaghcitybanbridgeandcraigavon, 2015) 	%calcperc (belfast, 2015) 	%calcperc (causewaycoastandglens, 2015) 	%calcperc (derrycityandstrabane, 2015) 	%calcperc (fermanaghandomagh, 2015) 	%calcperc (lisburnandcastlereagh, 2015) 	%calcperc (midandeastantrim, 2015) 	%calcperc (midulster, 2015) 	%calcperc (newrymourneanddown, 2015) 	%calcperc (ardsandnorthdown, 2015) 	%calcperc (clackmannanshire, 2015) 	%calcperc (dumfriesandgalloway, 2015) 	%calcperc (eastayrshire, 2015) 	%calcperc (eastlothian, 2015) 	%calcperc (eastrenfrewshire, 2015) 	%calcperc (naheileanansiar, 2015) 	%calcperc (falkirk, 2015) 	%calcperc (fife, 2015) 	%calcperc (highland, 2015) 	%calcperc (inverclyde, 2015) 	%calcperc (midlothian, 2015) 	%calcperc (moray, 2015) 	%calcperc (northayrshire, 2015) 	%calcperc (orkneyislands, 2015) 	%calcperc (perthandkinross, 2015) 	%calcperc (scottishborders, 2015) 	%calcperc (shetlandislands, 2015) 	%calcperc (southayrshire, 2015) 	%calcperc (southlanarkshire, 2015) 	%calcperc (stirling, 2015) 	%calcperc (aberdeencity, 2015) 	%calcperc (aberdeenshire, 2015) 	%calcperc (argyllandbute, 2015) 	%calcperc (cityofedinburgh, 2015) 	%calcperc (renfrewshire, 2015) 	%calcperc (westdunbartonshire, 2015) 	%calcperc (westlothian, 2015) 	%calcperc (angus, 2015) 	%calcperc (dundeecity, 2015) 	%calcperc (northlanarkshire, 2015) 	%calcperc (eastdunbartonshire, 2015) 	%calcperc (glasgowcity, 2015) 	%calcperc (isleofanglesey, 2015) 	%calcperc (gwynedd, 2015) 	%calcperc (conwy, 2015) 	%calcperc (denbighshire, 2015) 	%calcperc (flintshire, 2015) 	%calcperc (wrexham, 2015) 	%calcperc (ceredigion, 2015) 	%calcperc (pembrokeshire, 2015) 	%calcperc (carmarthenshire, 2015) 	%calcperc (swansea, 2015) 	%calcperc (neathporttalbot, 2015) 	%calcperc (bridgend, 2015) 	%calcperc (valeofglamorgan, 2015) 	%calcperc (cardiff, 2015) 	%calcperc (rhonddacynontaf, 2015) 	%calcperc (caerphilly, 2015) 	%calcperc (blaenaugwent, 2015) 	%calcperc (torfaen, 2015) 	%calcperc (monmouthshire, 2015) 	%calcperc (newport, 2015) 	%calcperc (powys, 2015) 	%calcperc (merthyrtydfil, 2015) 	%calcperc (northeast, 2015) 	%calcperc (northwest, 2015) 	%calcperc (yorkshireandhumber, 2015) 	%calcperc (eastmidlands, 2015) 	%calcperc (westmidlandsregion, 2015) 	%calcperc (east, 2015) 	%calcperc (london, 2015) 	%calcperc (southeast, 2015) 	%calcperc (southwest, 2015) 	
%calcperc (england, 2015) 	%calcperc (northernireland, 2015) 	%calcperc (scotland, 2015) 	%calcperc (wales, 2015) 	%calcperc (englandandwales, 2015) 	%calcperc (greatbritian, 2015) 	%calcperc (unitedkingdom, 2015);
%calcperc (hartlepool, 2016) 	%calcperc (middlesbrough, 2016) 	%calcperc (redcarandcleveland, 2016) 	%calcperc (stocktonontees, 2016) 	%calcperc (darlington, 2016) 	%calcperc (halton, 2016) 	%calcperc (warrington, 2016) 	%calcperc (blackburnwithdarwen, 2016) 	%calcperc (blackpool, 2016) 	%calcperc (kingstonuponhullcityof, 2016) 	%calcperc (eastridingofyorkshire, 2016) 	%calcperc (northeastlincolnshire, 2016) 	%calcperc (northlincolnshire, 2016) 	%calcperc (york, 2016) 	%calcperc (derby, 2016) 	%calcperc (leicester, 2016) 	%calcperc (rutland, 2016) 	%calcperc (nottingham, 2016) 	%calcperc (herefordshirecountyof, 2016) 	%calcperc (telfordandwrekin, 2016) 	%calcperc (stokeontrent, 2016) 	%calcperc (bathandnortheastsomerset, 2016) 	%calcperc (bristolcityof, 2016) 	%calcperc (northsomerset, 2016) 	%calcperc (southgloucestershire, 2016) 	%calcperc (plymouth, 2016) 	%calcperc (torbay, 2016) 	%calcperc (bournemouth, 2016) 	%calcperc (poole, 2016) 	%calcperc (swindon, 2016) 	%calcperc (peterborough, 2016) 	%calcperc (luton, 2016) 	%calcperc (southendonsea, 2016) 	%calcperc (thurrock, 2016) 	%calcperc (medway, 2016) 	%calcperc (bracknellforest, 2016) 	%calcperc (westberkshire, 2016) 	%calcperc (reading, 2016) 	%calcperc (slough, 2016) 	%calcperc (windsorandmaidenhead, 2016) 	%calcperc (wokingham, 2016) 	%calcperc (miltonkeynes, 2016) 	%calcperc (brightonandhove, 2016) 	%calcperc (portsmouth, 2016) 	%calcperc (southampton, 2016) 	%calcperc (isleofwight, 2016) 	%calcperc (countydurham, 2016) 	%calcperc (cheshireeast, 2016) 	%calcperc (cheshirewestandchester, 2016) 	%calcperc (shropshire, 2016) 	%calcperc (cornwall, 2016) 	%calcperc (islesofscilly, 2016) 	%calcperc (wiltshire, 2016) 	%calcperc (bedford, 2016) 	%calcperc (centralbedfordshire, 2016) 	%calcperc (northumberland, 2016) 	%calcperc (aylesburyvale, 2016) 	%calcperc (chiltern, 2016) 	%calcperc (southbucks, 2016) 	%calcperc (wycombe, 2016) 	%calcperc (cambridge, 2016) 	%calcperc (eastcambridgeshire, 2016) 	%calcperc (fenland, 2016) 	%calcperc (huntingdonshire, 2016) 	%calcperc (southcambridgeshire, 2016) 	%calcperc (allerdale, 2016) 	%calcperc (barrowinfurness, 2016) 	%calcperc (carlisle, 2016) 	%calcperc (copeland, 2016) 	%calcperc (eden, 2016) 	%calcperc (southlakeland, 2016) 	%calcperc (ambervalley, 2016) 	%calcperc (bolsover, 2016) 	%calcperc (chesterfield, 2016) 	%calcperc (derbyshiredales, 2016) 	%calcperc (erewash, 2016) 	%calcperc (highpeak, 2016) 	%calcperc (northeastderbyshire, 2016) 	%calcperc (southderbyshire, 2016) 	%calcperc (eastdevon, 2016) 	%calcperc (exeter, 2016) 	%calcperc (middevon, 2016) 	%calcperc (northdevon, 2016) 	%calcperc (southhams, 2016) 	%calcperc (teignbridge, 2016) 	%calcperc (torridge, 2016) 	%calcperc (westdevon, 2016) 	%calcperc (christchurch, 2016) 	%calcperc (eastdorset, 2016) 	%calcperc (northdorset, 2016) 	%calcperc (purbeck, 2016) 	%calcperc (westdorset, 2016) 	%calcperc (weymouthandportland, 2016) 	%calcperc (eastbourne, 2016) 	%calcperc (hastings, 2016) 	%calcperc (lewes, 2016) 	%calcperc (rother, 2016) 	%calcperc (wealden, 2016) 	%calcperc (basildon, 2016) 	%calcperc (braintree, 2016) 	%calcperc (brentwood, 2016) 	%calcperc (castlepoint, 2016) 	%calcperc (chelmsford, 2016) 	
%calcperc (colchester, 2016) 	%calcperc (eppingforest, 2016) 	%calcperc (harlow, 2016) 	%calcperc (maldon, 2016) 	%calcperc (rochford, 2016) 	%calcperc (tendring, 2016) 	%calcperc (uttlesford, 2016) 	%calcperc (cheltenham, 2016) 	%calcperc (cotswold, 2016) 	%calcperc (forestofdean, 2016) 	%calcperc (gloucester, 2016) 	%calcperc (stroud, 2016) 	%calcperc (tewkesbury, 2016) 	%calcperc (basingstokeanddeane, 2016) 	%calcperc (easthampshire, 2016) 	%calcperc (eastleigh, 2016) 	%calcperc (fareham, 2016) 	%calcperc (gosport, 2016) 	%calcperc (hart, 2016) 	%calcperc (havant, 2016) 	%calcperc (newforest, 2016) 	%calcperc (rushmoor, 2016) 	%calcperc (testvalley, 2016) 	%calcperc (winchester, 2016) 	%calcperc (broxbourne, 2016) 	%calcperc (dacorum, 2016) 	%calcperc (hertsmere, 2016) 	%calcperc (northhertfordshire, 2016) 	%calcperc (threerivers, 2016) 	%calcperc (watford, 2016) 	%calcperc (ashford, 2016) 	%calcperc (canterbury, 2016) 	%calcperc (dartford, 2016) 	%calcperc (dover, 2016) 	%calcperc (gravesham, 2016) 	%calcperc (maidstone, 2016) 	%calcperc (sevenoaks, 2016) 	%calcperc (shepway, 2016) 	%calcperc (swale, 2016) 	%calcperc (thanet, 2016) 	%calcperc (tonbridgeandmalling, 2016) 	%calcperc (tunbridgewells, 2016) 	%calcperc (burnley, 2016) 	%calcperc (chorley, 2016) 	%calcperc (fylde, 2016) 	%calcperc (hyndburn, 2016) 	%calcperc (lancaster, 2016) 	%calcperc (pendle, 2016) 	%calcperc (preston, 2016) 	%calcperc (ribblevalley, 2016) 	%calcperc (rossendale, 2016) 	%calcperc (southribble, 2016) 	%calcperc (westlancashire, 2016) 	%calcperc (wyre, 2016) 	%calcperc (blaby, 2016) 	%calcperc (charnwood, 2016) 	%calcperc (harborough, 2016) 	%calcperc (hinckleyandbosworth, 2016) 	%calcperc (melton, 2016) 	%calcperc (northwestleicestershire, 2016) 	%calcperc (oadbyandwigston, 2016) 	%calcperc (boston, 2016) 	%calcperc (eastlindsey, 2016) 	%calcperc (lincoln, 2016) 	%calcperc (northkesteven, 2016) 	%calcperc (southholland, 2016) 	%calcperc (southkesteven, 2016) 	%calcperc (westlindsey, 2016) 	%calcperc (breckland, 2016) 	%calcperc (broadland, 2016) 	%calcperc (greatyarmouth, 2016) 	%calcperc (kingslynnandwestnorfolk, 2016) 	%calcperc (northnorfolk, 2016) 	%calcperc (norwich, 2016) 	%calcperc (southnorfolk, 2016) 	%calcperc (corby, 2016) 	%calcperc (daventry, 2016) 	%calcperc (eastnorthamptonshire, 2016) 	%calcperc (kettering, 2016) 	%calcperc (northampton, 2016) 	%calcperc (southnorthamptonshire, 2016) 	%calcperc (wellingborough, 2016) 	%calcperc (craven, 2016) 	%calcperc (hambleton, 2016) 	%calcperc (harrogate, 2016) 	%calcperc (richmondshire, 2016) 	%calcperc (ryedale, 2016) 	%calcperc (scarborough, 2016) 	%calcperc (selby, 2016) 	%calcperc (ashfield, 2016) 	%calcperc (bassetlaw, 2016) 	%calcperc (broxtowe, 2016) 	%calcperc (gedling, 2016) 	%calcperc (mansfield, 2016) 	%calcperc (newarkandsherwood, 2016) 	%calcperc (rushcliffe, 2016) 	%calcperc (cherwell, 2016) 	%calcperc (oxford, 2016) 	%calcperc (southoxfordshire, 2016) 	%calcperc (valeofwhitehorse, 2016) 	%calcperc (westoxfordshire, 2016) 	%calcperc (mendip, 2016) 	%calcperc (sedgemoor, 2016) 	%calcperc (southsomerset, 2016) 	%calcperc (tauntondeane, 2016) 	%calcperc (westsomerset, 2016) 	%calcperc (cannockchase, 2016) 	
%calcperc (eaststaffordshire, 2016) 	%calcperc (lichfield, 2016) 	%calcperc (newcastleunderlyme, 2016) 	%calcperc (southstaffordshire, 2016) 	%calcperc (stafford, 2016) 	%calcperc (staffordshiremoorlands, 2016) 	%calcperc (tamworth, 2016) 	%calcperc (babergh, 2016) 	%calcperc (forestheath, 2016) 	%calcperc (ipswich, 2016) 	%calcperc (midsuffolk, 2016) 	%calcperc (stedmundsbury, 2016) 	%calcperc (suffolkcoastal, 2016) 	
%calcperc (waveney, 2016) 	%calcperc (elmbridge, 2016)     %calcperc (epsomandewell, 2016) 	%calcperc (guildford, 2016) 	%calcperc (molevalley, 2016) 	%calcperc (reigateandbanstead, 2016) 	%calcperc (runnymede, 2016) 	%calcperc (spelthorne, 2016) 	%calcperc (surreyheath, 2016) 	%calcperc (tandridge, 2016) 	%calcperc (waverley, 2016) 	%calcperc (woking, 2016) 	%calcperc (northwarwickshire, 2016) 	%calcperc (nuneatonandbedworth, 2016) 	%calcperc (rugby, 2016) 	%calcperc (stratfordonavon, 2016) 	%calcperc (warwick, 2016) 	%calcperc (adur, 2016) 	%calcperc (arun, 2016) 	%calcperc (chichester, 2016) 	%calcperc (crawley, 2016) 	%calcperc (horsham, 2016) 	%calcperc (midsussex, 2016) 	%calcperc (worthing, 2016) 	%calcperc (bromsgrove, 2016) 	%calcperc (malvernhills, 2016) 	%calcperc (redditch, 2016) 	%calcperc (worcester, 2016) 	%calcperc (wychavon, 2016) 	%calcperc (wyreforest, 2016) 	%calcperc (stalbans, 2016) 	%calcperc (welwynhatfield, 2016) 	%calcperc (easthertfordshire, 2016) 	%calcperc (stevenage, 2016) 	%calcperc (bolton, 2016) 	%calcperc (bury, 2016) 	%calcperc (manchester, 2016) 	%calcperc (oldham, 2016) 	%calcperc (rochdale, 2016) 	%calcperc (salford, 2016) 	%calcperc (stockport, 2016) 	%calcperc (tameside, 2016) 	%calcperc (trafford, 2016) 	%calcperc (wigan, 2016) 	%calcperc (knowsley, 2016) 	%calcperc (liverpool, 2016) 	%calcperc (sthelens, 2016) 	%calcperc (sefton, 2016) 	%calcperc (wirral, 2016) 	%calcperc (barnsley, 2016) 	%calcperc (doncaster, 2016) 	%calcperc (rotherham, 2016) 	%calcperc (sheffield, 2016) 	%calcperc (newcastleupontyne, 2016) 	%calcperc (northtyneside, 2016) 	%calcperc (southtyneside, 2016) 	%calcperc (sunderland, 2016) 	%calcperc (birmingham, 2016) 	%calcperc (coventry, 2016) 	%calcperc (dudley, 2016) 	%calcperc (sandwell, 2016) 	%calcperc (solihull, 2016) 	%calcperc (walsall, 2016) 	%calcperc (wolverhampton, 2016) 	%calcperc (bradford, 2016) 	%calcperc (calderdale, 2016) 	%calcperc (kirklees, 2016) 	%calcperc (leeds, 2016) 	%calcperc (wakefield, 2016) 	%calcperc (gateshead, 2016) 	%calcperc (cityoflondon, 2016) 	%calcperc (barkinganddagenham, 2016) 	%calcperc (barnet, 2016) 	%calcperc (bexley, 2016) 	%calcperc (brent, 2016) 	%calcperc (bromley, 2016) 	%calcperc (camden, 2016) 	%calcperc (croydon, 2016) 	%calcperc (ealing, 2016) 	%calcperc (enfield, 2016) 	%calcperc (greenwich, 2016) 	%calcperc (hackney, 2016) 	%calcperc (hammersmithandfulham, 2016) 	%calcperc (haringey, 2016) 	%calcperc (harrow, 2016) 	%calcperc (havering, 2016) 	%calcperc (hillingdon, 2016) 	%calcperc (hounslow, 2016) 	%calcperc (islington, 2016) 	%calcperc (kensingtonandchelsea, 2016) 	%calcperc (kingstonuponthames, 2016) 	%calcperc (lambeth, 2016) 	%calcperc (lewisham, 2016) 	%calcperc (merton, 2016) 	%calcperc (newham, 2016) 	%calcperc (redbridge, 2016) 	%calcperc (richmonduponthames, 2016) 	%calcperc (southwark, 2016) 	%calcperc (sutton, 2016) 	%calcperc (towerhamlets, 2016) 	%calcperc (walthamforest, 2016) 	%calcperc (wandsworth, 2016) 	%calcperc (westminster, 2016) 	%calcperc (buckinghamshire, 2016) 	%calcperc (cambridgeshire, 2016) 	%calcperc (cumbria, 2016) 	%calcperc (derbyshire, 2016) 	%calcperc (devon, 2016) 	%calcperc (dorset, 2016) 	
%calcperc (eastsussex, 2016) 	%calcperc (essex, 2016) 	%calcperc (gloucestershire, 2016) 	%calcperc (hampshire, 2016) 	%calcperc (hertfordshire, 2016) 	%calcperc (kent, 2016) 	%calcperc (lancashire, 2016) 	%calcperc (leicestershire, 2016) 	%calcperc (lincolnshire, 2016) 	%calcperc (norfolk, 2016) 	%calcperc (northamptonshire, 2016) 	%calcperc (northyorkshire, 2016) 	%calcperc (nottinghamshire, 2016) 	%calcperc (oxfordshire, 2016) 	%calcperc (somerset, 2016) 	%calcperc (staffordshire, 2016) 	%calcperc (suffolk, 2016) 	%calcperc (surrey, 2016) 	%calcperc (warwickshire, 2016) 	%calcperc (westsussex, 2016) 	%calcperc (worcestershire, 2016) 	%calcperc (greatermanchester, 2016) 	%calcperc (merseyside, 2016) 	%calcperc (southyorkshire, 2016) 	%calcperc (westmidlands, 2016) 	%calcperc (westyorkshire, 2016) 	%calcperc (tyneandwear, 2016) 	%calcperc (antrimandnewtownabbey, 2016) 	%calcperc (armaghcitybanbridgeandcraigavon, 2016) 	%calcperc (belfast, 2016) 	%calcperc (causewaycoastandglens, 2016) 	%calcperc (derrycityandstrabane, 2016) 	%calcperc (fermanaghandomagh, 2016) 	%calcperc (lisburnandcastlereagh, 2016) 	%calcperc (midandeastantrim, 2016) 	%calcperc (midulster, 2016) 	%calcperc (newrymourneanddown, 2016) 	%calcperc (ardsandnorthdown, 2016) 	%calcperc (clackmannanshire, 2016) 	%calcperc (dumfriesandgalloway, 2016) 	%calcperc (eastayrshire, 2016) 	%calcperc (eastlothian, 2016) 	%calcperc (eastrenfrewshire, 2016) 	%calcperc (naheileanansiar, 2016) 	%calcperc (falkirk, 2016) 	%calcperc (fife, 2016) 	%calcperc (highland, 2016) 	%calcperc (inverclyde, 2016) 	%calcperc (midlothian, 2016) 	%calcperc (moray, 2016) 	%calcperc (northayrshire, 2016) 	%calcperc (orkneyislands, 2016) 	%calcperc (perthandkinross, 2016) 	%calcperc (scottishborders, 2016) 	%calcperc (shetlandislands, 2016) 	%calcperc (southayrshire, 2016) 	%calcperc (southlanarkshire, 2016) 	%calcperc (stirling, 2016) 	%calcperc (aberdeencity, 2016) 	%calcperc (aberdeenshire, 2016) 	%calcperc (argyllandbute, 2016) 	%calcperc (cityofedinburgh, 2016) 	%calcperc (renfrewshire, 2016) 	%calcperc (westdunbartonshire, 2016) 	%calcperc (westlothian, 2016) 	%calcperc (angus, 2016) 	%calcperc (dundeecity, 2016) 	%calcperc (northlanarkshire, 2016) 	%calcperc (eastdunbartonshire, 2016) 	%calcperc (glasgowcity, 2016) 	%calcperc (isleofanglesey, 2016) 	%calcperc (gwynedd, 2016) 	%calcperc (conwy, 2016) 	%calcperc (denbighshire, 2016) 	%calcperc (flintshire, 2016) 	%calcperc (wrexham, 2016) 	%calcperc (ceredigion, 2016) 	%calcperc (pembrokeshire, 2016) 	%calcperc (carmarthenshire, 2016) 	%calcperc (swansea, 2016) 	%calcperc (neathporttalbot, 2016) 	%calcperc (bridgend, 2016) 	%calcperc (valeofglamorgan, 2016) 	%calcperc (cardiff, 2016) 	%calcperc (rhonddacynontaf, 2016) 	%calcperc (caerphilly, 2016) 	%calcperc (blaenaugwent, 2016) 	%calcperc (torfaen, 2016) 	%calcperc (monmouthshire, 2016) 	%calcperc (newport, 2016) 	%calcperc (powys, 2016) 	%calcperc (merthyrtydfil, 2016) 	%calcperc (northeast, 2016) 	%calcperc (northwest, 2016) 	%calcperc (yorkshireandhumber, 2016) 	%calcperc (eastmidlands, 2016) 	%calcperc (westmidlandsregion, 2016) 	%calcperc (east, 2016) 	%calcperc (london, 2016) 	%calcperc (southeast, 2016) 	%calcperc (southwest, 2016) 	
%calcperc (england, 2016) 	%calcperc (northernireland, 2016) 	%calcperc (scotland, 2016) 	%calcperc (wales, 2016) 	%calcperc (englandandwales, 2016) 	%calcperc (greatbritian, 2016) 	%calcperc (unitedkingdom, 2016); 
%calcperc (hartlepool, 2017) 	%calcperc (middlesbrough, 2017) 	%calcperc (redcarandcleveland, 2017) 	%calcperc (stocktonontees, 2017) 	%calcperc (darlington, 2017) 	%calcperc (halton, 2017) 	%calcperc (warrington, 2017) 	%calcperc (blackburnwithdarwen, 2017) 	%calcperc (blackpool, 2017) 	%calcperc (kingstonuponhullcityof, 2017) 	%calcperc (eastridingofyorkshire, 2017) 	%calcperc (northeastlincolnshire, 2017) 	%calcperc (northlincolnshire, 2017) 	%calcperc (york, 2017) 	%calcperc (derby, 2017) 	%calcperc (leicester, 2017) 	%calcperc (rutland, 2017) 	%calcperc (nottingham, 2017) 	%calcperc (herefordshirecountyof, 2017) 	%calcperc (telfordandwrekin, 2017) 	%calcperc (stokeontrent, 2017) 	%calcperc (bathandnortheastsomerset, 2017) 	%calcperc (bristolcityof, 2017) 	%calcperc (northsomerset, 2017) 	%calcperc (southgloucestershire, 2017) 	%calcperc (plymouth, 2017) 	%calcperc (torbay, 2017) 	%calcperc (bournemouth, 2017) 	%calcperc (poole, 2017) 	%calcperc (swindon, 2017) 	%calcperc (peterborough, 2017) 	%calcperc (luton, 2017) 	%calcperc (southendonsea, 2017) 	%calcperc (thurrock, 2017) 	%calcperc (medway, 2017) 	%calcperc (bracknellforest, 2017) 	%calcperc (westberkshire, 2017) 	%calcperc (reading, 2017) 	%calcperc (slough, 2017) 	%calcperc (windsorandmaidenhead, 2017) 	%calcperc (wokingham, 2017) 	%calcperc (miltonkeynes, 2017) 	%calcperc (brightonandhove, 2017) 	%calcperc (portsmouth, 2017) 	%calcperc (southampton, 2017) 	%calcperc (isleofwight, 2017) 	%calcperc (countydurham, 2017) 	%calcperc (cheshireeast, 2017) 	%calcperc (cheshirewestandchester, 2017) 	%calcperc (shropshire, 2017) 	%calcperc (cornwall, 2017) 	%calcperc (islesofscilly, 2017) 	%calcperc (wiltshire, 2017) 	%calcperc (bedford, 2017) 	%calcperc (centralbedfordshire, 2017) 	%calcperc (northumberland, 2017) 	%calcperc (aylesburyvale, 2017) 	%calcperc (chiltern, 2017) 	%calcperc (southbucks, 2017) 	%calcperc (wycombe, 2017) 	%calcperc (cambridge, 2017) 	%calcperc (eastcambridgeshire, 2017) 	%calcperc (fenland, 2017) 	%calcperc (huntingdonshire, 2017) 	%calcperc (southcambridgeshire, 2017) 	%calcperc (allerdale, 2017) 	%calcperc (barrowinfurness, 2017) 	%calcperc (carlisle, 2017) 	%calcperc (copeland, 2017) 	%calcperc (eden, 2017) 	%calcperc (southlakeland, 2017) 	%calcperc (ambervalley, 2017) 	%calcperc (bolsover, 2017) 	%calcperc (chesterfield, 2017) 	%calcperc (derbyshiredales, 2017) 	%calcperc (erewash, 2017) 	%calcperc (highpeak, 2017) 	%calcperc (northeastderbyshire, 2017) 	%calcperc (southderbyshire, 2017) 	%calcperc (eastdevon, 2017) 	%calcperc (exeter, 2017) 	%calcperc (middevon, 2017) 	%calcperc (northdevon, 2017) 	%calcperc (southhams, 2017) 	%calcperc (teignbridge, 2017) 	%calcperc (torridge, 2017) 	%calcperc (westdevon, 2017) 	%calcperc (christchurch, 2017) 	%calcperc (eastdorset, 2017) 	%calcperc (northdorset, 2017) 	%calcperc (purbeck, 2017) 	%calcperc (westdorset, 2017) 	%calcperc (weymouthandportland, 2017) 	%calcperc (eastbourne, 2017) 	%calcperc (hastings, 2017) 	%calcperc (lewes, 2017) 	%calcperc (rother, 2017) 	%calcperc (wealden, 2017) 	%calcperc (basildon, 2017) 	%calcperc (braintree, 2017) 	%calcperc (brentwood, 2017) 	%calcperc (castlepoint, 2017) 	%calcperc (chelmsford, 2017) 	
%calcperc (colchester, 2017) 	%calcperc (eppingforest, 2017) 	%calcperc (harlow, 2017) 	%calcperc (maldon, 2017) 	%calcperc (rochford, 2017) 	%calcperc (tendring, 2017) 	%calcperc (uttlesford, 2017) 	%calcperc (cheltenham, 2017) 	%calcperc (cotswold, 2017) 	%calcperc (forestofdean, 2017) 	%calcperc (gloucester, 2017) 	%calcperc (stroud, 2017) 	%calcperc (tewkesbury, 2017) 	%calcperc (basingstokeanddeane, 2017) 	%calcperc (easthampshire, 2017) 	%calcperc (eastleigh, 2017) 	%calcperc (fareham, 2017) 	%calcperc (gosport, 2017) 	%calcperc (hart, 2017) 	%calcperc (havant, 2017) 	%calcperc (newforest, 2017) 	%calcperc (rushmoor, 2017) 	%calcperc (testvalley, 2017) 	%calcperc (winchester, 2017) 	%calcperc (broxbourne, 2017) 	%calcperc (dacorum, 2017) 	%calcperc (hertsmere, 2017) 	%calcperc (northhertfordshire, 2017) 	%calcperc (threerivers, 2017) 	%calcperc (watford, 2017) 	%calcperc (ashford, 2017) 	%calcperc (canterbury, 2017) 	%calcperc (dartford, 2017) 	%calcperc (dover, 2017) 	%calcperc (gravesham, 2017) 	%calcperc (maidstone, 2017) 	%calcperc (sevenoaks, 2017) 	%calcperc (shepway, 2017) 	%calcperc (swale, 2017) 	%calcperc (thanet, 2017) 	%calcperc (tonbridgeandmalling, 2017) 	%calcperc (tunbridgewells, 2017) 	%calcperc (burnley, 2017) 	%calcperc (chorley, 2017) 	%calcperc (fylde, 2017) 	%calcperc (hyndburn, 2017) 	%calcperc (lancaster, 2017) 	%calcperc (pendle, 2017) 	%calcperc (preston, 2017) 	%calcperc (ribblevalley, 2017) 	%calcperc (rossendale, 2017) 	%calcperc (southribble, 2017) 	%calcperc (westlancashire, 2017) 	%calcperc (wyre, 2017) 	%calcperc (blaby, 2017) 	%calcperc (charnwood, 2017) 	%calcperc (harborough, 2017) 	%calcperc (hinckleyandbosworth, 2017) 	%calcperc (melton, 2017) 	%calcperc (northwestleicestershire, 2017) 	%calcperc (oadbyandwigston, 2017) 	%calcperc (boston, 2017) 	%calcperc (eastlindsey, 2017) 	%calcperc (lincoln, 2017) 	%calcperc (northkesteven, 2017) 	%calcperc (southholland, 2017) 	%calcperc (southkesteven, 2017) 	%calcperc (westlindsey, 2017) 	%calcperc (breckland, 2017) 	%calcperc (broadland, 2017) 	%calcperc (greatyarmouth, 2017) 	%calcperc (kingslynnandwestnorfolk, 2017) 	%calcperc (northnorfolk, 2017) 	%calcperc (norwich, 2017) 	%calcperc (southnorfolk, 2017) 	%calcperc (corby, 2017) 	%calcperc (daventry, 2017) 	%calcperc (eastnorthamptonshire, 2017) 	%calcperc (kettering, 2017) 	%calcperc (northampton, 2017) 	%calcperc (southnorthamptonshire, 2017) 	%calcperc (wellingborough, 2017) 	%calcperc (craven, 2017) 	%calcperc (hambleton, 2017) 	%calcperc (harrogate, 2017) 	%calcperc (richmondshire, 2017) 	%calcperc (ryedale, 2017) 	%calcperc (scarborough, 2017) 	%calcperc (selby, 2017) 	%calcperc (ashfield, 2017) 	%calcperc (bassetlaw, 2017) 	%calcperc (broxtowe, 2017) 	%calcperc (gedling, 2017) 	%calcperc (mansfield, 2017) 	%calcperc (newarkandsherwood, 2017) 	%calcperc (rushcliffe, 2017) 	%calcperc (cherwell, 2017) 	%calcperc (oxford, 2017) 	%calcperc (southoxfordshire, 2017) 	%calcperc (valeofwhitehorse, 2017) 	%calcperc (westoxfordshire, 2017) 	%calcperc (mendip, 2017) 	%calcperc (sedgemoor, 2017) 	%calcperc (southsomerset, 2017) 	%calcperc (tauntondeane, 2017) 	%calcperc (westsomerset, 2017) 	%calcperc (cannockchase, 2017) 	
%calcperc (eaststaffordshire, 2017) 	%calcperc (lichfield, 2017) 	%calcperc (newcastleunderlyme, 2017) 	%calcperc (southstaffordshire, 2017) 	%calcperc (stafford, 2017) 	%calcperc (staffordshiremoorlands, 2017) 	%calcperc (tamworth, 2017) 	%calcperc (babergh, 2017) 	%calcperc (forestheath, 2017) 	%calcperc (ipswich, 2017) 	%calcperc (midsuffolk, 2017) 	%calcperc (stedmundsbury, 2017) 	%calcperc (suffolkcoastal, 2017) 	
%calcperc (waveney, 2017) 	%calcperc (elmbridge, 2017)     %calcperc (epsomandewell, 2017) 	%calcperc (guildford, 2017) 	%calcperc (molevalley, 2017) 	%calcperc (reigateandbanstead, 2017) 	%calcperc (runnymede, 2017) 	%calcperc (spelthorne, 2017) 	%calcperc (surreyheath, 2017) 	%calcperc (tandridge, 2017) 	%calcperc (waverley, 2017) 	%calcperc (woking, 2017) 	%calcperc (northwarwickshire, 2017) 	%calcperc (nuneatonandbedworth, 2017) 	%calcperc (rugby, 2017) 	%calcperc (stratfordonavon, 2017) 	%calcperc (warwick, 2017) 	%calcperc (adur, 2017) 	%calcperc (arun, 2017) 	%calcperc (chichester, 2017) 	%calcperc (crawley, 2017) 	%calcperc (horsham, 2017) 	%calcperc (midsussex, 2017) 	%calcperc (worthing, 2017) 	%calcperc (bromsgrove, 2017) 	%calcperc (malvernhills, 2017) 	%calcperc (redditch, 2017) 	%calcperc (worcester, 2017) 	%calcperc (wychavon, 2017) 	%calcperc (wyreforest, 2017) 	%calcperc (stalbans, 2017) 	%calcperc (welwynhatfield, 2017) 	%calcperc (easthertfordshire, 2017) 	%calcperc (stevenage, 2017) 	%calcperc (bolton, 2017) 	%calcperc (bury, 2017) 	%calcperc (manchester, 2017) 	%calcperc (oldham, 2017) 	%calcperc (rochdale, 2017) 	%calcperc (salford, 2017) 	%calcperc (stockport, 2017) 	%calcperc (tameside, 2017) 	%calcperc (trafford, 2017) 	%calcperc (wigan, 2017) 	%calcperc (knowsley, 2017) 	%calcperc (liverpool, 2017) 	%calcperc (sthelens, 2017) 	%calcperc (sefton, 2017) 	%calcperc (wirral, 2017) 	%calcperc (barnsley, 2017) 	%calcperc (doncaster, 2017) 	%calcperc (rotherham, 2017) 	%calcperc (sheffield, 2017) 	%calcperc (newcastleupontyne, 2017) 	%calcperc (northtyneside, 2017) 	%calcperc (southtyneside, 2017) 	%calcperc (sunderland, 2017) 	%calcperc (birmingham, 2017) 	%calcperc (coventry, 2017) 	%calcperc (dudley, 2017) 	%calcperc (sandwell, 2017) 	%calcperc (solihull, 2017) 	%calcperc (walsall, 2017) 	%calcperc (wolverhampton, 2017) 	%calcperc (bradford, 2017) 	%calcperc (calderdale, 2017) 	%calcperc (kirklees, 2017) 	%calcperc (leeds, 2017) 	%calcperc (wakefield, 2017) 	%calcperc (gateshead, 2017) 	%calcperc (cityoflondon, 2017) 	%calcperc (barkinganddagenham, 2017) 	%calcperc (barnet, 2017) 	%calcperc (bexley, 2017) 	%calcperc (brent, 2017) 	%calcperc (bromley, 2017) 	%calcperc (camden, 2017) 	%calcperc (croydon, 2017) 	%calcperc (ealing, 2017) 	%calcperc (enfield, 2017) 	%calcperc (greenwich, 2017) 	%calcperc (hackney, 2017) 	%calcperc (hammersmithandfulham, 2017) 	%calcperc (haringey, 2017) 	%calcperc (harrow, 2017) 	%calcperc (havering, 2017) 	%calcperc (hillingdon, 2017) 	%calcperc (hounslow, 2017) 	%calcperc (islington, 2017) 	%calcperc (kensingtonandchelsea, 2017) 	%calcperc (kingstonuponthames, 2017) 	%calcperc (lambeth, 2017) 	%calcperc (lewisham, 2017) 	%calcperc (merton, 2017) 	%calcperc (newham, 2017) 	%calcperc (redbridge, 2017) 	%calcperc (richmonduponthames, 2017) 	%calcperc (southwark, 2017) 	%calcperc (sutton, 2017) 	%calcperc (towerhamlets, 2017) 	%calcperc (walthamforest, 2017) 	%calcperc (wandsworth, 2017) 	%calcperc (westminster, 2017) 	%calcperc (buckinghamshire, 2017) 	%calcperc (cambridgeshire, 2017) 	%calcperc (cumbria, 2017) 	%calcperc (derbyshire, 2017) 	%calcperc (devon, 2017) 	%calcperc (dorset, 2017) 	
%calcperc (eastsussex, 2017) 	%calcperc (essex, 2017) 	%calcperc (gloucestershire, 2017) 	%calcperc (hampshire, 2017) 	%calcperc (hertfordshire, 2017) 	%calcperc (kent, 2017) 	%calcperc (lancashire, 2017) 	%calcperc (leicestershire, 2017) 	%calcperc (lincolnshire, 2017) 	%calcperc (norfolk, 2017) 	%calcperc (northamptonshire, 2017) 	%calcperc (northyorkshire, 2017) 	%calcperc (nottinghamshire, 2017) 	%calcperc (oxfordshire, 2017) 	%calcperc (somerset, 2017) 	%calcperc (staffordshire, 2017) 	%calcperc (suffolk, 2017) 	%calcperc (surrey, 2017) 	%calcperc (warwickshire, 2017) 	%calcperc (westsussex, 2017) 	%calcperc (worcestershire, 2017) 	%calcperc (greatermanchester, 2017) 	%calcperc (merseyside, 2017) 	%calcperc (southyorkshire, 2017) 	%calcperc (westmidlands, 2017) 	%calcperc (westyorkshire, 2017) 	%calcperc (tyneandwear, 2017) 	%calcperc (antrimandnewtownabbey, 2017) 	%calcperc (armaghcitybanbridgeandcraigavon, 2017) 	%calcperc (belfast, 2017) 	%calcperc (causewaycoastandglens, 2017) 	%calcperc (derrycityandstrabane, 2017) 	%calcperc (fermanaghandomagh, 2017) 	%calcperc (lisburnandcastlereagh, 2017) 	%calcperc (midandeastantrim, 2017) 	%calcperc (midulster, 2017) 	%calcperc (newrymourneanddown, 2017) 	%calcperc (ardsandnorthdown, 2017) 	%calcperc (clackmannanshire, 2017) 	%calcperc (dumfriesandgalloway, 2017) 	%calcperc (eastayrshire, 2017) 	%calcperc (eastlothian, 2017) 	%calcperc (eastrenfrewshire, 2017) 	%calcperc (naheileanansiar, 2017) 	%calcperc (falkirk, 2017) 	%calcperc (fife, 2017) 	%calcperc (highland, 2017) 	%calcperc (inverclyde, 2017) 	%calcperc (midlothian, 2017) 	%calcperc (moray, 2017) 	%calcperc (northayrshire, 2017) 	%calcperc (orkneyislands, 2017) 	%calcperc (perthandkinross, 2017) 	%calcperc (scottishborders, 2017) 	%calcperc (shetlandislands, 2017) 	%calcperc (southayrshire, 2017) 	%calcperc (southlanarkshire, 2017) 	%calcperc (stirling, 2017) 	%calcperc (aberdeencity, 2017) 	%calcperc (aberdeenshire, 2017) 	%calcperc (argyllandbute, 2017) 	%calcperc (cityofedinburgh, 2017) 	%calcperc (renfrewshire, 2017) 	%calcperc (westdunbartonshire, 2017) 	%calcperc (westlothian, 2017) 	%calcperc (angus, 2017) 	%calcperc (dundeecity, 2017) 	%calcperc (northlanarkshire, 2017) 	%calcperc (eastdunbartonshire, 2017) 	%calcperc (glasgowcity, 2017) 	%calcperc (isleofanglesey, 2017) 	%calcperc (gwynedd, 2017) 	%calcperc (conwy, 2017) 	%calcperc (denbighshire, 2017) 	%calcperc (flintshire, 2017) 	%calcperc (wrexham, 2017) 	%calcperc (ceredigion, 2017) 	%calcperc (pembrokeshire, 2017) 	%calcperc (carmarthenshire, 2017) 	%calcperc (swansea, 2017) 	%calcperc (neathporttalbot, 2017) 	%calcperc (bridgend, 2017) 	%calcperc (valeofglamorgan, 2017) 	%calcperc (cardiff, 2017) 	%calcperc (rhonddacynontaf, 2017) 	%calcperc (caerphilly, 2017) 	%calcperc (blaenaugwent, 2017) 	%calcperc (torfaen, 2017) 	%calcperc (monmouthshire, 2017) 	%calcperc (newport, 2017) 	%calcperc (powys, 2017) 	%calcperc (merthyrtydfil, 2017)	%calcperc (northeast, 2017) 	%calcperc (northwest, 2017) 	%calcperc (yorkshireandhumber, 2017) 	%calcperc (eastmidlands, 2017) 	%calcperc (westmidlandsregion, 2017) 	%calcperc (east, 2017) 	%calcperc (london, 2017) 	%calcperc (southeast, 2017) 	%calcperc (southwest, 2017) 	
%calcperc (england, 2017) 	%calcperc (northernireland, 2017) 	%calcperc (scotland, 2017) 	%calcperc (wales, 2017) 	%calcperc (englandandwales, 2017) 	%calcperc (greatbritian, 2017) 	%calcperc (unitedkingdom, 2017); 
%calcperc (hartlepool, 2018) 	%calcperc (middlesbrough, 2018) 	%calcperc (redcarandcleveland, 2018) 	%calcperc (stocktonontees, 2018) 	%calcperc (darlington, 2018) 	%calcperc (halton, 2018) 	%calcperc (warrington, 2018) 	%calcperc (blackburnwithdarwen, 2018) 	%calcperc (blackpool, 2018) 	%calcperc (kingstonuponhullcityof, 2018) 	%calcperc (eastridingofyorkshire, 2018) 	%calcperc (northeastlincolnshire, 2018) 	%calcperc (northlincolnshire, 2018) 	%calcperc (york, 2018) 	%calcperc (derby, 2018) 	%calcperc (leicester, 2018) 	%calcperc (rutland, 2018) 	%calcperc (nottingham, 2018) 	%calcperc (herefordshirecountyof, 2018) 	%calcperc (telfordandwrekin, 2018) 	%calcperc (stokeontrent, 2018) 	%calcperc (bathandnortheastsomerset, 2018) 	%calcperc (bristolcityof, 2018) 	%calcperc (northsomerset, 2018) 	%calcperc (southgloucestershire, 2018) 	%calcperc (plymouth, 2018) 	%calcperc (torbay, 2018) 	%calcperc (bournemouth, 2018) 	%calcperc (poole, 2018) 	%calcperc (swindon, 2018) 	%calcperc (peterborough, 2018) 	%calcperc (luton, 2018) 	%calcperc (southendonsea, 2018) 	%calcperc (thurrock, 2018) 	%calcperc (medway, 2018) 	%calcperc (bracknellforest, 2018) 	%calcperc (westberkshire, 2018) 	%calcperc (reading, 2018) 	%calcperc (slough, 2018) 	%calcperc (windsorandmaidenhead, 2018) 	%calcperc (wokingham, 2018) 	%calcperc (miltonkeynes, 2018) 	%calcperc (brightonandhove, 2018) 	%calcperc (portsmouth, 2018) 	%calcperc (southampton, 2018) 	%calcperc (isleofwight, 2018) 	%calcperc (countydurham, 2018) 	%calcperc (cheshireeast, 2018) 	%calcperc (cheshirewestandchester, 2018) 	%calcperc (shropshire, 2018) 	%calcperc (cornwall, 2018) 	%calcperc (islesofscilly, 2018) 	%calcperc (wiltshire, 2018) 	%calcperc (bedford, 2018) 	%calcperc (centralbedfordshire, 2018) 	%calcperc (northumberland, 2018) 	%calcperc (aylesburyvale, 2018) 	%calcperc (chiltern, 2018) 	%calcperc (southbucks, 2018) 	%calcperc (wycombe, 2018) 	%calcperc (cambridge, 2018) 	%calcperc (eastcambridgeshire, 2018) 	%calcperc (fenland, 2018) 	%calcperc (huntingdonshire, 2018) 	%calcperc (southcambridgeshire, 2018) 	%calcperc (allerdale, 2018) 	%calcperc (barrowinfurness, 2018) 	%calcperc (carlisle, 2018) 	%calcperc (copeland, 2018) 	%calcperc (eden, 2018) 	%calcperc (southlakeland, 2018) 	%calcperc (ambervalley, 2018) 	%calcperc (bolsover, 2018) 	%calcperc (chesterfield, 2018) 	%calcperc (derbyshiredales, 2018) 	%calcperc (erewash, 2018) 	%calcperc (highpeak, 2018) 	%calcperc (northeastderbyshire, 2018) 	%calcperc (southderbyshire, 2018) 	%calcperc (eastdevon, 2018) 	%calcperc (exeter, 2018) 	%calcperc (middevon, 2018) 	%calcperc (northdevon, 2018) 	%calcperc (southhams, 2018) 	%calcperc (teignbridge, 2018) 	%calcperc (torridge, 2018) 	%calcperc (westdevon, 2018) 	%calcperc (christchurch, 2018) 	%calcperc (eastdorset, 2018) 	%calcperc (northdorset, 2018) 	%calcperc (purbeck, 2018) 	%calcperc (westdorset, 2018) 	%calcperc (weymouthandportland, 2018) 	%calcperc (eastbourne, 2018) 	%calcperc (hastings, 2018) 	%calcperc (lewes, 2018) 	%calcperc (rother, 2018) 	%calcperc (wealden, 2018) 	%calcperc (basildon, 2018) 	%calcperc (braintree, 2018) 	%calcperc (brentwood, 2018) 	%calcperc (castlepoint, 2018) 	%calcperc (chelmsford, 2018) 	%calcperc (colchester, 2018) 	
%calcperc (eppingforest, 2018) 	%calcperc (harlow, 2018) 	%calcperc (maldon, 2018) 	%calcperc (rochford, 2018) 	%calcperc (tendring, 2018) 	%calcperc (uttlesford, 2018) 	%calcperc (cheltenham, 2018) 	%calcperc (cotswold, 2018) 	%calcperc (forestofdean, 2018) 	%calcperc (gloucester, 2018) 	%calcperc (stroud, 2018) 	%calcperc (tewkesbury, 2018) 	%calcperc (basingstokeanddeane, 2018) 	%calcperc (easthampshire, 2018) 	%calcperc (eastleigh, 2018) 	%calcperc (fareham, 2018) 	%calcperc (gosport, 2018) 	%calcperc (hart, 2018) 	%calcperc (havant, 2018) 	%calcperc (newforest, 2018) 	%calcperc (rushmoor, 2018) 	%calcperc (testvalley, 2018) 	%calcperc (winchester, 2018) 	%calcperc (broxbourne, 2018) 	%calcperc (dacorum, 2018) 	%calcperc (hertsmere, 2018) 	%calcperc (northhertfordshire, 2018) 	%calcperc (threerivers, 2018) 	%calcperc (watford, 2018) 	%calcperc (ashford, 2018) 	%calcperc (canterbury, 2018) 	%calcperc (dartford, 2018) 	%calcperc (dover, 2018) 	%calcperc (gravesham, 2018) 	%calcperc (maidstone, 2018) 	%calcperc (sevenoaks, 2018) 	%calcperc (shepway, 2018) 	%calcperc (swale, 2018) 	%calcperc (thanet, 2018) 	%calcperc (tonbridgeandmalling, 2018) 	%calcperc (tunbridgewells, 2018) 	%calcperc (burnley, 2018) 	%calcperc (chorley, 2018) 	%calcperc (fylde, 2018) 	%calcperc (hyndburn, 2018) 	%calcperc (lancaster, 2018) 	%calcperc (pendle, 2018) 	%calcperc (preston, 2018) 	%calcperc (ribblevalley, 2018) 	%calcperc (rossendale, 2018) 	%calcperc (southribble, 2018) 	%calcperc (westlancashire, 2018) 	%calcperc (wyre, 2018) 	%calcperc (blaby, 2018) 	%calcperc (charnwood, 2018) 	%calcperc (harborough, 2018) 	%calcperc (hinckleyandbosworth, 2018) 	%calcperc (melton, 2018) 	%calcperc (northwestleicestershire, 2018) 	%calcperc (oadbyandwigston, 2018) 	%calcperc (boston, 2018) 	%calcperc (eastlindsey, 2018) 	%calcperc (lincoln, 2018) 	%calcperc (northkesteven, 2018) 	%calcperc (southholland, 2018) 	%calcperc (southkesteven, 2018) 	%calcperc (westlindsey, 2018) 	%calcperc (breckland, 2018) 	%calcperc (broadland, 2018) 	%calcperc (greatyarmouth, 2018) 	%calcperc (kingslynnandwestnorfolk, 2018) 	%calcperc (northnorfolk, 2018) 	%calcperc (norwich, 2018) 	%calcperc (southnorfolk, 2018) 	%calcperc (corby, 2018) 	%calcperc (daventry, 2018) 	%calcperc (eastnorthamptonshire, 2018) 	%calcperc (kettering, 2018) 	%calcperc (northampton, 2018) 	%calcperc (southnorthamptonshire, 2018) 	%calcperc (wellingborough, 2018) 	%calcperc (craven, 2018) 	%calcperc (hambleton, 2018) 	%calcperc (harrogate, 2018) 	%calcperc (richmondshire, 2018) 	%calcperc (ryedale, 2018) 	%calcperc (scarborough, 2018) 	%calcperc (selby, 2018) 	%calcperc (ashfield, 2018) 	%calcperc (bassetlaw, 2018) 	%calcperc (broxtowe, 2018) 	%calcperc (gedling, 2018) 	%calcperc (mansfield, 2018) 	%calcperc (newarkandsherwood, 2018) 	%calcperc (rushcliffe, 2018) 	%calcperc (cherwell, 2018) 	%calcperc (oxford, 2018) 	%calcperc (southoxfordshire, 2018) 	%calcperc (valeofwhitehorse, 2018) 	%calcperc (westoxfordshire, 2018) 	%calcperc (mendip, 2018) 	%calcperc (sedgemoor, 2018) 	%calcperc (southsomerset, 2018) 	%calcperc (tauntondeane, 2018) 	%calcperc (westsomerset, 2018) 	%calcperc (cannockchase, 2018) 	%calcperc (eaststaffordshire, 2018) 	
%calcperc (lichfield, 2018) 	%calcperc (newcastleunderlyme, 2018) 	%calcperc (southstaffordshire, 2018) 	%calcperc (stafford, 2018) 	%calcperc (staffordshiremoorlands, 2018) 	%calcperc (tamworth, 2018) 	%calcperc (babergh, 2018) 	%calcperc (forestheath, 2018) 	%calcperc (ipswich, 2018) 	%calcperc (midsuffolk, 2018) 	%calcperc (stedmundsbury, 2018) 	%calcperc (suffolkcoastal, 2018) 	
%calcperc (waveney, 2018) 	%calcperc (elmbridge, 2018) %calcperc (epsomandewell, 2018) 	%calcperc (guildford, 2018) 	%calcperc (molevalley, 2018) 	%calcperc (reigateandbanstead, 2018) 	%calcperc (runnymede, 2018) 	%calcperc (spelthorne, 2018) 	%calcperc (surreyheath, 2018) 	%calcperc (tandridge, 2018) 	%calcperc (waverley, 2018) 	%calcperc (woking, 2018) 	%calcperc (northwarwickshire, 2018) 	%calcperc (nuneatonandbedworth, 2018) 	%calcperc (rugby, 2018) 	%calcperc (stratfordonavon, 2018) 	%calcperc (warwick, 2018) 	%calcperc (adur, 2018) 	%calcperc (arun, 2018) 	%calcperc (chichester, 2018) 	%calcperc (crawley, 2018) 	%calcperc (horsham, 2018) 	%calcperc (midsussex, 2018) 	%calcperc (worthing, 2018) 	%calcperc (bromsgrove, 2018) 	%calcperc (malvernhills, 2018) 	%calcperc (redditch, 2018) 	%calcperc (worcester, 2018) 	%calcperc (wychavon, 2018) 	%calcperc (wyreforest, 2018) 	%calcperc (stalbans, 2018) 	%calcperc (welwynhatfield, 2018) 	%calcperc (easthertfordshire, 2018) 	%calcperc (stevenage, 2018) 	%calcperc (bolton, 2018) 	%calcperc (bury, 2018) 	%calcperc (manchester, 2018) 	%calcperc (oldham, 2018) 	%calcperc (rochdale, 2018) 	%calcperc (salford, 2018) 	%calcperc (stockport, 2018) 	%calcperc (tameside, 2018) 	%calcperc (trafford, 2018) 	%calcperc (wigan, 2018) 	%calcperc (knowsley, 2018) 	%calcperc (liverpool, 2018) 	%calcperc (sthelens, 2018) 	%calcperc (sefton, 2018) 	%calcperc (wirral, 2018) 	%calcperc (barnsley, 2018) 	%calcperc (doncaster, 2018) 	%calcperc (rotherham, 2018) 	%calcperc (sheffield, 2018) 	%calcperc (newcastleupontyne, 2018) 	%calcperc (northtyneside, 2018) 	%calcperc (southtyneside, 2018) 	%calcperc (sunderland, 2018) 	%calcperc (birmingham, 2018) 	%calcperc (coventry, 2018) 	%calcperc (dudley, 2018) 	%calcperc (sandwell, 2018) 	%calcperc (solihull, 2018) 	%calcperc (walsall, 2018) 	%calcperc (wolverhampton, 2018) 	%calcperc (bradford, 2018) 	%calcperc (calderdale, 2018) 	%calcperc (kirklees, 2018) 	%calcperc (leeds, 2018) 	%calcperc (wakefield, 2018) 	%calcperc (gateshead, 2018) 	%calcperc (cityoflondon, 2018) 	%calcperc (barkinganddagenham, 2018) 	%calcperc (barnet, 2018) 	%calcperc (bexley, 2018) 	%calcperc (brent, 2018) 	%calcperc (bromley, 2018) 	%calcperc (camden, 2018) 	%calcperc (croydon, 2018) 	%calcperc (ealing, 2018) 	%calcperc (enfield, 2018) 	%calcperc (greenwich, 2018) 	%calcperc (hackney, 2018) 	%calcperc (hammersmithandfulham, 2018) 	%calcperc (haringey, 2018) 	%calcperc (harrow, 2018) 	%calcperc (havering, 2018) 	%calcperc (hillingdon, 2018) 	%calcperc (hounslow, 2018) 	%calcperc (islington, 2018) 	%calcperc (kensingtonandchelsea, 2018) 	%calcperc (kingstonuponthames, 2018) 	%calcperc (lambeth, 2018) 	%calcperc (lewisham, 2018) 	%calcperc (merton, 2018) 	%calcperc (newham, 2018) 	%calcperc (redbridge, 2018) 	%calcperc (richmonduponthames, 2018) 	%calcperc (southwark, 2018) 	%calcperc (sutton, 2018) 	%calcperc (towerhamlets, 2018) 	%calcperc (walthamforest, 2018) 	%calcperc (wandsworth, 2018) 	%calcperc (westminster, 2018) 	%calcperc (buckinghamshire, 2018) 	%calcperc (cambridgeshire, 2018) 	%calcperc (cumbria, 2018) 	%calcperc (derbyshire, 2018) 	%calcperc (devon, 2018) 	%calcperc (dorset, 2018) 	%calcperc (eastsussex, 2018) 	
%calcperc (essex, 2018) 	%calcperc (gloucestershire, 2018) 	%calcperc (hampshire, 2018) 	%calcperc (hertfordshire, 2018) 	%calcperc (kent, 2018) 	%calcperc (lancashire, 2018) 	%calcperc (leicestershire, 2018) 	%calcperc (lincolnshire, 2018) 	%calcperc (norfolk, 2018) 	%calcperc (northamptonshire, 2018) 	%calcperc (northyorkshire, 2018) 	%calcperc (nottinghamshire, 2018) 	%calcperc (oxfordshire, 2018) 	%calcperc (somerset, 2018) 	%calcperc (staffordshire, 2018) 	%calcperc (suffolk, 2018) 	%calcperc (surrey, 2018) 	%calcperc (warwickshire, 2018) 	%calcperc (westsussex, 2018) 	%calcperc (worcestershire, 2018) 	%calcperc (greatermanchester, 2018) 	%calcperc (merseyside, 2018) 	%calcperc (southyorkshire, 2018) 	%calcperc (westmidlands, 2018) 	%calcperc (westyorkshire, 2018) 	%calcperc (tyneandwear, 2018) 	%calcperc (antrimandnewtownabbey, 2018) 	%calcperc (armaghcitybanbridgeandcraigavon, 2018) 	%calcperc (belfast, 2018) 	%calcperc (causewaycoastandglens, 2018) 	%calcperc (derrycityandstrabane, 2018) 	%calcperc (fermanaghandomagh, 2018) 	%calcperc (lisburnandcastlereagh, 2018) 	%calcperc (midandeastantrim, 2018) 	%calcperc (midulster, 2018) 	%calcperc (newrymourneanddown, 2018) 	%calcperc (ardsandnorthdown, 2018) 	%calcperc (clackmannanshire, 2018) 	%calcperc (dumfriesandgalloway, 2018) 	%calcperc (eastayrshire, 2018) 	%calcperc (eastlothian, 2018) 	%calcperc (eastrenfrewshire, 2018) 	%calcperc (naheileanansiar, 2018) 	%calcperc (falkirk, 2018) 	%calcperc (fife, 2018) 	%calcperc (highland, 2018) 	%calcperc (inverclyde, 2018) 	%calcperc (midlothian, 2018) 	%calcperc (moray, 2018) 	%calcperc (northayrshire, 2018) 	%calcperc (orkneyislands, 2018) 	%calcperc (perthandkinross, 2018) 	%calcperc (scottishborders, 2018) 	%calcperc (shetlandislands, 2018) 	%calcperc (southayrshire, 2018) 	%calcperc (southlanarkshire, 2018) 	%calcperc (stirling, 2018) 	%calcperc (aberdeencity, 2018) 	%calcperc (aberdeenshire, 2018) 	%calcperc (argyllandbute, 2018) 	%calcperc (cityofedinburgh, 2018) 	%calcperc (renfrewshire, 2018) 	%calcperc (westdunbartonshire, 2018) 	%calcperc (westlothian, 2018) 	%calcperc (angus, 2018) 	%calcperc (dundeecity, 2018) 	%calcperc (northlanarkshire, 2018) 	%calcperc (eastdunbartonshire, 2018) 	%calcperc (glasgowcity, 2018) 	%calcperc (isleofanglesey, 2018) 	%calcperc (gwynedd, 2018) 	%calcperc (conwy, 2018) 	%calcperc (denbighshire, 2018) 	%calcperc (flintshire, 2018) 	%calcperc (wrexham, 2018) 	%calcperc (ceredigion, 2018) 	%calcperc (pembrokeshire, 2018) 	%calcperc (carmarthenshire, 2018) 	%calcperc (swansea, 2018) 	%calcperc (neathporttalbot, 2018) 	%calcperc (bridgend, 2018) 	%calcperc (valeofglamorgan, 2018) 	%calcperc (cardiff, 2018) 	%calcperc (rhonddacynontaf, 2018) 	%calcperc (caerphilly, 2018) 	%calcperc (blaenaugwent, 2018) 	%calcperc (torfaen, 2018) 	%calcperc (monmouthshire, 2018) 	%calcperc (newport, 2018) 	%calcperc (powys, 2018) 	%calcperc (merthyrtydfil, 2018) 	%calcperc (northeast, 2018) 	%calcperc (northwest, 2018) 	%calcperc (yorkshireandhumber, 2018) 	%calcperc (eastmidlands, 2018) 	%calcperc (westmidlandsregion, 2018) 	%calcperc (east, 2018) 	%calcperc (london, 2018) 	%calcperc (southeast, 2018) 	%calcperc (southwest, 2018) 	%calcperc (england, 2018) 	
%calcperc (northernireland, 2018) 	%calcperc (scotland, 2018) 	%calcperc (wales, 2018) 	%calcperc (englandandwales, 2018) 	%calcperc (greatbritian, 2018) 	%calcperc (unitedkingdom, 2018); 





%macro maximums (variable);

DATA &variable.2;
	SET &variable. (DROP=i);
    maxagegrpperc = MAX(of m_01_perc1--f_18_perc91);
	maxagegrpnum = MAX(maxagegrpnum_01,maxagegrpnum_02,maxagegrpnum_03, maxagegrpnum_04, maxagegrpnum_05, maxagegrpnum_06, maxagegrpnum_07, maxagegrpnum_08, maxagegrpnum_09, maxagegrpnum_10,maxagegrpnum_11,maxagegrpnum_12,maxagegrpnum_13,maxagegrpnum_14,maxagegrpnum_15,maxagegrpnum_16,maxagegrpnum_17,maxagegrpnum_18);
RUN;

%mend;
%maximums(hartlepool)
%maximums(middlesbrough)
%maximums(redcarandcleveland)
%maximums(stocktonontees)
%maximums(darlington)
%maximums(halton)
%maximums(warrington)
%maximums(blackburnwithdarwen)
%maximums(blackpool)
%maximums(kingstonuponhullcityof)
%maximums(eastridingofyorkshire)
%maximums(northeastlincolnshire)
%maximums(northlincolnshire)
%maximums(york)
%maximums(derby)
%maximums(leicester)
%maximums(rutland)
%maximums(nottingham)
%maximums(herefordshirecountyof)
%maximums(telfordandwrekin)
%maximums(stokeontrent)
%maximums(bathandnortheastsomerset)
%maximums(bristolcityof)
%maximums(northsomerset)
%maximums(southgloucestershire)
%maximums(plymouth)
%maximums(torbay)
%maximums(bournemouth)
%maximums(poole)
%maximums(swindon)
%maximums(peterborough)
%maximums(luton)
%maximums(southendonsea)
%maximums(thurrock)
%maximums(medway)
%maximums(bracknellforest)
%maximums(westberkshire)
%maximums(reading)
%maximums(slough)
%maximums(windsorandmaidenhead)
%maximums(wokingham)
%maximums(miltonkeynes)
%maximums(brightonandhove)
%maximums(portsmouth)
%maximums(southampton)
%maximums(isleofwight)
%maximums(countydurham)
%maximums(cheshireeast)
%maximums(cheshirewestandchester)
%maximums(shropshire)
%maximums(cornwall)
%maximums(islesofscilly)
%maximums(wiltshire)
%maximums(bedford)
%maximums(centralbedfordshire)
%maximums(northumberland)
%maximums(aylesburyvale)
%maximums(chiltern)
%maximums(southbucks)
%maximums(wycombe)
%maximums(cambridge)
%maximums(eastcambridgeshire)
%maximums(fenland)
%maximums(huntingdonshire)
%maximums(southcambridgeshire)
%maximums(allerdale)
%maximums(barrowinfurness)
%maximums(carlisle)
%maximums(copeland)
%maximums(eden)
%maximums(southlakeland)
%maximums(ambervalley)
%maximums(bolsover)
%maximums(chesterfield)
%maximums(derbyshiredales)
%maximums(erewash)
%maximums(highpeak)
%maximums(northeastderbyshire)
%maximums(southderbyshire)
%maximums(eastdevon)
%maximums(exeter)
%maximums(middevon)
%maximums(northdevon)
%maximums(southhams)
%maximums(teignbridge)
%maximums(torridge)
%maximums(westdevon)
%maximums(christchurch)
%maximums(eastdorset)
%maximums(northdorset)
%maximums(purbeck)
%maximums(westdorset)
%maximums(weymouthandportland)
%maximums(eastbourne)
%maximums(hastings)
%maximums(lewes)
%maximums(rother)
%maximums(wealden)
%maximums(basildon)
%maximums(braintree)
%maximums(brentwood)
%maximums(castlepoint)
%maximums(chelmsford)
%maximums(colchester)
%maximums(eppingforest)
%maximums(harlow)
%maximums(maldon)
%maximums(rochford)
%maximums(tendring)
%maximums(uttlesford)
%maximums(cheltenham)
%maximums(cotswold)
%maximums(forestofdean)
%maximums(gloucester)
%maximums(stroud)
%maximums(tewkesbury)
%maximums(basingstokeanddeane)
%maximums(easthampshire)
%maximums(eastleigh)
%maximums(fareham)
%maximums(gosport)
%maximums(hart)
%maximums(havant)
%maximums(newforest)
%maximums(rushmoor)
%maximums(testvalley)
%maximums(winchester)
%maximums(broxbourne)
%maximums(dacorum)
%maximums(hertsmere)
%maximums(northhertfordshire)
%maximums(threerivers)
%maximums(watford)
%maximums(ashford)
%maximums(canterbury)
%maximums(dartford)
%maximums(dover)
%maximums(gravesham)
%maximums(maidstone)
%maximums(sevenoaks)
%maximums(shepway)
%maximums(swale)
%maximums(thanet)
%maximums(tonbridgeandmalling)
%maximums(tunbridgewells)
%maximums(burnley)
%maximums(chorley)
%maximums(fylde)
%maximums(hyndburn)
%maximums(lancaster)
%maximums(pendle)
%maximums(preston)
%maximums(ribblevalley)
%maximums(rossendale)
%maximums(southribble)
%maximums(westlancashire)
%maximums(wyre)
%maximums(blaby)
%maximums(charnwood)
%maximums(harborough)
%maximums(hinckleyandbosworth)
%maximums(melton)
%maximums(northwestleicestershire)
%maximums(oadbyandwigston)
%maximums(boston)
%maximums(eastlindsey)
%maximums(lincoln)
%maximums(northkesteven)
%maximums(southholland)
%maximums(southkesteven)
%maximums(westlindsey)
%maximums(breckland)
%maximums(broadland)
%maximums(greatyarmouth)
%maximums(kingslynnandwestnorfolk)
%maximums(northnorfolk)
%maximums(norwich)
%maximums(southnorfolk)
%maximums(corby)
%maximums(daventry)
%maximums(eastnorthamptonshire)
%maximums(kettering)
%maximums(northampton)
%maximums(southnorthamptonshire)
%maximums(wellingborough)
%maximums(craven)
%maximums(hambleton)
%maximums(harrogate)
%maximums(richmondshire)
%maximums(ryedale)
%maximums(scarborough)
%maximums(selby)
%maximums(ashfield)
%maximums(bassetlaw)
%maximums(broxtowe)
%maximums(gedling)
%maximums(mansfield)
%maximums(newarkandsherwood)
%maximums(rushcliffe)
%maximums(cherwell)
%maximums(oxford)
%maximums(southoxfordshire)
%maximums(valeofwhitehorse)
%maximums(westoxfordshire)
%maximums(mendip)
%maximums(sedgemoor)
%maximums(southsomerset)
%maximums(tauntondeane)
%maximums(westsomerset)
%maximums(cannockchase)
%maximums(eaststaffordshire)
%maximums(lichfield)
%maximums(newcastleunderlyme)
%maximums(southstaffordshire)
%maximums(stafford)
%maximums(staffordshiremoorlands)
%maximums(tamworth)
%maximums(babergh)
%maximums(forestheath)
%maximums(ipswich)
%maximums(midsuffolk)
%maximums(stedmundsbury)
%maximums(suffolkcoastal)
%maximums(waveney)
%maximums(elmbridge)
%maximums(epsomandewell)
%maximums(guildford)
%maximums(molevalley)
%maximums(reigateandbanstead)
%maximums(runnymede)
%maximums(spelthorne)
%maximums(surreyheath)
%maximums(tandridge)
%maximums(waverley)
%maximums(woking)
%maximums(northwarwickshire)
%maximums(nuneatonandbedworth)
%maximums(rugby)
%maximums(stratfordonavon)
%maximums(warwick)
%maximums(adur)
%maximums(arun)
%maximums(chichester)
%maximums(crawley)
%maximums(horsham)
%maximums(midsussex)
%maximums(worthing)
%maximums(bromsgrove)
%maximums(malvernhills)
%maximums(redditch)
%maximums(worcester)
%maximums(wychavon)
%maximums(wyreforest)
%maximums(stalbans)
%maximums(welwynhatfield)
%maximums(easthertfordshire)
%maximums(stevenage)
%maximums(bolton)
%maximums(bury)
%maximums(manchester)
%maximums(oldham)
%maximums(rochdale)
%maximums(salford)
%maximums(stockport)
%maximums(tameside)
%maximums(trafford)
%maximums(wigan)
%maximums(knowsley)
%maximums(liverpool)
%maximums(sthelens)
%maximums(sefton)
%maximums(wirral)
%maximums(barnsley)
%maximums(doncaster)
%maximums(rotherham)
%maximums(sheffield)
%maximums(newcastleupontyne)
%maximums(northtyneside)
%maximums(southtyneside)
%maximums(sunderland)
%maximums(birmingham)
%maximums(coventry)
%maximums(dudley)
%maximums(sandwell)
%maximums(solihull)
%maximums(walsall)
%maximums(wolverhampton)
%maximums(bradford)
%maximums(calderdale)
%maximums(kirklees)
%maximums(leeds)
%maximums(wakefield)
%maximums(gateshead)
%maximums(cityoflondon)
%maximums(barkinganddagenham)
%maximums(barnet)
%maximums(bexley)
%maximums(brent)
%maximums(bromley)
%maximums(camden)
%maximums(croydon)
%maximums(ealing)
%maximums(enfield)
%maximums(greenwich)
%maximums(hackney)
%maximums(hammersmithandfulham)
%maximums(haringey)
%maximums(harrow)
%maximums(havering)
%maximums(hillingdon)
%maximums(hounslow)
%maximums(islington)
%maximums(kensingtonandchelsea)
%maximums(kingstonuponthames)
%maximums(lambeth)
%maximums(lewisham)
%maximums(merton)
%maximums(newham)
%maximums(redbridge)
%maximums(richmonduponthames)
%maximums(southwark)
%maximums(sutton)
%maximums(towerhamlets)
%maximums(walthamforest)
%maximums(wandsworth)
%maximums(westminster)
%maximums(buckinghamshire)
%maximums(cambridgeshire)
%maximums(cumbria)
%maximums(derbyshire)
%maximums(devon)
%maximums(dorset)
%maximums(eastsussex)
%maximums(essex)
%maximums(gloucestershire)
%maximums(hampshire)
%maximums(hertfordshire)
%maximums(kent)
%maximums(lancashire)
%maximums(leicestershire)
%maximums(lincolnshire)
%maximums(norfolk)
%maximums(northamptonshire)
%maximums(northyorkshire)
%maximums(nottinghamshire)
%maximums(oxfordshire)
%maximums(somerset)
%maximums(staffordshire)
%maximums(suffolk)
%maximums(surrey)
%maximums(warwickshire)
%maximums(westsussex)
%maximums(worcestershire)
%maximums(greatermanchester)
%maximums(merseyside)
%maximums(southyorkshire)
%maximums(westmidlands)
%maximums(westyorkshire)
%maximums(tyneandwear)
%maximums(antrimandnewtownabbey)
%maximums(armaghcitybanbridgeandcraigavon)
%maximums(belfast)
%maximums(causewaycoastandglens)
%maximums(derrycityandstrabane)
%maximums(fermanaghandomagh)
%maximums(lisburnandcastlereagh)
%maximums(midandeastantrim)
%maximums(midulster)
%maximums(newrymourneanddown)
%maximums(ardsandnorthdown)
%maximums(clackmannanshire)
%maximums(dumfriesandgalloway)
%maximums(eastayrshire)
%maximums(eastlothian)
%maximums(eastrenfrewshire)
%maximums(naheileanansiar)
%maximums(falkirk)
%maximums(fife)
%maximums(highland)
%maximums(inverclyde)
%maximums(midlothian)
%maximums(moray)
%maximums(northayrshire)
%maximums(orkneyislands)
%maximums(perthandkinross)
%maximums(scottishborders)
%maximums(shetlandislands)
%maximums(southayrshire)
%maximums(southlanarkshire)
%maximums(stirling)
%maximums(aberdeencity)
%maximums(aberdeenshire)
%maximums(argyllandbute)
%maximums(cityofedinburgh)
%maximums(renfrewshire)
%maximums(westdunbartonshire)
%maximums(westlothian)
%maximums(angus)
%maximums(dundeecity)
%maximums(northlanarkshire)
%maximums(eastdunbartonshire)
%maximums(glasgowcity)
%maximums(isleofanglesey)
%maximums(gwynedd)
%maximums(conwy)
%maximums(denbighshire)
%maximums(flintshire)
%maximums(wrexham)
%maximums(ceredigion)
%maximums(pembrokeshire)
%maximums(carmarthenshire)
%maximums(swansea)
%maximums(neathporttalbot)
%maximums(bridgend)
%maximums(valeofglamorgan)
%maximums(cardiff)
%maximums(rhonddacynontaf)
%maximums(caerphilly)
%maximums(blaenaugwent)
%maximums(torfaen)
%maximums(monmouthshire)
%maximums(newport)
%maximums(powys)
%maximums(merthyrtydfil)
%maximums(northeast)
%maximums(northwest)
%maximums(yorkshireandhumber)
%maximums(eastmidlands)
%maximums(westmidlandsregion)
%maximums(east)
%maximums(london)
%maximums(southeast)
%maximums(southwest)
%maximums(england)
%maximums(northernireland)
%maximums(scotland)
%maximums(wales)
%maximums(englandandwales)
%maximums(greatbritian)
%maximums(unitedkingdom);


/*add total population, total female population and total male population for each year to each file*/

/*DATA totalpopulationplus (KEEP = ptot_01_al ptot_02_al ptot_03_al ptot_04_al ptot_05_al ptot_06_al ptot_07_al
	ptot_08_al ptot_09_al ptot_10_al ptot_11_al ptot_12_al
	pm_01_al pm_02_al pm_03_al pm_04_al pm_05_al pm_06_al pm_07_al pm_08_al pm_09_al pm_10_al pm_11_al pm_12_al 
	pf_01_al pf_02_al pf_03_al pf_04_al pf_05_al pf_06_al pf_07_al pf_08_al pf_09_al pf_10_al pf_11_al pf_12_al);
	SET totalpopulation2 (RENAME=(tot_01_al = ptot_01_al tot_02_al = ptot_02_al tot_03_al = ptot_03_al tot_04_al=ptot_04_al tot_05_al=ptot_05_al tot_06_al=ptot_06_al tot_07_al=ptot_07_al
	tot_08_al=ptot_08_al tot_09_al=ptot_09_al tot_10_al=ptot_10_al tot_11_al=ptot_11_al tot_12_al=ptot_12_al
	m_01_al=pm_01_al m_02_al=pm_02_al m_03_al=pm_03_al m_04_al=pm_04_al m_05_al=pm_05_al m_06_al=pm_06_al m_07_al=pm_07_al m_08_al=pm_08_al m_09_al=pm_09_al 
	m_10_al=pm_10_al m_11_al=pm_11_al m_12_al=pm_12_al f_01_al=pf_01_al f_02_al=pf_02_al f_03_al=pf_03_al f_04_al=pf_04_al f_05_al=pf_05_al f_06_al=pf_06_al f_07_al=pf_07_al 
	f_08_al=pf_08_al f_09_al=pf_09_al f_10_al=pf_10_al f_11_al=pf_11_al f_12_al=pf_12_al)); 
RUN;


%macro addtotals (datafile);

DATA &datafile.add;
	SET totalpopulationplus;
	MERGE &datafile. totalpopulationplus;
RUN;
%mend addtotals;
%addtotals(unitedkingdom2)
%addtotals(greatbritain2)
%addtotals(englandandwales2)
%addtotals(england2)
%addtotals(northeast2)
%addtotals(countydurham2)
%addtotals(darlington2)
%addtotals(hartlepool2)
%addtotals(middlesbrough2)
%addtotals(northumberland2)
%addtotals(redcarandcleveland2)
%addtotals(stocktonontees2)
%addtotals(tyneandwear2)
%addtotals(gateshead2)
%addtotals(newcastleupontyne2)
%addtotals(northtyneside2)
%addtotals(southtyneside2)
%addtotals(sunderland2)
%addtotals(northwest2)
%addtotals(blackburnwithdarwen2)
%addtotals(blackpool2)
%addtotals(cheshireeast2)
%addtotals(cheshirewestandchester2)
%addtotals(halton2)
%addtotals(warrington2)
%addtotals(cumbria2)
%addtotals(allerdale2)
%addtotals(barrowinfurness2)
%addtotals(carlisle2)
%addtotals(copeland2)
%addtotals(eden2)
%addtotals(southlakeland2)
%addtotals(greatermanchester2)
%addtotals(bolton2)
%addtotals(bury2)
%addtotals(manchester2)
%addtotals(oldham2)
%addtotals(rochdale2)
%addtotals(salford2)
%addtotals(stockport2)
%addtotals(tameside2)
%addtotals(trafford2)
%addtotals(wigan2)
%addtotals(lancashire2)
%addtotals(burnley2)
%addtotals(chorley2)
%addtotals(fylde2)
%addtotals(hyndburn2)
%addtotals(lancaster2)
%addtotals(pendle2)
%addtotals(preston2)
%addtotals(ribblevalley2)
%addtotals(rossendale2)
%addtotals(southribble2)
%addtotals(westlancashire2)
%addtotals(wyre2)
%addtotals(merseyside2)
%addtotals(knowsley2)
%addtotals(liverpool2)
%addtotals(sefton2)
%addtotals(sthelens2)
%addtotals(wirral2)
%addtotals(yorkshireandhumber2)
%addtotals(eastridingofyorkshire2)
%addtotals(kingstonuponhullcityof2)
%addtotals(northeastlincolnshire2)
%addtotals(northlincolnshire2)
%addtotals(york2)
%addtotals(northyorkshire2)
%addtotals(craven2)
%addtotals(hambleton2)
%addtotals(harrogate2)
%addtotals(richmondshire2)
%addtotals(ryedale2)
%addtotals(scarborough2)
%addtotals(selby2)
%addtotals(southyorkshire2)
%addtotals(barnsley2)
%addtotals(doncaster2)
%addtotals(rotherham2)
%addtotals(sheffield2)
%addtotals(westyorkshire2)
%addtotals(bradford2)
%addtotals(calderdale2)
%addtotals(kirklees2)
%addtotals(leeds2)
%addtotals(wakefield2)
%addtotals(eastmidlands2)
%addtotals(derby2)
%addtotals(leicester2)
%addtotals(nottingham2)
%addtotals(rutland2)
%addtotals(derbyshire2)
%addtotals(ambervalley2)
%addtotals(bolsover2)
%addtotals(chesterfield2)
%addtotals(derbyshiredales2)
%addtotals(erewash2)
%addtotals(highpeak2)
%addtotals(northeastderbyshire2)
%addtotals(southderbyshire2)
%addtotals(leicestershire2)
%addtotals(blaby2)
%addtotals(charnwood2)
%addtotals(harborough2)
%addtotals(hinckleyandbosworth2)
%addtotals(melton2)
%addtotals(northwestleicestershire2)
%addtotals(oadbyandwigston2)
%addtotals(lincolnshire2)
%addtotals(boston2)
%addtotals(eastlindsey2)
%addtotals(lincoln2)
%addtotals(northkesteven2)
%addtotals(southholland2)
%addtotals(southkesteven2)
%addtotals(westlindsey2)
%addtotals(northamptonshire2)
%addtotals(corby2)
%addtotals(daventry2)
%addtotals(eastnorthamptonshire2)
%addtotals(kettering2)
%addtotals(northampton2)
%addtotals(southnorthamptonshire2)
%addtotals(wellingborough2)
%addtotals(nottinghamshire2)
%addtotals(ashfield2)
%addtotals(bassetlaw2)
%addtotals(broxtowe2)
%addtotals(gedling2)
%addtotals(mansfield2)
%addtotals(newarkandsherwood2)
%addtotals(rushcliffe2)
%addtotals(westmidlands2)
%addtotals(herefordshirecountyof2)
%addtotals(shropshire2)
%addtotals(stokeontrent2)
%addtotals(telfordandwrekin2)
%addtotals(staffordshire2)
%addtotals(cannockchase2)
%addtotals(eaststaffordshire2)
%addtotals(lichfield2)
%addtotals(newcastleunderlyme2)
%addtotals(southstaffordshire2)
%addtotals(stafford2)
%addtotals(staffordshiremoorlands2)
%addtotals(tamworth2)
%addtotals(warwickshire2)
%addtotals(northwarwickshire2)
%addtotals(nuneatonandbedworth2)
%addtotals(rugby2)
%addtotals(stratfordonavon2)
%addtotals(warwick2)
%addtotals(westmidlands2)
%addtotals(birmingham2)
%addtotals(coventry2)
%addtotals(dudley2)
%addtotals(sandwell2)
%addtotals(solihull2)
%addtotals(walsall2)
%addtotals(wolverhampton2)
%addtotals(worcestershire2)
%addtotals(bromsgrove2)
%addtotals(malvernhills2)
%addtotals(redditch2)
%addtotals(worcester2)
%addtotals(wychavon2)
%addtotals(wyreforest2)
%addtotals(east2)
%addtotals(bedford2)
%addtotals(centralbedfordshire2)
%addtotals(luton2)
%addtotals(peterborough2)
%addtotals(southendonsea2)
%addtotals(thurrock2)
%addtotals(cambridgeshire2)
%addtotals(cambridge2)
%addtotals(eastcambridgeshire2)
%addtotals(fenland2)
%addtotals(huntingdonshire2)
%addtotals(southcambridgeshire2)
%addtotals(essex2)
%addtotals(basildon2)
%addtotals(braintree2)
%addtotals(brentwood2)
%addtotals(castlepoint2)
%addtotals(chelmsford2)
%addtotals(colchester2)
%addtotals(eppingforest2)
%addtotals(harlow2)
%addtotals(maldon2)
%addtotals(rochford2)
%addtotals(tendring2)
%addtotals(uttlesford2)
%addtotals(hertfordshire2)
%addtotals(broxbourne2)
%addtotals(dacorum2)
%addtotals(easthertfordshire2)
%addtotals(hertsmere2)
%addtotals(northhertfordshire2)
%addtotals(stalbans2)
%addtotals(stevenage2)
%addtotals(threerivers2)
%addtotals(watford2)
%addtotals(welwynhatfield2)
%addtotals(norfolk2)
%addtotals(breckland2)
%addtotals(broadland2)
%addtotals(greatyarmouth2)
%addtotals(kingslynnandwestnorfolk2)
%addtotals(northnorfolk2)
%addtotals(norwich2)
%addtotals(southnorfolk2)
%addtotals(suffolk2)
%addtotals(babergh2)
%addtotals(forestheath2)
%addtotals(ipswich2)
%addtotals(midsuffolk2)
%addtotals(stedmundsbury2)
%addtotals(suffolkcoastal2)
%addtotals(waveney2)
%addtotals(buckinghamshire2)
%addtotals(london2)
%addtotals(camden2)
%addtotals(cityoflondon2)
%addtotals(hackney2)
%addtotals(hammersmithandfulham2)
%addtotals(haringey2)
%addtotals(islington2)
%addtotals(kensingtonandchelsea2)
%addtotals(lambeth2)
%addtotals(lewisham2)
%addtotals(newham2)
%addtotals(southwark2)
%addtotals(towerhamlets2)
%addtotals(wandsworth2)
%addtotals(westminster2)
%addtotals(barkinganddagenham2)
%addtotals(barnet2)
%addtotals(bexley2)
%addtotals(brent2)
%addtotals(bromley2)
%addtotals(croydon2)
%addtotals(ealing2)
%addtotals(enfield2)
%addtotals(greenwich2)
%addtotals(harrow2)
%addtotals(havering2)
%addtotals(hillingdon2)
%addtotals(hounslow2)
%addtotals(kingstonuponthames2)
%addtotals(merton2)
%addtotals(redbridge2)
%addtotals(richmonduponthames2)
%addtotals(sutton2)
%addtotals(walthamforest2)
%addtotals(southeast2)
%addtotals(bracknellforest2)
%addtotals(brightonandhove2)
%addtotals(isleofwight2)
%addtotals(medway2)
%addtotals(miltonkeynes2)
%addtotals(portsmouth2)
%addtotals(reading2)
%addtotals(slough2)
%addtotals(southampton2)
%addtotals(westberkshire2)
%addtotals(windsorandmaidenhead2)
%addtotals(wokingham2)
%addtotals(aylesburyvale2)
%addtotals(chiltern2)
%addtotals(southbucks2)
%addtotals(wycombe2)
%addtotals(eastsussex2)
%addtotals(eastbourne2)
%addtotals(hastings2)
%addtotals(lewes2)
%addtotals(rother2)
%addtotals(wealden2)
%addtotals(hampshire2)
%addtotals(basingstokeanddeane2)
%addtotals(easthampshire2)
%addtotals(eastleigh2)
%addtotals(fareham2)
%addtotals(gosport2)
%addtotals(hart2)
%addtotals(havant2)
%addtotals(newforest2)
%addtotals(rushmoor2)
%addtotals(testvalley2)
%addtotals(winchester2)
%addtotals(kent2)
%addtotals(ashford2)
%addtotals(canterbury2)
%addtotals(dartford2)
%addtotals(dover2)
%addtotals(gravesham2)
%addtotals(maidstone2)
%addtotals(sevenoaks2)
%addtotals(shepway2)
%addtotals(swale2)
%addtotals(thanet2)
%addtotals(tonbridgeandmalling2)
%addtotals(tunbridgewells2)
%addtotals(oxfordshire2)
%addtotals(cherwell2)
%addtotals(oxford2)
%addtotals(southoxfordshire2)
%addtotals(valeofwhitehorse2)
%addtotals(westoxfordshire2)
%addtotals(surrey2)
%addtotals(elmbridge2)
%addtotals(epsomandewell2)
%addtotals(guildford2)
%addtotals(molevalley2)
%addtotals(reigateandbanstead2)
%addtotals(runnymede2)
%addtotals(spelthorne2)
%addtotals(surreyheath2)
%addtotals(tandridge2)
%addtotals(waverley2)
%addtotals(woking2)
%addtotals(westsussex2)
%addtotals(adur2)
%addtotals(arun2)
%addtotals(chichester2)
%addtotals(crawley2)
%addtotals(horsham2)
%addtotals(midsussex2)
%addtotals(worthing2)
%addtotals(southwest2)
%addtotals(bathandnortheastsomerset2)
%addtotals(bournemouth2)
%addtotals(bristolcityof2)
%addtotals(cornwall2)
%addtotals(islesofscilly2)
%addtotals(northsomerset2)
%addtotals(plymouth2)
%addtotals(poole2)
%addtotals(southgloucestershire2)
%addtotals(swindon2)
%addtotals(torbay2)
%addtotals(wiltshire2)
%addtotals(devon2)
%addtotals(eastdevon2)
%addtotals(exeter2)
%addtotals(middevon2)
%addtotals(northdevon2)
%addtotals(southhams2)
%addtotals(teignbridge2)
%addtotals(torridge2)
%addtotals(westdevon2)
%addtotals(dorset2)
%addtotals(christchurch2)
%addtotals(eastdorset2)
%addtotals(northdorset2)
%addtotals(purbeck2)
%addtotals(westdorset2)
%addtotals(weymouthandportland2)
%addtotals(gloucestershire2)
%addtotals(cheltenham2)
%addtotals(cotswold2)
%addtotals(forestofdean2)
%addtotals(gloucester2)
%addtotals(stroud2)
%addtotals(tewkesbury2)
%addtotals(somerset2)
%addtotals(mendip2)
%addtotals(sedgemoor2)
%addtotals(southsomerset2)
%addtotals(tauntondeane2)
%addtotals(westsomerset2)
%addtotals(wales2)
%addtotals(isleofanglesey2)
%addtotals(gwynedd2)
%addtotals(conwy2)
%addtotals(denbighshire2)
%addtotals(flintshire2)
%addtotals(wrexham2)
%addtotals(powys2)
%addtotals(ceredigion2)
%addtotals(pembrokeshire2)
%addtotals(carmarthenshire2)
%addtotals(swansea2)
%addtotals(neathporttalbot2)
%addtotals(bridgend2)
%addtotals(thevaleofglamorgan2)
%addtotals(cardiff2)
%addtotals(rhonddacynontaf2)
%addtotals(merthyrtydfil2)
%addtotals(caerphilly2)
%addtotals(blaenaugwent2)
%addtotals(torfaen2)
%addtotals(monmouthshire2)
%addtotals(newport2)
%addtotals(scotland2)
%addtotals(aberdeencity2)
%addtotals(aberdeenshire2)
%addtotals(angus2)
%addtotals(argyllandbute2)
%addtotals(clackmannanshire2)
%addtotals(dumfriesandgalloway2)
%addtotals(dundeecity2)
%addtotals(eastayrshire2)
%addtotals(eastdunbartonshire2)
%addtotals(eastlothian2)
%addtotals(eastrenfrewshire2)
%addtotals(cityofedinburgh2)
%addtotals(eileansiar2)
%addtotals(falkirk2)
%addtotals(fife2)
%addtotals(glasgowcity2)
%addtotals(highland2)
%addtotals(inverclyde2)
%addtotals(midlothian2)
%addtotals(moray2)
%addtotals(northayrshire2)
%addtotals(northlanarkshire2)
%addtotals(orkneyislands2)
%addtotals(perthandkinross2)
%addtotals(renfrewshire2)
%addtotals(scottishborders2)
%addtotals(shetlandislands2)
%addtotals(southayrshire2)
%addtotals(southlanarkshire2)
%addtotals(stirling2)
%addtotals(westdunbartonshire2)
%addtotals(westlothian2)
%addtotals(northernireland2)
%addtotals(antrim2)
%addtotals(ards2)
%addtotals(armagh2)
%addtotals(ballymena2)
%addtotals(ballymoney2)
%addtotals(banbridge2)
%addtotals(belfast2)
%addtotals(carrickfergus2)
%addtotals(castlereagh2)
%addtotals(coleraine2)
%addtotals(cookstown2)
%addtotals(craigavon2)
%addtotals(derry2)
%addtotals(down2)
%addtotals(dungannon2)
%addtotals(fermanagh2)
%addtotals(larne2)
%addtotals(limavady2)
%addtotals(lisburn2)
%addtotals(magherafelt2)
%addtotals(moyle2)
%addtotals(newryandmourne2)
%addtotals(newtownabbey2)
%addtotals(northdown2)
%addtotals(omagh2)
%addtotals(strabane2);*/





/*OUTPUT JSON FORMAT DATA AS SAS FILE FIRST*/

/*THIS ENSURES THAT VARIABLE REFERENCES OUTPUT NUMBERS WHERE APPROPRIATE*/

%macro manipfile (variable);

DATA &variable.3 (KEEP=VAR1);
	SET &variable.;
	IF _N_=1 				THEN DO; 
	length VAR1 $32000;
	VAR1 = '{' ;OUTPUT;
	VAR1 = '"ons":{' ;OUTPUT;
	VAR1 = '"label":"Population Projections for England and Wales, by local authority", ' ;output;
	VAR1 = '"source":"Office for National Statistics", ' ; output;
	VAR1 = '"updated":"2014-10-01", ' ;OUTPUT;
	VAR1 = '"area":	{' ;OUTPUT;
	VAR1 = '"code":"K04000001", ' ; OUTPUT;
	VAR1 = '"label":"England and Wales"' ; OUTPUT;
	VAR1 = '},' ; OUTPUT;
	VAR1 = '"time":	{' ; OUTPUT;
	VAR1 = '"label":"2001-2018", ' ; OUTPUT;
	VAR1 = '"index":["2001",  "2002",  "2003",  "2004",  "2005",  "2006",  "2007",  "2008",  "2009",  "2010",  "2011",  "2012",  "2013",  "2014",  "2015",  "2016",  "2017", "2018"]' ; OUTPUT;
	VAR1 = '},' ; OUTPUT;
	VAR1 = '"concept":{' ;OUTPUT;
	VAR1 = '"label":["population", "% of population"],' ; OUTPUT;
	VAR1 = '"units":["count", "%"],' ; OUTPUT;
	VAR1 = '"max":['||maxagegrpnum||', '||maxagegrpperc||']' ; OUTPUT;
	VAR1 = '},' ; OUTPUT;
	VAR1 = '"sums":{' ; OUTPUT;
	VAR1 = '"series1":['||m_01_al||', '||m_02_al||', '||m_03_al||', '||m_04_al||', '||m_05_al||', '||m_06_al||', '||m_07_al||', '||m_08_al||', '||m_09_al||', '||m_10_al||', '||m_11_al||', '||m_12_al||', '||m_13_al||', '||m_14_al||', '||m_15_al||', '||m_16_al||', '||m_17_al||', '||m_18_al||'],' ;OUTPUT;	
	VAR1 = '"series2":['||f_01_al||', '||f_02_al||', '||f_03_al||', '||f_04_al||', '||f_05_al||', '||f_06_al||', '||f_07_al||', '||f_08_al||', '||f_09_al||', '||f_10_al||', '||f_11_al||', '||f_12_al||', '||f_13_al||', '||f_14_al||', '||f_15_al||', '||f_16_al||', '||f_17_al||', '||f_18_al||']' ;OUTPUT;	
	VAR1 = '},' ; OUTPUT;
	VAR1 = '"dimension":{' ; OUTPUT;
	VAR1 = '"label":"age", ' ; OUTPUT;
	VAR1 = '"index":["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90+"]' ; OUTPUT;
	VAR1 = '},' ; OUTPUT;
	VAR1 = '"series":["male", "female"],' ; OUTPUT;
VAR1 = '"value":[[[['||m_01_0||','||m_01_perc1||'],['||m_02_0||','||m_02_perc1||'],['||m_03_0||','||m_03_perc1||'],['||m_04_0||','||m_04_perc1||'],['||m_05_0||','||m_05_perc1||'],['||m_06_0||','||m_06_perc1||'],['||m_07_0||','||m_07_perc1||'],['||m_08_0||','||m_08_perc1||'],['||m_09_0||','||m_09_perc1||'],['||m_10_0||','||m_10_perc1||'],['||m_11_0||','||m_11_perc1||'],['||m_12_0||','||m_12_perc1||'],['||m_13_0||','||m_13_perc1||'],['||m_14_0||','||m_14_perc1||'],['||m_15_0||','||m_15_perc1||'],['||m_16_0||','||m_16_perc1||'],['||m_17_0||','||m_17_perc1||'],['||m_18_0||','||m_18_perc1||']],';OUTPUT;
VAR1 = '[['||m_01_1||','||m_01_perc2||'],['||m_02_1||','||m_02_perc2||'],['||m_03_1||','||m_03_perc2||'],['||m_04_1||','||m_04_perc2||'],['||m_05_1||','||m_05_perc2||'],['||m_06_1||','||m_06_perc2||'],['||m_07_1||','||m_07_perc2||'],['||m_08_1||','||m_08_perc2||'],['||m_09_1||','||m_09_perc2||'],['||m_10_1||','||m_10_perc2||'],['||m_11_1||','||m_11_perc2||'],['||m_12_1||','||m_12_perc2||'],['||m_13_1||','||m_13_perc2||'],['||m_14_1||','||m_14_perc2||'],['||m_15_1||','||m_15_perc2||'],['||m_16_1||','||m_16_perc2||'],['||m_17_1||','||m_17_perc2||'],['||m_18_1||','||m_18_perc2||']],';OUTPUT;
VAR1 = '[['||m_01_2||','||m_01_perc3||'],['||m_02_2||','||m_02_perc3||'],['||m_03_2||','||m_03_perc3||'],['||m_04_2||','||m_04_perc3||'],['||m_05_2||','||m_05_perc3||'],['||m_06_2||','||m_06_perc3||'],['||m_07_2||','||m_07_perc3||'],['||m_08_2||','||m_08_perc3||'],['||m_09_2||','||m_09_perc3||'],['||m_10_2||','||m_10_perc3||'],['||m_11_2||','||m_11_perc3||'],['||m_12_2||','||m_12_perc3||'],['||m_13_2||','||m_13_perc3||'],['||m_14_2||','||m_14_perc3||'],['||m_15_2||','||m_15_perc3||'],['||m_16_2||','||m_16_perc3||'],['||m_17_2||','||m_17_perc3||'],['||m_18_2||','||m_18_perc3||']],';OUTPUT;
VAR1 = '[['||m_01_3||','||m_01_perc4||'],['||m_02_3||','||m_02_perc4||'],['||m_03_3||','||m_03_perc4||'],['||m_04_3||','||m_04_perc4||'],['||m_05_3||','||m_05_perc4||'],['||m_06_3||','||m_06_perc4||'],['||m_07_3||','||m_07_perc4||'],['||m_08_3||','||m_08_perc4||'],['||m_09_3||','||m_09_perc4||'],['||m_10_3||','||m_10_perc4||'],['||m_11_3||','||m_11_perc4||'],['||m_12_3||','||m_12_perc4||'],['||m_13_3||','||m_13_perc4||'],['||m_14_3||','||m_14_perc4||'],['||m_15_3||','||m_15_perc4||'],['||m_16_3||','||m_16_perc4||'],['||m_17_3||','||m_17_perc4||'],['||m_18_3||','||m_18_perc4||']],';OUTPUT;
VAR1 = '[['||m_01_4||','||m_01_perc5||'],['||m_02_4||','||m_02_perc5||'],['||m_03_4||','||m_03_perc5||'],['||m_04_4||','||m_04_perc5||'],['||m_05_4||','||m_05_perc5||'],['||m_06_4||','||m_06_perc5||'],['||m_07_4||','||m_07_perc5||'],['||m_08_4||','||m_08_perc5||'],['||m_09_4||','||m_09_perc5||'],['||m_10_4||','||m_10_perc5||'],['||m_11_4||','||m_11_perc5||'],['||m_12_4||','||m_12_perc5||'],['||m_13_4||','||m_13_perc5||'],['||m_14_4||','||m_14_perc5||'],['||m_15_4||','||m_15_perc5||'],['||m_16_4||','||m_16_perc5||'],['||m_17_4||','||m_17_perc5||'],['||m_18_4||','||m_18_perc5||']],';OUTPUT;
VAR1 = '[['||m_01_5||','||m_01_perc6||'],['||m_02_5||','||m_02_perc6||'],['||m_03_5||','||m_03_perc6||'],['||m_04_5||','||m_04_perc6||'],['||m_05_5||','||m_05_perc6||'],['||m_06_5||','||m_06_perc6||'],['||m_07_5||','||m_07_perc6||'],['||m_08_5||','||m_08_perc6||'],['||m_09_5||','||m_09_perc6||'],['||m_10_5||','||m_10_perc6||'],['||m_11_5||','||m_11_perc6||'],['||m_12_5||','||m_12_perc6||'],['||m_13_5||','||m_13_perc6||'],['||m_14_5||','||m_14_perc6||'],['||m_15_5||','||m_15_perc6||'],['||m_16_5||','||m_16_perc6||'],['||m_17_5||','||m_17_perc6||'],['||m_18_5||','||m_18_perc6||']],';OUTPUT;
VAR1 = '[['||m_01_6||','||m_01_perc7||'],['||m_02_6||','||m_02_perc7||'],['||m_03_6||','||m_03_perc7||'],['||m_04_6||','||m_04_perc7||'],['||m_05_6||','||m_05_perc7||'],['||m_06_6||','||m_06_perc7||'],['||m_07_6||','||m_07_perc7||'],['||m_08_6||','||m_08_perc7||'],['||m_09_6||','||m_09_perc7||'],['||m_10_6||','||m_10_perc7||'],['||m_11_6||','||m_11_perc7||'],['||m_12_6||','||m_12_perc7||'],['||m_13_6||','||m_13_perc7||'],['||m_14_6||','||m_14_perc7||'],['||m_15_6||','||m_15_perc7||'],['||m_16_6||','||m_16_perc7||'],['||m_17_6||','||m_17_perc7||'],['||m_18_6||','||m_18_perc7||']],';OUTPUT;
VAR1 = '[['||m_01_7||','||m_01_perc8||'],['||m_02_7||','||m_02_perc8||'],['||m_03_7||','||m_03_perc8||'],['||m_04_7||','||m_04_perc8||'],['||m_05_7||','||m_05_perc8||'],['||m_06_7||','||m_06_perc8||'],['||m_07_7||','||m_07_perc8||'],['||m_08_7||','||m_08_perc8||'],['||m_09_7||','||m_09_perc8||'],['||m_10_7||','||m_10_perc8||'],['||m_11_7||','||m_11_perc8||'],['||m_12_7||','||m_12_perc8||'],['||m_13_7||','||m_13_perc8||'],['||m_14_7||','||m_14_perc8||'],['||m_15_7||','||m_15_perc8||'],['||m_16_7||','||m_16_perc8||'],['||m_17_7||','||m_17_perc8||'],['||m_18_7||','||m_18_perc8||']],';OUTPUT;
VAR1 = '[['||m_01_8||','||m_01_perc9||'],['||m_02_8||','||m_02_perc9||'],['||m_03_8||','||m_03_perc9||'],['||m_04_8||','||m_04_perc9||'],['||m_05_8||','||m_05_perc9||'],['||m_06_8||','||m_06_perc9||'],['||m_07_8||','||m_07_perc9||'],['||m_08_8||','||m_08_perc9||'],['||m_09_8||','||m_09_perc9||'],['||m_10_8||','||m_10_perc9||'],['||m_11_8||','||m_11_perc9||'],['||m_12_8||','||m_12_perc9||'],['||m_13_8||','||m_13_perc9||'],['||m_14_8||','||m_14_perc9||'],['||m_15_8||','||m_15_perc9||'],['||m_16_8||','||m_16_perc9||'],['||m_17_8||','||m_17_perc9||'],['||m_18_8||','||m_18_perc9||']],';OUTPUT;
VAR1 = '[['||m_01_9||','||m_01_perc10||'],['||m_02_9||','||m_02_perc10||'],['||m_03_9||','||m_03_perc10||'],['||m_04_9||','||m_04_perc10||'],['||m_05_9||','||m_05_perc10||'],['||m_06_9||','||m_06_perc10||'],['||m_07_9||','||m_07_perc10||'],['||m_08_9||','||m_08_perc10||'],['||m_09_9||','||m_09_perc10||'],['||m_10_9||','||m_10_perc10||'],['||m_11_9||','||m_11_perc10||'],['||m_12_9||','||m_12_perc10||'],['||m_13_9||','||m_13_perc10||'],['||m_14_9||','||m_14_perc10||'],['||m_15_9||','||m_15_perc10||'],['||m_16_9||','||m_16_perc10||'],['||m_17_9||','||m_17_perc10||'],['||m_18_9||','||m_18_perc10||']],';OUTPUT;
VAR1 = '[['||m_01_10||','||m_01_perc11||'],['||m_02_10||','||m_02_perc11||'],['||m_03_10||','||m_03_perc11||'],['||m_04_10||','||m_04_perc11||'],['||m_05_10||','||m_05_perc11||'],['||m_06_10||','||m_06_perc11||'],['||m_07_10||','||m_07_perc11||'],['||m_08_10||','||m_08_perc11||'],['||m_09_10||','||m_09_perc11||'],['||m_10_10||','||m_10_perc11||'],['||m_11_10||','||m_11_perc11||'],['||m_12_10||','||m_12_perc11||'],['||m_13_10||','||m_13_perc11||'],['||m_14_10||','||m_14_perc11||'],['||m_15_10||','||m_15_perc11||'],['||m_16_10||','||m_16_perc11||'],['||m_17_10||','||m_17_perc11||'],['||m_18_10||','||m_18_perc11||']],';OUTPUT;
VAR1 = '[['||m_01_11||','||m_01_perc12||'],['||m_02_11||','||m_02_perc12||'],['||m_03_11||','||m_03_perc12||'],['||m_04_11||','||m_04_perc12||'],['||m_05_11||','||m_05_perc12||'],['||m_06_11||','||m_06_perc12||'],['||m_07_11||','||m_07_perc12||'],['||m_08_11||','||m_08_perc12||'],['||m_09_11||','||m_09_perc12||'],['||m_10_11||','||m_10_perc12||'],['||m_11_11||','||m_11_perc12||'],['||m_12_11||','||m_12_perc12||'],['||m_13_11||','||m_13_perc12||'],['||m_14_11||','||m_14_perc12||'],['||m_15_11||','||m_15_perc12||'],['||m_16_11||','||m_16_perc12||'],['||m_17_11||','||m_17_perc12||'],['||m_18_11||','||m_18_perc12||']],';OUTPUT;
VAR1 = '[['||m_01_12||','||m_01_perc13||'],['||m_02_12||','||m_02_perc13||'],['||m_03_12||','||m_03_perc13||'],['||m_04_12||','||m_04_perc13||'],['||m_05_12||','||m_05_perc13||'],['||m_06_12||','||m_06_perc13||'],['||m_07_12||','||m_07_perc13||'],['||m_08_12||','||m_08_perc13||'],['||m_09_12||','||m_09_perc13||'],['||m_10_12||','||m_10_perc13||'],['||m_11_12||','||m_11_perc13||'],['||m_12_12||','||m_12_perc13||'],['||m_13_12||','||m_13_perc13||'],['||m_14_12||','||m_14_perc13||'],['||m_15_12||','||m_15_perc13||'],['||m_16_12||','||m_16_perc13||'],['||m_17_12||','||m_17_perc13||'],['||m_18_12||','||m_18_perc13||']],';OUTPUT;
VAR1 = '[['||m_01_13||','||m_01_perc14||'],['||m_02_13||','||m_02_perc14||'],['||m_03_13||','||m_03_perc14||'],['||m_04_13||','||m_04_perc14||'],['||m_05_13||','||m_05_perc14||'],['||m_06_13||','||m_06_perc14||'],['||m_07_13||','||m_07_perc14||'],['||m_08_13||','||m_08_perc14||'],['||m_09_13||','||m_09_perc14||'],['||m_10_13||','||m_10_perc14||'],['||m_11_13||','||m_11_perc14||'],['||m_12_13||','||m_12_perc14||'],['||m_13_13||','||m_13_perc14||'],['||m_14_13||','||m_14_perc14||'],['||m_15_13||','||m_15_perc14||'],['||m_16_13||','||m_16_perc14||'],['||m_17_13||','||m_17_perc14||'],['||m_18_13||','||m_18_perc14||']],';OUTPUT;
VAR1 = '[['||m_01_14||','||m_01_perc15||'],['||m_02_14||','||m_02_perc15||'],['||m_03_14||','||m_03_perc15||'],['||m_04_14||','||m_04_perc15||'],['||m_05_14||','||m_05_perc15||'],['||m_06_14||','||m_06_perc15||'],['||m_07_14||','||m_07_perc15||'],['||m_08_14||','||m_08_perc15||'],['||m_09_14||','||m_09_perc15||'],['||m_10_14||','||m_10_perc15||'],['||m_11_14||','||m_11_perc15||'],['||m_12_14||','||m_12_perc15||'],['||m_13_14||','||m_13_perc15||'],['||m_14_14||','||m_14_perc15||'],['||m_15_14||','||m_15_perc15||'],['||m_16_14||','||m_16_perc15||'],['||m_17_14||','||m_17_perc15||'],['||m_18_14||','||m_18_perc15||']],';OUTPUT;
VAR1 = '[['||m_01_15||','||m_01_perc16||'],['||m_02_15||','||m_02_perc16||'],['||m_03_15||','||m_03_perc16||'],['||m_04_15||','||m_04_perc16||'],['||m_05_15||','||m_05_perc16||'],['||m_06_15||','||m_06_perc16||'],['||m_07_15||','||m_07_perc16||'],['||m_08_15||','||m_08_perc16||'],['||m_09_15||','||m_09_perc16||'],['||m_10_15||','||m_10_perc16||'],['||m_11_15||','||m_11_perc16||'],['||m_12_15||','||m_12_perc16||'],['||m_13_15||','||m_13_perc16||'],['||m_14_15||','||m_14_perc16||'],['||m_15_15||','||m_15_perc16||'],['||m_16_15||','||m_16_perc16||'],['||m_17_15||','||m_17_perc16||'],['||m_18_15||','||m_18_perc16||']],';OUTPUT;
VAR1 = '[['||m_01_16||','||m_01_perc17||'],['||m_02_16||','||m_02_perc17||'],['||m_03_16||','||m_03_perc17||'],['||m_04_16||','||m_04_perc17||'],['||m_05_16||','||m_05_perc17||'],['||m_06_16||','||m_06_perc17||'],['||m_07_16||','||m_07_perc17||'],['||m_08_16||','||m_08_perc17||'],['||m_09_16||','||m_09_perc17||'],['||m_10_16||','||m_10_perc17||'],['||m_11_16||','||m_11_perc17||'],['||m_12_16||','||m_12_perc17||'],['||m_13_16||','||m_13_perc17||'],['||m_14_16||','||m_14_perc17||'],['||m_15_16||','||m_15_perc17||'],['||m_16_16||','||m_16_perc17||'],['||m_17_16||','||m_17_perc17||'],['||m_18_16||','||m_18_perc17||']],';OUTPUT;
VAR1 = '[['||m_01_17||','||m_01_perc18||'],['||m_02_17||','||m_02_perc18||'],['||m_03_17||','||m_03_perc18||'],['||m_04_17||','||m_04_perc18||'],['||m_05_17||','||m_05_perc18||'],['||m_06_17||','||m_06_perc18||'],['||m_07_17||','||m_07_perc18||'],['||m_08_17||','||m_08_perc18||'],['||m_09_17||','||m_09_perc18||'],['||m_10_17||','||m_10_perc18||'],['||m_11_17||','||m_11_perc18||'],['||m_12_17||','||m_12_perc18||'],['||m_13_17||','||m_13_perc18||'],['||m_14_17||','||m_14_perc18||'],['||m_15_17||','||m_15_perc18||'],['||m_16_17||','||m_16_perc18||'],['||m_17_17||','||m_17_perc18||'],['||m_18_17||','||m_18_perc18||']],';OUTPUT;
VAR1 = '[['||m_01_18||','||m_01_perc19||'],['||m_02_18||','||m_02_perc19||'],['||m_03_18||','||m_03_perc19||'],['||m_04_18||','||m_04_perc19||'],['||m_05_18||','||m_05_perc19||'],['||m_06_18||','||m_06_perc19||'],['||m_07_18||','||m_07_perc19||'],['||m_08_18||','||m_08_perc19||'],['||m_09_18||','||m_09_perc19||'],['||m_10_18||','||m_10_perc19||'],['||m_11_18||','||m_11_perc19||'],['||m_12_18||','||m_12_perc19||'],['||m_13_18||','||m_13_perc19||'],['||m_14_18||','||m_14_perc19||'],['||m_15_18||','||m_15_perc19||'],['||m_16_18||','||m_16_perc19||'],['||m_17_18||','||m_17_perc19||'],['||m_18_18||','||m_18_perc19||']],';OUTPUT;
VAR1 = '[['||m_01_19||','||m_01_perc20||'],['||m_02_19||','||m_02_perc20||'],['||m_03_19||','||m_03_perc20||'],['||m_04_19||','||m_04_perc20||'],['||m_05_19||','||m_05_perc20||'],['||m_06_19||','||m_06_perc20||'],['||m_07_19||','||m_07_perc20||'],['||m_08_19||','||m_08_perc20||'],['||m_09_19||','||m_09_perc20||'],['||m_10_19||','||m_10_perc20||'],['||m_11_19||','||m_11_perc20||'],['||m_12_19||','||m_12_perc20||'],['||m_13_19||','||m_13_perc20||'],['||m_14_19||','||m_14_perc20||'],['||m_15_19||','||m_15_perc20||'],['||m_16_19||','||m_16_perc20||'],['||m_17_19||','||m_17_perc20||'],['||m_18_19||','||m_18_perc20||']],';OUTPUT;
VAR1 = '[['||m_01_20||','||m_01_perc21||'],['||m_02_20||','||m_02_perc21||'],['||m_03_20||','||m_03_perc21||'],['||m_04_20||','||m_04_perc21||'],['||m_05_20||','||m_05_perc21||'],['||m_06_20||','||m_06_perc21||'],['||m_07_20||','||m_07_perc21||'],['||m_08_20||','||m_08_perc21||'],['||m_09_20||','||m_09_perc21||'],['||m_10_20||','||m_10_perc21||'],['||m_11_20||','||m_11_perc21||'],['||m_12_20||','||m_12_perc21||'],['||m_13_20||','||m_13_perc21||'],['||m_14_20||','||m_14_perc21||'],['||m_15_20||','||m_15_perc21||'],['||m_16_20||','||m_16_perc21||'],['||m_17_20||','||m_17_perc21||'],['||m_18_20||','||m_18_perc21||']],';OUTPUT;
VAR1 = '[['||m_01_21||','||m_01_perc22||'],['||m_02_21||','||m_02_perc22||'],['||m_03_21||','||m_03_perc22||'],['||m_04_21||','||m_04_perc22||'],['||m_05_21||','||m_05_perc22||'],['||m_06_21||','||m_06_perc22||'],['||m_07_21||','||m_07_perc22||'],['||m_08_21||','||m_08_perc22||'],['||m_09_21||','||m_09_perc22||'],['||m_10_21||','||m_10_perc22||'],['||m_11_21||','||m_11_perc22||'],['||m_12_21||','||m_12_perc22||'],['||m_13_21||','||m_13_perc22||'],['||m_14_21||','||m_14_perc22||'],['||m_15_21||','||m_15_perc22||'],['||m_16_21||','||m_16_perc22||'],['||m_17_21||','||m_17_perc22||'],['||m_18_21||','||m_18_perc22||']],';OUTPUT;
VAR1 = '[['||m_01_22||','||m_01_perc23||'],['||m_02_22||','||m_02_perc23||'],['||m_03_22||','||m_03_perc23||'],['||m_04_22||','||m_04_perc23||'],['||m_05_22||','||m_05_perc23||'],['||m_06_22||','||m_06_perc23||'],['||m_07_22||','||m_07_perc23||'],['||m_08_22||','||m_08_perc23||'],['||m_09_22||','||m_09_perc23||'],['||m_10_22||','||m_10_perc23||'],['||m_11_22||','||m_11_perc23||'],['||m_12_22||','||m_12_perc23||'],['||m_13_22||','||m_13_perc23||'],['||m_14_22||','||m_14_perc23||'],['||m_15_22||','||m_15_perc23||'],['||m_16_22||','||m_16_perc23||'],['||m_17_22||','||m_17_perc23||'],['||m_18_22||','||m_18_perc23||']],';OUTPUT;
VAR1 = '[['||m_01_23||','||m_01_perc24||'],['||m_02_23||','||m_02_perc24||'],['||m_03_23||','||m_03_perc24||'],['||m_04_23||','||m_04_perc24||'],['||m_05_23||','||m_05_perc24||'],['||m_06_23||','||m_06_perc24||'],['||m_07_23||','||m_07_perc24||'],['||m_08_23||','||m_08_perc24||'],['||m_09_23||','||m_09_perc24||'],['||m_10_23||','||m_10_perc24||'],['||m_11_23||','||m_11_perc24||'],['||m_12_23||','||m_12_perc24||'],['||m_13_23||','||m_13_perc24||'],['||m_14_23||','||m_14_perc24||'],['||m_15_23||','||m_15_perc24||'],['||m_16_23||','||m_16_perc24||'],['||m_17_23||','||m_17_perc24||'],['||m_18_23||','||m_18_perc24||']],';OUTPUT;
VAR1 = '[['||m_01_24||','||m_01_perc25||'],['||m_02_24||','||m_02_perc25||'],['||m_03_24||','||m_03_perc25||'],['||m_04_24||','||m_04_perc25||'],['||m_05_24||','||m_05_perc25||'],['||m_06_24||','||m_06_perc25||'],['||m_07_24||','||m_07_perc25||'],['||m_08_24||','||m_08_perc25||'],['||m_09_24||','||m_09_perc25||'],['||m_10_24||','||m_10_perc25||'],['||m_11_24||','||m_11_perc25||'],['||m_12_24||','||m_12_perc25||'],['||m_13_24||','||m_13_perc25||'],['||m_14_24||','||m_14_perc25||'],['||m_15_24||','||m_15_perc25||'],['||m_16_24||','||m_16_perc25||'],['||m_17_24||','||m_17_perc25||'],['||m_18_24||','||m_18_perc25||']],';OUTPUT;
VAR1 = '[['||m_01_25||','||m_01_perc26||'],['||m_02_25||','||m_02_perc26||'],['||m_03_25||','||m_03_perc26||'],['||m_04_25||','||m_04_perc26||'],['||m_05_25||','||m_05_perc26||'],['||m_06_25||','||m_06_perc26||'],['||m_07_25||','||m_07_perc26||'],['||m_08_25||','||m_08_perc26||'],['||m_09_25||','||m_09_perc26||'],['||m_10_25||','||m_10_perc26||'],['||m_11_25||','||m_11_perc26||'],['||m_12_25||','||m_12_perc26||'],['||m_13_25||','||m_13_perc26||'],['||m_14_25||','||m_14_perc26||'],['||m_15_25||','||m_15_perc26||'],['||m_16_25||','||m_16_perc26||'],['||m_17_25||','||m_17_perc26||'],['||m_18_25||','||m_18_perc26||']],';OUTPUT;
VAR1 = '[['||m_01_26||','||m_01_perc27||'],['||m_02_26||','||m_02_perc27||'],['||m_03_26||','||m_03_perc27||'],['||m_04_26||','||m_04_perc27||'],['||m_05_26||','||m_05_perc27||'],['||m_06_26||','||m_06_perc27||'],['||m_07_26||','||m_07_perc27||'],['||m_08_26||','||m_08_perc27||'],['||m_09_26||','||m_09_perc27||'],['||m_10_26||','||m_10_perc27||'],['||m_11_26||','||m_11_perc27||'],['||m_12_26||','||m_12_perc27||'],['||m_13_26||','||m_13_perc27||'],['||m_14_26||','||m_14_perc27||'],['||m_15_26||','||m_15_perc27||'],['||m_16_26||','||m_16_perc27||'],['||m_17_26||','||m_17_perc27||'],['||m_18_26||','||m_18_perc27||']],';OUTPUT;
VAR1 = '[['||m_01_27||','||m_01_perc28||'],['||m_02_27||','||m_02_perc28||'],['||m_03_27||','||m_03_perc28||'],['||m_04_27||','||m_04_perc28||'],['||m_05_27||','||m_05_perc28||'],['||m_06_27||','||m_06_perc28||'],['||m_07_27||','||m_07_perc28||'],['||m_08_27||','||m_08_perc28||'],['||m_09_27||','||m_09_perc28||'],['||m_10_27||','||m_10_perc28||'],['||m_11_27||','||m_11_perc28||'],['||m_12_27||','||m_12_perc28||'],['||m_13_27||','||m_13_perc28||'],['||m_14_27||','||m_14_perc28||'],['||m_15_27||','||m_15_perc28||'],['||m_16_27||','||m_16_perc28||'],['||m_17_27||','||m_17_perc28||'],['||m_18_27||','||m_18_perc28||']],';OUTPUT;
VAR1 = '[['||m_01_28||','||m_01_perc29||'],['||m_02_28||','||m_02_perc29||'],['||m_03_28||','||m_03_perc29||'],['||m_04_28||','||m_04_perc29||'],['||m_05_28||','||m_05_perc29||'],['||m_06_28||','||m_06_perc29||'],['||m_07_28||','||m_07_perc29||'],['||m_08_28||','||m_08_perc29||'],['||m_09_28||','||m_09_perc29||'],['||m_10_28||','||m_10_perc29||'],['||m_11_28||','||m_11_perc29||'],['||m_12_28||','||m_12_perc29||'],['||m_13_28||','||m_13_perc29||'],['||m_14_28||','||m_14_perc29||'],['||m_15_28||','||m_15_perc29||'],['||m_16_28||','||m_16_perc29||'],['||m_17_28||','||m_17_perc29||'],['||m_18_28||','||m_18_perc29||']],';OUTPUT;
VAR1 = '[['||m_01_29||','||m_01_perc30||'],['||m_02_29||','||m_02_perc30||'],['||m_03_29||','||m_03_perc30||'],['||m_04_29||','||m_04_perc30||'],['||m_05_29||','||m_05_perc30||'],['||m_06_29||','||m_06_perc30||'],['||m_07_29||','||m_07_perc30||'],['||m_08_29||','||m_08_perc30||'],['||m_09_29||','||m_09_perc30||'],['||m_10_29||','||m_10_perc30||'],['||m_11_29||','||m_11_perc30||'],['||m_12_29||','||m_12_perc30||'],['||m_13_29||','||m_13_perc30||'],['||m_14_29||','||m_14_perc30||'],['||m_15_29||','||m_15_perc30||'],['||m_16_29||','||m_16_perc30||'],['||m_17_29||','||m_17_perc30||'],['||m_18_29||','||m_18_perc30||']],';OUTPUT;
VAR1 = '[['||m_01_30||','||m_01_perc31||'],['||m_02_30||','||m_02_perc31||'],['||m_03_30||','||m_03_perc31||'],['||m_04_30||','||m_04_perc31||'],['||m_05_30||','||m_05_perc31||'],['||m_06_30||','||m_06_perc31||'],['||m_07_30||','||m_07_perc31||'],['||m_08_30||','||m_08_perc31||'],['||m_09_30||','||m_09_perc31||'],['||m_10_30||','||m_10_perc31||'],['||m_11_30||','||m_11_perc31||'],['||m_12_30||','||m_12_perc31||'],['||m_13_30||','||m_13_perc31||'],['||m_14_30||','||m_14_perc31||'],['||m_15_30||','||m_15_perc31||'],['||m_16_30||','||m_16_perc31||'],['||m_17_30||','||m_17_perc31||'],['||m_18_30||','||m_18_perc31||']],';OUTPUT;
VAR1 = '[['||m_01_31||','||m_01_perc32||'],['||m_02_31||','||m_02_perc32||'],['||m_03_31||','||m_03_perc32||'],['||m_04_31||','||m_04_perc32||'],['||m_05_31||','||m_05_perc32||'],['||m_06_31||','||m_06_perc32||'],['||m_07_31||','||m_07_perc32||'],['||m_08_31||','||m_08_perc32||'],['||m_09_31||','||m_09_perc32||'],['||m_10_31||','||m_10_perc32||'],['||m_11_31||','||m_11_perc32||'],['||m_12_31||','||m_12_perc32||'],['||m_13_31||','||m_13_perc32||'],['||m_14_31||','||m_14_perc32||'],['||m_15_31||','||m_15_perc32||'],['||m_16_31||','||m_16_perc32||'],['||m_17_31||','||m_17_perc32||'],['||m_18_31||','||m_18_perc32||']],';OUTPUT;
VAR1 = '[['||m_01_32||','||m_01_perc33||'],['||m_02_32||','||m_02_perc33||'],['||m_03_32||','||m_03_perc33||'],['||m_04_32||','||m_04_perc33||'],['||m_05_32||','||m_05_perc33||'],['||m_06_32||','||m_06_perc33||'],['||m_07_32||','||m_07_perc33||'],['||m_08_32||','||m_08_perc33||'],['||m_09_32||','||m_09_perc33||'],['||m_10_32||','||m_10_perc33||'],['||m_11_32||','||m_11_perc33||'],['||m_12_32||','||m_12_perc33||'],['||m_13_32||','||m_13_perc33||'],['||m_14_32||','||m_14_perc33||'],['||m_15_32||','||m_15_perc33||'],['||m_16_32||','||m_16_perc33||'],['||m_17_32||','||m_17_perc33||'],['||m_18_32||','||m_18_perc33||']],';OUTPUT;
VAR1 = '[['||m_01_33||','||m_01_perc34||'],['||m_02_33||','||m_02_perc34||'],['||m_03_33||','||m_03_perc34||'],['||m_04_33||','||m_04_perc34||'],['||m_05_33||','||m_05_perc34||'],['||m_06_33||','||m_06_perc34||'],['||m_07_33||','||m_07_perc34||'],['||m_08_33||','||m_08_perc34||'],['||m_09_33||','||m_09_perc34||'],['||m_10_33||','||m_10_perc34||'],['||m_11_33||','||m_11_perc34||'],['||m_12_33||','||m_12_perc34||'],['||m_13_33||','||m_13_perc34||'],['||m_14_33||','||m_14_perc34||'],['||m_15_33||','||m_15_perc34||'],['||m_16_33||','||m_16_perc34||'],['||m_17_33||','||m_17_perc34||'],['||m_18_33||','||m_18_perc34||']],';OUTPUT;
VAR1 = '[['||m_01_34||','||m_01_perc35||'],['||m_02_34||','||m_02_perc35||'],['||m_03_34||','||m_03_perc35||'],['||m_04_34||','||m_04_perc35||'],['||m_05_34||','||m_05_perc35||'],['||m_06_34||','||m_06_perc35||'],['||m_07_34||','||m_07_perc35||'],['||m_08_34||','||m_08_perc35||'],['||m_09_34||','||m_09_perc35||'],['||m_10_34||','||m_10_perc35||'],['||m_11_34||','||m_11_perc35||'],['||m_12_34||','||m_12_perc35||'],['||m_13_34||','||m_13_perc35||'],['||m_14_34||','||m_14_perc35||'],['||m_15_34||','||m_15_perc35||'],['||m_16_34||','||m_16_perc35||'],['||m_17_34||','||m_17_perc35||'],['||m_18_34||','||m_18_perc35||']],';OUTPUT;
VAR1 = '[['||m_01_35||','||m_01_perc36||'],['||m_02_35||','||m_02_perc36||'],['||m_03_35||','||m_03_perc36||'],['||m_04_35||','||m_04_perc36||'],['||m_05_35||','||m_05_perc36||'],['||m_06_35||','||m_06_perc36||'],['||m_07_35||','||m_07_perc36||'],['||m_08_35||','||m_08_perc36||'],['||m_09_35||','||m_09_perc36||'],['||m_10_35||','||m_10_perc36||'],['||m_11_35||','||m_11_perc36||'],['||m_12_35||','||m_12_perc36||'],['||m_13_35||','||m_13_perc36||'],['||m_14_35||','||m_14_perc36||'],['||m_15_35||','||m_15_perc36||'],['||m_16_35||','||m_16_perc36||'],['||m_17_35||','||m_17_perc36||'],['||m_18_35||','||m_18_perc36||']],';OUTPUT;
VAR1 = '[['||m_01_36||','||m_01_perc37||'],['||m_02_36||','||m_02_perc37||'],['||m_03_36||','||m_03_perc37||'],['||m_04_36||','||m_04_perc37||'],['||m_05_36||','||m_05_perc37||'],['||m_06_36||','||m_06_perc37||'],['||m_07_36||','||m_07_perc37||'],['||m_08_36||','||m_08_perc37||'],['||m_09_36||','||m_09_perc37||'],['||m_10_36||','||m_10_perc37||'],['||m_11_36||','||m_11_perc37||'],['||m_12_36||','||m_12_perc37||'],['||m_13_36||','||m_13_perc37||'],['||m_14_36||','||m_14_perc37||'],['||m_15_36||','||m_15_perc37||'],['||m_16_36||','||m_16_perc37||'],['||m_17_36||','||m_17_perc37||'],['||m_18_36||','||m_18_perc37||']],';OUTPUT;
VAR1 = '[['||m_01_37||','||m_01_perc38||'],['||m_02_37||','||m_02_perc38||'],['||m_03_37||','||m_03_perc38||'],['||m_04_37||','||m_04_perc38||'],['||m_05_37||','||m_05_perc38||'],['||m_06_37||','||m_06_perc38||'],['||m_07_37||','||m_07_perc38||'],['||m_08_37||','||m_08_perc38||'],['||m_09_37||','||m_09_perc38||'],['||m_10_37||','||m_10_perc38||'],['||m_11_37||','||m_11_perc38||'],['||m_12_37||','||m_12_perc38||'],['||m_13_37||','||m_13_perc38||'],['||m_14_37||','||m_14_perc38||'],['||m_15_37||','||m_15_perc38||'],['||m_16_37||','||m_16_perc38||'],['||m_17_37||','||m_17_perc38||'],['||m_18_37||','||m_18_perc38||']],';OUTPUT;
VAR1 = '[['||m_01_38||','||m_01_perc39||'],['||m_02_38||','||m_02_perc39||'],['||m_03_38||','||m_03_perc39||'],['||m_04_38||','||m_04_perc39||'],['||m_05_38||','||m_05_perc39||'],['||m_06_38||','||m_06_perc39||'],['||m_07_38||','||m_07_perc39||'],['||m_08_38||','||m_08_perc39||'],['||m_09_38||','||m_09_perc39||'],['||m_10_38||','||m_10_perc39||'],['||m_11_38||','||m_11_perc39||'],['||m_12_38||','||m_12_perc39||'],['||m_13_38||','||m_13_perc39||'],['||m_14_38||','||m_14_perc39||'],['||m_15_38||','||m_15_perc39||'],['||m_16_38||','||m_16_perc39||'],['||m_17_38||','||m_17_perc39||'],['||m_18_38||','||m_18_perc39||']],';OUTPUT;
VAR1 = '[['||m_01_39||','||m_01_perc40||'],['||m_02_39||','||m_02_perc40||'],['||m_03_39||','||m_03_perc40||'],['||m_04_39||','||m_04_perc40||'],['||m_05_39||','||m_05_perc40||'],['||m_06_39||','||m_06_perc40||'],['||m_07_39||','||m_07_perc40||'],['||m_08_39||','||m_08_perc40||'],['||m_09_39||','||m_09_perc40||'],['||m_10_39||','||m_10_perc40||'],['||m_11_39||','||m_11_perc40||'],['||m_12_39||','||m_12_perc40||'],['||m_13_39||','||m_13_perc40||'],['||m_14_39||','||m_14_perc40||'],['||m_15_39||','||m_15_perc40||'],['||m_16_39||','||m_16_perc40||'],['||m_17_39||','||m_17_perc40||'],['||m_18_39||','||m_18_perc40||']],';OUTPUT;
VAR1 = '[['||m_01_40||','||m_01_perc41||'],['||m_02_40||','||m_02_perc41||'],['||m_03_40||','||m_03_perc41||'],['||m_04_40||','||m_04_perc41||'],['||m_05_40||','||m_05_perc41||'],['||m_06_40||','||m_06_perc41||'],['||m_07_40||','||m_07_perc41||'],['||m_08_40||','||m_08_perc41||'],['||m_09_40||','||m_09_perc41||'],['||m_10_40||','||m_10_perc41||'],['||m_11_40||','||m_11_perc41||'],['||m_12_40||','||m_12_perc41||'],['||m_13_40||','||m_13_perc41||'],['||m_14_40||','||m_14_perc41||'],['||m_15_40||','||m_15_perc41||'],['||m_16_40||','||m_16_perc41||'],['||m_17_40||','||m_17_perc41||'],['||m_18_40||','||m_18_perc41||']],';OUTPUT;
VAR1 = '[['||m_01_41||','||m_01_perc42||'],['||m_02_41||','||m_02_perc42||'],['||m_03_41||','||m_03_perc42||'],['||m_04_41||','||m_04_perc42||'],['||m_05_41||','||m_05_perc42||'],['||m_06_41||','||m_06_perc42||'],['||m_07_41||','||m_07_perc42||'],['||m_08_41||','||m_08_perc42||'],['||m_09_41||','||m_09_perc42||'],['||m_10_41||','||m_10_perc42||'],['||m_11_41||','||m_11_perc42||'],['||m_12_41||','||m_12_perc42||'],['||m_13_41||','||m_13_perc42||'],['||m_14_41||','||m_14_perc42||'],['||m_15_41||','||m_15_perc42||'],['||m_16_41||','||m_16_perc42||'],['||m_17_41||','||m_17_perc42||'],['||m_18_41||','||m_18_perc42||']],';OUTPUT;
VAR1 = '[['||m_01_42||','||m_01_perc43||'],['||m_02_42||','||m_02_perc43||'],['||m_03_42||','||m_03_perc43||'],['||m_04_42||','||m_04_perc43||'],['||m_05_42||','||m_05_perc43||'],['||m_06_42||','||m_06_perc43||'],['||m_07_42||','||m_07_perc43||'],['||m_08_42||','||m_08_perc43||'],['||m_09_42||','||m_09_perc43||'],['||m_10_42||','||m_10_perc43||'],['||m_11_42||','||m_11_perc43||'],['||m_12_42||','||m_12_perc43||'],['||m_13_42||','||m_13_perc43||'],['||m_14_42||','||m_14_perc43||'],['||m_15_42||','||m_15_perc43||'],['||m_16_42||','||m_16_perc43||'],['||m_17_42||','||m_17_perc43||'],['||m_18_42||','||m_18_perc43||']],';OUTPUT;
VAR1 = '[['||m_01_43||','||m_01_perc44||'],['||m_02_43||','||m_02_perc44||'],['||m_03_43||','||m_03_perc44||'],['||m_04_43||','||m_04_perc44||'],['||m_05_43||','||m_05_perc44||'],['||m_06_43||','||m_06_perc44||'],['||m_07_43||','||m_07_perc44||'],['||m_08_43||','||m_08_perc44||'],['||m_09_43||','||m_09_perc44||'],['||m_10_43||','||m_10_perc44||'],['||m_11_43||','||m_11_perc44||'],['||m_12_43||','||m_12_perc44||'],['||m_13_43||','||m_13_perc44||'],['||m_14_43||','||m_14_perc44||'],['||m_15_43||','||m_15_perc44||'],['||m_16_43||','||m_16_perc44||'],['||m_17_43||','||m_17_perc44||'],['||m_18_43||','||m_18_perc44||']],';OUTPUT;
VAR1 = '[['||m_01_44||','||m_01_perc45||'],['||m_02_44||','||m_02_perc45||'],['||m_03_44||','||m_03_perc45||'],['||m_04_44||','||m_04_perc45||'],['||m_05_44||','||m_05_perc45||'],['||m_06_44||','||m_06_perc45||'],['||m_07_44||','||m_07_perc45||'],['||m_08_44||','||m_08_perc45||'],['||m_09_44||','||m_09_perc45||'],['||m_10_44||','||m_10_perc45||'],['||m_11_44||','||m_11_perc45||'],['||m_12_44||','||m_12_perc45||'],['||m_13_44||','||m_13_perc45||'],['||m_14_44||','||m_14_perc45||'],['||m_15_44||','||m_15_perc45||'],['||m_16_44||','||m_16_perc45||'],['||m_17_44||','||m_17_perc45||'],['||m_18_44||','||m_18_perc45||']],';OUTPUT;
VAR1 = '[['||m_01_45||','||m_01_perc46||'],['||m_02_45||','||m_02_perc46||'],['||m_03_45||','||m_03_perc46||'],['||m_04_45||','||m_04_perc46||'],['||m_05_45||','||m_05_perc46||'],['||m_06_45||','||m_06_perc46||'],['||m_07_45||','||m_07_perc46||'],['||m_08_45||','||m_08_perc46||'],['||m_09_45||','||m_09_perc46||'],['||m_10_45||','||m_10_perc46||'],['||m_11_45||','||m_11_perc46||'],['||m_12_45||','||m_12_perc46||'],['||m_13_45||','||m_13_perc46||'],['||m_14_45||','||m_14_perc46||'],['||m_15_45||','||m_15_perc46||'],['||m_16_45||','||m_16_perc46||'],['||m_17_45||','||m_17_perc46||'],['||m_18_45||','||m_18_perc46||']],';OUTPUT;
VAR1 = '[['||m_01_46||','||m_01_perc47||'],['||m_02_46||','||m_02_perc47||'],['||m_03_46||','||m_03_perc47||'],['||m_04_46||','||m_04_perc47||'],['||m_05_46||','||m_05_perc47||'],['||m_06_46||','||m_06_perc47||'],['||m_07_46||','||m_07_perc47||'],['||m_08_46||','||m_08_perc47||'],['||m_09_46||','||m_09_perc47||'],['||m_10_46||','||m_10_perc47||'],['||m_11_46||','||m_11_perc47||'],['||m_12_46||','||m_12_perc47||'],['||m_13_46||','||m_13_perc47||'],['||m_14_46||','||m_14_perc47||'],['||m_15_46||','||m_15_perc47||'],['||m_16_46||','||m_16_perc47||'],['||m_17_46||','||m_17_perc47||'],['||m_18_46||','||m_18_perc47||']],';OUTPUT;
VAR1 = '[['||m_01_47||','||m_01_perc48||'],['||m_02_47||','||m_02_perc48||'],['||m_03_47||','||m_03_perc48||'],['||m_04_47||','||m_04_perc48||'],['||m_05_47||','||m_05_perc48||'],['||m_06_47||','||m_06_perc48||'],['||m_07_47||','||m_07_perc48||'],['||m_08_47||','||m_08_perc48||'],['||m_09_47||','||m_09_perc48||'],['||m_10_47||','||m_10_perc48||'],['||m_11_47||','||m_11_perc48||'],['||m_12_47||','||m_12_perc48||'],['||m_13_47||','||m_13_perc48||'],['||m_14_47||','||m_14_perc48||'],['||m_15_47||','||m_15_perc48||'],['||m_16_47||','||m_16_perc48||'],['||m_17_47||','||m_17_perc48||'],['||m_18_47||','||m_18_perc48||']],';OUTPUT;
VAR1 = '[['||m_01_48||','||m_01_perc49||'],['||m_02_48||','||m_02_perc49||'],['||m_03_48||','||m_03_perc49||'],['||m_04_48||','||m_04_perc49||'],['||m_05_48||','||m_05_perc49||'],['||m_06_48||','||m_06_perc49||'],['||m_07_48||','||m_07_perc49||'],['||m_08_48||','||m_08_perc49||'],['||m_09_48||','||m_09_perc49||'],['||m_10_48||','||m_10_perc49||'],['||m_11_48||','||m_11_perc49||'],['||m_12_48||','||m_12_perc49||'],['||m_13_48||','||m_13_perc49||'],['||m_14_48||','||m_14_perc49||'],['||m_15_48||','||m_15_perc49||'],['||m_16_48||','||m_16_perc49||'],['||m_17_48||','||m_17_perc49||'],['||m_18_48||','||m_18_perc49||']],';OUTPUT;
VAR1 = '[['||m_01_49||','||m_01_perc50||'],['||m_02_49||','||m_02_perc50||'],['||m_03_49||','||m_03_perc50||'],['||m_04_49||','||m_04_perc50||'],['||m_05_49||','||m_05_perc50||'],['||m_06_49||','||m_06_perc50||'],['||m_07_49||','||m_07_perc50||'],['||m_08_49||','||m_08_perc50||'],['||m_09_49||','||m_09_perc50||'],['||m_10_49||','||m_10_perc50||'],['||m_11_49||','||m_11_perc50||'],['||m_12_49||','||m_12_perc50||'],['||m_13_49||','||m_13_perc50||'],['||m_14_49||','||m_14_perc50||'],['||m_15_49||','||m_15_perc50||'],['||m_16_49||','||m_16_perc50||'],['||m_17_49||','||m_17_perc50||'],['||m_18_49||','||m_18_perc50||']],';OUTPUT;
VAR1 = '[['||m_01_50||','||m_01_perc51||'],['||m_02_50||','||m_02_perc51||'],['||m_03_50||','||m_03_perc51||'],['||m_04_50||','||m_04_perc51||'],['||m_05_50||','||m_05_perc51||'],['||m_06_50||','||m_06_perc51||'],['||m_07_50||','||m_07_perc51||'],['||m_08_50||','||m_08_perc51||'],['||m_09_50||','||m_09_perc51||'],['||m_10_50||','||m_10_perc51||'],['||m_11_50||','||m_11_perc51||'],['||m_12_50||','||m_12_perc51||'],['||m_13_50||','||m_13_perc51||'],['||m_14_50||','||m_14_perc51||'],['||m_15_50||','||m_15_perc51||'],['||m_16_50||','||m_16_perc51||'],['||m_17_50||','||m_17_perc51||'],['||m_18_50||','||m_18_perc51||']],';OUTPUT;
VAR1 = '[['||m_01_51||','||m_01_perc52||'],['||m_02_51||','||m_02_perc52||'],['||m_03_51||','||m_03_perc52||'],['||m_04_51||','||m_04_perc52||'],['||m_05_51||','||m_05_perc52||'],['||m_06_51||','||m_06_perc52||'],['||m_07_51||','||m_07_perc52||'],['||m_08_51||','||m_08_perc52||'],['||m_09_51||','||m_09_perc52||'],['||m_10_51||','||m_10_perc52||'],['||m_11_51||','||m_11_perc52||'],['||m_12_51||','||m_12_perc52||'],['||m_13_51||','||m_13_perc52||'],['||m_14_51||','||m_14_perc52||'],['||m_15_51||','||m_15_perc52||'],['||m_16_51||','||m_16_perc52||'],['||m_17_51||','||m_17_perc52||'],['||m_18_51||','||m_18_perc52||']],';OUTPUT;
VAR1 = '[['||m_01_52||','||m_01_perc53||'],['||m_02_52||','||m_02_perc53||'],['||m_03_52||','||m_03_perc53||'],['||m_04_52||','||m_04_perc53||'],['||m_05_52||','||m_05_perc53||'],['||m_06_52||','||m_06_perc53||'],['||m_07_52||','||m_07_perc53||'],['||m_08_52||','||m_08_perc53||'],['||m_09_52||','||m_09_perc53||'],['||m_10_52||','||m_10_perc53||'],['||m_11_52||','||m_11_perc53||'],['||m_12_52||','||m_12_perc53||'],['||m_13_52||','||m_13_perc53||'],['||m_14_52||','||m_14_perc53||'],['||m_15_52||','||m_15_perc53||'],['||m_16_52||','||m_16_perc53||'],['||m_17_52||','||m_17_perc53||'],['||m_18_52||','||m_18_perc53||']],';OUTPUT;
VAR1 = '[['||m_01_53||','||m_01_perc54||'],['||m_02_53||','||m_02_perc54||'],['||m_03_53||','||m_03_perc54||'],['||m_04_53||','||m_04_perc54||'],['||m_05_53||','||m_05_perc54||'],['||m_06_53||','||m_06_perc54||'],['||m_07_53||','||m_07_perc54||'],['||m_08_53||','||m_08_perc54||'],['||m_09_53||','||m_09_perc54||'],['||m_10_53||','||m_10_perc54||'],['||m_11_53||','||m_11_perc54||'],['||m_12_53||','||m_12_perc54||'],['||m_13_53||','||m_13_perc54||'],['||m_14_53||','||m_14_perc54||'],['||m_15_53||','||m_15_perc54||'],['||m_16_53||','||m_16_perc54||'],['||m_17_53||','||m_17_perc54||'],['||m_18_53||','||m_18_perc54||']],';OUTPUT;
VAR1 = '[['||m_01_54||','||m_01_perc55||'],['||m_02_54||','||m_02_perc55||'],['||m_03_54||','||m_03_perc55||'],['||m_04_54||','||m_04_perc55||'],['||m_05_54||','||m_05_perc55||'],['||m_06_54||','||m_06_perc55||'],['||m_07_54||','||m_07_perc55||'],['||m_08_54||','||m_08_perc55||'],['||m_09_54||','||m_09_perc55||'],['||m_10_54||','||m_10_perc55||'],['||m_11_54||','||m_11_perc55||'],['||m_12_54||','||m_12_perc55||'],['||m_13_54||','||m_13_perc55||'],['||m_14_54||','||m_14_perc55||'],['||m_15_54||','||m_15_perc55||'],['||m_16_54||','||m_16_perc55||'],['||m_17_54||','||m_17_perc55||'],['||m_18_54||','||m_18_perc55||']],';OUTPUT;
VAR1 = '[['||m_01_55||','||m_01_perc56||'],['||m_02_55||','||m_02_perc56||'],['||m_03_55||','||m_03_perc56||'],['||m_04_55||','||m_04_perc56||'],['||m_05_55||','||m_05_perc56||'],['||m_06_55||','||m_06_perc56||'],['||m_07_55||','||m_07_perc56||'],['||m_08_55||','||m_08_perc56||'],['||m_09_55||','||m_09_perc56||'],['||m_10_55||','||m_10_perc56||'],['||m_11_55||','||m_11_perc56||'],['||m_12_55||','||m_12_perc56||'],['||m_13_55||','||m_13_perc56||'],['||m_14_55||','||m_14_perc56||'],['||m_15_55||','||m_15_perc56||'],['||m_16_55||','||m_16_perc56||'],['||m_17_55||','||m_17_perc56||'],['||m_18_55||','||m_18_perc56||']],';OUTPUT;
VAR1 = '[['||m_01_56||','||m_01_perc57||'],['||m_02_56||','||m_02_perc57||'],['||m_03_56||','||m_03_perc57||'],['||m_04_56||','||m_04_perc57||'],['||m_05_56||','||m_05_perc57||'],['||m_06_56||','||m_06_perc57||'],['||m_07_56||','||m_07_perc57||'],['||m_08_56||','||m_08_perc57||'],['||m_09_56||','||m_09_perc57||'],['||m_10_56||','||m_10_perc57||'],['||m_11_56||','||m_11_perc57||'],['||m_12_56||','||m_12_perc57||'],['||m_13_56||','||m_13_perc57||'],['||m_14_56||','||m_14_perc57||'],['||m_15_56||','||m_15_perc57||'],['||m_16_56||','||m_16_perc57||'],['||m_17_56||','||m_17_perc57||'],['||m_18_56||','||m_18_perc57||']],';OUTPUT;
VAR1 = '[['||m_01_57||','||m_01_perc58||'],['||m_02_57||','||m_02_perc58||'],['||m_03_57||','||m_03_perc58||'],['||m_04_57||','||m_04_perc58||'],['||m_05_57||','||m_05_perc58||'],['||m_06_57||','||m_06_perc58||'],['||m_07_57||','||m_07_perc58||'],['||m_08_57||','||m_08_perc58||'],['||m_09_57||','||m_09_perc58||'],['||m_10_57||','||m_10_perc58||'],['||m_11_57||','||m_11_perc58||'],['||m_12_57||','||m_12_perc58||'],['||m_13_57||','||m_13_perc58||'],['||m_14_57||','||m_14_perc58||'],['||m_15_57||','||m_15_perc58||'],['||m_16_57||','||m_16_perc58||'],['||m_17_57||','||m_17_perc58||'],['||m_18_57||','||m_18_perc58||']],';OUTPUT;
VAR1 = '[['||m_01_58||','||m_01_perc59||'],['||m_02_58||','||m_02_perc59||'],['||m_03_58||','||m_03_perc59||'],['||m_04_58||','||m_04_perc59||'],['||m_05_58||','||m_05_perc59||'],['||m_06_58||','||m_06_perc59||'],['||m_07_58||','||m_07_perc59||'],['||m_08_58||','||m_08_perc59||'],['||m_09_58||','||m_09_perc59||'],['||m_10_58||','||m_10_perc59||'],['||m_11_58||','||m_11_perc59||'],['||m_12_58||','||m_12_perc59||'],['||m_13_58||','||m_13_perc59||'],['||m_14_58||','||m_14_perc59||'],['||m_15_58||','||m_15_perc59||'],['||m_16_58||','||m_16_perc59||'],['||m_17_58||','||m_17_perc59||'],['||m_18_58||','||m_18_perc59||']],';OUTPUT;
VAR1 = '[['||m_01_59||','||m_01_perc60||'],['||m_02_59||','||m_02_perc60||'],['||m_03_59||','||m_03_perc60||'],['||m_04_59||','||m_04_perc60||'],['||m_05_59||','||m_05_perc60||'],['||m_06_59||','||m_06_perc60||'],['||m_07_59||','||m_07_perc60||'],['||m_08_59||','||m_08_perc60||'],['||m_09_59||','||m_09_perc60||'],['||m_10_59||','||m_10_perc60||'],['||m_11_59||','||m_11_perc60||'],['||m_12_59||','||m_12_perc60||'],['||m_13_59||','||m_13_perc60||'],['||m_14_59||','||m_14_perc60||'],['||m_15_59||','||m_15_perc60||'],['||m_16_59||','||m_16_perc60||'],['||m_17_59||','||m_17_perc60||'],['||m_18_59||','||m_18_perc60||']],';OUTPUT;
VAR1 = '[['||m_01_60||','||m_01_perc61||'],['||m_02_60||','||m_02_perc61||'],['||m_03_60||','||m_03_perc61||'],['||m_04_60||','||m_04_perc61||'],['||m_05_60||','||m_05_perc61||'],['||m_06_60||','||m_06_perc61||'],['||m_07_60||','||m_07_perc61||'],['||m_08_60||','||m_08_perc61||'],['||m_09_60||','||m_09_perc61||'],['||m_10_60||','||m_10_perc61||'],['||m_11_60||','||m_11_perc61||'],['||m_12_60||','||m_12_perc61||'],['||m_13_60||','||m_13_perc61||'],['||m_14_60||','||m_14_perc61||'],['||m_15_60||','||m_15_perc61||'],['||m_16_60||','||m_16_perc61||'],['||m_17_60||','||m_17_perc61||'],['||m_18_60||','||m_18_perc61||']],';OUTPUT;
VAR1 = '[['||m_01_61||','||m_01_perc62||'],['||m_02_61||','||m_02_perc62||'],['||m_03_61||','||m_03_perc62||'],['||m_04_61||','||m_04_perc62||'],['||m_05_61||','||m_05_perc62||'],['||m_06_61||','||m_06_perc62||'],['||m_07_61||','||m_07_perc62||'],['||m_08_61||','||m_08_perc62||'],['||m_09_61||','||m_09_perc62||'],['||m_10_61||','||m_10_perc62||'],['||m_11_61||','||m_11_perc62||'],['||m_12_61||','||m_12_perc62||'],['||m_13_61||','||m_13_perc62||'],['||m_14_61||','||m_14_perc62||'],['||m_15_61||','||m_15_perc62||'],['||m_16_61||','||m_16_perc62||'],['||m_17_61||','||m_17_perc62||'],['||m_18_61||','||m_18_perc62||']],';OUTPUT;
VAR1 = '[['||m_01_62||','||m_01_perc63||'],['||m_02_62||','||m_02_perc63||'],['||m_03_62||','||m_03_perc63||'],['||m_04_62||','||m_04_perc63||'],['||m_05_62||','||m_05_perc63||'],['||m_06_62||','||m_06_perc63||'],['||m_07_62||','||m_07_perc63||'],['||m_08_62||','||m_08_perc63||'],['||m_09_62||','||m_09_perc63||'],['||m_10_62||','||m_10_perc63||'],['||m_11_62||','||m_11_perc63||'],['||m_12_62||','||m_12_perc63||'],['||m_13_62||','||m_13_perc63||'],['||m_14_62||','||m_14_perc63||'],['||m_15_62||','||m_15_perc63||'],['||m_16_62||','||m_16_perc63||'],['||m_17_62||','||m_17_perc63||'],['||m_18_62||','||m_18_perc63||']],';OUTPUT;
VAR1 = '[['||m_01_63||','||m_01_perc64||'],['||m_02_63||','||m_02_perc64||'],['||m_03_63||','||m_03_perc64||'],['||m_04_63||','||m_04_perc64||'],['||m_05_63||','||m_05_perc64||'],['||m_06_63||','||m_06_perc64||'],['||m_07_63||','||m_07_perc64||'],['||m_08_63||','||m_08_perc64||'],['||m_09_63||','||m_09_perc64||'],['||m_10_63||','||m_10_perc64||'],['||m_11_63||','||m_11_perc64||'],['||m_12_63||','||m_12_perc64||'],['||m_13_63||','||m_13_perc64||'],['||m_14_63||','||m_14_perc64||'],['||m_15_63||','||m_15_perc64||'],['||m_16_63||','||m_16_perc64||'],['||m_17_63||','||m_17_perc64||'],['||m_18_63||','||m_18_perc64||']],';OUTPUT;
VAR1 = '[['||m_01_64||','||m_01_perc65||'],['||m_02_64||','||m_02_perc65||'],['||m_03_64||','||m_03_perc65||'],['||m_04_64||','||m_04_perc65||'],['||m_05_64||','||m_05_perc65||'],['||m_06_64||','||m_06_perc65||'],['||m_07_64||','||m_07_perc65||'],['||m_08_64||','||m_08_perc65||'],['||m_09_64||','||m_09_perc65||'],['||m_10_64||','||m_10_perc65||'],['||m_11_64||','||m_11_perc65||'],['||m_12_64||','||m_12_perc65||'],['||m_13_64||','||m_13_perc65||'],['||m_14_64||','||m_14_perc65||'],['||m_15_64||','||m_15_perc65||'],['||m_16_64||','||m_16_perc65||'],['||m_17_64||','||m_17_perc65||'],['||m_18_64||','||m_18_perc65||']],';OUTPUT;
VAR1 = '[['||m_01_65||','||m_01_perc66||'],['||m_02_65||','||m_02_perc66||'],['||m_03_65||','||m_03_perc66||'],['||m_04_65||','||m_04_perc66||'],['||m_05_65||','||m_05_perc66||'],['||m_06_65||','||m_06_perc66||'],['||m_07_65||','||m_07_perc66||'],['||m_08_65||','||m_08_perc66||'],['||m_09_65||','||m_09_perc66||'],['||m_10_65||','||m_10_perc66||'],['||m_11_65||','||m_11_perc66||'],['||m_12_65||','||m_12_perc66||'],['||m_13_65||','||m_13_perc66||'],['||m_14_65||','||m_14_perc66||'],['||m_15_65||','||m_15_perc66||'],['||m_16_65||','||m_16_perc66||'],['||m_17_65||','||m_17_perc66||'],['||m_18_65||','||m_18_perc66||']],';OUTPUT;
VAR1 = '[['||m_01_66||','||m_01_perc67||'],['||m_02_66||','||m_02_perc67||'],['||m_03_66||','||m_03_perc67||'],['||m_04_66||','||m_04_perc67||'],['||m_05_66||','||m_05_perc67||'],['||m_06_66||','||m_06_perc67||'],['||m_07_66||','||m_07_perc67||'],['||m_08_66||','||m_08_perc67||'],['||m_09_66||','||m_09_perc67||'],['||m_10_66||','||m_10_perc67||'],['||m_11_66||','||m_11_perc67||'],['||m_12_66||','||m_12_perc67||'],['||m_13_66||','||m_13_perc67||'],['||m_14_66||','||m_14_perc67||'],['||m_15_66||','||m_15_perc67||'],['||m_16_66||','||m_16_perc67||'],['||m_17_66||','||m_17_perc67||'],['||m_18_66||','||m_18_perc67||']],';OUTPUT;
VAR1 = '[['||m_01_67||','||m_01_perc68||'],['||m_02_67||','||m_02_perc68||'],['||m_03_67||','||m_03_perc68||'],['||m_04_67||','||m_04_perc68||'],['||m_05_67||','||m_05_perc68||'],['||m_06_67||','||m_06_perc68||'],['||m_07_67||','||m_07_perc68||'],['||m_08_67||','||m_08_perc68||'],['||m_09_67||','||m_09_perc68||'],['||m_10_67||','||m_10_perc68||'],['||m_11_67||','||m_11_perc68||'],['||m_12_67||','||m_12_perc68||'],['||m_13_67||','||m_13_perc68||'],['||m_14_67||','||m_14_perc68||'],['||m_15_67||','||m_15_perc68||'],['||m_16_67||','||m_16_perc68||'],['||m_17_67||','||m_17_perc68||'],['||m_18_67||','||m_18_perc68||']],';OUTPUT;
VAR1 = '[['||m_01_68||','||m_01_perc69||'],['||m_02_68||','||m_02_perc69||'],['||m_03_68||','||m_03_perc69||'],['||m_04_68||','||m_04_perc69||'],['||m_05_68||','||m_05_perc69||'],['||m_06_68||','||m_06_perc69||'],['||m_07_68||','||m_07_perc69||'],['||m_08_68||','||m_08_perc69||'],['||m_09_68||','||m_09_perc69||'],['||m_10_68||','||m_10_perc69||'],['||m_11_68||','||m_11_perc69||'],['||m_12_68||','||m_12_perc69||'],['||m_13_68||','||m_13_perc69||'],['||m_14_68||','||m_14_perc69||'],['||m_15_68||','||m_15_perc69||'],['||m_16_68||','||m_16_perc69||'],['||m_17_68||','||m_17_perc69||'],['||m_18_68||','||m_18_perc69||']],';OUTPUT;
VAR1 = '[['||m_01_69||','||m_01_perc70||'],['||m_02_69||','||m_02_perc70||'],['||m_03_69||','||m_03_perc70||'],['||m_04_69||','||m_04_perc70||'],['||m_05_69||','||m_05_perc70||'],['||m_06_69||','||m_06_perc70||'],['||m_07_69||','||m_07_perc70||'],['||m_08_69||','||m_08_perc70||'],['||m_09_69||','||m_09_perc70||'],['||m_10_69||','||m_10_perc70||'],['||m_11_69||','||m_11_perc70||'],['||m_12_69||','||m_12_perc70||'],['||m_13_69||','||m_13_perc70||'],['||m_14_69||','||m_14_perc70||'],['||m_15_69||','||m_15_perc70||'],['||m_16_69||','||m_16_perc70||'],['||m_17_69||','||m_17_perc70||'],['||m_18_69||','||m_18_perc70||']],';OUTPUT;
VAR1 = '[['||m_01_70||','||m_01_perc71||'],['||m_02_70||','||m_02_perc71||'],['||m_03_70||','||m_03_perc71||'],['||m_04_70||','||m_04_perc71||'],['||m_05_70||','||m_05_perc71||'],['||m_06_70||','||m_06_perc71||'],['||m_07_70||','||m_07_perc71||'],['||m_08_70||','||m_08_perc71||'],['||m_09_70||','||m_09_perc71||'],['||m_10_70||','||m_10_perc71||'],['||m_11_70||','||m_11_perc71||'],['||m_12_70||','||m_12_perc71||'],['||m_13_70||','||m_13_perc71||'],['||m_14_70||','||m_14_perc71||'],['||m_15_70||','||m_15_perc71||'],['||m_16_70||','||m_16_perc71||'],['||m_17_70||','||m_17_perc71||'],['||m_18_70||','||m_18_perc71||']],';OUTPUT;
VAR1 = '[['||m_01_71||','||m_01_perc72||'],['||m_02_71||','||m_02_perc72||'],['||m_03_71||','||m_03_perc72||'],['||m_04_71||','||m_04_perc72||'],['||m_05_71||','||m_05_perc72||'],['||m_06_71||','||m_06_perc72||'],['||m_07_71||','||m_07_perc72||'],['||m_08_71||','||m_08_perc72||'],['||m_09_71||','||m_09_perc72||'],['||m_10_71||','||m_10_perc72||'],['||m_11_71||','||m_11_perc72||'],['||m_12_71||','||m_12_perc72||'],['||m_13_71||','||m_13_perc72||'],['||m_14_71||','||m_14_perc72||'],['||m_15_71||','||m_15_perc72||'],['||m_16_71||','||m_16_perc72||'],['||m_17_71||','||m_17_perc72||'],['||m_18_71||','||m_18_perc72||']],';OUTPUT;
VAR1 = '[['||m_01_72||','||m_01_perc73||'],['||m_02_72||','||m_02_perc73||'],['||m_03_72||','||m_03_perc73||'],['||m_04_72||','||m_04_perc73||'],['||m_05_72||','||m_05_perc73||'],['||m_06_72||','||m_06_perc73||'],['||m_07_72||','||m_07_perc73||'],['||m_08_72||','||m_08_perc73||'],['||m_09_72||','||m_09_perc73||'],['||m_10_72||','||m_10_perc73||'],['||m_11_72||','||m_11_perc73||'],['||m_12_72||','||m_12_perc73||'],['||m_13_72||','||m_13_perc73||'],['||m_14_72||','||m_14_perc73||'],['||m_15_72||','||m_15_perc73||'],['||m_16_72||','||m_16_perc73||'],['||m_17_72||','||m_17_perc73||'],['||m_18_72||','||m_18_perc73||']],';OUTPUT;
VAR1 = '[['||m_01_73||','||m_01_perc74||'],['||m_02_73||','||m_02_perc74||'],['||m_03_73||','||m_03_perc74||'],['||m_04_73||','||m_04_perc74||'],['||m_05_73||','||m_05_perc74||'],['||m_06_73||','||m_06_perc74||'],['||m_07_73||','||m_07_perc74||'],['||m_08_73||','||m_08_perc74||'],['||m_09_73||','||m_09_perc74||'],['||m_10_73||','||m_10_perc74||'],['||m_11_73||','||m_11_perc74||'],['||m_12_73||','||m_12_perc74||'],['||m_13_73||','||m_13_perc74||'],['||m_14_73||','||m_14_perc74||'],['||m_15_73||','||m_15_perc74||'],['||m_16_73||','||m_16_perc74||'],['||m_17_73||','||m_17_perc74||'],['||m_18_73||','||m_18_perc74||']],';OUTPUT;
VAR1 = '[['||m_01_74||','||m_01_perc75||'],['||m_02_74||','||m_02_perc75||'],['||m_03_74||','||m_03_perc75||'],['||m_04_74||','||m_04_perc75||'],['||m_05_74||','||m_05_perc75||'],['||m_06_74||','||m_06_perc75||'],['||m_07_74||','||m_07_perc75||'],['||m_08_74||','||m_08_perc75||'],['||m_09_74||','||m_09_perc75||'],['||m_10_74||','||m_10_perc75||'],['||m_11_74||','||m_11_perc75||'],['||m_12_74||','||m_12_perc75||'],['||m_13_74||','||m_13_perc75||'],['||m_14_74||','||m_14_perc75||'],['||m_15_74||','||m_15_perc75||'],['||m_16_74||','||m_16_perc75||'],['||m_17_74||','||m_17_perc75||'],['||m_18_74||','||m_18_perc75||']],';OUTPUT;
VAR1 = '[['||m_01_75||','||m_01_perc76||'],['||m_02_75||','||m_02_perc76||'],['||m_03_75||','||m_03_perc76||'],['||m_04_75||','||m_04_perc76||'],['||m_05_75||','||m_05_perc76||'],['||m_06_75||','||m_06_perc76||'],['||m_07_75||','||m_07_perc76||'],['||m_08_75||','||m_08_perc76||'],['||m_09_75||','||m_09_perc76||'],['||m_10_75||','||m_10_perc76||'],['||m_11_75||','||m_11_perc76||'],['||m_12_75||','||m_12_perc76||'],['||m_13_75||','||m_13_perc76||'],['||m_14_75||','||m_14_perc76||'],['||m_15_75||','||m_15_perc76||'],['||m_16_75||','||m_16_perc76||'],['||m_17_75||','||m_17_perc76||'],['||m_18_75||','||m_18_perc76||']],';OUTPUT;
VAR1 = '[['||m_01_76||','||m_01_perc77||'],['||m_02_76||','||m_02_perc77||'],['||m_03_76||','||m_03_perc77||'],['||m_04_76||','||m_04_perc77||'],['||m_05_76||','||m_05_perc77||'],['||m_06_76||','||m_06_perc77||'],['||m_07_76||','||m_07_perc77||'],['||m_08_76||','||m_08_perc77||'],['||m_09_76||','||m_09_perc77||'],['||m_10_76||','||m_10_perc77||'],['||m_11_76||','||m_11_perc77||'],['||m_12_76||','||m_12_perc77||'],['||m_13_76||','||m_13_perc77||'],['||m_14_76||','||m_14_perc77||'],['||m_15_76||','||m_15_perc77||'],['||m_16_76||','||m_16_perc77||'],['||m_17_76||','||m_17_perc77||'],['||m_18_76||','||m_18_perc77||']],';OUTPUT;
VAR1 = '[['||m_01_77||','||m_01_perc78||'],['||m_02_77||','||m_02_perc78||'],['||m_03_77||','||m_03_perc78||'],['||m_04_77||','||m_04_perc78||'],['||m_05_77||','||m_05_perc78||'],['||m_06_77||','||m_06_perc78||'],['||m_07_77||','||m_07_perc78||'],['||m_08_77||','||m_08_perc78||'],['||m_09_77||','||m_09_perc78||'],['||m_10_77||','||m_10_perc78||'],['||m_11_77||','||m_11_perc78||'],['||m_12_77||','||m_12_perc78||'],['||m_13_77||','||m_13_perc78||'],['||m_14_77||','||m_14_perc78||'],['||m_15_77||','||m_15_perc78||'],['||m_16_77||','||m_16_perc78||'],['||m_17_77||','||m_17_perc78||'],['||m_18_77||','||m_18_perc78||']],';OUTPUT;
VAR1 = '[['||m_01_78||','||m_01_perc79||'],['||m_02_78||','||m_02_perc79||'],['||m_03_78||','||m_03_perc79||'],['||m_04_78||','||m_04_perc79||'],['||m_05_78||','||m_05_perc79||'],['||m_06_78||','||m_06_perc79||'],['||m_07_78||','||m_07_perc79||'],['||m_08_78||','||m_08_perc79||'],['||m_09_78||','||m_09_perc79||'],['||m_10_78||','||m_10_perc79||'],['||m_11_78||','||m_11_perc79||'],['||m_12_78||','||m_12_perc79||'],['||m_13_78||','||m_13_perc79||'],['||m_14_78||','||m_14_perc79||'],['||m_15_78||','||m_15_perc79||'],['||m_16_78||','||m_16_perc79||'],['||m_17_78||','||m_17_perc79||'],['||m_18_78||','||m_18_perc79||']],';OUTPUT;
VAR1 = '[['||m_01_79||','||m_01_perc80||'],['||m_02_79||','||m_02_perc80||'],['||m_03_79||','||m_03_perc80||'],['||m_04_79||','||m_04_perc80||'],['||m_05_79||','||m_05_perc80||'],['||m_06_79||','||m_06_perc80||'],['||m_07_79||','||m_07_perc80||'],['||m_08_79||','||m_08_perc80||'],['||m_09_79||','||m_09_perc80||'],['||m_10_79||','||m_10_perc80||'],['||m_11_79||','||m_11_perc80||'],['||m_12_79||','||m_12_perc80||'],['||m_13_79||','||m_13_perc80||'],['||m_14_79||','||m_14_perc80||'],['||m_15_79||','||m_15_perc80||'],['||m_16_79||','||m_16_perc80||'],['||m_17_79||','||m_17_perc80||'],['||m_18_79||','||m_18_perc80||']],';OUTPUT;
VAR1 = '[['||m_01_80||','||m_01_perc81||'],['||m_02_80||','||m_02_perc81||'],['||m_03_80||','||m_03_perc81||'],['||m_04_80||','||m_04_perc81||'],['||m_05_80||','||m_05_perc81||'],['||m_06_80||','||m_06_perc81||'],['||m_07_80||','||m_07_perc81||'],['||m_08_80||','||m_08_perc81||'],['||m_09_80||','||m_09_perc81||'],['||m_10_80||','||m_10_perc81||'],['||m_11_80||','||m_11_perc81||'],['||m_12_80||','||m_12_perc81||'],['||m_13_80||','||m_13_perc81||'],['||m_14_80||','||m_14_perc81||'],['||m_15_80||','||m_15_perc81||'],['||m_16_80||','||m_16_perc81||'],['||m_17_80||','||m_17_perc81||'],['||m_18_80||','||m_18_perc81||']],';OUTPUT;
VAR1 = '[['||m_01_81||','||m_01_perc82||'],['||m_02_81||','||m_02_perc82||'],['||m_03_81||','||m_03_perc82||'],['||m_04_81||','||m_04_perc82||'],['||m_05_81||','||m_05_perc82||'],['||m_06_81||','||m_06_perc82||'],['||m_07_81||','||m_07_perc82||'],['||m_08_81||','||m_08_perc82||'],['||m_09_81||','||m_09_perc82||'],['||m_10_81||','||m_10_perc82||'],['||m_11_81||','||m_11_perc82||'],['||m_12_81||','||m_12_perc82||'],['||m_13_81||','||m_13_perc82||'],['||m_14_81||','||m_14_perc82||'],['||m_15_81||','||m_15_perc82||'],['||m_16_81||','||m_16_perc82||'],['||m_17_81||','||m_17_perc82||'],['||m_18_81||','||m_18_perc82||']],';OUTPUT;
VAR1 = '[['||m_01_82||','||m_01_perc83||'],['||m_02_82||','||m_02_perc83||'],['||m_03_82||','||m_03_perc83||'],['||m_04_82||','||m_04_perc83||'],['||m_05_82||','||m_05_perc83||'],['||m_06_82||','||m_06_perc83||'],['||m_07_82||','||m_07_perc83||'],['||m_08_82||','||m_08_perc83||'],['||m_09_82||','||m_09_perc83||'],['||m_10_82||','||m_10_perc83||'],['||m_11_82||','||m_11_perc83||'],['||m_12_82||','||m_12_perc83||'],['||m_13_82||','||m_13_perc83||'],['||m_14_82||','||m_14_perc83||'],['||m_15_82||','||m_15_perc83||'],['||m_16_82||','||m_16_perc83||'],['||m_17_82||','||m_17_perc83||'],['||m_18_82||','||m_18_perc83||']],';OUTPUT;
VAR1 = '[['||m_01_83||','||m_01_perc84||'],['||m_02_83||','||m_02_perc84||'],['||m_03_83||','||m_03_perc84||'],['||m_04_83||','||m_04_perc84||'],['||m_05_83||','||m_05_perc84||'],['||m_06_83||','||m_06_perc84||'],['||m_07_83||','||m_07_perc84||'],['||m_08_83||','||m_08_perc84||'],['||m_09_83||','||m_09_perc84||'],['||m_10_83||','||m_10_perc84||'],['||m_11_83||','||m_11_perc84||'],['||m_12_83||','||m_12_perc84||'],['||m_13_83||','||m_13_perc84||'],['||m_14_83||','||m_14_perc84||'],['||m_15_83||','||m_15_perc84||'],['||m_16_83||','||m_16_perc84||'],['||m_17_83||','||m_17_perc84||'],['||m_18_83||','||m_18_perc84||']],';OUTPUT;
VAR1 = '[['||m_01_84||','||m_01_perc85||'],['||m_02_84||','||m_02_perc85||'],['||m_03_84||','||m_03_perc85||'],['||m_04_84||','||m_04_perc85||'],['||m_05_84||','||m_05_perc85||'],['||m_06_84||','||m_06_perc85||'],['||m_07_84||','||m_07_perc85||'],['||m_08_84||','||m_08_perc85||'],['||m_09_84||','||m_09_perc85||'],['||m_10_84||','||m_10_perc85||'],['||m_11_84||','||m_11_perc85||'],['||m_12_84||','||m_12_perc85||'],['||m_13_84||','||m_13_perc85||'],['||m_14_84||','||m_14_perc85||'],['||m_15_84||','||m_15_perc85||'],['||m_16_84||','||m_16_perc85||'],['||m_17_84||','||m_17_perc85||'],['||m_18_84||','||m_18_perc85||']],';OUTPUT;
VAR1 = '[['||m_01_85||','||m_01_perc86||'],['||m_02_85||','||m_02_perc86||'],['||m_03_85||','||m_03_perc86||'],['||m_04_85||','||m_04_perc86||'],['||m_05_85||','||m_05_perc86||'],['||m_06_85||','||m_06_perc86||'],['||m_07_85||','||m_07_perc86||'],['||m_08_85||','||m_08_perc86||'],['||m_09_85||','||m_09_perc86||'],['||m_10_85||','||m_10_perc86||'],['||m_11_85||','||m_11_perc86||'],['||m_12_85||','||m_12_perc86||'],['||m_13_85||','||m_13_perc86||'],['||m_14_85||','||m_14_perc86||'],['||m_15_85||','||m_15_perc86||'],['||m_16_85||','||m_16_perc86||'],['||m_17_85||','||m_17_perc86||'],['||m_18_85||','||m_18_perc86||']],';OUTPUT;
VAR1 = '[['||m_01_86||','||m_01_perc87||'],['||m_02_86||','||m_02_perc87||'],['||m_03_86||','||m_03_perc87||'],['||m_04_86||','||m_04_perc87||'],['||m_05_86||','||m_05_perc87||'],['||m_06_86||','||m_06_perc87||'],['||m_07_86||','||m_07_perc87||'],['||m_08_86||','||m_08_perc87||'],['||m_09_86||','||m_09_perc87||'],['||m_10_86||','||m_10_perc87||'],['||m_11_86||','||m_11_perc87||'],['||m_12_86||','||m_12_perc87||'],['||m_13_86||','||m_13_perc87||'],['||m_14_86||','||m_14_perc87||'],['||m_15_86||','||m_15_perc87||'],['||m_16_86||','||m_16_perc87||'],['||m_17_86||','||m_17_perc87||'],['||m_18_86||','||m_18_perc87||']],';OUTPUT;
VAR1 = '[['||m_01_87||','||m_01_perc88||'],['||m_02_87||','||m_02_perc88||'],['||m_03_87||','||m_03_perc88||'],['||m_04_87||','||m_04_perc88||'],['||m_05_87||','||m_05_perc88||'],['||m_06_87||','||m_06_perc88||'],['||m_07_87||','||m_07_perc88||'],['||m_08_87||','||m_08_perc88||'],['||m_09_87||','||m_09_perc88||'],['||m_10_87||','||m_10_perc88||'],['||m_11_87||','||m_11_perc88||'],['||m_12_87||','||m_12_perc88||'],['||m_13_87||','||m_13_perc88||'],['||m_14_87||','||m_14_perc88||'],['||m_15_87||','||m_15_perc88||'],['||m_16_87||','||m_16_perc88||'],['||m_17_87||','||m_17_perc88||'],['||m_18_87||','||m_18_perc88||']],';OUTPUT;
VAR1 = '[['||m_01_88||','||m_01_perc89||'],['||m_02_88||','||m_02_perc89||'],['||m_03_88||','||m_03_perc89||'],['||m_04_88||','||m_04_perc89||'],['||m_05_88||','||m_05_perc89||'],['||m_06_88||','||m_06_perc89||'],['||m_07_88||','||m_07_perc89||'],['||m_08_88||','||m_08_perc89||'],['||m_09_88||','||m_09_perc89||'],['||m_10_88||','||m_10_perc89||'],['||m_11_88||','||m_11_perc89||'],['||m_12_88||','||m_12_perc89||'],['||m_13_88||','||m_13_perc89||'],['||m_14_88||','||m_14_perc89||'],['||m_15_88||','||m_15_perc89||'],['||m_16_88||','||m_16_perc89||'],['||m_17_88||','||m_17_perc89||'],['||m_18_88||','||m_18_perc89||']],';OUTPUT;
VAR1 = '[['||m_01_89||','||m_01_perc90||'],['||m_02_89||','||m_02_perc90||'],['||m_03_89||','||m_03_perc90||'],['||m_04_89||','||m_04_perc90||'],['||m_05_89||','||m_05_perc90||'],['||m_06_89||','||m_06_perc90||'],['||m_07_89||','||m_07_perc90||'],['||m_08_89||','||m_08_perc90||'],['||m_09_89||','||m_09_perc90||'],['||m_10_89||','||m_10_perc90||'],['||m_11_89||','||m_11_perc90||'],['||m_12_89||','||m_12_perc90||'],['||m_13_89||','||m_13_perc90||'],['||m_14_89||','||m_14_perc90||'],['||m_15_89||','||m_15_perc90||'],['||m_16_89||','||m_16_perc90||'],['||m_17_89||','||m_17_perc90||'],['||m_18_89||','||m_18_perc90||']],';OUTPUT;
VAR1 = '[['||m_01_90||','||m_01_perc91||'],['||m_02_90||','||m_02_perc91||'],['||m_03_90||','||m_03_perc91||'],['||m_04_90||','||m_04_perc91||'],['||m_05_90||','||m_05_perc91||'],['||m_06_90||','||m_06_perc91||'],['||m_07_90||','||m_07_perc91||'],['||m_08_90||','||m_08_perc91||'],['||m_09_90||','||m_09_perc91||'],['||m_10_90||','||m_10_perc91||'],['||m_11_90||','||m_11_perc91||'],['||m_12_90||','||m_12_perc91||'],['||m_13_90||','||m_13_perc91||'],['||m_14_90||','||m_14_perc91||'],['||m_15_90||','||m_15_perc91||'],['||m_16_90||','||m_16_perc91||'],['||m_17_90||','||m_17_perc91||'],['||m_18_90||','||m_18_perc91||']]],';OUTPUT;
VAR1 = '[[['||f_01_0||','||f_01_perc1||'],['||f_02_0||','||f_02_perc1||'],['||f_03_0||','||f_03_perc1||'],['||f_04_0||','||f_04_perc1||'],['||f_05_0||','||f_05_perc1||'],['||f_06_0||','||f_06_perc1||'],['||f_07_0||','||f_07_perc1||'],['||f_08_0||','||f_08_perc1||'],['||f_09_0||','||f_09_perc1||'],['||f_10_0||','||f_10_perc1||'],['||f_11_0||','||f_11_perc1||'],['||f_12_0||','||f_12_perc1||'],['||f_13_0||','||f_13_perc1||'],['||f_14_0||','||f_14_perc1||'],['||f_15_0||','||f_15_perc1||'],['||f_16_0||','||f_16_perc1||'],['||f_17_0||','||f_17_perc1||'],['||f_18_0||','||f_18_perc1||']],';OUTPUT;
VAR1 = '[['||f_01_1||','||f_01_perc2||'],['||f_02_1||','||f_02_perc2||'],['||f_03_1||','||f_03_perc2||'],['||f_04_1||','||f_04_perc2||'],['||f_05_1||','||f_05_perc2||'],['||f_06_1||','||f_06_perc2||'],['||f_07_1||','||f_07_perc2||'],['||f_08_1||','||f_08_perc2||'],['||f_09_1||','||f_09_perc2||'],['||f_10_1||','||f_10_perc2||'],['||f_11_1||','||f_11_perc2||'],['||f_12_1||','||f_12_perc2||'],['||f_13_1||','||f_13_perc2||'],['||f_14_1||','||f_14_perc2||'],['||f_15_1||','||f_15_perc2||'],['||f_16_1||','||f_16_perc2||'],['||f_17_1||','||m_17_perc2||'],['||f_18_1||','||f_18_perc2||']],';OUTPUT;
VAR1 = '[['||f_01_2||','||f_01_perc3||'],['||f_02_2||','||f_02_perc3||'],['||f_03_2||','||f_03_perc3||'],['||f_04_2||','||f_04_perc3||'],['||f_05_2||','||f_05_perc3||'],['||f_06_2||','||f_06_perc3||'],['||f_07_2||','||f_07_perc3||'],['||f_08_2||','||f_08_perc3||'],['||f_09_2||','||f_09_perc3||'],['||f_10_2||','||f_10_perc3||'],['||f_11_2||','||f_11_perc3||'],['||f_12_2||','||f_12_perc3||'],['||f_13_2||','||f_13_perc3||'],['||f_14_2||','||f_14_perc3||'],['||f_15_2||','||f_15_perc3||'],['||f_16_2||','||f_16_perc3||'],['||f_17_2||','||m_17_perc3||'],['||f_18_2||','||f_18_perc3||']],';OUTPUT;
VAR1 = '[['||f_01_3||','||f_01_perc4||'],['||f_02_3||','||f_02_perc4||'],['||f_03_3||','||f_03_perc4||'],['||f_04_3||','||f_04_perc4||'],['||f_05_3||','||f_05_perc4||'],['||f_06_3||','||f_06_perc4||'],['||f_07_3||','||f_07_perc4||'],['||f_08_3||','||f_08_perc4||'],['||f_09_3||','||f_09_perc4||'],['||f_10_3||','||f_10_perc4||'],['||f_11_3||','||f_11_perc4||'],['||f_12_3||','||f_12_perc4||'],['||f_13_3||','||f_13_perc4||'],['||f_14_3||','||f_14_perc4||'],['||f_15_3||','||f_15_perc4||'],['||f_16_3||','||f_16_perc4||'],['||f_17_3||','||m_17_perc4||'],['||f_18_3||','||f_18_perc4||']],';OUTPUT;
VAR1 = '[['||f_01_4||','||f_01_perc5||'],['||f_02_4||','||f_02_perc5||'],['||f_03_4||','||f_03_perc5||'],['||f_04_4||','||f_04_perc5||'],['||f_05_4||','||f_05_perc5||'],['||f_06_4||','||f_06_perc5||'],['||f_07_4||','||f_07_perc5||'],['||f_08_4||','||f_08_perc5||'],['||f_09_4||','||f_09_perc5||'],['||f_10_4||','||f_10_perc5||'],['||f_11_4||','||f_11_perc5||'],['||f_12_4||','||f_12_perc5||'],['||f_13_4||','||f_13_perc5||'],['||f_14_4||','||f_14_perc5||'],['||f_15_4||','||f_15_perc5||'],['||f_16_4||','||f_16_perc5||'],['||f_17_4||','||m_17_perc5||'],['||f_18_4||','||f_18_perc5||']],';OUTPUT;
VAR1 = '[['||f_01_5||','||f_01_perc6||'],['||f_02_5||','||f_02_perc6||'],['||f_03_5||','||f_03_perc6||'],['||f_04_5||','||f_04_perc6||'],['||f_05_5||','||f_05_perc6||'],['||f_06_5||','||f_06_perc6||'],['||f_07_5||','||f_07_perc6||'],['||f_08_5||','||f_08_perc6||'],['||f_09_5||','||f_09_perc6||'],['||f_10_5||','||f_10_perc6||'],['||f_11_5||','||f_11_perc6||'],['||f_12_5||','||f_12_perc6||'],['||f_13_5||','||f_13_perc6||'],['||f_14_5||','||f_14_perc6||'],['||f_15_5||','||f_15_perc6||'],['||f_16_5||','||f_16_perc6||'],['||f_17_5||','||m_17_perc6||'],['||f_18_5||','||f_18_perc6||']],';OUTPUT;
VAR1 = '[['||f_01_6||','||f_01_perc7||'],['||f_02_6||','||f_02_perc7||'],['||f_03_6||','||f_03_perc7||'],['||f_04_6||','||f_04_perc7||'],['||f_05_6||','||f_05_perc7||'],['||f_06_6||','||f_06_perc7||'],['||f_07_6||','||f_07_perc7||'],['||f_08_6||','||f_08_perc7||'],['||f_09_6||','||f_09_perc7||'],['||f_10_6||','||f_10_perc7||'],['||f_11_6||','||f_11_perc7||'],['||f_12_6||','||f_12_perc7||'],['||f_13_6||','||f_13_perc7||'],['||f_14_6||','||f_14_perc7||'],['||f_15_6||','||f_15_perc7||'],['||f_16_6||','||f_16_perc7||'],['||f_17_6||','||m_17_perc7||'],['||f_18_6||','||f_18_perc7||']],';OUTPUT;
VAR1 = '[['||f_01_7||','||f_01_perc8||'],['||f_02_7||','||f_02_perc8||'],['||f_03_7||','||f_03_perc8||'],['||f_04_7||','||f_04_perc8||'],['||f_05_7||','||f_05_perc8||'],['||f_06_7||','||f_06_perc8||'],['||f_07_7||','||f_07_perc8||'],['||f_08_7||','||f_08_perc8||'],['||f_09_7||','||f_09_perc8||'],['||f_10_7||','||f_10_perc8||'],['||f_11_7||','||f_11_perc8||'],['||f_12_7||','||f_12_perc8||'],['||f_13_7||','||f_13_perc8||'],['||f_14_7||','||f_14_perc8||'],['||f_15_7||','||f_15_perc8||'],['||f_16_7||','||f_16_perc8||'],['||f_17_7||','||m_17_perc8||'],['||f_18_7||','||f_18_perc8||']],';OUTPUT;
VAR1 = '[['||f_01_8||','||f_01_perc9||'],['||f_02_8||','||f_02_perc9||'],['||f_03_8||','||f_03_perc9||'],['||f_04_8||','||f_04_perc9||'],['||f_05_8||','||f_05_perc9||'],['||f_06_8||','||f_06_perc9||'],['||f_07_8||','||f_07_perc9||'],['||f_08_8||','||f_08_perc9||'],['||f_09_8||','||f_09_perc9||'],['||f_10_8||','||f_10_perc9||'],['||f_11_8||','||f_11_perc9||'],['||f_12_8||','||f_12_perc9||'],['||f_13_8||','||f_13_perc9||'],['||f_14_8||','||f_14_perc9||'],['||f_15_8||','||f_15_perc9||'],['||f_16_8||','||f_16_perc9||'],['||f_17_8||','||m_17_perc9||'],['||f_18_8||','||f_18_perc9||']],';OUTPUT;
VAR1 = '[['||f_01_9||','||f_01_perc10||'],['||f_02_9||','||f_02_perc10||'],['||f_03_9||','||f_03_perc10||'],['||f_04_9||','||f_04_perc10||'],['||f_05_9||','||f_05_perc10||'],['||f_06_9||','||f_06_perc10||'],['||f_07_9||','||f_07_perc10||'],['||f_08_9||','||f_08_perc10||'],['||f_09_9||','||f_09_perc10||'],['||f_10_9||','||f_10_perc10||'],['||f_11_9||','||f_11_perc10||'],['||f_12_9||','||f_12_perc10||'],['||f_13_9||','||f_13_perc10||'],['||f_14_9||','||f_14_perc10||'],['||f_15_9||','||f_15_perc10||'],['||f_16_9||','||f_16_perc10||'],['||f_17_9||','||m_17_perc10||'],['||f_18_9||','||f_18_perc10||']],';OUTPUT;
VAR1 = '[['||f_01_10||','||f_01_perc11||'],['||f_02_10||','||f_02_perc11||'],['||f_03_10||','||f_03_perc11||'],['||f_04_10||','||f_04_perc11||'],['||f_05_10||','||f_05_perc11||'],['||f_06_10||','||f_06_perc11||'],['||f_07_10||','||f_07_perc11||'],['||f_08_10||','||f_08_perc11||'],['||f_09_10||','||f_09_perc11||'],['||f_10_10||','||f_10_perc11||'],['||f_11_10||','||f_11_perc11||'],['||f_12_10||','||f_12_perc11||'],['||f_13_10||','||f_13_perc11||'],['||f_14_10||','||f_14_perc11||'],['||f_15_10||','||f_15_perc11||'],['||f_16_10||','||f_16_perc11||'],['||f_17_10||','||m_17_perc11||'],['||f_18_10||','||f_18_perc11||']],';OUTPUT;
VAR1 = '[['||f_01_11||','||f_01_perc12||'],['||f_02_11||','||f_02_perc12||'],['||f_03_11||','||f_03_perc12||'],['||f_04_11||','||f_04_perc12||'],['||f_05_11||','||f_05_perc12||'],['||f_06_11||','||f_06_perc12||'],['||f_07_11||','||f_07_perc12||'],['||f_08_11||','||f_08_perc12||'],['||f_09_11||','||f_09_perc12||'],['||f_10_11||','||f_10_perc12||'],['||f_11_11||','||f_11_perc12||'],['||f_12_11||','||f_12_perc12||'],['||f_13_11||','||f_13_perc12||'],['||f_14_11||','||f_14_perc12||'],['||f_15_11||','||f_15_perc12||'],['||f_16_11||','||f_16_perc12||'],['||f_17_11||','||m_17_perc12||'],['||f_18_11||','||f_18_perc12||']],';OUTPUT;
VAR1 = '[['||f_01_12||','||f_01_perc13||'],['||f_02_12||','||f_02_perc13||'],['||f_03_12||','||f_03_perc13||'],['||f_04_12||','||f_04_perc13||'],['||f_05_12||','||f_05_perc13||'],['||f_06_12||','||f_06_perc13||'],['||f_07_12||','||f_07_perc13||'],['||f_08_12||','||f_08_perc13||'],['||f_09_12||','||f_09_perc13||'],['||f_10_12||','||f_10_perc13||'],['||f_11_12||','||f_11_perc13||'],['||f_12_12||','||f_12_perc13||'],['||f_13_12||','||f_13_perc13||'],['||f_14_12||','||f_14_perc13||'],['||f_15_12||','||f_15_perc13||'],['||f_16_12||','||f_16_perc13||'],['||f_17_12||','||m_17_perc13||'],['||f_18_12||','||f_18_perc13||']],';OUTPUT;
VAR1 = '[['||f_01_13||','||f_01_perc14||'],['||f_02_13||','||f_02_perc14||'],['||f_03_13||','||f_03_perc14||'],['||f_04_13||','||f_04_perc14||'],['||f_05_13||','||f_05_perc14||'],['||f_06_13||','||f_06_perc14||'],['||f_07_13||','||f_07_perc14||'],['||f_08_13||','||f_08_perc14||'],['||f_09_13||','||f_09_perc14||'],['||f_10_13||','||f_10_perc14||'],['||f_11_13||','||f_11_perc14||'],['||f_12_13||','||f_12_perc14||'],['||f_13_13||','||f_13_perc14||'],['||f_14_13||','||f_14_perc14||'],['||f_15_13||','||f_15_perc14||'],['||f_16_13||','||f_16_perc14||'],['||f_17_13||','||m_17_perc14||'],['||f_18_13||','||f_18_perc14||']],';OUTPUT;
VAR1 = '[['||f_01_14||','||f_01_perc15||'],['||f_02_14||','||f_02_perc15||'],['||f_03_14||','||f_03_perc15||'],['||f_04_14||','||f_04_perc15||'],['||f_05_14||','||f_05_perc15||'],['||f_06_14||','||f_06_perc15||'],['||f_07_14||','||f_07_perc15||'],['||f_08_14||','||f_08_perc15||'],['||f_09_14||','||f_09_perc15||'],['||f_10_14||','||f_10_perc15||'],['||f_11_14||','||f_11_perc15||'],['||f_12_14||','||f_12_perc15||'],['||f_13_14||','||f_13_perc15||'],['||f_14_14||','||f_14_perc15||'],['||f_15_14||','||f_15_perc15||'],['||f_16_14||','||f_16_perc15||'],['||f_17_14||','||m_17_perc15||'],['||f_18_14||','||f_18_perc15||']],';OUTPUT;
VAR1 = '[['||f_01_15||','||f_01_perc16||'],['||f_02_15||','||f_02_perc16||'],['||f_03_15||','||f_03_perc16||'],['||f_04_15||','||f_04_perc16||'],['||f_05_15||','||f_05_perc16||'],['||f_06_15||','||f_06_perc16||'],['||f_07_15||','||f_07_perc16||'],['||f_08_15||','||f_08_perc16||'],['||f_09_15||','||f_09_perc16||'],['||f_10_15||','||f_10_perc16||'],['||f_11_15||','||f_11_perc16||'],['||f_12_15||','||f_12_perc16||'],['||f_13_15||','||f_13_perc16||'],['||f_14_15||','||f_14_perc16||'],['||f_15_15||','||f_15_perc16||'],['||f_16_15||','||f_16_perc16||'],['||f_17_15||','||m_17_perc16||'],['||f_18_15||','||f_18_perc16||']],';OUTPUT;
VAR1 = '[['||f_01_16||','||f_01_perc17||'],['||f_02_16||','||f_02_perc17||'],['||f_03_16||','||f_03_perc17||'],['||f_04_16||','||f_04_perc17||'],['||f_05_16||','||f_05_perc17||'],['||f_06_16||','||f_06_perc17||'],['||f_07_16||','||f_07_perc17||'],['||f_08_16||','||f_08_perc17||'],['||f_09_16||','||f_09_perc17||'],['||f_10_16||','||f_10_perc17||'],['||f_11_16||','||f_11_perc17||'],['||f_12_16||','||f_12_perc17||'],['||f_13_16||','||f_13_perc17||'],['||f_14_16||','||f_14_perc17||'],['||f_15_16||','||f_15_perc17||'],['||f_16_16||','||f_16_perc17||'],['||f_17_16||','||m_17_perc17||'],['||f_18_16||','||f_18_perc17||']],';OUTPUT;
VAR1 = '[['||f_01_17||','||f_01_perc18||'],['||f_02_17||','||f_02_perc18||'],['||f_03_17||','||f_03_perc18||'],['||f_04_17||','||f_04_perc18||'],['||f_05_17||','||f_05_perc18||'],['||f_06_17||','||f_06_perc18||'],['||f_07_17||','||f_07_perc18||'],['||f_08_17||','||f_08_perc18||'],['||f_09_17||','||f_09_perc18||'],['||f_10_17||','||f_10_perc18||'],['||f_11_17||','||f_11_perc18||'],['||f_12_17||','||f_12_perc18||'],['||f_13_17||','||f_13_perc18||'],['||f_14_17||','||f_14_perc18||'],['||f_15_17||','||f_15_perc18||'],['||f_16_17||','||f_16_perc18||'],['||f_17_17||','||m_17_perc18||'],['||f_18_17||','||f_18_perc18||']],';OUTPUT;
VAR1 = '[['||f_01_18||','||f_01_perc19||'],['||f_02_18||','||f_02_perc19||'],['||f_03_18||','||f_03_perc19||'],['||f_04_18||','||f_04_perc19||'],['||f_05_18||','||f_05_perc19||'],['||f_06_18||','||f_06_perc19||'],['||f_07_18||','||f_07_perc19||'],['||f_08_18||','||f_08_perc19||'],['||f_09_18||','||f_09_perc19||'],['||f_10_18||','||f_10_perc19||'],['||f_11_18||','||f_11_perc19||'],['||f_12_18||','||f_12_perc19||'],['||f_13_18||','||f_13_perc19||'],['||f_14_18||','||f_14_perc19||'],['||f_15_18||','||f_15_perc19||'],['||f_16_18||','||f_16_perc19||'],['||f_17_18||','||m_17_perc19||'],['||f_18_18||','||f_18_perc19||']],';OUTPUT;
VAR1 = '[['||f_01_19||','||f_01_perc20||'],['||f_02_19||','||f_02_perc20||'],['||f_03_19||','||f_03_perc20||'],['||f_04_19||','||f_04_perc20||'],['||f_05_19||','||f_05_perc20||'],['||f_06_19||','||f_06_perc20||'],['||f_07_19||','||f_07_perc20||'],['||f_08_19||','||f_08_perc20||'],['||f_09_19||','||f_09_perc20||'],['||f_10_19||','||f_10_perc20||'],['||f_11_19||','||f_11_perc20||'],['||f_12_19||','||f_12_perc20||'],['||f_13_19||','||f_13_perc20||'],['||f_14_19||','||f_14_perc20||'],['||f_15_19||','||f_15_perc20||'],['||f_16_19||','||f_16_perc20||'],['||f_17_19||','||m_17_perc20||'],['||f_18_19||','||f_18_perc20||']],';OUTPUT;
VAR1 = '[['||f_01_20||','||f_01_perc21||'],['||f_02_20||','||f_02_perc21||'],['||f_03_20||','||f_03_perc21||'],['||f_04_20||','||f_04_perc21||'],['||f_05_20||','||f_05_perc21||'],['||f_06_20||','||f_06_perc21||'],['||f_07_20||','||f_07_perc21||'],['||f_08_20||','||f_08_perc21||'],['||f_09_20||','||f_09_perc21||'],['||f_10_20||','||f_10_perc21||'],['||f_11_20||','||f_11_perc21||'],['||f_12_20||','||f_12_perc21||'],['||f_13_20||','||f_13_perc21||'],['||f_14_20||','||f_14_perc21||'],['||f_15_20||','||f_15_perc21||'],['||f_16_20||','||f_16_perc21||'],['||f_17_20||','||m_17_perc21||'],['||f_18_20||','||f_18_perc21||']],';OUTPUT;
VAR1 = '[['||f_01_21||','||f_01_perc22||'],['||f_02_21||','||f_02_perc22||'],['||f_03_21||','||f_03_perc22||'],['||f_04_21||','||f_04_perc22||'],['||f_05_21||','||f_05_perc22||'],['||f_06_21||','||f_06_perc22||'],['||f_07_21||','||f_07_perc22||'],['||f_08_21||','||f_08_perc22||'],['||f_09_21||','||f_09_perc22||'],['||f_10_21||','||f_10_perc22||'],['||f_11_21||','||f_11_perc22||'],['||f_12_21||','||f_12_perc22||'],['||f_13_21||','||f_13_perc22||'],['||f_14_21||','||f_14_perc22||'],['||f_15_21||','||f_15_perc22||'],['||f_16_21||','||f_16_perc22||'],['||f_17_21||','||m_17_perc22||'],['||f_18_21||','||f_18_perc22||']],';OUTPUT;
VAR1 = '[['||f_01_22||','||f_01_perc23||'],['||f_02_22||','||f_02_perc23||'],['||f_03_22||','||f_03_perc23||'],['||f_04_22||','||f_04_perc23||'],['||f_05_22||','||f_05_perc23||'],['||f_06_22||','||f_06_perc23||'],['||f_07_22||','||f_07_perc23||'],['||f_08_22||','||f_08_perc23||'],['||f_09_22||','||f_09_perc23||'],['||f_10_22||','||f_10_perc23||'],['||f_11_22||','||f_11_perc23||'],['||f_12_22||','||f_12_perc23||'],['||f_13_22||','||f_13_perc23||'],['||f_14_22||','||f_14_perc23||'],['||f_15_22||','||f_15_perc23||'],['||f_16_22||','||f_16_perc23||'],['||f_17_22||','||m_17_perc23||'],['||f_18_22||','||f_18_perc23||']],';OUTPUT;
VAR1 = '[['||f_01_23||','||f_01_perc24||'],['||f_02_23||','||f_02_perc24||'],['||f_03_23||','||f_03_perc24||'],['||f_04_23||','||f_04_perc24||'],['||f_05_23||','||f_05_perc24||'],['||f_06_23||','||f_06_perc24||'],['||f_07_23||','||f_07_perc24||'],['||f_08_23||','||f_08_perc24||'],['||f_09_23||','||f_09_perc24||'],['||f_10_23||','||f_10_perc24||'],['||f_11_23||','||f_11_perc24||'],['||f_12_23||','||f_12_perc24||'],['||f_13_23||','||f_13_perc24||'],['||f_14_23||','||f_14_perc24||'],['||f_15_23||','||f_15_perc24||'],['||f_16_23||','||f_16_perc24||'],['||f_17_23||','||m_17_perc24||'],['||f_18_23||','||f_18_perc24||']],';OUTPUT;
VAR1 = '[['||f_01_24||','||f_01_perc25||'],['||f_02_24||','||f_02_perc25||'],['||f_03_24||','||f_03_perc25||'],['||f_04_24||','||f_04_perc25||'],['||f_05_24||','||f_05_perc25||'],['||f_06_24||','||f_06_perc25||'],['||f_07_24||','||f_07_perc25||'],['||f_08_24||','||f_08_perc25||'],['||f_09_24||','||f_09_perc25||'],['||f_10_24||','||f_10_perc25||'],['||f_11_24||','||f_11_perc25||'],['||f_12_24||','||f_12_perc25||'],['||f_13_24||','||f_13_perc25||'],['||f_14_24||','||f_14_perc25||'],['||f_15_24||','||f_15_perc25||'],['||f_16_24||','||f_16_perc25||'],['||f_17_24||','||m_17_perc25||'],['||f_18_24||','||f_18_perc25||']],';OUTPUT;
VAR1 = '[['||f_01_25||','||f_01_perc26||'],['||f_02_25||','||f_02_perc26||'],['||f_03_25||','||f_03_perc26||'],['||f_04_25||','||f_04_perc26||'],['||f_05_25||','||f_05_perc26||'],['||f_06_25||','||f_06_perc26||'],['||f_07_25||','||f_07_perc26||'],['||f_08_25||','||f_08_perc26||'],['||f_09_25||','||f_09_perc26||'],['||f_10_25||','||f_10_perc26||'],['||f_11_25||','||f_11_perc26||'],['||f_12_25||','||f_12_perc26||'],['||f_13_25||','||f_13_perc26||'],['||f_14_25||','||f_14_perc26||'],['||f_15_25||','||f_15_perc26||'],['||f_16_25||','||f_16_perc26||'],['||f_17_25||','||m_17_perc26||'],['||f_18_25||','||f_18_perc26||']],';OUTPUT;
VAR1 = '[['||f_01_26||','||f_01_perc27||'],['||f_02_26||','||f_02_perc27||'],['||f_03_26||','||f_03_perc27||'],['||f_04_26||','||f_04_perc27||'],['||f_05_26||','||f_05_perc27||'],['||f_06_26||','||f_06_perc27||'],['||f_07_26||','||f_07_perc27||'],['||f_08_26||','||f_08_perc27||'],['||f_09_26||','||f_09_perc27||'],['||f_10_26||','||f_10_perc27||'],['||f_11_26||','||f_11_perc27||'],['||f_12_26||','||f_12_perc27||'],['||f_13_26||','||f_13_perc27||'],['||f_14_26||','||f_14_perc27||'],['||f_15_26||','||f_15_perc27||'],['||f_16_26||','||f_16_perc27||'],['||f_17_26||','||m_17_perc27||'],['||f_18_26||','||f_18_perc27||']],';OUTPUT;
VAR1 = '[['||f_01_27||','||f_01_perc28||'],['||f_02_27||','||f_02_perc28||'],['||f_03_27||','||f_03_perc28||'],['||f_04_27||','||f_04_perc28||'],['||f_05_27||','||f_05_perc28||'],['||f_06_27||','||f_06_perc28||'],['||f_07_27||','||f_07_perc28||'],['||f_08_27||','||f_08_perc28||'],['||f_09_27||','||f_09_perc28||'],['||f_10_27||','||f_10_perc28||'],['||f_11_27||','||f_11_perc28||'],['||f_12_27||','||f_12_perc28||'],['||f_13_27||','||f_13_perc28||'],['||f_14_27||','||f_14_perc28||'],['||f_15_27||','||f_15_perc28||'],['||f_16_27||','||f_16_perc28||'],['||f_17_27||','||m_17_perc28||'],['||f_18_27||','||f_18_perc28||']],';OUTPUT;
VAR1 = '[['||f_01_28||','||f_01_perc29||'],['||f_02_28||','||f_02_perc29||'],['||f_03_28||','||f_03_perc29||'],['||f_04_28||','||f_04_perc29||'],['||f_05_28||','||f_05_perc29||'],['||f_06_28||','||f_06_perc29||'],['||f_07_28||','||f_07_perc29||'],['||f_08_28||','||f_08_perc29||'],['||f_09_28||','||f_09_perc29||'],['||f_10_28||','||f_10_perc29||'],['||f_11_28||','||f_11_perc29||'],['||f_12_28||','||f_12_perc29||'],['||f_13_28||','||f_13_perc29||'],['||f_14_28||','||f_14_perc29||'],['||f_15_28||','||f_15_perc29||'],['||f_16_28||','||f_16_perc29||'],['||f_17_28||','||m_17_perc29||'],['||f_18_28||','||f_18_perc29||']],';OUTPUT;
VAR1 = '[['||f_01_29||','||f_01_perc30||'],['||f_02_29||','||f_02_perc30||'],['||f_03_29||','||f_03_perc30||'],['||f_04_29||','||f_04_perc30||'],['||f_05_29||','||f_05_perc30||'],['||f_06_29||','||f_06_perc30||'],['||f_07_29||','||f_07_perc30||'],['||f_08_29||','||f_08_perc30||'],['||f_09_29||','||f_09_perc30||'],['||f_10_29||','||f_10_perc30||'],['||f_11_29||','||f_11_perc30||'],['||f_12_29||','||f_12_perc30||'],['||f_13_29||','||f_13_perc30||'],['||f_14_29||','||f_14_perc30||'],['||f_15_29||','||f_15_perc30||'],['||f_16_29||','||f_16_perc30||'],['||f_17_29||','||m_17_perc30||'],['||f_18_29||','||f_18_perc30||']],';OUTPUT;
VAR1 = '[['||f_01_30||','||f_01_perc31||'],['||f_02_30||','||f_02_perc31||'],['||f_03_30||','||f_03_perc31||'],['||f_04_30||','||f_04_perc31||'],['||f_05_30||','||f_05_perc31||'],['||f_06_30||','||f_06_perc31||'],['||f_07_30||','||f_07_perc31||'],['||f_08_30||','||f_08_perc31||'],['||f_09_30||','||f_09_perc31||'],['||f_10_30||','||f_10_perc31||'],['||f_11_30||','||f_11_perc31||'],['||f_12_30||','||f_12_perc31||'],['||f_13_30||','||f_13_perc31||'],['||f_14_30||','||f_14_perc31||'],['||f_15_30||','||f_15_perc31||'],['||f_16_30||','||f_16_perc31||'],['||f_17_30||','||m_17_perc31||'],['||f_18_30||','||f_18_perc31||']],';OUTPUT;
VAR1 = '[['||f_01_31||','||f_01_perc32||'],['||f_02_31||','||f_02_perc32||'],['||f_03_31||','||f_03_perc32||'],['||f_04_31||','||f_04_perc32||'],['||f_05_31||','||f_05_perc32||'],['||f_06_31||','||f_06_perc32||'],['||f_07_31||','||f_07_perc32||'],['||f_08_31||','||f_08_perc32||'],['||f_09_31||','||f_09_perc32||'],['||f_10_31||','||f_10_perc32||'],['||f_11_31||','||f_11_perc32||'],['||f_12_31||','||f_12_perc32||'],['||f_13_31||','||f_13_perc32||'],['||f_14_31||','||f_14_perc32||'],['||f_15_31||','||f_15_perc32||'],['||f_16_31||','||f_16_perc32||'],['||f_17_31||','||m_17_perc32||'],['||f_18_31||','||f_18_perc32||']],';OUTPUT;
VAR1 = '[['||f_01_32||','||f_01_perc33||'],['||f_02_32||','||f_02_perc33||'],['||f_03_32||','||f_03_perc33||'],['||f_04_32||','||f_04_perc33||'],['||f_05_32||','||f_05_perc33||'],['||f_06_32||','||f_06_perc33||'],['||f_07_32||','||f_07_perc33||'],['||f_08_32||','||f_08_perc33||'],['||f_09_32||','||f_09_perc33||'],['||f_10_32||','||f_10_perc33||'],['||f_11_32||','||f_11_perc33||'],['||f_12_32||','||f_12_perc33||'],['||f_13_32||','||f_13_perc33||'],['||f_14_32||','||f_14_perc33||'],['||f_15_32||','||f_15_perc33||'],['||f_16_32||','||f_16_perc33||'],['||f_17_32||','||m_17_perc33||'],['||f_18_32||','||f_18_perc33||']],';OUTPUT;
VAR1 = '[['||f_01_33||','||f_01_perc34||'],['||f_02_33||','||f_02_perc34||'],['||f_03_33||','||f_03_perc34||'],['||f_04_33||','||f_04_perc34||'],['||f_05_33||','||f_05_perc34||'],['||f_06_33||','||f_06_perc34||'],['||f_07_33||','||f_07_perc34||'],['||f_08_33||','||f_08_perc34||'],['||f_09_33||','||f_09_perc34||'],['||f_10_33||','||f_10_perc34||'],['||f_11_33||','||f_11_perc34||'],['||f_12_33||','||f_12_perc34||'],['||f_13_33||','||f_13_perc34||'],['||f_14_33||','||f_14_perc34||'],['||f_15_33||','||f_15_perc34||'],['||f_16_33||','||f_16_perc34||'],['||f_17_33||','||m_17_perc34||'],['||f_18_33||','||f_18_perc34||']],';OUTPUT;
VAR1 = '[['||f_01_34||','||f_01_perc35||'],['||f_02_34||','||f_02_perc35||'],['||f_03_34||','||f_03_perc35||'],['||f_04_34||','||f_04_perc35||'],['||f_05_34||','||f_05_perc35||'],['||f_06_34||','||f_06_perc35||'],['||f_07_34||','||f_07_perc35||'],['||f_08_34||','||f_08_perc35||'],['||f_09_34||','||f_09_perc35||'],['||f_10_34||','||f_10_perc35||'],['||f_11_34||','||f_11_perc35||'],['||f_12_34||','||f_12_perc35||'],['||f_13_34||','||f_13_perc35||'],['||f_14_34||','||f_14_perc35||'],['||f_15_34||','||f_15_perc35||'],['||f_16_34||','||f_16_perc35||'],['||f_17_34||','||m_17_perc35||'],['||f_18_34||','||f_18_perc35||']],';OUTPUT;
VAR1 = '[['||f_01_35||','||f_01_perc36||'],['||f_02_35||','||f_02_perc36||'],['||f_03_35||','||f_03_perc36||'],['||f_04_35||','||f_04_perc36||'],['||f_05_35||','||f_05_perc36||'],['||f_06_35||','||f_06_perc36||'],['||f_07_35||','||f_07_perc36||'],['||f_08_35||','||f_08_perc36||'],['||f_09_35||','||f_09_perc36||'],['||f_10_35||','||f_10_perc36||'],['||f_11_35||','||f_11_perc36||'],['||f_12_35||','||f_12_perc36||'],['||f_13_35||','||f_13_perc36||'],['||f_14_35||','||f_14_perc36||'],['||f_15_35||','||f_15_perc36||'],['||f_16_35||','||f_16_perc36||'],['||f_17_35||','||m_17_perc36||'],['||f_18_35||','||f_18_perc36||']],';OUTPUT;
VAR1 = '[['||f_01_36||','||f_01_perc37||'],['||f_02_36||','||f_02_perc37||'],['||f_03_36||','||f_03_perc37||'],['||f_04_36||','||f_04_perc37||'],['||f_05_36||','||f_05_perc37||'],['||f_06_36||','||f_06_perc37||'],['||f_07_36||','||f_07_perc37||'],['||f_08_36||','||f_08_perc37||'],['||f_09_36||','||f_09_perc37||'],['||f_10_36||','||f_10_perc37||'],['||f_11_36||','||f_11_perc37||'],['||f_12_36||','||f_12_perc37||'],['||f_13_36||','||f_13_perc37||'],['||f_14_36||','||f_14_perc37||'],['||f_15_36||','||f_15_perc37||'],['||f_16_36||','||f_16_perc37||'],['||f_17_36||','||m_17_perc37||'],['||f_18_36||','||f_18_perc37||']],';OUTPUT;
VAR1 = '[['||f_01_37||','||f_01_perc38||'],['||f_02_37||','||f_02_perc38||'],['||f_03_37||','||f_03_perc38||'],['||f_04_37||','||f_04_perc38||'],['||f_05_37||','||f_05_perc38||'],['||f_06_37||','||f_06_perc38||'],['||f_07_37||','||f_07_perc38||'],['||f_08_37||','||f_08_perc38||'],['||f_09_37||','||f_09_perc38||'],['||f_10_37||','||f_10_perc38||'],['||f_11_37||','||f_11_perc38||'],['||f_12_37||','||f_12_perc38||'],['||f_13_37||','||f_13_perc38||'],['||f_14_37||','||f_14_perc38||'],['||f_15_37||','||f_15_perc38||'],['||f_16_37||','||f_16_perc38||'],['||f_17_37||','||m_17_perc38||'],['||f_18_37||','||f_18_perc38||']],';OUTPUT;
VAR1 = '[['||f_01_38||','||f_01_perc39||'],['||f_02_38||','||f_02_perc39||'],['||f_03_38||','||f_03_perc39||'],['||f_04_38||','||f_04_perc39||'],['||f_05_38||','||f_05_perc39||'],['||f_06_38||','||f_06_perc39||'],['||f_07_38||','||f_07_perc39||'],['||f_08_38||','||f_08_perc39||'],['||f_09_38||','||f_09_perc39||'],['||f_10_38||','||f_10_perc39||'],['||f_11_38||','||f_11_perc39||'],['||f_12_38||','||f_12_perc39||'],['||f_13_38||','||f_13_perc39||'],['||f_14_38||','||f_14_perc39||'],['||f_15_38||','||f_15_perc39||'],['||f_16_38||','||f_16_perc39||'],['||f_17_38||','||m_17_perc39||'],['||f_18_38||','||f_18_perc39||']],';OUTPUT;
VAR1 = '[['||f_01_39||','||f_01_perc40||'],['||f_02_39||','||f_02_perc40||'],['||f_03_39||','||f_03_perc40||'],['||f_04_39||','||f_04_perc40||'],['||f_05_39||','||f_05_perc40||'],['||f_06_39||','||f_06_perc40||'],['||f_07_39||','||f_07_perc40||'],['||f_08_39||','||f_08_perc40||'],['||f_09_39||','||f_09_perc40||'],['||f_10_39||','||f_10_perc40||'],['||f_11_39||','||f_11_perc40||'],['||f_12_39||','||f_12_perc40||'],['||f_13_39||','||f_13_perc40||'],['||f_14_39||','||f_14_perc40||'],['||f_15_39||','||f_15_perc40||'],['||f_16_39||','||f_16_perc40||'],['||f_17_39||','||m_17_perc40||'],['||f_18_39||','||f_18_perc40||']],';OUTPUT;
VAR1 = '[['||f_01_40||','||f_01_perc41||'],['||f_02_40||','||f_02_perc41||'],['||f_03_40||','||f_03_perc41||'],['||f_04_40||','||f_04_perc41||'],['||f_05_40||','||f_05_perc41||'],['||f_06_40||','||f_06_perc41||'],['||f_07_40||','||f_07_perc41||'],['||f_08_40||','||f_08_perc41||'],['||f_09_40||','||f_09_perc41||'],['||f_10_40||','||f_10_perc41||'],['||f_11_40||','||f_11_perc41||'],['||f_12_40||','||f_12_perc41||'],['||f_13_40||','||f_13_perc41||'],['||f_14_40||','||f_14_perc41||'],['||f_15_40||','||f_15_perc41||'],['||f_16_40||','||f_16_perc41||'],['||f_17_40||','||m_17_perc41||'],['||f_18_40||','||f_18_perc41||']],';OUTPUT;
VAR1 = '[['||f_01_41||','||f_01_perc42||'],['||f_02_41||','||f_02_perc42||'],['||f_03_41||','||f_03_perc42||'],['||f_04_41||','||f_04_perc42||'],['||f_05_41||','||f_05_perc42||'],['||f_06_41||','||f_06_perc42||'],['||f_07_41||','||f_07_perc42||'],['||f_08_41||','||f_08_perc42||'],['||f_09_41||','||f_09_perc42||'],['||f_10_41||','||f_10_perc42||'],['||f_11_41||','||f_11_perc42||'],['||f_12_41||','||f_12_perc42||'],['||f_13_41||','||f_13_perc42||'],['||f_14_41||','||f_14_perc42||'],['||f_15_41||','||f_15_perc42||'],['||f_16_41||','||f_16_perc42||'],['||f_17_41||','||m_17_perc42||'],['||f_18_41||','||f_18_perc42||']],';OUTPUT;
VAR1 = '[['||f_01_42||','||f_01_perc43||'],['||f_02_42||','||f_02_perc43||'],['||f_03_42||','||f_03_perc43||'],['||f_04_42||','||f_04_perc43||'],['||f_05_42||','||f_05_perc43||'],['||f_06_42||','||f_06_perc43||'],['||f_07_42||','||f_07_perc43||'],['||f_08_42||','||f_08_perc43||'],['||f_09_42||','||f_09_perc43||'],['||f_10_42||','||f_10_perc43||'],['||f_11_42||','||f_11_perc43||'],['||f_12_42||','||f_12_perc43||'],['||f_13_42||','||f_13_perc43||'],['||f_14_42||','||f_14_perc43||'],['||f_15_42||','||f_15_perc43||'],['||f_16_42||','||f_16_perc43||'],['||f_17_42||','||m_17_perc43||'],['||f_18_42||','||f_18_perc43||']],';OUTPUT;
VAR1 = '[['||f_01_43||','||f_01_perc44||'],['||f_02_43||','||f_02_perc44||'],['||f_03_43||','||f_03_perc44||'],['||f_04_43||','||f_04_perc44||'],['||f_05_43||','||f_05_perc44||'],['||f_06_43||','||f_06_perc44||'],['||f_07_43||','||f_07_perc44||'],['||f_08_43||','||f_08_perc44||'],['||f_09_43||','||f_09_perc44||'],['||f_10_43||','||f_10_perc44||'],['||f_11_43||','||f_11_perc44||'],['||f_12_43||','||f_12_perc44||'],['||f_13_43||','||f_13_perc44||'],['||f_14_43||','||f_14_perc44||'],['||f_15_43||','||f_15_perc44||'],['||f_16_43||','||f_16_perc44||'],['||f_17_43||','||m_17_perc44||'],['||f_18_43||','||f_18_perc44||']],';OUTPUT;
VAR1 = '[['||f_01_44||','||f_01_perc45||'],['||f_02_44||','||f_02_perc45||'],['||f_03_44||','||f_03_perc45||'],['||f_04_44||','||f_04_perc45||'],['||f_05_44||','||f_05_perc45||'],['||f_06_44||','||f_06_perc45||'],['||f_07_44||','||f_07_perc45||'],['||f_08_44||','||f_08_perc45||'],['||f_09_44||','||f_09_perc45||'],['||f_10_44||','||f_10_perc45||'],['||f_11_44||','||f_11_perc45||'],['||f_12_44||','||f_12_perc45||'],['||f_13_44||','||f_13_perc45||'],['||f_14_44||','||f_14_perc45||'],['||f_15_44||','||f_15_perc45||'],['||f_16_44||','||f_16_perc45||'],['||f_17_44||','||m_17_perc45||'],['||f_18_44||','||f_18_perc45||']],';OUTPUT;
VAR1 = '[['||f_01_45||','||f_01_perc46||'],['||f_02_45||','||f_02_perc46||'],['||f_03_45||','||f_03_perc46||'],['||f_04_45||','||f_04_perc46||'],['||f_05_45||','||f_05_perc46||'],['||f_06_45||','||f_06_perc46||'],['||f_07_45||','||f_07_perc46||'],['||f_08_45||','||f_08_perc46||'],['||f_09_45||','||f_09_perc46||'],['||f_10_45||','||f_10_perc46||'],['||f_11_45||','||f_11_perc46||'],['||f_12_45||','||f_12_perc46||'],['||f_13_45||','||f_13_perc46||'],['||f_14_45||','||f_14_perc46||'],['||f_15_45||','||f_15_perc46||'],['||f_16_45||','||f_16_perc46||'],['||f_17_45||','||m_17_perc46||'],['||f_18_45||','||f_18_perc46||']],';OUTPUT;
VAR1 = '[['||f_01_46||','||f_01_perc47||'],['||f_02_46||','||f_02_perc47||'],['||f_03_46||','||f_03_perc47||'],['||f_04_46||','||f_04_perc47||'],['||f_05_46||','||f_05_perc47||'],['||f_06_46||','||f_06_perc47||'],['||f_07_46||','||f_07_perc47||'],['||f_08_46||','||f_08_perc47||'],['||f_09_46||','||f_09_perc47||'],['||f_10_46||','||f_10_perc47||'],['||f_11_46||','||f_11_perc47||'],['||f_12_46||','||f_12_perc47||'],['||f_13_46||','||f_13_perc47||'],['||f_14_46||','||f_14_perc47||'],['||f_15_46||','||f_15_perc47||'],['||f_16_46||','||f_16_perc47||'],['||f_17_46||','||m_17_perc47||'],['||f_18_46||','||f_18_perc47||']],';OUTPUT;
VAR1 = '[['||f_01_47||','||f_01_perc48||'],['||f_02_47||','||f_02_perc48||'],['||f_03_47||','||f_03_perc48||'],['||f_04_47||','||f_04_perc48||'],['||f_05_47||','||f_05_perc48||'],['||f_06_47||','||f_06_perc48||'],['||f_07_47||','||f_07_perc48||'],['||f_08_47||','||f_08_perc48||'],['||f_09_47||','||f_09_perc48||'],['||f_10_47||','||f_10_perc48||'],['||f_11_47||','||f_11_perc48||'],['||f_12_47||','||f_12_perc48||'],['||f_13_47||','||f_13_perc48||'],['||f_14_47||','||f_14_perc48||'],['||f_15_47||','||f_15_perc48||'],['||f_16_47||','||f_16_perc48||'],['||f_17_47||','||m_17_perc48||'],['||f_18_47||','||f_18_perc48||']],';OUTPUT;
VAR1 = '[['||f_01_48||','||f_01_perc49||'],['||f_02_48||','||f_02_perc49||'],['||f_03_48||','||f_03_perc49||'],['||f_04_48||','||f_04_perc49||'],['||f_05_48||','||f_05_perc49||'],['||f_06_48||','||f_06_perc49||'],['||f_07_48||','||f_07_perc49||'],['||f_08_48||','||f_08_perc49||'],['||f_09_48||','||f_09_perc49||'],['||f_10_48||','||f_10_perc49||'],['||f_11_48||','||f_11_perc49||'],['||f_12_48||','||f_12_perc49||'],['||f_13_48||','||f_13_perc49||'],['||f_14_48||','||f_14_perc49||'],['||f_15_48||','||f_15_perc49||'],['||f_16_48||','||f_16_perc49||'],['||f_17_48||','||m_17_perc49||'],['||f_18_48||','||f_18_perc49||']],';OUTPUT;
VAR1 = '[['||f_01_49||','||f_01_perc50||'],['||f_02_49||','||f_02_perc50||'],['||f_03_49||','||f_03_perc50||'],['||f_04_49||','||f_04_perc50||'],['||f_05_49||','||f_05_perc50||'],['||f_06_49||','||f_06_perc50||'],['||f_07_49||','||f_07_perc50||'],['||f_08_49||','||f_08_perc50||'],['||f_09_49||','||f_09_perc50||'],['||f_10_49||','||f_10_perc50||'],['||f_11_49||','||f_11_perc50||'],['||f_12_49||','||f_12_perc50||'],['||f_13_49||','||f_13_perc50||'],['||f_14_49||','||f_14_perc50||'],['||f_15_49||','||f_15_perc50||'],['||f_16_49||','||f_16_perc50||'],['||f_17_49||','||m_17_perc50||'],['||f_18_49||','||f_18_perc50||']],';OUTPUT;
VAR1 = '[['||f_01_50||','||f_01_perc51||'],['||f_02_50||','||f_02_perc51||'],['||f_03_50||','||f_03_perc51||'],['||f_04_50||','||f_04_perc51||'],['||f_05_50||','||f_05_perc51||'],['||f_06_50||','||f_06_perc51||'],['||f_07_50||','||f_07_perc51||'],['||f_08_50||','||f_08_perc51||'],['||f_09_50||','||f_09_perc51||'],['||f_10_50||','||f_10_perc51||'],['||f_11_50||','||f_11_perc51||'],['||f_12_50||','||f_12_perc51||'],['||f_13_50||','||f_13_perc51||'],['||f_14_50||','||f_14_perc51||'],['||f_15_50||','||f_15_perc51||'],['||f_16_50||','||f_16_perc51||'],['||f_17_50||','||m_17_perc51||'],['||f_18_50||','||f_18_perc51||']],';OUTPUT;
VAR1 = '[['||f_01_51||','||f_01_perc52||'],['||f_02_51||','||f_02_perc52||'],['||f_03_51||','||f_03_perc52||'],['||f_04_51||','||f_04_perc52||'],['||f_05_51||','||f_05_perc52||'],['||f_06_51||','||f_06_perc52||'],['||f_07_51||','||f_07_perc52||'],['||f_08_51||','||f_08_perc52||'],['||f_09_51||','||f_09_perc52||'],['||f_10_51||','||f_10_perc52||'],['||f_11_51||','||f_11_perc52||'],['||f_12_51||','||f_12_perc52||'],['||f_13_51||','||f_13_perc52||'],['||f_14_51||','||f_14_perc52||'],['||f_15_51||','||f_15_perc52||'],['||f_16_51||','||f_16_perc52||'],['||f_17_51||','||m_17_perc52||'],['||f_18_51||','||f_18_perc52||']],';OUTPUT;
VAR1 = '[['||f_01_52||','||f_01_perc53||'],['||f_02_52||','||f_02_perc53||'],['||f_03_52||','||f_03_perc53||'],['||f_04_52||','||f_04_perc53||'],['||f_05_52||','||f_05_perc53||'],['||f_06_52||','||f_06_perc53||'],['||f_07_52||','||f_07_perc53||'],['||f_08_52||','||f_08_perc53||'],['||f_09_52||','||f_09_perc53||'],['||f_10_52||','||f_10_perc53||'],['||f_11_52||','||f_11_perc53||'],['||f_12_52||','||f_12_perc53||'],['||f_13_52||','||f_13_perc53||'],['||f_14_52||','||f_14_perc53||'],['||f_15_52||','||f_15_perc53||'],['||f_16_52||','||f_16_perc53||'],['||f_17_52||','||m_17_perc53||'],['||f_18_52||','||f_18_perc53||']],';OUTPUT;
VAR1 = '[['||f_01_53||','||f_01_perc54||'],['||f_02_53||','||f_02_perc54||'],['||f_03_53||','||f_03_perc54||'],['||f_04_53||','||f_04_perc54||'],['||f_05_53||','||f_05_perc54||'],['||f_06_53||','||f_06_perc54||'],['||f_07_53||','||f_07_perc54||'],['||f_08_53||','||f_08_perc54||'],['||f_09_53||','||f_09_perc54||'],['||f_10_53||','||f_10_perc54||'],['||f_11_53||','||f_11_perc54||'],['||f_12_53||','||f_12_perc54||'],['||f_13_53||','||f_13_perc54||'],['||f_14_53||','||f_14_perc54||'],['||f_15_53||','||f_15_perc54||'],['||f_16_53||','||f_16_perc54||'],['||f_17_53||','||m_17_perc54||'],['||f_18_53||','||f_18_perc54||']],';OUTPUT;
VAR1 = '[['||f_01_54||','||f_01_perc55||'],['||f_02_54||','||f_02_perc55||'],['||f_03_54||','||f_03_perc55||'],['||f_04_54||','||f_04_perc55||'],['||f_05_54||','||f_05_perc55||'],['||f_06_54||','||f_06_perc55||'],['||f_07_54||','||f_07_perc55||'],['||f_08_54||','||f_08_perc55||'],['||f_09_54||','||f_09_perc55||'],['||f_10_54||','||f_10_perc55||'],['||f_11_54||','||f_11_perc55||'],['||f_12_54||','||f_12_perc55||'],['||f_13_54||','||f_13_perc55||'],['||f_14_54||','||f_14_perc55||'],['||f_15_54||','||f_15_perc55||'],['||f_16_54||','||f_16_perc55||'],['||f_17_54||','||m_17_perc55||'],['||f_18_54||','||f_18_perc55||']],';OUTPUT;
VAR1 = '[['||f_01_55||','||f_01_perc56||'],['||f_02_55||','||f_02_perc56||'],['||f_03_55||','||f_03_perc56||'],['||f_04_55||','||f_04_perc56||'],['||f_05_55||','||f_05_perc56||'],['||f_06_55||','||f_06_perc56||'],['||f_07_55||','||f_07_perc56||'],['||f_08_55||','||f_08_perc56||'],['||f_09_55||','||f_09_perc56||'],['||f_10_55||','||f_10_perc56||'],['||f_11_55||','||f_11_perc56||'],['||f_12_55||','||f_12_perc56||'],['||f_13_55||','||f_13_perc56||'],['||f_14_55||','||f_14_perc56||'],['||f_15_55||','||f_15_perc56||'],['||f_16_55||','||f_16_perc56||'],['||f_17_55||','||m_17_perc56||'],['||f_18_55||','||f_18_perc56||']],';OUTPUT;
VAR1 = '[['||f_01_56||','||f_01_perc57||'],['||f_02_56||','||f_02_perc57||'],['||f_03_56||','||f_03_perc57||'],['||f_04_56||','||f_04_perc57||'],['||f_05_56||','||f_05_perc57||'],['||f_06_56||','||f_06_perc57||'],['||f_07_56||','||f_07_perc57||'],['||f_08_56||','||f_08_perc57||'],['||f_09_56||','||f_09_perc57||'],['||f_10_56||','||f_10_perc57||'],['||f_11_56||','||f_11_perc57||'],['||f_12_56||','||f_12_perc57||'],['||f_13_56||','||f_13_perc57||'],['||f_14_56||','||f_14_perc57||'],['||f_15_56||','||f_15_perc57||'],['||f_16_56||','||f_16_perc57||'],['||f_17_56||','||m_17_perc57||'],['||f_18_56||','||f_18_perc57||']],';OUTPUT;
VAR1 = '[['||f_01_57||','||f_01_perc58||'],['||f_02_57||','||f_02_perc58||'],['||f_03_57||','||f_03_perc58||'],['||f_04_57||','||f_04_perc58||'],['||f_05_57||','||f_05_perc58||'],['||f_06_57||','||f_06_perc58||'],['||f_07_57||','||f_07_perc58||'],['||f_08_57||','||f_08_perc58||'],['||f_09_57||','||f_09_perc58||'],['||f_10_57||','||f_10_perc58||'],['||f_11_57||','||f_11_perc58||'],['||f_12_57||','||f_12_perc58||'],['||f_13_57||','||f_13_perc58||'],['||f_14_57||','||f_14_perc58||'],['||f_15_57||','||f_15_perc58||'],['||f_16_57||','||f_16_perc58||'],['||f_17_57||','||m_17_perc58||'],['||f_18_57||','||f_18_perc58||']],';OUTPUT;
VAR1 = '[['||f_01_58||','||f_01_perc59||'],['||f_02_58||','||f_02_perc59||'],['||f_03_58||','||f_03_perc59||'],['||f_04_58||','||f_04_perc59||'],['||f_05_58||','||f_05_perc59||'],['||f_06_58||','||f_06_perc59||'],['||f_07_58||','||f_07_perc59||'],['||f_08_58||','||f_08_perc59||'],['||f_09_58||','||f_09_perc59||'],['||f_10_58||','||f_10_perc59||'],['||f_11_58||','||f_11_perc59||'],['||f_12_58||','||f_12_perc59||'],['||f_13_58||','||f_13_perc59||'],['||f_14_58||','||f_14_perc59||'],['||f_15_58||','||f_15_perc59||'],['||f_16_58||','||f_16_perc59||'],['||f_17_58||','||m_17_perc59||'],['||f_18_58||','||f_18_perc59||']],';OUTPUT;
VAR1 = '[['||f_01_59||','||f_01_perc60||'],['||f_02_59||','||f_02_perc60||'],['||f_03_59||','||f_03_perc60||'],['||f_04_59||','||f_04_perc60||'],['||f_05_59||','||f_05_perc60||'],['||f_06_59||','||f_06_perc60||'],['||f_07_59||','||f_07_perc60||'],['||f_08_59||','||f_08_perc60||'],['||f_09_59||','||f_09_perc60||'],['||f_10_59||','||f_10_perc60||'],['||f_11_59||','||f_11_perc60||'],['||f_12_59||','||f_12_perc60||'],['||f_13_59||','||f_13_perc60||'],['||f_14_59||','||f_14_perc60||'],['||f_15_59||','||f_15_perc60||'],['||f_16_59||','||f_16_perc60||'],['||f_17_59||','||m_17_perc60||'],['||f_18_59||','||f_18_perc60||']],';OUTPUT;
VAR1 = '[['||f_01_60||','||f_01_perc61||'],['||f_02_60||','||f_02_perc61||'],['||f_03_60||','||f_03_perc61||'],['||f_04_60||','||f_04_perc61||'],['||f_05_60||','||f_05_perc61||'],['||f_06_60||','||f_06_perc61||'],['||f_07_60||','||f_07_perc61||'],['||f_08_60||','||f_08_perc61||'],['||f_09_60||','||f_09_perc61||'],['||f_10_60||','||f_10_perc61||'],['||f_11_60||','||f_11_perc61||'],['||f_12_60||','||f_12_perc61||'],['||f_13_60||','||f_13_perc61||'],['||f_14_60||','||f_14_perc61||'],['||f_15_60||','||f_15_perc61||'],['||f_16_60||','||f_16_perc61||'],['||f_17_60||','||m_17_perc61||'],['||f_18_60||','||f_18_perc61||']],';OUTPUT;
VAR1 = '[['||f_01_61||','||f_01_perc62||'],['||f_02_61||','||f_02_perc62||'],['||f_03_61||','||f_03_perc62||'],['||f_04_61||','||f_04_perc62||'],['||f_05_61||','||f_05_perc62||'],['||f_06_61||','||f_06_perc62||'],['||f_07_61||','||f_07_perc62||'],['||f_08_61||','||f_08_perc62||'],['||f_09_61||','||f_09_perc62||'],['||f_10_61||','||f_10_perc62||'],['||f_11_61||','||f_11_perc62||'],['||f_12_61||','||f_12_perc62||'],['||f_13_61||','||f_13_perc62||'],['||f_14_61||','||f_14_perc62||'],['||f_15_61||','||f_15_perc62||'],['||f_16_61||','||f_16_perc62||'],['||f_17_61||','||m_17_perc62||'],['||f_18_61||','||f_18_perc62||']],';OUTPUT;
VAR1 = '[['||f_01_62||','||f_01_perc63||'],['||f_02_62||','||f_02_perc63||'],['||f_03_62||','||f_03_perc63||'],['||f_04_62||','||f_04_perc63||'],['||f_05_62||','||f_05_perc63||'],['||f_06_62||','||f_06_perc63||'],['||f_07_62||','||f_07_perc63||'],['||f_08_62||','||f_08_perc63||'],['||f_09_62||','||f_09_perc63||'],['||f_10_62||','||f_10_perc63||'],['||f_11_62||','||f_11_perc63||'],['||f_12_62||','||f_12_perc63||'],['||f_13_62||','||f_13_perc63||'],['||f_14_62||','||f_14_perc63||'],['||f_15_62||','||f_15_perc63||'],['||f_16_62||','||f_16_perc63||'],['||f_17_62||','||m_17_perc63||'],['||f_18_62||','||f_18_perc63||']],';OUTPUT;
VAR1 = '[['||f_01_63||','||f_01_perc64||'],['||f_02_63||','||f_02_perc64||'],['||f_03_63||','||f_03_perc64||'],['||f_04_63||','||f_04_perc64||'],['||f_05_63||','||f_05_perc64||'],['||f_06_63||','||f_06_perc64||'],['||f_07_63||','||f_07_perc64||'],['||f_08_63||','||f_08_perc64||'],['||f_09_63||','||f_09_perc64||'],['||f_10_63||','||f_10_perc64||'],['||f_11_63||','||f_11_perc64||'],['||f_12_63||','||f_12_perc64||'],['||f_13_63||','||f_13_perc64||'],['||f_14_63||','||f_14_perc64||'],['||f_15_63||','||f_15_perc64||'],['||f_16_63||','||f_16_perc64||'],['||f_17_63||','||m_17_perc64||'],['||f_18_63||','||f_18_perc64||']],';OUTPUT;
VAR1 = '[['||f_01_64||','||f_01_perc65||'],['||f_02_64||','||f_02_perc65||'],['||f_03_64||','||f_03_perc65||'],['||f_04_64||','||f_04_perc65||'],['||f_05_64||','||f_05_perc65||'],['||f_06_64||','||f_06_perc65||'],['||f_07_64||','||f_07_perc65||'],['||f_08_64||','||f_08_perc65||'],['||f_09_64||','||f_09_perc65||'],['||f_10_64||','||f_10_perc65||'],['||f_11_64||','||f_11_perc65||'],['||f_12_64||','||f_12_perc65||'],['||f_13_64||','||f_13_perc65||'],['||f_14_64||','||f_14_perc65||'],['||f_15_64||','||f_15_perc65||'],['||f_16_64||','||f_16_perc65||'],['||f_17_64||','||m_17_perc65||'],['||f_18_64||','||f_18_perc65||']],';OUTPUT;
VAR1 = '[['||f_01_65||','||f_01_perc66||'],['||f_02_65||','||f_02_perc66||'],['||f_03_65||','||f_03_perc66||'],['||f_04_65||','||f_04_perc66||'],['||f_05_65||','||f_05_perc66||'],['||f_06_65||','||f_06_perc66||'],['||f_07_65||','||f_07_perc66||'],['||f_08_65||','||f_08_perc66||'],['||f_09_65||','||f_09_perc66||'],['||f_10_65||','||f_10_perc66||'],['||f_11_65||','||f_11_perc66||'],['||f_12_65||','||f_12_perc66||'],['||f_13_65||','||f_13_perc66||'],['||f_14_65||','||f_14_perc66||'],['||f_15_65||','||f_15_perc66||'],['||f_16_65||','||f_16_perc66||'],['||f_17_65||','||m_17_perc66||'],['||f_18_65||','||f_18_perc66||']],';OUTPUT;
VAR1 = '[['||f_01_66||','||f_01_perc67||'],['||f_02_66||','||f_02_perc67||'],['||f_03_66||','||f_03_perc67||'],['||f_04_66||','||f_04_perc67||'],['||f_05_66||','||f_05_perc67||'],['||f_06_66||','||f_06_perc67||'],['||f_07_66||','||f_07_perc67||'],['||f_08_66||','||f_08_perc67||'],['||f_09_66||','||f_09_perc67||'],['||f_10_66||','||f_10_perc67||'],['||f_11_66||','||f_11_perc67||'],['||f_12_66||','||f_12_perc67||'],['||f_13_66||','||f_13_perc67||'],['||f_14_66||','||f_14_perc67||'],['||f_15_66||','||f_15_perc67||'],['||f_16_66||','||f_16_perc67||'],['||f_17_66||','||m_17_perc67||'],['||f_18_66||','||f_18_perc67||']],';OUTPUT;
VAR1 = '[['||f_01_67||','||f_01_perc68||'],['||f_02_67||','||f_02_perc68||'],['||f_03_67||','||f_03_perc68||'],['||f_04_67||','||f_04_perc68||'],['||f_05_67||','||f_05_perc68||'],['||f_06_67||','||f_06_perc68||'],['||f_07_67||','||f_07_perc68||'],['||f_08_67||','||f_08_perc68||'],['||f_09_67||','||f_09_perc68||'],['||f_10_67||','||f_10_perc68||'],['||f_11_67||','||f_11_perc68||'],['||f_12_67||','||f_12_perc68||'],['||f_13_67||','||f_13_perc68||'],['||f_14_67||','||f_14_perc68||'],['||f_15_67||','||f_15_perc68||'],['||f_16_67||','||f_16_perc68||'],['||f_17_67||','||m_17_perc68||'],['||f_18_67||','||f_18_perc68||']],';OUTPUT;
VAR1 = '[['||f_01_68||','||f_01_perc69||'],['||f_02_68||','||f_02_perc69||'],['||f_03_68||','||f_03_perc69||'],['||f_04_68||','||f_04_perc69||'],['||f_05_68||','||f_05_perc69||'],['||f_06_68||','||f_06_perc69||'],['||f_07_68||','||f_07_perc69||'],['||f_08_68||','||f_08_perc69||'],['||f_09_68||','||f_09_perc69||'],['||f_10_68||','||f_10_perc69||'],['||f_11_68||','||f_11_perc69||'],['||f_12_68||','||f_12_perc69||'],['||f_13_68||','||f_13_perc69||'],['||f_14_68||','||f_14_perc69||'],['||f_15_68||','||f_15_perc69||'],['||f_16_68||','||f_16_perc69||'],['||f_17_68||','||m_17_perc69||'],['||f_18_68||','||f_18_perc69||']],';OUTPUT;
VAR1 = '[['||f_01_69||','||f_01_perc70||'],['||f_02_69||','||f_02_perc70||'],['||f_03_69||','||f_03_perc70||'],['||f_04_69||','||f_04_perc70||'],['||f_05_69||','||f_05_perc70||'],['||f_06_69||','||f_06_perc70||'],['||f_07_69||','||f_07_perc70||'],['||f_08_69||','||f_08_perc70||'],['||f_09_69||','||f_09_perc70||'],['||f_10_69||','||f_10_perc70||'],['||f_11_69||','||f_11_perc70||'],['||f_12_69||','||f_12_perc70||'],['||f_13_69||','||f_13_perc70||'],['||f_14_69||','||f_14_perc70||'],['||f_15_69||','||f_15_perc70||'],['||f_16_69||','||f_16_perc70||'],['||f_17_69||','||m_17_perc70||'],['||f_18_69||','||f_18_perc70||']],';OUTPUT;
VAR1 = '[['||f_01_70||','||f_01_perc71||'],['||f_02_70||','||f_02_perc71||'],['||f_03_70||','||f_03_perc71||'],['||f_04_70||','||f_04_perc71||'],['||f_05_70||','||f_05_perc71||'],['||f_06_70||','||f_06_perc71||'],['||f_07_70||','||f_07_perc71||'],['||f_08_70||','||f_08_perc71||'],['||f_09_70||','||f_09_perc71||'],['||f_10_70||','||f_10_perc71||'],['||f_11_70||','||f_11_perc71||'],['||f_12_70||','||f_12_perc71||'],['||f_13_70||','||f_13_perc71||'],['||f_14_70||','||f_14_perc71||'],['||f_15_70||','||f_15_perc71||'],['||f_16_70||','||f_16_perc71||'],['||f_17_70||','||m_17_perc71||'],['||f_18_70||','||f_18_perc71||']],';OUTPUT;
VAR1 = '[['||f_01_71||','||f_01_perc72||'],['||f_02_71||','||f_02_perc72||'],['||f_03_71||','||f_03_perc72||'],['||f_04_71||','||f_04_perc72||'],['||f_05_71||','||f_05_perc72||'],['||f_06_71||','||f_06_perc72||'],['||f_07_71||','||f_07_perc72||'],['||f_08_71||','||f_08_perc72||'],['||f_09_71||','||f_09_perc72||'],['||f_10_71||','||f_10_perc72||'],['||f_11_71||','||f_11_perc72||'],['||f_12_71||','||f_12_perc72||'],['||f_13_71||','||f_13_perc72||'],['||f_14_71||','||f_14_perc72||'],['||f_15_71||','||f_15_perc72||'],['||f_16_71||','||f_16_perc72||'],['||f_17_71||','||m_17_perc72||'],['||f_18_71||','||f_18_perc72||']],';OUTPUT;
VAR1 = '[['||f_01_72||','||f_01_perc73||'],['||f_02_72||','||f_02_perc73||'],['||f_03_72||','||f_03_perc73||'],['||f_04_72||','||f_04_perc73||'],['||f_05_72||','||f_05_perc73||'],['||f_06_72||','||f_06_perc73||'],['||f_07_72||','||f_07_perc73||'],['||f_08_72||','||f_08_perc73||'],['||f_09_72||','||f_09_perc73||'],['||f_10_72||','||f_10_perc73||'],['||f_11_72||','||f_11_perc73||'],['||f_12_72||','||f_12_perc73||'],['||f_13_72||','||f_13_perc73||'],['||f_14_72||','||f_14_perc73||'],['||f_15_72||','||f_15_perc73||'],['||f_16_72||','||f_16_perc73||'],['||f_17_72||','||m_17_perc73||'],['||f_18_72||','||f_18_perc73||']],';OUTPUT;
VAR1 = '[['||f_01_73||','||f_01_perc74||'],['||f_02_73||','||f_02_perc74||'],['||f_03_73||','||f_03_perc74||'],['||f_04_73||','||f_04_perc74||'],['||f_05_73||','||f_05_perc74||'],['||f_06_73||','||f_06_perc74||'],['||f_07_73||','||f_07_perc74||'],['||f_08_73||','||f_08_perc74||'],['||f_09_73||','||f_09_perc74||'],['||f_10_73||','||f_10_perc74||'],['||f_11_73||','||f_11_perc74||'],['||f_12_73||','||f_12_perc74||'],['||f_13_73||','||f_13_perc74||'],['||f_14_73||','||f_14_perc74||'],['||f_15_73||','||f_15_perc74||'],['||f_16_73||','||f_16_perc74||'],['||f_17_73||','||m_17_perc74||'],['||f_18_73||','||f_18_perc74||']],';OUTPUT;
VAR1 = '[['||f_01_74||','||f_01_perc75||'],['||f_02_74||','||f_02_perc75||'],['||f_03_74||','||f_03_perc75||'],['||f_04_74||','||f_04_perc75||'],['||f_05_74||','||f_05_perc75||'],['||f_06_74||','||f_06_perc75||'],['||f_07_74||','||f_07_perc75||'],['||f_08_74||','||f_08_perc75||'],['||f_09_74||','||f_09_perc75||'],['||f_10_74||','||f_10_perc75||'],['||f_11_74||','||f_11_perc75||'],['||f_12_74||','||f_12_perc75||'],['||f_13_74||','||f_13_perc75||'],['||f_14_74||','||f_14_perc75||'],['||f_15_74||','||f_15_perc75||'],['||f_16_74||','||f_16_perc75||'],['||f_17_74||','||m_17_perc75||'],['||f_18_74||','||f_18_perc75||']],';OUTPUT;
VAR1 = '[['||f_01_75||','||f_01_perc76||'],['||f_02_75||','||f_02_perc76||'],['||f_03_75||','||f_03_perc76||'],['||f_04_75||','||f_04_perc76||'],['||f_05_75||','||f_05_perc76||'],['||f_06_75||','||f_06_perc76||'],['||f_07_75||','||f_07_perc76||'],['||f_08_75||','||f_08_perc76||'],['||f_09_75||','||f_09_perc76||'],['||f_10_75||','||f_10_perc76||'],['||f_11_75||','||f_11_perc76||'],['||f_12_75||','||f_12_perc76||'],['||f_13_75||','||f_13_perc76||'],['||f_14_75||','||f_14_perc76||'],['||f_15_75||','||f_15_perc76||'],['||f_16_75||','||f_16_perc76||'],['||f_17_75||','||m_17_perc76||'],['||f_18_75||','||f_18_perc76||']],';OUTPUT;
VAR1 = '[['||f_01_76||','||f_01_perc77||'],['||f_02_76||','||f_02_perc77||'],['||f_03_76||','||f_03_perc77||'],['||f_04_76||','||f_04_perc77||'],['||f_05_76||','||f_05_perc77||'],['||f_06_76||','||f_06_perc77||'],['||f_07_76||','||f_07_perc77||'],['||f_08_76||','||f_08_perc77||'],['||f_09_76||','||f_09_perc77||'],['||f_10_76||','||f_10_perc77||'],['||f_11_76||','||f_11_perc77||'],['||f_12_76||','||f_12_perc77||'],['||f_13_76||','||f_13_perc77||'],['||f_14_76||','||f_14_perc77||'],['||f_15_76||','||f_15_perc77||'],['||f_16_76||','||f_16_perc77||'],['||f_17_76||','||m_17_perc77||'],['||f_18_76||','||f_18_perc77||']],';OUTPUT;
VAR1 = '[['||f_01_77||','||f_01_perc78||'],['||f_02_77||','||f_02_perc78||'],['||f_03_77||','||f_03_perc78||'],['||f_04_77||','||f_04_perc78||'],['||f_05_77||','||f_05_perc78||'],['||f_06_77||','||f_06_perc78||'],['||f_07_77||','||f_07_perc78||'],['||f_08_77||','||f_08_perc78||'],['||f_09_77||','||f_09_perc78||'],['||f_10_77||','||f_10_perc78||'],['||f_11_77||','||f_11_perc78||'],['||f_12_77||','||f_12_perc78||'],['||f_13_77||','||f_13_perc78||'],['||f_14_77||','||f_14_perc78||'],['||f_15_77||','||f_15_perc78||'],['||f_16_77||','||f_16_perc78||'],['||f_17_77||','||m_17_perc78||'],['||f_18_77||','||f_18_perc78||']],';OUTPUT;
VAR1 = '[['||f_01_78||','||f_01_perc79||'],['||f_02_78||','||f_02_perc79||'],['||f_03_78||','||f_03_perc79||'],['||f_04_78||','||f_04_perc79||'],['||f_05_78||','||f_05_perc79||'],['||f_06_78||','||f_06_perc79||'],['||f_07_78||','||f_07_perc79||'],['||f_08_78||','||f_08_perc79||'],['||f_09_78||','||f_09_perc79||'],['||f_10_78||','||f_10_perc79||'],['||f_11_78||','||f_11_perc79||'],['||f_12_78||','||f_12_perc79||'],['||f_13_78||','||f_13_perc79||'],['||f_14_78||','||f_14_perc79||'],['||f_15_78||','||f_15_perc79||'],['||f_16_78||','||f_16_perc79||'],['||f_17_78||','||m_17_perc79||'],['||f_18_78||','||f_18_perc79||']],';OUTPUT;
VAR1 = '[['||f_01_79||','||f_01_perc80||'],['||f_02_79||','||f_02_perc80||'],['||f_03_79||','||f_03_perc80||'],['||f_04_79||','||f_04_perc80||'],['||f_05_79||','||f_05_perc80||'],['||f_06_79||','||f_06_perc80||'],['||f_07_79||','||f_07_perc80||'],['||f_08_79||','||f_08_perc80||'],['||f_09_79||','||f_09_perc80||'],['||f_10_79||','||f_10_perc80||'],['||f_11_79||','||f_11_perc80||'],['||f_12_79||','||f_12_perc80||'],['||f_13_79||','||f_13_perc80||'],['||f_14_79||','||f_14_perc80||'],['||f_15_79||','||f_15_perc80||'],['||f_16_79||','||f_16_perc80||'],['||f_17_79||','||m_17_perc80||'],['||f_18_79||','||f_18_perc80||']],';OUTPUT;
VAR1 = '[['||f_01_80||','||f_01_perc81||'],['||f_02_80||','||f_02_perc81||'],['||f_03_80||','||f_03_perc81||'],['||f_04_80||','||f_04_perc81||'],['||f_05_80||','||f_05_perc81||'],['||f_06_80||','||f_06_perc81||'],['||f_07_80||','||f_07_perc81||'],['||f_08_80||','||f_08_perc81||'],['||f_09_80||','||f_09_perc81||'],['||f_10_80||','||f_10_perc81||'],['||f_11_80||','||f_11_perc81||'],['||f_12_80||','||f_12_perc81||'],['||f_13_80||','||f_13_perc81||'],['||f_14_80||','||f_14_perc81||'],['||f_15_80||','||f_15_perc81||'],['||f_16_80||','||f_16_perc81||'],['||f_17_80||','||m_17_perc81||'],['||f_18_80||','||f_18_perc81||']],';OUTPUT;
VAR1 = '[['||f_01_81||','||f_01_perc82||'],['||f_02_81||','||f_02_perc82||'],['||f_03_81||','||f_03_perc82||'],['||f_04_81||','||f_04_perc82||'],['||f_05_81||','||f_05_perc82||'],['||f_06_81||','||f_06_perc82||'],['||f_07_81||','||f_07_perc82||'],['||f_08_81||','||f_08_perc82||'],['||f_09_81||','||f_09_perc82||'],['||f_10_81||','||f_10_perc82||'],['||f_11_81||','||f_11_perc82||'],['||f_12_81||','||f_12_perc82||'],['||f_13_81||','||f_13_perc82||'],['||f_14_81||','||f_14_perc82||'],['||f_15_81||','||f_15_perc82||'],['||f_16_81||','||f_16_perc82||'],['||f_17_81||','||m_17_perc82||'],['||f_18_81||','||f_18_perc82||']],';OUTPUT;
VAR1 = '[['||f_01_82||','||f_01_perc83||'],['||f_02_82||','||f_02_perc83||'],['||f_03_82||','||f_03_perc83||'],['||f_04_82||','||f_04_perc83||'],['||f_05_82||','||f_05_perc83||'],['||f_06_82||','||f_06_perc83||'],['||f_07_82||','||f_07_perc83||'],['||f_08_82||','||f_08_perc83||'],['||f_09_82||','||f_09_perc83||'],['||f_10_82||','||f_10_perc83||'],['||f_11_82||','||f_11_perc83||'],['||f_12_82||','||f_12_perc83||'],['||f_13_82||','||f_13_perc83||'],['||f_14_82||','||f_14_perc83||'],['||f_15_82||','||f_15_perc83||'],['||f_16_82||','||f_16_perc83||'],['||f_17_82||','||m_17_perc83||'],['||f_18_82||','||f_18_perc83||']],';OUTPUT;
VAR1 = '[['||f_01_83||','||f_01_perc84||'],['||f_02_83||','||f_02_perc84||'],['||f_03_83||','||f_03_perc84||'],['||f_04_83||','||f_04_perc84||'],['||f_05_83||','||f_05_perc84||'],['||f_06_83||','||f_06_perc84||'],['||f_07_83||','||f_07_perc84||'],['||f_08_83||','||f_08_perc84||'],['||f_09_83||','||f_09_perc84||'],['||f_10_83||','||f_10_perc84||'],['||f_11_83||','||f_11_perc84||'],['||f_12_83||','||f_12_perc84||'],['||f_13_83||','||f_13_perc84||'],['||f_14_83||','||f_14_perc84||'],['||f_15_83||','||f_15_perc84||'],['||f_16_83||','||f_16_perc84||'],['||f_17_83||','||m_17_perc84||'],['||f_18_83||','||f_18_perc84||']],';OUTPUT;
VAR1 = '[['||f_01_84||','||f_01_perc85||'],['||f_02_84||','||f_02_perc85||'],['||f_03_84||','||f_03_perc85||'],['||f_04_84||','||f_04_perc85||'],['||f_05_84||','||f_05_perc85||'],['||f_06_84||','||f_06_perc85||'],['||f_07_84||','||f_07_perc85||'],['||f_08_84||','||f_08_perc85||'],['||f_09_84||','||f_09_perc85||'],['||f_10_84||','||f_10_perc85||'],['||f_11_84||','||f_11_perc85||'],['||f_12_84||','||f_12_perc85||'],['||f_13_84||','||f_13_perc85||'],['||f_14_84||','||f_14_perc85||'],['||f_15_84||','||f_15_perc85||'],['||f_16_84||','||f_16_perc85||'],['||f_17_84||','||m_17_perc85||'],['||f_18_84||','||f_18_perc85||']],';OUTPUT;
VAR1 = '[['||f_01_85||','||f_01_perc86||'],['||f_02_85||','||f_02_perc86||'],['||f_03_85||','||f_03_perc86||'],['||f_04_85||','||f_04_perc86||'],['||f_05_85||','||f_05_perc86||'],['||f_06_85||','||f_06_perc86||'],['||f_07_85||','||f_07_perc86||'],['||f_08_85||','||f_08_perc86||'],['||f_09_85||','||f_09_perc86||'],['||f_10_85||','||f_10_perc86||'],['||f_11_85||','||f_11_perc86||'],['||f_12_85||','||f_12_perc86||'],['||f_13_85||','||f_13_perc86||'],['||f_14_85||','||f_14_perc86||'],['||f_15_85||','||f_15_perc86||'],['||f_16_85||','||f_16_perc86||'],['||f_17_85||','||m_17_perc86||'],['||f_18_85||','||f_18_perc86||']],';OUTPUT;
VAR1 = '[['||f_01_86||','||f_01_perc87||'],['||f_02_86||','||f_02_perc87||'],['||f_03_86||','||f_03_perc87||'],['||f_04_86||','||f_04_perc87||'],['||f_05_86||','||f_05_perc87||'],['||f_06_86||','||f_06_perc87||'],['||f_07_86||','||f_07_perc87||'],['||f_08_86||','||f_08_perc87||'],['||f_09_86||','||f_09_perc87||'],['||f_10_86||','||f_10_perc87||'],['||f_11_86||','||f_11_perc87||'],['||f_12_86||','||f_12_perc87||'],['||f_13_86||','||f_13_perc87||'],['||f_14_86||','||f_14_perc87||'],['||f_15_86||','||f_15_perc87||'],['||f_16_86||','||f_16_perc87||'],['||f_17_86||','||m_17_perc87||'],['||f_18_86||','||f_18_perc87||']],';OUTPUT;
VAR1 = '[['||f_01_87||','||f_01_perc88||'],['||f_02_87||','||f_02_perc88||'],['||f_03_87||','||f_03_perc88||'],['||f_04_87||','||f_04_perc88||'],['||f_05_87||','||f_05_perc88||'],['||f_06_87||','||f_06_perc88||'],['||f_07_87||','||f_07_perc88||'],['||f_08_87||','||f_08_perc88||'],['||f_09_87||','||f_09_perc88||'],['||f_10_87||','||f_10_perc88||'],['||f_11_87||','||f_11_perc88||'],['||f_12_87||','||f_12_perc88||'],['||f_13_87||','||f_13_perc88||'],['||f_14_87||','||f_14_perc88||'],['||f_15_87||','||f_15_perc88||'],['||f_16_87||','||f_16_perc88||'],['||f_17_87||','||m_17_perc88||'],['||f_18_87||','||f_18_perc88||']],';OUTPUT;
VAR1 = '[['||f_01_88||','||f_01_perc89||'],['||f_02_88||','||f_02_perc89||'],['||f_03_88||','||f_03_perc89||'],['||f_04_88||','||f_04_perc89||'],['||f_05_88||','||f_05_perc89||'],['||f_06_88||','||f_06_perc89||'],['||f_07_88||','||f_07_perc89||'],['||f_08_88||','||f_08_perc89||'],['||f_09_88||','||f_09_perc89||'],['||f_10_88||','||f_10_perc89||'],['||f_11_88||','||f_11_perc89||'],['||f_12_88||','||f_12_perc89||'],['||f_13_88||','||f_13_perc89||'],['||f_14_88||','||f_14_perc89||'],['||f_15_88||','||f_15_perc89||'],['||f_16_88||','||f_16_perc89||'],['||f_17_88||','||m_17_perc89||'],['||f_18_88||','||f_18_perc89||']],';OUTPUT;
VAR1 = '[['||f_01_89||','||f_01_perc90||'],['||f_02_89||','||f_02_perc90||'],['||f_03_89||','||f_03_perc90||'],['||f_04_89||','||f_04_perc90||'],['||f_05_89||','||f_05_perc90||'],['||f_06_89||','||f_06_perc90||'],['||f_07_89||','||f_07_perc90||'],['||f_08_89||','||f_08_perc90||'],['||f_09_89||','||f_09_perc90||'],['||f_10_89||','||f_10_perc90||'],['||f_11_89||','||f_11_perc90||'],['||f_12_89||','||f_12_perc90||'],['||f_13_89||','||f_13_perc90||'],['||f_14_89||','||f_14_perc90||'],['||f_15_89||','||f_15_perc90||'],['||f_16_89||','||f_16_perc90||'],['||f_17_89||','||m_17_perc90||'],['||f_18_89||','||f_18_perc90||']],';OUTPUT;
VAR1 = '[['||f_01_90||','||f_01_perc91||'],['||f_02_90||','||f_02_perc91||'],['||f_03_90||','||f_03_perc91||'],['||f_04_90||','||f_04_perc91||'],['||f_05_90||','||f_05_perc91||'],['||f_06_90||','||f_06_perc91||'],['||f_07_90||','||f_07_perc91||'],['||f_08_90||','||f_08_perc91||'],['||f_09_90||','||f_09_perc91||'],['||f_10_90||','||f_10_perc91||'],['||f_11_90||','||f_11_perc91||'],['||f_12_90||','||f_12_perc91||'],['||f_13_90||','||f_13_perc91||'],['||f_14_90||','||f_14_perc91||'],['||f_15_90||','||f_15_perc91||'],['||f_16_90||','||f_16_perc91||'],['||f_17_90||','||m_17_perc91||'],['||f_18_90||','||f_18_perc91||']]]]}}' ;OUTPUT;

END;
RUN;


%mend;
%manipfile(hartlepool2)
%manipfile(middlesbrough2)
%manipfile(redcarandcleveland2)
%manipfile(stocktonontees2)
%manipfile(darlington2)
%manipfile(halton2)
%manipfile(warrington2)
%manipfile(blackburnwithdarwen2)
%manipfile(blackpool2)
%manipfile(kingstonuponhullcityof2)
%manipfile(eastridingofyorkshire2)
%manipfile(northeastlincolnshire2)
%manipfile(northlincolnshire2)
%manipfile(york2)
%manipfile(derby2)
%manipfile(leicester2)
%manipfile(rutland2)
%manipfile(nottingham2)
%manipfile(herefordshirecountyof2)
%manipfile(telfordandwrekin2)
%manipfile(stokeontrent2)
%manipfile(bathandnortheastsomerset2)
%manipfile(bristolcityof2)
%manipfile(northsomerset2)
%manipfile(southgloucestershire2)
%manipfile(plymouth2)
%manipfile(torbay2)
%manipfile(bournemouth2)
%manipfile(poole2)
%manipfile(swindon2)
%manipfile(peterborough2)
%manipfile(luton2)
%manipfile(southendonsea2)
%manipfile(thurrock2)
%manipfile(medway2)
%manipfile(bracknellforest2)
%manipfile(westberkshire2)
%manipfile(reading2)
%manipfile(slough2)
%manipfile(windsorandmaidenhead2)
%manipfile(wokingham2)
%manipfile(miltonkeynes2)
%manipfile(brightonandhove2)
%manipfile(portsmouth2)
%manipfile(southampton2)
%manipfile(isleofwight2)
%manipfile(countydurham2)
%manipfile(cheshireeast2)
%manipfile(cheshirewestandchester2)
%manipfile(shropshire2)
%manipfile(cornwall2)
%manipfile(islesofscilly2)
%manipfile(wiltshire2)
%manipfile(bedford2)
%manipfile(centralbedfordshire2)
%manipfile(northumberland2)
%manipfile(aylesburyvale2)
%manipfile(chiltern2)
%manipfile(southbucks2)
%manipfile(wycombe2)
%manipfile(cambridge2)
%manipfile(eastcambridgeshire2)
%manipfile(fenland2)
%manipfile(huntingdonshire2)
%manipfile(southcambridgeshire2)
%manipfile(allerdale2)
%manipfile(barrowinfurness2)
%manipfile(carlisle2)
%manipfile(copeland2)
%manipfile(eden2)
%manipfile(southlakeland2)
%manipfile(ambervalley2)
%manipfile(bolsover2)
%manipfile(chesterfield2)
%manipfile(derbyshiredales2)
%manipfile(erewash2)
%manipfile(highpeak2)
%manipfile(northeastderbyshire2)
%manipfile(southderbyshire2)
%manipfile(eastdevon2)
%manipfile(exeter2)
%manipfile(middevon2)
%manipfile(northdevon2)
%manipfile(southhams2)
%manipfile(teignbridge2)
%manipfile(torridge2)
%manipfile(westdevon2)
%manipfile(christchurch2)
%manipfile(eastdorset2)
%manipfile(northdorset2)
%manipfile(purbeck2)
%manipfile(westdorset2)
%manipfile(weymouthandportland2)
%manipfile(eastbourne2)
%manipfile(hastings2)
%manipfile(lewes2)
%manipfile(rother2)
%manipfile(wealden2)
%manipfile(basildon2)
%manipfile(braintree2)
%manipfile(brentwood2)
%manipfile(castlepoint2)
%manipfile(chelmsford2)
%manipfile(colchester2)
%manipfile(eppingforest2)
%manipfile(harlow2)
%manipfile(maldon2)
%manipfile(rochford2)
%manipfile(tendring2)
%manipfile(uttlesford2)
%manipfile(cheltenham2)
%manipfile(cotswold2)
%manipfile(forestofdean2)
%manipfile(gloucester2)
%manipfile(stroud2)
%manipfile(tewkesbury2)
%manipfile(basingstokeanddeane2)
%manipfile(easthampshire2)
%manipfile(eastleigh2)
%manipfile(fareham2)
%manipfile(gosport2)
%manipfile(hart2)
%manipfile(havant2)
%manipfile(newforest2)
%manipfile(rushmoor2)
%manipfile(testvalley2)
%manipfile(winchester2)
%manipfile(broxbourne2)
%manipfile(dacorum2)
%manipfile(hertsmere2)
%manipfile(northhertfordshire2)
%manipfile(threerivers2)
%manipfile(watford2)
%manipfile(ashford2)
%manipfile(canterbury2)
%manipfile(dartford2)
%manipfile(dover2)
%manipfile(gravesham2)
%manipfile(maidstone2)
%manipfile(sevenoaks2)
%manipfile(shepway2)
%manipfile(swale2)
%manipfile(thanet2)
%manipfile(tonbridgeandmalling2)
%manipfile(tunbridgewells2)
%manipfile(burnley2)
%manipfile(chorley2)
%manipfile(fylde2)
%manipfile(hyndburn2)
%manipfile(lancaster2)
%manipfile(pendle2)
%manipfile(preston2)
%manipfile(ribblevalley2)
%manipfile(rossendale2)
%manipfile(southribble2)
%manipfile(westlancashire2)
%manipfile(wyre2)
%manipfile(blaby2)
%manipfile(charnwood2)
%manipfile(harborough2)
%manipfile(hinckleyandbosworth2)
%manipfile(melton2)
%manipfile(northwestleicestershire2)
%manipfile(oadbyandwigston2)
%manipfile(boston2)
%manipfile(eastlindsey2)
%manipfile(lincoln2)
%manipfile(northkesteven2)
%manipfile(southholland2)
%manipfile(southkesteven2)
%manipfile(westlindsey2)
%manipfile(breckland2)
%manipfile(broadland2)
%manipfile(greatyarmouth2)
%manipfile(kingslynnandwestnorfolk2)
%manipfile(northnorfolk2)
%manipfile(norwich2)
%manipfile(southnorfolk2)
%manipfile(corby2)
%manipfile(daventry2)
%manipfile(eastnorthamptonshire2)
%manipfile(kettering2)
%manipfile(northampton2)
%manipfile(southnorthamptonshire2)
%manipfile(wellingborough2)
%manipfile(craven2)
%manipfile(hambleton2)
%manipfile(harrogate2)
%manipfile(richmondshire2)
%manipfile(ryedale2)
%manipfile(scarborough2)
%manipfile(selby2)
%manipfile(ashfield2)
%manipfile(bassetlaw2)
%manipfile(broxtowe2)
%manipfile(gedling2)
%manipfile(mansfield2)
%manipfile(newarkandsherwood2)
%manipfile(rushcliffe2)
%manipfile(cherwell2)
%manipfile(oxford2)
%manipfile(southoxfordshire2)
%manipfile(valeofwhitehorse2)
%manipfile(westoxfordshire2)
%manipfile(mendip2)
%manipfile(sedgemoor2)
%manipfile(southsomerset2)
%manipfile(tauntondeane2)
%manipfile(westsomerset2)
%manipfile(cannockchase2)
%manipfile(eaststaffordshire2)
%manipfile(lichfield2)
%manipfile(newcastleunderlyme2)
%manipfile(southstaffordshire2)
%manipfile(stafford2)
%manipfile(staffordshiremoorlands2)
%manipfile(tamworth2)
%manipfile(babergh2)
%manipfile(forestheath2)
%manipfile(ipswich2)
%manipfile(midsuffolk2)
%manipfile(stedmundsbury2)
%manipfile(suffolkcoastal2)
%manipfile(waveney2)
%manipfile(elmbridge2)
%manipfile(epsomandewell2)
%manipfile(guildford2)
%manipfile(molevalley2)
%manipfile(reigateandbanstead2)
%manipfile(runnymede2)
%manipfile(spelthorne2)
%manipfile(surreyheath2)
%manipfile(tandridge2)
%manipfile(waverley2)
%manipfile(woking2)
%manipfile(northwarwickshire2)
%manipfile(nuneatonandbedworth2)
%manipfile(rugby2)
%manipfile(stratfordonavon2)
%manipfile(warwick2)
%manipfile(adur2)
%manipfile(arun2)
%manipfile(chichester2)
%manipfile(crawley2)
%manipfile(horsham2)
%manipfile(midsussex2)
%manipfile(worthing2)
%manipfile(bromsgrove2)
%manipfile(malvernhills2)
%manipfile(redditch2)
%manipfile(worcester2)
%manipfile(wychavon2)
%manipfile(wyreforest2)
%manipfile(stalbans2)
%manipfile(welwynhatfield2)
%manipfile(easthertfordshire2)
%manipfile(stevenage2)
%manipfile(bolton2)
%manipfile(bury2)
%manipfile(manchester2)
%manipfile(oldham2)
%manipfile(rochdale2)
%manipfile(salford2)
%manipfile(stockport2)
%manipfile(tameside2)
%manipfile(trafford2)
%manipfile(wigan2)
%manipfile(knowsley2)
%manipfile(liverpool2)
%manipfile(sthelens2)
%manipfile(sefton2)
%manipfile(wirral2)
%manipfile(barnsley2)
%manipfile(doncaster2)
%manipfile(rotherham2)
%manipfile(sheffield2)
%manipfile(newcastleupontyne2)
%manipfile(northtyneside2)
%manipfile(southtyneside2)
%manipfile(sunderland2)
%manipfile(birmingham2)
%manipfile(coventry2)
%manipfile(dudley2)
%manipfile(sandwell2)
%manipfile(solihull2)
%manipfile(walsall2)
%manipfile(wolverhampton2)
%manipfile(bradford2)
%manipfile(calderdale2)
%manipfile(kirklees2)
%manipfile(leeds2)
%manipfile(wakefield2)
%manipfile(gateshead2)
%manipfile(cityoflondon2)
%manipfile(barkinganddagenham2)
%manipfile(barnet2)
%manipfile(bexley2)
%manipfile(brent2)
%manipfile(bromley2)
%manipfile(camden2)
%manipfile(croydon2)
%manipfile(ealing2)
%manipfile(enfield2)
%manipfile(greenwich2)
%manipfile(hackney2)
%manipfile(hammersmithandfulham2)
%manipfile(haringey2)
%manipfile(harrow2)
%manipfile(havering2)
%manipfile(hillingdon2)
%manipfile(hounslow2)
%manipfile(islington2)
%manipfile(kensingtonandchelsea2)
%manipfile(kingstonuponthames2)
%manipfile(lambeth2)
%manipfile(lewisham2)
%manipfile(merton2)
%manipfile(newham2)
%manipfile(redbridge2)
%manipfile(richmonduponthames2)
%manipfile(southwark2)
%manipfile(sutton2)
%manipfile(towerhamlets2)
%manipfile(walthamforest2)
%manipfile(wandsworth2)
%manipfile(westminster2)
%manipfile(buckinghamshire2)
%manipfile(cambridgeshire2)
%manipfile(cumbria2)
%manipfile(derbyshire2)
%manipfile(devon2)
%manipfile(dorset2)
%manipfile(eastsussex2)
%manipfile(essex2)
%manipfile(gloucestershire2)
%manipfile(hampshire2)
%manipfile(hertfordshire2)
%manipfile(kent2)
%manipfile(lancashire2)
%manipfile(leicestershire2)
%manipfile(lincolnshire2)
%manipfile(norfolk2)
%manipfile(northamptonshire2)
%manipfile(northyorkshire2)
%manipfile(nottinghamshire2)
%manipfile(oxfordshire2)
%manipfile(somerset2)
%manipfile(staffordshire2)
%manipfile(suffolk2)
%manipfile(surrey2)
%manipfile(warwickshire2)
%manipfile(westsussex2)
%manipfile(worcestershire2)
%manipfile(greatermanchester2)
%manipfile(merseyside2)
%manipfile(southyorkshire2)
%manipfile(westmidlands2)
%manipfile(westyorkshire2)
%manipfile(tyneandwear2)
%manipfile(antrimandnewtownabbey2)
%manipfile(armaghcitybanbridgeandcraigavon2)
%manipfile(belfast2)
%manipfile(causewaycoastandglens2)
%manipfile(derrycityandstrabane2)
%manipfile(fermanaghandomagh2)
%manipfile(lisburnandcastlereagh2)
%manipfile(midandeastantrim2)
%manipfile(midulster2)
%manipfile(newrymourneanddown2)
%manipfile(ardsandnorthdown2)
%manipfile(clackmannanshire2)
%manipfile(dumfriesandgalloway2)
%manipfile(eastayrshire2)
%manipfile(eastlothian2)
%manipfile(eastrenfrewshire2)
%manipfile(naheileanansiar2)
%manipfile(falkirk2)
%manipfile(fife2)
%manipfile(highland2)
%manipfile(inverclyde2)
%manipfile(midlothian2)
%manipfile(moray2)
%manipfile(northayrshire2)
%manipfile(orkneyislands2)
%manipfile(perthandkinross2)
%manipfile(scottishborders2)
%manipfile(shetlandislands2)
%manipfile(southayrshire2)
%manipfile(southlanarkshire2)
%manipfile(stirling2)
%manipfile(aberdeencity2)
%manipfile(aberdeenshire2)
%manipfile(argyllandbute2)
%manipfile(cityofedinburgh2)
%manipfile(renfrewshire2)
%manipfile(westdunbartonshire2)
%manipfile(westlothian2)
%manipfile(angus2)
%manipfile(dundeecity2)
%manipfile(northlanarkshire2)
%manipfile(eastdunbartonshire2)
%manipfile(glasgowcity2)
%manipfile(isleofanglesey2)
%manipfile(gwynedd2)
%manipfile(conwy2)
%manipfile(denbighshire2)
%manipfile(flintshire2)
%manipfile(wrexham2)
%manipfile(ceredigion2)
%manipfile(pembrokeshire2)
%manipfile(carmarthenshire2)
%manipfile(swansea2)
%manipfile(neathporttalbot2)
%manipfile(bridgend2)
%manipfile(valeofglamorgan2)
%manipfile(cardiff2)
%manipfile(rhonddacynontaf2)
%manipfile(caerphilly2)
%manipfile(blaenaugwent2)
%manipfile(torfaen2)
%manipfile(monmouthshire2)
%manipfile(newport2)
%manipfile(powys2)
%manipfile(merthyrtydfil2)
%manipfile(northeast2)
%manipfile(northwest2)
%manipfile(yorkshireandhumber2)
%manipfile(eastmidlands2)
%manipfile(westmidlandsregion2)
%manipfile(east2)
%manipfile(london2)
%manipfile(southeast2)
%manipfile(southwest2)
%manipfile(england2)
%manipfile(northernireland2)
%manipfile(scotland2)
%manipfile(wales2)
%manipfile(englandandwales2)
%manipfile(greatbritian2)
%manipfile(unitedkingdom2);


filename myoutfil "&data_area\hartlepool.json" ; data _null_; set work.hartlepool23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\middlesbrough.json" ; data _null_; set work.middlesbrough23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\redcarandcleveland.json" ; data _null_; set work.redcarandcleveland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stocktonontees.json" ; data _null_; set work.stocktonontees23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\darlington.json" ; data _null_; set work.darlington23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\halton.json" ; data _null_; set work.halton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\warrington.json" ; data _null_; set work.warrington23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\blackburnwithdarwen.json" ; data _null_; set work.blackburnwithdarwen23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\blackpool.json" ; data _null_; set work.blackpool23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\kingstonuponhullcityof.json" ; data _null_; set work.kingstonuponhullcityof23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastridingofyorkshire.json" ; data _null_; set work.eastridingofyorkshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northeastlincolnshire.json" ; data _null_; set work.northeastlincolnshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northlincolnshire.json" ; data _null_; set work.northlincolnshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\york.json" ; data _null_; set work.york23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\derby.json" ; data _null_; set work.derby23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\leicester.json" ; data _null_; set work.leicester23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rutland.json" ; data _null_; set work.rutland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\nottingham.json" ; data _null_; set work.nottingham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\herefordshirecountyof.json" ; data _null_; set work.herefordshirecountyof23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\telfordandwrekin.json" ; data _null_; set work.telfordandwrekin23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stokeontrent.json" ; data _null_; set work.stokeontrent23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bathandnortheastsomerset.json" ; data _null_; set work.bathandnortheastsomerset23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bristolcityof.json" ; data _null_; set work.bristolcityof23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northsomerset.json" ; data _null_; set work.northsomerset23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southgloucestershire.json" ; data _null_; set work.southgloucestershire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\plymouth.json" ; data _null_; set work.plymouth23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\torbay.json" ; data _null_; set work.torbay23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bournemouth.json" ; data _null_; set work.bournemouth23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\poole.json" ; data _null_; set work.poole23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\swindon.json" ; data _null_; set work.swindon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\peterborough.json" ; data _null_; set work.peterborough23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\luton.json" ; data _null_; set work.luton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southendonsea.json" ; data _null_; set work.southendonsea23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\thurrock.json" ; data _null_; set work.thurrock23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\medway.json" ; data _null_; set work.medway23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bracknellforest.json" ; data _null_; set work.bracknellforest23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westberkshire.json" ; data _null_; set work.westberkshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\reading.json" ; data _null_; set work.reading23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\slough.json" ; data _null_; set work.slough23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\windsorandmaidenhead.json" ; data _null_; set work.windsorandmaidenhead23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wokingham.json" ; data _null_; set work.wokingham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\miltonkeynes.json" ; data _null_; set work.miltonkeynes23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\brightonandhove.json" ; data _null_; set work.brightonandhove23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\portsmouth.json" ; data _null_; set work.portsmouth23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southampton.json" ; data _null_; set work.southampton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\isleofwight.json" ; data _null_; set work.isleofwight23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\countydurham.json" ; data _null_; set work.countydurham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cheshireeast.json" ; data _null_; set work.cheshireeast23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cheshirewestandchester.json" ; data _null_; set work.cheshirewestandchester23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\shropshire.json" ; data _null_; set work.shropshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cornwall.json" ; data _null_; set work.cornwall23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\islesofscilly.json" ; data _null_; set work.islesofscilly23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wiltshire.json" ; data _null_; set work.wiltshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bedford.json" ; data _null_; set work.bedford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\centralbedfordshire.json" ; data _null_; set work.centralbedfordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northumberland.json" ; data _null_; set work.northumberland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\aylesburyvale.json" ; data _null_; set work.aylesburyvale23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\chiltern.json" ; data _null_; set work.chiltern23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southbucks.json" ; data _null_; set work.southbucks23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wycombe.json" ; data _null_; set work.wycombe23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cambridge.json" ; data _null_; set work.cambridge23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastcambridgeshire.json" ; data _null_; set work.eastcambridgeshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\fenland.json" ; data _null_; set work.fenland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\huntingdonshire.json" ; data _null_; set work.huntingdonshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southcambridgeshire.json" ; data _null_; set work.southcambridgeshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\allerdale.json" ; data _null_; set work.allerdale23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\barrowinfurness.json" ; data _null_; set work.barrowinfurness23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\carlisle.json" ; data _null_; set work.carlisle23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\copeland.json" ; data _null_; set work.copeland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eden.json" ; data _null_; set work.eden23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southlakeland.json" ; data _null_; set work.southlakeland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\ambervalley.json" ; data _null_; set work.ambervalley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bolsover.json" ; data _null_; set work.bolsover23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\chesterfield.json" ; data _null_; set work.chesterfield23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\derbyshiredales.json" ; data _null_; set work.derbyshiredales23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\erewash.json" ; data _null_; set work.erewash23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\highpeak.json" ; data _null_; set work.highpeak23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northeastderbyshire.json" ; data _null_; set work.northeastderbyshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southderbyshire.json" ; data _null_; set work.southderbyshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastdevon.json" ; data _null_; set work.eastdevon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\exeter.json" ; data _null_; set work.exeter23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\middevon.json" ; data _null_; set work.middevon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northdevon.json" ; data _null_; set work.northdevon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southhams.json" ; data _null_; set work.southhams23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\teignbridge.json" ; data _null_; set work.teignbridge23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\torridge.json" ; data _null_; set work.torridge23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westdevon.json" ; data _null_; set work.westdevon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\christchurch.json" ; data _null_; set work.christchurch23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastdorset.json" ; data _null_; set work.eastdorset23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northdorset.json" ; data _null_; set work.northdorset23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\purbeck.json" ; data _null_; set work.purbeck23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westdorset.json" ; data _null_; set work.westdorset23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\weymouthandportland.json" ; data _null_; set work.weymouthandportland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastbourne.json" ; data _null_; set work.eastbourne23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hastings.json" ; data _null_; set work.hastings23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\lewes.json" ; data _null_; set work.lewes23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rother.json" ; data _null_; set work.rother23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wealden.json" ; data _null_; set work.wealden23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\basildon.json" ; data _null_; set work.basildon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\braintree.json" ; data _null_; set work.braintree23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\brentwood.json" ; data _null_; set work.brentwood23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\castlepoint.json" ; data _null_; set work.castlepoint23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\chelmsford.json" ; data _null_; set work.chelmsford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\colchester.json" ; data _null_; set work.colchester23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eppingforest.json" ; data _null_; set work.eppingforest23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\harlow.json" ; data _null_; set work.harlow23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\maldon.json" ; data _null_; set work.maldon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rochford.json" ; data _null_; set work.rochford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\tendring.json" ; data _null_; set work.tendring23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\uttlesford.json" ; data _null_; set work.uttlesford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cheltenham.json" ; data _null_; set work.cheltenham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cotswold.json" ; data _null_; set work.cotswold23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\forestofdean.json" ; data _null_; set work.forestofdean23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\gloucester.json" ; data _null_; set work.gloucester23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stroud.json" ; data _null_; set work.stroud23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\tewkesbury.json" ; data _null_; set work.tewkesbury23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\basingstokeanddeane.json" ; data _null_; set work.basingstokeanddeane23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\easthampshire.json" ; data _null_; set work.easthampshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastleigh.json" ; data _null_; set work.eastleigh23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\fareham.json" ; data _null_; set work.fareham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\gosport.json" ; data _null_; set work.gosport23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hart.json" ; data _null_; set work.hart23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\havant.json" ; data _null_; set work.havant23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\newforest.json" ; data _null_; set work.newforest23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rushmoor.json" ; data _null_; set work.rushmoor23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\testvalley.json" ; data _null_; set work.testvalley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\winchester.json" ; data _null_; set work.winchester23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\broxbourne.json" ; data _null_; set work.broxbourne23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\dacorum.json" ; data _null_; set work.dacorum23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hertsmere.json" ; data _null_; set work.hertsmere23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northhertfordshire.json" ; data _null_; set work.northhertfordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\threerivers.json" ; data _null_; set work.threerivers23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\watford.json" ; data _null_; set work.watford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\ashford.json" ; data _null_; set work.ashford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\canterbury.json" ; data _null_; set work.canterbury23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\dartford.json" ; data _null_; set work.dartford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\dover.json" ; data _null_; set work.dover23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\gravesham.json" ; data _null_; set work.gravesham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\maidstone.json" ; data _null_; set work.maidstone23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\sevenoaks.json" ; data _null_; set work.sevenoaks23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\shepway.json" ; data _null_; set work.shepway23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\swale.json" ; data _null_; set work.swale23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\thanet.json" ; data _null_; set work.thanet23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\tonbridgeandmalling.json" ; data _null_; set work.tonbridgeandmalling23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\tunbridgewells.json" ; data _null_; set work.tunbridgewells23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\burnley.json" ; data _null_; set work.burnley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\chorley.json" ; data _null_; set work.chorley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\fylde.json" ; data _null_; set work.fylde23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hyndburn.json" ; data _null_; set work.hyndburn23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\lancaster.json" ; data _null_; set work.lancaster23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\pendle.json" ; data _null_; set work.pendle23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\preston.json" ; data _null_; set work.preston23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\ribblevalley.json" ; data _null_; set work.ribblevalley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rossendale.json" ; data _null_; set work.rossendale23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southribble.json" ; data _null_; set work.southribble23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westlancashire.json" ; data _null_; set work.westlancashire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wyre.json" ; data _null_; set work.wyre23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\blaby.json" ; data _null_; set work.blaby23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\charnwood.json" ; data _null_; set work.charnwood23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\harborough.json" ; data _null_; set work.harborough23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hinckleyandbosworth.json" ; data _null_; set work.hinckleyandbosworth23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\melton.json" ; data _null_; set work.melton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northwestleicestershire.json" ; data _null_; set work.northwestleicestershire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\oadbyandwigston.json" ; data _null_; set work.oadbyandwigston23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\boston.json" ; data _null_; set work.boston23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastlindsey.json" ; data _null_; set work.eastlindsey23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\lincoln.json" ; data _null_; set work.lincoln23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northkesteven.json" ; data _null_; set work.northkesteven23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southholland.json" ; data _null_; set work.southholland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southkesteven.json" ; data _null_; set work.southkesteven23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westlindsey.json" ; data _null_; set work.westlindsey23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\breckland.json" ; data _null_; set work.breckland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\broadland.json" ; data _null_; set work.broadland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\greatyarmouth.json" ; data _null_; set work.greatyarmouth23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\kingslynnandwestnorfolk.json" ; data _null_; set work.kingslynnandwestnorfolk23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northnorfolk.json" ; data _null_; set work.northnorfolk23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\norwich.json" ; data _null_; set work.norwich23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southnorfolk.json" ; data _null_; set work.southnorfolk23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\corby.json" ; data _null_; set work.corby23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\daventry.json" ; data _null_; set work.daventry23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastnorthamptonshire.json" ; data _null_; set work.eastnorthamptonshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\kettering.json" ; data _null_; set work.kettering23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northampton.json" ; data _null_; set work.northampton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southnorthamptonshire.json" ; data _null_; set work.southnorthamptonshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wellingborough.json" ; data _null_; set work.wellingborough23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\craven.json" ; data _null_; set work.craven23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hambleton.json" ; data _null_; set work.hambleton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\harrogate.json" ; data _null_; set work.harrogate23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\richmondshire.json" ; data _null_; set work.richmondshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\ryedale.json" ; data _null_; set work.ryedale23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\scarborough.json" ; data _null_; set work.scarborough23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\selby.json" ; data _null_; set work.selby23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\ashfield.json" ; data _null_; set work.ashfield23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bassetlaw.json" ; data _null_; set work.bassetlaw23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\broxtowe.json" ; data _null_; set work.broxtowe23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\gedling.json" ; data _null_; set work.gedling23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\mansfield.json" ; data _null_; set work.mansfield23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\newarkandsherwood.json" ; data _null_; set work.newarkandsherwood23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rushcliffe.json" ; data _null_; set work.rushcliffe23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cherwell.json" ; data _null_; set work.cherwell23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\oxford.json" ; data _null_; set work.oxford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southoxfordshire.json" ; data _null_; set work.southoxfordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\valeofwhitehorse.json" ; data _null_; set work.valeofwhitehorse23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westoxfordshire.json" ; data _null_; set work.westoxfordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\mendip.json" ; data _null_; set work.mendip23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\sedgemoor.json" ; data _null_; set work.sedgemoor23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southsomerset.json" ; data _null_; set work.southsomerset23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\tauntondeane.json" ; data _null_; set work.tauntondeane23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westsomerset.json" ; data _null_; set work.westsomerset23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cannockchase.json" ; data _null_; set work.cannockchase23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eaststaffordshire.json" ; data _null_; set work.eaststaffordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\lichfield.json" ; data _null_; set work.lichfield23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\newcastleunderlyme.json" ; data _null_; set work.newcastleunderlyme23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southstaffordshire.json" ; data _null_; set work.southstaffordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stafford.json" ; data _null_; set work.stafford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\staffordshiremoorlands.json" ; data _null_; set work.staffordshiremoorlands23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\tamworth.json" ; data _null_; set work.tamworth23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\babergh.json" ; data _null_; set work.babergh23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\forestheath.json" ; data _null_; set work.forestheath23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\ipswich.json" ; data _null_; set work.ipswich23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\midsuffolk.json" ; data _null_; set work.midsuffolk23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stedmundsbury.json" ; data _null_; set work.stedmundsbury23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\suffolkcoastal.json" ; data _null_; set work.suffolkcoastal23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\waveney.json" ; data _null_; set work.waveney23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\elmbridge.json" ; data _null_; set work.elmbridge23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\epsomandewell.json" ; data _null_; set work.epsomandewell23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\guildford.json" ; data _null_; set work.guildford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\molevalley.json" ; data _null_; set work.molevalley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\reigateandbanstead.json" ; data _null_; set work.reigateandbanstead23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\runnymede.json" ; data _null_; set work.runnymede23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\spelthorne.json" ; data _null_; set work.spelthorne23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\surreyheath.json" ; data _null_; set work.surreyheath23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\tandridge.json" ; data _null_; set work.tandridge23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\waverley.json" ; data _null_; set work.waverley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\woking.json" ; data _null_; set work.woking23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northwarwickshire.json" ; data _null_; set work.northwarwickshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\nuneatonandbedworth.json" ; data _null_; set work.nuneatonandbedworth23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rugby.json" ; data _null_; set work.rugby23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stratfordonavon.json" ; data _null_; set work.stratfordonavon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\warwick.json" ; data _null_; set work.warwick23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\adur.json" ; data _null_; set work.adur23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\arun.json" ; data _null_; set work.arun23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\chichester.json" ; data _null_; set work.chichester23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\crawley.json" ; data _null_; set work.crawley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\horsham.json" ; data _null_; set work.horsham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\midsussex.json" ; data _null_; set work.midsussex23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\worthing.json" ; data _null_; set work.worthing23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bromsgrove.json" ; data _null_; set work.bromsgrove23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\malvernhills.json" ; data _null_; set work.malvernhills23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\redditch.json" ; data _null_; set work.redditch23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\worcester.json" ; data _null_; set work.worcester23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wychavon.json" ; data _null_; set work.wychavon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wyreforest.json" ; data _null_; set work.wyreforest23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stalbans.json" ; data _null_; set work.stalbans23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\welwynhatfield.json" ; data _null_; set work.welwynhatfield23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\easthertfordshire.json" ; data _null_; set work.easthertfordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stevenage.json" ; data _null_; set work.stevenage23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bolton.json" ; data _null_; set work.bolton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bury.json" ; data _null_; set work.bury23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\manchester.json" ; data _null_; set work.manchester23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\oldham.json" ; data _null_; set work.oldham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rochdale.json" ; data _null_; set work.rochdale23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\salford.json" ; data _null_; set work.salford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stockport.json" ; data _null_; set work.stockport23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\tameside.json" ; data _null_; set work.tameside23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\trafford.json" ; data _null_; set work.trafford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wigan.json" ; data _null_; set work.wigan23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\knowsley.json" ; data _null_; set work.knowsley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\liverpool.json" ; data _null_; set work.liverpool23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\sthelens.json" ; data _null_; set work.sthelens23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\sefton.json" ; data _null_; set work.sefton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wirral.json" ; data _null_; set work.wirral23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\barnsley.json" ; data _null_; set work.barnsley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\doncaster.json" ; data _null_; set work.doncaster23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rotherham.json" ; data _null_; set work.rotherham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\sheffield.json" ; data _null_; set work.sheffield23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\newcastleupontyne.json" ; data _null_; set work.newcastleupontyne23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northtyneside.json" ; data _null_; set work.northtyneside23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southtyneside.json" ; data _null_; set work.southtyneside23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\sunderland.json" ; data _null_; set work.sunderland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\birmingham.json" ; data _null_; set work.birmingham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\coventry.json" ; data _null_; set work.coventry23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\dudley.json" ; data _null_; set work.dudley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\sandwell.json" ; data _null_; set work.sandwell23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\solihull.json" ; data _null_; set work.solihull23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\walsall.json" ; data _null_; set work.walsall23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wolverhampton.json" ; data _null_; set work.wolverhampton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bradford.json" ; data _null_; set work.bradford23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\calderdale.json" ; data _null_; set work.calderdale23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\kirklees.json" ; data _null_; set work.kirklees23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\leeds.json" ; data _null_; set work.leeds23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wakefield.json" ; data _null_; set work.wakefield23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\gateshead.json" ; data _null_; set work.gateshead23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cityoflondon.json" ; data _null_; set work.cityoflondon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\barkinganddagenham.json" ; data _null_; set work.barkinganddagenham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\barnet.json" ; data _null_; set work.barnet23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bexley.json" ; data _null_; set work.bexley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\brent.json" ; data _null_; set work.brent23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bromley.json" ; data _null_; set work.bromley23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\camden.json" ; data _null_; set work.camden23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\croydon.json" ; data _null_; set work.croydon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\ealing.json" ; data _null_; set work.ealing23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\enfield.json" ; data _null_; set work.enfield23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\greenwich.json" ; data _null_; set work.greenwich23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hackney.json" ; data _null_; set work.hackney23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hammersmithandfulham.json" ; data _null_; set work.hammersmithandfulham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\haringey.json" ; data _null_; set work.haringey23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\harrow.json" ; data _null_; set work.harrow23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\havering.json" ; data _null_; set work.havering23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hillingdon.json" ; data _null_; set work.hillingdon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hounslow.json" ; data _null_; set work.hounslow23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\islington.json" ; data _null_; set work.islington23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\kensingtonandchelsea.json" ; data _null_; set work.kensingtonandchelsea23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\kingstonuponthames.json" ; data _null_; set work.kingstonuponthames23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\lambeth.json" ; data _null_; set work.lambeth23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\lewisham.json" ; data _null_; set work.lewisham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\merton.json" ; data _null_; set work.merton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\newham.json" ; data _null_; set work.newham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\redbridge.json" ; data _null_; set work.redbridge23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\richmonduponthames.json" ; data _null_; set work.richmonduponthames23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southwark.json" ; data _null_; set work.southwark23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\sutton.json" ; data _null_; set work.sutton23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\towerhamlets.json" ; data _null_; set work.towerhamlets23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\walthamforest.json" ; data _null_; set work.walthamforest23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wandsworth.json" ; data _null_; set work.wandsworth23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westminster.json" ; data _null_; set work.westminster23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\buckinghamshire.json" ; data _null_; set work.buckinghamshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cambridgeshire.json" ; data _null_; set work.cambridgeshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cumbria.json" ; data _null_; set work.cumbria23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\derbyshire.json" ; data _null_; set work.derbyshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\devon.json" ; data _null_; set work.devon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\dorset.json" ; data _null_; set work.dorset23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastsussex.json" ; data _null_; set work.eastsussex23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\essex.json" ; data _null_; set work.essex23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\gloucestershire.json" ; data _null_; set work.gloucestershire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hampshire.json" ; data _null_; set work.hampshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\hertfordshire.json" ; data _null_; set work.hertfordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\kent.json" ; data _null_; set work.kent23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\lancashire.json" ; data _null_; set work.lancashire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\leicestershire.json" ; data _null_; set work.leicestershire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\lincolnshire.json" ; data _null_; set work.lincolnshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\norfolk.json" ; data _null_; set work.norfolk23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northamptonshire.json" ; data _null_; set work.northamptonshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northyorkshire.json" ; data _null_; set work.northyorkshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\nottinghamshire.json" ; data _null_; set work.nottinghamshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\oxfordshire.json" ; data _null_; set work.oxfordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\somerset.json" ; data _null_; set work.somerset23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\staffordshire.json" ; data _null_; set work.staffordshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\suffolk.json" ; data _null_; set work.suffolk23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\surrey.json" ; data _null_; set work.surrey23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\warwickshire.json" ; data _null_; set work.warwickshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westsussex.json" ; data _null_; set work.westsussex23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\worcestershire.json" ; data _null_; set work.worcestershire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\greatermanchester.json" ; data _null_; set work.greatermanchester23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\merseyside.json" ; data _null_; set work.merseyside23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southyorkshire.json" ; data _null_; set work.southyorkshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westmidlands.json" ; data _null_; set work.westmidlands23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westyorkshire.json" ; data _null_; set work.westyorkshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\tyneandwear.json" ; data _null_; set work.tyneandwear23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\antrimandnewtownabbey.json" ; data _null_; set work.antrimandnewtownabbey23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\armaghcitybanbridgeandcraigavon.json" ; data _null_; set work.armaghcitybanbridgeandcraigavon23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\belfast.json" ; data _null_; set work.belfast23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\causewaycoastandglens.json" ; data _null_; set work.causewaycoastandglens23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\derrycityandstrabane.json" ; data _null_; set work.derrycityandstrabane23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\fermanaghandomagh.json" ; data _null_; set work.fermanaghandomagh23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\lisburnandcastlereagh.json" ; data _null_; set work.lisburnandcastlereagh23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\midandeastantrim.json" ; data _null_; set work.midandeastantrim23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\midulster.json" ; data _null_; set work.midulster23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\newrymourneanddown.json" ; data _null_; set work.newrymourneanddown23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\ardsandnorthdown.json" ; data _null_; set work.ardsandnorthdown23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\clackmannanshire.json" ; data _null_; set work.clackmannanshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\dumfriesandgalloway.json" ; data _null_; set work.dumfriesandgalloway23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastayrshire.json" ; data _null_; set work.eastayrshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastlothian.json" ; data _null_; set work.eastlothian23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastrenfrewshire.json" ; data _null_; set work.eastrenfrewshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\naheileanansiar.json" ; data _null_; set work.naheileanansiar23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\falkirk.json" ; data _null_; set work.falkirk23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\fife.json" ; data _null_; set work.fife23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\highland.json" ; data _null_; set work.highland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\inverclyde.json" ; data _null_; set work.inverclyde23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\midlothian.json" ; data _null_; set work.midlothian23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\moray.json" ; data _null_; set work.moray23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northayrshire.json" ; data _null_; set work.northayrshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\orkneyislands.json" ; data _null_; set work.orkneyislands23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\perthandkinross.json" ; data _null_; set work.perthandkinross23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\scottishborders.json" ; data _null_; set work.scottishborders23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\shetlandislands.json" ; data _null_; set work.shetlandislands23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southayrshire.json" ; data _null_; set work.southayrshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southlanarkshire.json" ; data _null_; set work.southlanarkshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\stirling.json" ; data _null_; set work.stirling23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\aberdeencity.json" ; data _null_; set work.aberdeencity23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\aberdeenshire.json" ; data _null_; set work.aberdeenshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\argyllandbute.json" ; data _null_; set work.argyllandbute23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cityofedinburgh.json" ; data _null_; set work.cityofedinburgh23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\renfrewshire.json" ; data _null_; set work.renfrewshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westdunbartonshire.json" ; data _null_; set work.westdunbartonshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westlothian.json" ; data _null_; set work.westlothian23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\angus.json" ; data _null_; set work.angus23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\dundeecity.json" ; data _null_; set work.dundeecity23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northlanarkshire.json" ; data _null_; set work.northlanarkshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastdunbartonshire.json" ; data _null_; set work.eastdunbartonshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\glasgowcity.json" ; data _null_; set work.glasgowcity23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\isleofanglesey.json" ; data _null_; set work.isleofanglesey23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\gwynedd.json" ; data _null_; set work.gwynedd23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\conwy.json" ; data _null_; set work.conwy23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\denbighshire.json" ; data _null_; set work.denbighshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\flintshire.json" ; data _null_; set work.flintshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wrexham.json" ; data _null_; set work.wrexham23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\ceredigion.json" ; data _null_; set work.ceredigion23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\pembrokeshire.json" ; data _null_; set work.pembrokeshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\carmarthenshire.json" ; data _null_; set work.carmarthenshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\swansea.json" ; data _null_; set work.swansea23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\neathporttalbot.json" ; data _null_; set work.neathporttalbot23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\bridgend.json" ; data _null_; set work.bridgend23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\valeofglamorgan.json" ; data _null_; set work.valeofglamorgan23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\cardiff.json" ; data _null_; set work.cardiff23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\rhonddacynontaf.json" ; data _null_; set work.rhonddacynontaf23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\caerphilly.json" ; data _null_; set work.caerphilly23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\blaenaugwent.json" ; data _null_; set work.blaenaugwent23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\torfaen.json" ; data _null_; set work.torfaen23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\monmouthshire.json" ; data _null_; set work.monmouthshire23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\newport.json" ; data _null_; set work.newport23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\powys.json" ; data _null_; set work.powys23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\merthyrtydfil.json" ; data _null_; set work.merthyrtydfil23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northeast.json" ; data _null_; set work.northeast23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northwest.json" ; data _null_; set work.northwest23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\yorkshireandhumber.json" ; data _null_; set work.yorkshireandhumber23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\eastmidlands.json" ; data _null_; set work.eastmidlands23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\westmidlandsregion.json" ; data _null_; set work.westmidlandsregion23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\east.json" ; data _null_; set work.east23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\london.json" ; data _null_; set work.london23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southeast.json" ; data _null_; set work.southeast23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\southwest.json" ; data _null_; set work.southwest23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\england.json" ; data _null_; set work.england23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\northernireland.json" ; data _null_; set work.northernireland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\scotland.json" ; data _null_; set work.scotland23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\wales.json" ; data _null_; set work.wales23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\englandandwales.json" ; data _null_; set work.englandandwales23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\greatbritian.json" ; data _null_; set work.greatbritian23; file myoutfil lrecl=32767; put VAR1; run;
filename myoutfil "&data_area\unitedkingdom.json" ; data _null_; set work.unitedkingdom23; file myoutfil lrecl=32767; put VAR1; run;

