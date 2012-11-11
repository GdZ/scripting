/**
 * 
 */
var RISrvrUri = '/VR5SIF/v2/';
var SIF_Server = 'http://ss-auto-centos-9.cisco.com:8080';

var btnCllPtr = 'button.call', btnClrPtr = 'button.clear'; 

var quickieViewerHdlr = $('#QuickieViewer');
var searchHdlr = $('#SearchViewer');
var searchAheadHdlr = $('#SearchAheadViewer');
var addFavoritesHdlr = $('#AddFavoritesViewer');
var getFavoritesHdlr = $('#GetFavoritesViewer');
var removeFavoritesHdlr = $('#RemoveFavoritesViewer');
var getRegionsHdlr = $('#GetRegionsViewer');
var getChannelsHdlr = $('#GetChannelsViewer');
var getChannelsByChannelPksHdlr = $('#GetChannelsByChannelPksViewer');
var getSchedulesHdlr = $('#GetSchedulesViewer');
var getPurchaseHistoryHdlr = $('#GetPurchaseHistoryViewer');
var purchaseHdlr = $('#PurchaseViewer');
var getAllGenreHdlr = $('#GetAllGenreViewer');
var getAllVideoContentTypesHdlr = $('#GetAllVideoContentTypesViewer');
var getProvidersHdlr = $('#GetProvidersViewer');
var getSubscriptinsBySubKeyHdlr = $('#GetSubscriptinsBySubKeyViewer');
var getProviderDetailsHdlr = $('#GetProviderDetailsViewer');
    
    // New APIs
var getCategoryHdlr = $('#GetCategoryViewer');
var getCategorySubHdlr = $('#GetCategorySubViewer');
var getCategoryByIdHdlr = $('#GetCategoryByIdViewer');
var getProductBySkuHdlr = $('#GetProductBySkuViewer');

var addBlockedChannelsHdlr = $('#AddBlockedChannelsViewer');
var deleteBlockedChannelsHdlr = $('#DeleteBlockedChannelsViewer');

var getProductRecommendedBySkuHdlr = $('#GetProductRecommendedBySkuViewer');
var getProductsHdlr = $('#GetProductsViewer');
var getRatingsParentalControlsHdlr = $('#GetRatingsParentalControlsViewer');
var loginHdlr = $('#LoginViewer');
var logoutHdlr = $('#LogoutViewer');
var changePasswordHdlr = $('#ChangePasswordViewer');
var resetPasswordHdlr = $('#ResetPasswordViewer');
var resetPasswordValidateHdlr = $('#ResetPasswordValidateViewer');
var getProfileHdlr = $('#GetProfileViewer');
var updateProfileHdlr = $('#UpdateProfileViewer');
var getSchedulesByChannelIdsHdlr = $('#GetSchedulesByChannelIdsViewer');
var getEntitlementsHdlr = $('#GetEntitlementsViewer');
var deleteEntitlementsHdlr = $('#DeleteEntitlementsViewer');
var getSettingsHdlr = $('#GetSettingsViewer');
var getSettingsParentalRatingsHdlr = $('#GetSettingsParentalRatingsViewer');
var registerHdlr = $('#RegisterViewer');
var updateSettingsParentalRatingsHdlr = $('#UpdateSettingsParentalRatingsViewer');
var updateAccountPinsHdlr = $('#UpdateAccountPinsViewer');
var createUser = $('#CreateUserViewer');
var getBookmarksHdlr = $('#GetBookmarksViewer');
var addBookmarkHdlr = $('#AddBookmarkViewer');
var deleteBookmarkHdlr = $('#DeleteBookmarkViewer');
var	addDeviceHdlr = $('#AddDeviceViewer');
var	updateDeviceHdlr = $('#UpdateDeviceViewer');
var	deleteDeviceHdlr = $('#DeleteDeviceViewer');
var	getAccountDevicesHdlr = $('#GetAccountDevicesViewer');
var deleteUserHdlr = $('#DeleteUserViewer');
var getProgramScheduleHdlr = $('#GetProgramScheduleViewer');
var getModifiedSchedulesHdlr = $('#GetModifiedSchedulesViewer');
	    
var searchCallEvt = $('div.Search').find(btnCllPtr);
var searchClearEvt = $('div.Search').find(btnClrPtr);
var searchAheadCallEvt = $('div.SearchAhead').find(btnCllPtr);
var searchAheadClearEvt = $('div.SearchAhead').find(btnClrPtr);
var addFavoritesCallEvt = $('div.AddFavorites').find(btnCllPtr);
var addFavoritesClearEvt = $('div.AddFavorites').find(btnClrPtr);
var getFavoritesCallEvt = $('div.GetFavorites').find(btnCllPtr);
var getFavoritesClearEvt = $('div.GetFavorites').find(btnClrPtr);
var removeFavoritesCallEvt = $('div.RemoveFavorites').find(btnCllPtr);
var removeFavoritesClearEvt = $('div.RemoveFavorites').find(btnClrPtr);
var getRegionsCallEvt = $('div.GetRegions').find(btnCllPtr);
var getRegionsClearEvt = $('div.GetRegions').find(btnClrPtr);
var getChannelsCallEvt = $('div.GetChannels').find(btnCllPtr);
var getChannelsClearEvt = $('div.GetChannels').find(btnClrPtr);
var getChannelsByChannelPksCallEvt = $('div.GetChannelsByChannelPks').find(btnCllPtr);
var getChannelsByChannelPksClearEvt = $('div.GetChannelsByChannelPks').find(btnClrPtr);
var getSchedulesCallEvt = $('div.GetSchedules').find(btnCllPtr);
var getSchedulesClearEvt = $('div.GetSchedules').find(btnClrPtr);
var getPurchaseHistoryCallEvt = $('div.GetPurchaseHistory').find(btnCllPtr);
var getPurchaseHistoryClearEvt = $('div.GetPurchaseHistory').find(btnClrPtr);
var purchaseCallEvt = $('div.Purchase').find(btnCllPtr);
var purchaseClearEvt = $('div.Purchase').find(btnClrPtr);
var getAllGenreCallEvt = $('div.GetAllGenre').find(btnCllPtr);
var getAllGenreClearEvt = $('div.GetAllGenre').find(btnClrPtr);
var getAllVideoContentTypesCallEvt = $('div.GetAllVideoContentTypes').find(btnCllPtr);
var getAllVideoContentTypesClearEvt = $('div.GetAllVideoContentTypes').find(btnClrPtr);

	// New APIs
var	getCategoryCallEvt = $('div.GetCategory').find(btnCllPtr);
var	getCategoryClearEvt = $('div.GetCategory').find(btnClrPtr);
var	getCategorySubCallEvt = $('div.GetCategorySubscriptions').find(btnCllPtr);
var	getCategorySubClearEvt = $('div.GetCategorySubscriptions').find(btnClrPtr);
var	getCategoryByIdCallEvt = $('div.GetCategoryById').find(btnCllPtr);
var	getCategoryByIdClearEvt = $('div.GetCategoryById').find(btnClrPtr);
var	getProductBySkuCallEvt = $('div.GetProductBySku').find(btnCllPtr);
var	getProductBySkuClearEvt = $('div.GetProductBySku').find(btnClrPtr);
var	addDeviceCallEvt = $('div.AddDevice').find(btnCllPtr);
var	addDeviceClearEvt = $('div.AddDevice').find(btnClrPtr);
var	updateDeviceCallEvt = $('div.UpdateDevice').find(btnCllPtr);
var	updateDeviceClearEvt = $('div.UpdateDevice').find(btnClrPtr);
var	deleteDeviceCallEvt = $('div.DeleteDevice').find(btnCllPtr);
var	deleteDeviceClearEvt = $('div.DeleteDevice').find(btnClrPtr);
var	getAccountDevicesCallEvt = $('div.GetAccountDevices').find(btnCllPtr);
var	getAccountDevicesClearEvt = $('div.GetAccountDevices').find(btnClrPtr);
var	getSubscriptinsBySubKeyCallEvt = $('div.GetSubscriptinsBySubKey').find(btnCllPtr);
var	getSubscriptinsBySubKeyClearEvt = $('div.GetSubscriptinsBySubKey').find(btnClrPtr);



var	addBlockedChannelsCallEvt = $('div.AddBlockedChannels').find(btnCllPtr);
var	addBlockedChannelsClearEvt = $('div.AddBlockedChannels').find(btnClrPtr);

var	deleteBlockedChannelsCallEvt = $('div.DeleteBlockedChannels').find(btnCllPtr);
var	deleteBlockedChannelsClearEvt = $('div.DeleteBlockedChannels').find(btnClrPtr);

var	getProductRecommendedBySkuCallEvt = $('div.GetProductRecommendedBySku').find(btnCllPtr);
var	getProductRecommendedBySkuClearEvt = $('div.GetProductRecommendedBySku').find(btnClrPtr);
var	getProductsCallEvt = $('div.GetProducts').find(btnCllPtr);
var	getProductsClearEvt = $('div.GetProducts').find(btnClrPtr);
var	getRatingsParentalControlsCallEvt = $('div.GetRatingsParentalControls').find(btnCllPtr);
var	getRatingsParentalControlsClearEvt = $('div.GetRatingsParentalControls').find(btnClrPtr);
var	loginCallEvt = $('div.Login').find(btnCllPtr);
var	loginClearEvt = $('div.Login').find(btnClrPtr);
var	logoutCallEvt = $('div.Logout').find(btnCllPtr);
var	logoutClearEvt = $('div.Logout').find(btnClrPtr);
var	changePasswordCallEvt = $('div.ChangePassword').find(btnCllPtr);
var	changePasswordClearEvt = $('div.ChangePassword').find(btnClrPtr);
var	resetPasswordCallEvt = $('div.ResetPassword').find(btnCllPtr);
var	resetPasswordClearEvt = $('div.ResetPassword').find(btnClrPtr);
var	resetPasswordValidateCallEvt = $('div.ResetPasswordValidate').find(btnCllPtr);
var	resetPasswordValidateClearEvt = $('div.ResetPasswordValidate').find(btnClrPtr);
var	getProfileCallEvt = $('div.GetProfile').find(btnCllPtr);
var	getProfileClearEvt = $('div.GetProfile').find(btnClrPtr);
var	updateProfileCallEvt = $('div.UpdateProfile').find(btnCllPtr);
var	updateProfileClearEvt = $('div.UpdateProfile').find(btnClrPtr);
var	getSchedulesByChannelIdsCallEvt = $('div.GetSchedulesByChannelIds').find(btnCllPtr);
var	getSchedulesByChannelIdsClearEvt = $('div.GetSchedulesByChannelIds').find(btnClrPtr);
var	getEntitlementsCallEvt = $('div.GetEntitlements').find(btnCllPtr);
var	getEntitlementsClearEvt = $('div.GetEntitlements').find(btnClrPtr);
var	deleteEntitlementsCallEvt = $('div.DeleteEntitlements').find(btnCllPtr);
var	deleteEntitlementsClearEvt = $('div.DeleteEntitlements').find(btnClrPtr);
var	getSettingsCallEvt = $('div.GetSettings').find(btnCllPtr);
var	getSettingsClearEvt = $('div.GetSettings').find(btnClrPtr);
var	getSettingsParentalRatingsCallEvt = $('div.GetSettingsParentalRatings').find(btnCllPtr);
var	getSettingsParentalRatingsClearEvt = $('div.GetSettingsParentalRatings').find(btnClrPtr);
var	registerCallEvt = $('div.Register').find(btnCllPtr);
var	registerClearEvt = $('div.Register').find(btnClrPtr);
var	updateSettingsParentalRatingsCallEvt = $('div.UpdateSettingsParentalRatings').find(btnCllPtr);
var	updateSettingsParentalRatingsClearEvt = $('div.UpdateSettingsParentalRatings').find(btnClrPtr);
var	updateAccountPinsCallEvt = $('div.UpdateAccountPins').find(btnCllPtr);
var	updateAccountPinsClearEvt = $('div.UpdateAccountPins').find(btnClrPtr);
var	createUserCallEvt = $('div.CreateUser').find(btnCllPtr);
var	createUserClearEvt = $('div.CreateUser').find(btnClrPtr);
var	getBookmarksCallEvt = $('div.GetBookmarks').find(btnCllPtr);
var	getBookmarksClearEvt = $('div.GetBookmarks').find(btnClrPtr);
var	addBookmarkCallEvt = $('div.AddBookmark').find(btnCllPtr);
var	addBookmarkClearEvt = $('div.AddBookmark').find(btnClrPtr);
var	deleteBookmarkCallEvt = $('div.DeleteBookmark').find(btnCllPtr);
var	deleteBookmarkClearEvt = $('div.DeleteBookmark').find(btnClrPtr);
var deleteUserCallEvt = $('div.DeleteUser').find(btnCllPtr);
var deleteUserClearEvt = $('div.DeleteUser').find(btnClrPtr);
var getProgramScheduleCallEvt = $('div.GetProgramSchedule').find(btnCllPtr);
var getProgramScheduleClearEvt = $('div.GetProgramSchedule').find(btnClrPtr);
var	getModifiedSchedulesCallEvt = $('div.GetModifiedSchedules').find(btnCllPtr);
var	getModifiedSchedulesClearEvt = $('div.GetModifiedSchedules').find(btnClrPtr);
var getProvidersCallEvt = $('div.GetProviders').find(btnCllPtr);
var getProvidersClearEvt = $('div.GetProviders').find(btnClrPtr);
var getProviderDetailsCallEvt = $('div.GetProviderDetails').find(btnCllPtr);
var getProviderDetailsClearEvt = $('div.GetProviderDetails').find(btnClrPtr);

//HERRY
var getVodPlayBackCallEvt = $('div.GetVodPlayBack').find(btnCllPtr);
getVodPlayBackCallEvt.bind('click',function () {getVodPlayBack();});
var getVodPlayBackCallEvt = $('div.GetVodPlayBack').find(btnClrPtr);
getVodPlayBackCallEvt.bind('click',function () {getVodPlayBackClear();});
//
	
  searchCallEvt.bind('click', function () { doSearch();});
  searchClearEvt.bind('click', function () { clearSearch();});
  
  searchAheadCallEvt.bind('click', function () { doSearchAhead();});
  searchAheadClearEvt.bind('click', function () { clearSearchAhead();});
  	    
  addFavoritesCallEvt.bind('click', function () { addFavorites();});
  addFavoritesClearEvt.bind('click', function () { clearaddFavorites();}); 	   
  	    
  getFavoritesCallEvt.bind('click', function () { getFavorites();});
  getFavoritesClearEvt.bind('click', function () { clearGetFavorites();});     
        
  removeFavoritesCallEvt.bind('click', function () { removeFavorites();});
  removeFavoritesClearEvt.bind('click', function () { clearremoveFavorites();});      
        
  getRegionsCallEvt.bind('click', function () { getRegions();});
  getRegionsClearEvt.bind('click', function () { clearGetRegions();});
        
  getChannelsCallEvt.bind('click', function () { getChannels();});
  getChannelsClearEvt.bind('click', function () { clearGetChannels();});       

  getChannelsByChannelPksCallEvt.bind('click', function () { getChannelsByChannelPks();});
  getChannelsByChannelPksClearEvt.bind('click', function () { clearGetChannelsByChannelPks();});       

  getSchedulesCallEvt.bind('click', function () { getSchedules();});
  getSchedulesClearEvt.bind('click', function () { clearGetSchedules();}); 
    
  getPurchaseHistoryCallEvt.bind('click', function () { getPurchaseHistory();});
  getPurchaseHistoryClearEvt.bind('click', function () { clearGetPurchaseHistory();});     
    
  purchaseCallEvt.bind('click', function () { purchase();});
  purchaseClearEvt.bind('click', function () { clearPurchase();});   
  
  getAllGenreCallEvt.bind('click', function () { getAllGenre();});
  getAllGenreClearEvt.bind('click', function () { clearGetAllGenre();});
  
  getAllVideoContentTypesCallEvt.bind('click', function () { getAllVideoContentTypes();});
  getAllVideoContentTypesClearEvt.bind('click', function () { clearGetAllVideoContentTypes();});    

  // New APIs
  getCategoryCallEvt.bind('click', function () { getCategory();});
  getCategoryClearEvt.bind('click', function () { clearGetCategory();}); 
  getCategorySubCallEvt.bind('click', function () { getCategorySubscriptions();});
  getCategorySubClearEvt.bind('click', function () { clearGetCategorySubscriptions();});
  getCategoryByIdCallEvt.bind('click', function () { getCategoryById();});
  getCategoryByIdClearEvt.bind('click', function () { clearGetCategoryById();});    
  getProductBySkuCallEvt.bind('click', function () { getProductBySku();});
  getProductBySkuClearEvt.bind('click', function () { clearGetProductBySku();});    

  addBlockedChannelsCallEvt.bind('click', function () { addBlockedChannels();});
  addBlockedChannelsClearEvt.bind('click', function () { clearAddBlockedChannels();}); 
  
  deleteBlockedChannelsCallEvt.bind('click', function () { deleteBlockedChannels();});
  deleteBlockedChannelsClearEvt.bind('click', function () { clearDeleteBlockedChannels();});

  getProductRecommendedBySkuCallEvt.bind('click', function () { getProductRecommendedBySku();});
  getProductRecommendedBySkuClearEvt.bind('click', function () { clearGetProductRecommendedBySku();});    
  getProductsCallEvt.bind('click', function () { getProducts();});
  getProductsClearEvt.bind('click', function () { clearGetProducts();});    
  getRatingsParentalControlsCallEvt.bind('click', function () { getRatingsParentalControls();});
  getRatingsParentalControlsClearEvt.bind('click', function () { clearGetRatingsParentalControls();});    
  loginCallEvt.bind('click', function () { login();});
  loginClearEvt.bind('click', function () { clearLogin();});    
  logoutCallEvt.bind('click', function () { logout();});
  logoutClearEvt.bind('click', function () { clearLogout();});    
  changePasswordCallEvt.bind('click', function () { changePassword();});
  changePasswordClearEvt.bind('click', function () { clearChangePassword();});    
  resetPasswordCallEvt.bind('click', function () { resetPassword();});
  resetPasswordClearEvt.bind('click', function () { clearResetPassword();});    
  resetPasswordValidateCallEvt.bind('click', function () { resetPasswordValidate();});
  resetPasswordValidateClearEvt.bind('click', function () { clearResetPasswordValidate();});    
  getProfileCallEvt.bind('click', function () { getProfile();});
  getProfileClearEvt.bind('click', function () { clearGetProfile();});    
  updateProfileCallEvt.bind('click', function () { updateProfile();});
  updateProfileClearEvt.bind('click', function () { clearUpdateProfile();});    
  getSchedulesByChannelIdsCallEvt.bind('click', function () { getSchedulesByChannelIds();});
  getSchedulesByChannelIdsClearEvt.bind('click', function () { clearGetSchedulesByChannelIds();});    
  getEntitlementsCallEvt.bind('click', function () { getEntitlements();});
  getEntitlementsClearEvt.bind('click', function () { clearGetEntitlements();});
  deleteEntitlementsCallEvt.bind('click', function () { deleteEntitlements();});
  deleteEntitlementsClearEvt.bind('click', function () { clearDeleteEntitlements();});
  getSettingsCallEvt.bind('click', function () { getSettings();});
  getSettingsClearEvt.bind('click', function () { clearGetSettings();});    
  getSettingsParentalRatingsCallEvt.bind('click', function () { getSettingsParentalRatings();});
  getSettingsParentalRatingsClearEvt.bind('click', function () { clearGetSettingsParentalRatings();});    
  registerCallEvt.bind('click', function () { register();});
  registerClearEvt.bind('click', function () { clearRegister();});    
  updateSettingsParentalRatingsCallEvt.bind('click', function () { updateSettingsParentalRatings();});
  updateSettingsParentalRatingsClearEvt.bind('click', function () { clearUpdateSettingsParentalRatings();});  
  updateAccountPinsCallEvt.bind('click', function () { updateAccountPins();});
  updateAccountPinsClearEvt.bind('click', function () { clearUpdateAccountPins();});  
  createUserCallEvt.bind('click', function () { callCreateUser();});
  createUserClearEvt.bind('click', function () { clearCreateUser();});
  addBookmarkCallEvt.bind('click', function () { callAddBookmark();});
  addBookmarkClearEvt.bind('click', function () { clearAddBookmark();});
  deleteBookmarkCallEvt.bind('click', function () { callDeleteBookmark();});
  deleteBookmarkClearEvt.bind('click', function () { clearDeleteBookmark();});  
  getBookmarksCallEvt.bind('click', function () { getBookmarks();});
  getBookmarksClearEvt.bind('click', function () { clearGetBookmarks();});
  addDeviceCallEvt.bind('click', function () { callAddDevice();});
  addDeviceClearEvt.bind('click', function () { clearAddDevice();});
  deleteUserCallEvt.bind('click', function () { callDeleteUser();});
  deleteUserClearEvt.bind('click', function () { clearDeleteUser();});
  getProgramScheduleCallEvt.bind('click', function () { callGetProgramSchedule();});
  getProgramScheduleClearEvt.bind('click', function () { clearGetProgramSchedule();});
  getModifiedSchedulesCallEvt.bind('click', function () { callGetModifiedSchedules();});
  getModifiedSchedulesClearEvt.bind('click', function () { clearGetModifiedSchedules();});
  deleteDeviceCallEvt.bind('click', function () { callDeleteDevice();});
  deleteDeviceClearEvt.bind('click', function () { clearDeleteDevice();});
  updateDeviceCallEvt.bind('click', function () { callUpdateDevice();});
  updateDeviceClearEvt.bind('click', function () { clearUpdateDevice();});
  getAccountDevicesCallEvt.bind('click', function () { callGetAccountDevices();});
  getAccountDevicesClearEvt.bind('click', function () { clearGetAccountDevices();});
  getProvidersCallEvt.bind('click', function () { getProviders();});
  getProvidersClearEvt.bind('click', function () { clearGetProviders();});
  getProviderDetailsCallEvt.bind('click', function () { getProviderDetails();});
  getProviderDetailsClearEvt.bind('click', function () { clearGetProviderDetails();});
  getSubscriptinsBySubKeyCallEvt.bind('click', function () { getSubscriptinsBySubKey();});
  getSubscriptinsBySubKeyClearEvt.bind('click', function () { clearGetSubscriptinsBySubKey();});
 
  

function responseHdlr(response, status, xhr) {
	if (status == "error") {
		var msg = "Sorry but there was an error: ";

		$("#rpcStatus").html(msg + xhr.status + " " + xhr.statusText);

		return;
	}
	$("#rpcStatus").html('Success!');
}
function syntaxHighlight(json) {
    json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
    return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
        var cls = 'number';
        if (/^"/.test(match)) {
            if (/:$/.test(match)) {
                cls = 'key';
            } else {
                cls = 'string';
            }
        } else if (/true|false/.test(match)) {
            cls = 'boolean';
        } else if (/null/.test(match)) {
            cls = 'null';
        }
        return '<span class="' + cls + '">' + match + '</span>';
    });
}
function loadContent(cntntHdlr, cntntUri) {
	//cntntHdlr.load(cntntUri, responseHdlr);
	$.ajax({
		type: 		"GET",
		dataType: 	"json",
		url: 		cntntUri,
		data:		"",
                success:	function(rsp, textStatus, jqXHR) {
                   var text = jqXHR.responseText;
                   console.log(text);
                   var output = JSON.parse(text);
                   console.log(output);
                   var new_text = JSON.stringify(output,undefined,4);
                   //var json = new JsonUtil();
                   //cntntHdlr.html(json.tableifyObject(output));
                   new_text = syntaxHighlight(new_text);
                   //new_text = '<pre>'  + new_text +  '</pre>';
                   //new_text = '<pre class="prettyprint">'  + new_text +  '</pre>';
                   cntntHdlr.html(new_text);
                }
	});
}

function loadReferenceContent(cntntHdlr, cntntUri) {
	cntntUri = RISrvrUri + cntntUri;

	loadContent(cntntHdlr, cntntUri);

	return cntntUri;
}    
	  
function ajaxCall(method, url, data, divname) {
	$.ajax({
		type: 		method,
		dataType: 	"json",
		url: 		url,
		data:		data,
                success:	function(rsp, textStatus, jqXHR) {
                   var text = jqXHR.responseText;
                   var output = JSON.parse(text);
                   console.log(output);
                   //var json = new JsonUtil();
                   //$('div.' + divname).find('a.responseDetails').html(jqXHR.responseText);
                   //$('div.' + divname).find('a.responseDetails').html(json.tableifyObject(output));
                   var new_text = JSON.stringify(output,undefined,4);
                   $('div.' + divname).find('a.responseDetails').html(syntaxHighlight(new_text));
                }
	});
};

function doSearch() {
	var srvc = 'catalog/search', argv = '', call = '';


	var formHdlr = $('table.SearchForm'), qHdlr = formHdlr.find('input.q'), 
			sessionidHdlr = formHdlr.find('input.sessionid'),
			productsizeHdlr = formHdlr.find('input.productsize'),
			pagesizeHdlr = formHdlr.find('input.pagesize'),
			startrecordHdlr = formHdlr.find('input.startrecord'),
			filtersHdlr = formHdlr.find('input.filters'),
			sortfieldHdlr = formHdlr.find('input.sortfield'),
			sortorderHdlr = formHdlr.find('input.sortorder'),
			regionIdHdlr = formHdlr.find('input.regionid'),
			video_stream_typeHdlr = formHdlr.find('input.video_stream_type');

	argv = 'q=' + qHdlr.val() + '&sessionid='
			+ sessionidHdlr.val() + '&productsize=' + productsizeHdlr.val() + '&pagesize=' + pagesizeHdlr.val()
			+ '&startrecord=' + startrecordHdlr.val() + '&filters='
			+ filtersHdlr.val() + '&sortfield=' + sortfieldHdlr.val()
			+ '&sortorder=' + sortorderHdlr.val() +'&regionid='+regionIdHdlr.val() + '&video_stream_type=' + video_stream_typeHdlr.val() + '';
	call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(searchHdlr, call);
	$('div.Search').find('a.rpcDetails').html(cntntUri);
};
  

function clearSearch() {
	var formHdlr = $('table.SearchForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	searchHdlr.html('');
	$('div.Search').find('a.rpcDetails').html('');
};

function doSearchAhead() {
	var srvc = 'catalog/searchahead', argv = '', call = '';


	var formHdlr = $('table.SearchAheadForm'), qHdlr = formHdlr.find('input.q'), 
			sessionidHdlr = formHdlr.find('input.sessionid'),
			filterHdlr = formHdlr.find('input.filters'),
			regionIdHdlr = formHdlr.find('input.regionid');

	argv = 'q=' + qHdlr.val() + '&sessionid='
			+ sessionidHdlr.val() + '&filters='
			+ filterHdlr.val() + '&regionid='+regionIdHdlr.val() + '';
	call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(searchAheadHdlr, call);
	$('div.SearchAhead').find('a.rpcDetails').html(cntntUri);
};
  

function clearSearchAhead() {
	var formHdlr = $('table.SearchAheadForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	searchAheadHdlr.html('');
	$('div.SearchAhead').find('a.rpcDetails').html('');
};


function getAllGenre() {
	var srvc = 'catalog/genres';

	var call = srvc;

	var cntntUri = loadReferenceContent(getAllGenreHdlr, call);

	$('div.GetAllGenre').find('a.rpcDetails').html(cntntUri);
};

function clearGetAllGenre() {
	getAllGenreHdlr.html('');
	$('div.GetAllGenre').find('a.rpcDetails').html('');
};

function getAllVideoContentTypes() {
	var srvc = 'catalog/contenttypes';
	var call = srvc;

	var cntntUri = loadReferenceContent(getAllVideoContentTypesHdlr, call);

	$('div.GetAllVideoContentTypes').find('a.rpcDetails').html(cntntUri);
};

function clearGetAllVideoContentTypes() {
	getAllVideoContentTypesHdlr.html('');
	$('div.GetAllVideoContentTypes').find('a.rpcDetails').html('');
};

function getCategory() {
	var srvc = 'catalog/category';
	var call = srvc;
	var cntntUri = loadReferenceContent(getCategoryHdlr, call);
        
        var show_url = SIF_Server + cntntUri ;
	$('div.GetCategory').find('a.rpcDetails').attr("href",show_url);
	$('div.GetCategory').find('a.rpcDetails').html(cntntUri);
};

function clearGetCategory() {
	getCategoryHdlr.html('');
	$('div.GetCategory').find('a.rpcDetails').html('');
};

function getCategorySubscriptions() {
	var srvc = 'catalog/subscriptions';
	var call = srvc;
	var cntntUri = loadReferenceContent(getCategorySubHdlr, call);

	$('div.GetCategorySubscriptions').find('a.rpcDetails').html(cntntUri);
};

function clearGetCategorySubscriptions() {
	getCategorySubHdlr.html('');
	$('div.GetCategorySubscriptions').find('a.rpcDetails').html('');
};

function getCategoryById() {
	var srvc = 'catalog/category';

	var formHdlr = $('table.GetCategoryByIdForm'), categoryIdHdlr = formHdlr
			.find('input.categoryid'), returnproductsHdlr = formHdlr
			.find('input.returnproducts'),returnpromocatsHdlr = formHdlr
			.find('input.returnpromocats'), pagesizeHdlr = formHdlr
			.find('input.pagesize'), startrecordHdlr = formHdlr
			.find('input.startrecord'); 

	var argv = 'returnpromocats=' + returnpromocatsHdlr.val() + '&returnproducts=' + returnproductsHdlr.val() + '&pagesize=' + pagesizeHdlr.val() + '&startrecord=' + startrecordHdlr.val() +	'';
	var call = srvc + '/' + categoryIdHdlr.val() + '?' + argv;

	var cntntUri = loadReferenceContent(getCategoryByIdHdlr, call);

	$('div.GetCategoryById').find('a.rpcDetails').html(cntntUri);
};

function clearGetCategoryById() {
	var formHdlr = $('table.GetCategoryByIdForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getCategoryByIdHdlr.html('');
	$('div.GetCategoryById').find('a.rpcDetails').html('');
};


function getProductBySku() {
	var srvc = 'catalog/product', url = '', argv = '';
	var formHdlr = $('table.GetProductBySkuForm'), productskuHdlr = formHdlr
			.find('input.productsku'), sessionidHdlr = formHdlr
			.find('input.sessionid'), video_stream_typeHdlr = formHdlr
			.find('input.video_stream_type'), productsizeHdlr = formHdlr
			.find('input.productsize'), parentalpinHdlr = formHdlr
			.find('input.parentalpin');

	url = srvc + '/' + productskuHdlr.val();
	argv = 'sessionid=' + sessionidHdlr.val() + '&video_stream_type='
			+ video_stream_typeHdlr.val() +  '&productsize='
			+ productsizeHdlr.val() + '&parentalpin=' + parentalpinHdlr.val();

	var call = url + '?' + argv;

	var cntntUri = loadReferenceContent(getProductBySkuHdlr, call);

	$('div.GetProductBySku').find('a.rpcDetails').html(cntntUri);
};

function clearGetProductBySku() {
	var formHdlr = $('table.GetProductBySkuForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getProductBySkuHdlr.html('');
	$('div.GetProductBySku').find('a.rpcDetails').html('');
};


function addBlockedChannels() {
	var srvc = 'account/settings/blockedchannels', url = '', argv = '';
	var formHdlr = $('table.AddBlockedChannelsForm'), 
		channelsHdlr = formHdlr.find('input.channels'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
		parentalpinHdlr = formHdlr.find('input.parentalpin'); 

	argv = 'sessionid=' + sessionidHdlr.val()+'&parentalpin='+parentalpinHdlr.val();

	url = RISrvrUri + srvc + '/' + channelsHdlr.val() + '?' + argv;

	ajaxCall('put', url, '', 'AddBlockedChannels');
	
	$('div.AddBlockedChannels').find('a.rpcDetails').html(url);
};

function clearAddBlockedChannels() {
	var formHdlr = $('table.AddBlockedChannelsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	addBlockedChannelsHdlr.html('');
	$('div.AddBlockedChannels').find('a.rpcDetails').html('');
	$('div.AddBlockedChannels').find('a.responseDetails').html('');
};



function getProductRecommendedBySku() {
	var srvc = 'catalog/products/recommended';
	var formHdlr = $('table.GetProductRecommendedBySkuForm');
	var productskuHdlr = formHdlr.find('input.productsku');
	var pagesizeHdlr = formHdlr.find('input.pagesize');
	var startrecordHdlr = formHdlr.find('input.startrecord');
	var sortfieldHdlr = formHdlr.find('input.sortfield');
	var sortorderHdlr = formHdlr.find('input.sortorder');
	var video_stream_typeHdlr = formHdlr.find('input.video_stream_type');
	var sessionidHdlr = formHdlr.find('input.sessionid');
	
	var url = srvc + '/' + productskuHdlr.val();
	var argv = 'sessionid=' + sessionidHdlr.val() +
				'&pagesize=' + pagesizeHdlr.val() + 
				'&startrecord=' + startrecordHdlr.val() +
				'&sortfield=' + sortfieldHdlr.val() + 
				'&sortorder=' + sortorderHdlr.val() + 
				'&video_stream_type=' + video_stream_typeHdlr.val() + '';

	var call = url + '?' + argv;

	var cntntUri = loadReferenceContent(getProductRecommendedBySkuHdlr, call);

	$('div.GetProductRecommendedBySku').find('a.rpcDetails').html(cntntUri);
};

function clearGetProductRecommendedBySku() {
	var formHdlr = $('table.GetProductRecommendedBySkuForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getProductRecommendedBySkuHdlr.html('');
	$('div.GetProductRecommendedBySku').find('a.rpcDetails').html('');
};

function getProducts() {
	var srvc = 'catalog/products';
	var formHdlr = $('table.GetProductsForm');
	var productsizeHdlr = formHdlr.find('input.productsize');
	var pagesizeHdlr = formHdlr.find('input.pagesize');
	var startrecordHdlr = formHdlr.find('input.startrecord');
	var filtersHdlr = formHdlr.find('input.filters');
	var sortfieldHdlr = formHdlr.find('input.sortfield');
	var sortorderHdlr = formHdlr.find('input.sortorder');
	var video_stream_typeHdlr = formHdlr.find('input.video_stream_type');
	var sessionidHdlr = formHdlr.find('input.sessionid');

	var argv = 'productsize=' + productsizeHdlr.val() + 
				'&pagesize=' + pagesizeHdlr.val() + 
				'&startrecord=' + startrecordHdlr.val() + 
				'&sessionid=' + sessionidHdlr.val() +
				'&filters=' + filtersHdlr.val() + 
				'&sortfield=' + sortfieldHdlr.val() + 
				'&sortorder=' + sortorderHdlr.val() + 
				'&video_stream_type=' + video_stream_typeHdlr.val() + '';

	var call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(getProductsHdlr, call);

	$('div.GetProducts').find('a.rpcDetails').html(cntntUri);
};

function clearGetProducts() {
	var formHdlr = $('table.GetProductsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getProductsHdlr.html('');
	$('div.GetProducts').find('a.rpcDetails').html('');
};   

function getRatingsParentalControls() {
	var srvc = 'catalog/parentalcontroloptions';
	var call = srvc;
	var cntntUri = loadReferenceContent(getRatingsParentalControlsHdlr, call);

	$('div.GetRatingsParentalControls').find('a.rpcDetails').html(cntntUri);
};

function clearGetRatingsParentalControls() {
	getRatingsParentalControlsHdlr.html('');
	$('div.GetCategory').find('a.rpcDetails').html('');
};

	    
function addFavorites() {
	var srvc = 'user/favorites', url = '', data = '';

	var formHdlr = $('table.AddFavoritesForm'), 
		productskuHdlr = formHdlr.find('input.productsku'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
		favoritetypeHdlr = formHdlr.find('input.favoritetype'),
	    favoritelistHdlr = formHdlr.find('input.favoritelist');

	data = 'sessionid=' + sessionidHdlr.val() + '&favoritetype=' + favoritetypeHdlr.val() + '&favoritelist=' + favoritelistHdlr.val();

	url = RISrvrUri + srvc + '/' + productskuHdlr.val() + '?' + data;

	ajaxCall('put', url, '', 'AddFavorites');

	$('div.AddFavorites').find('a.rpcDetails').html(url);
};

function clearAddFavorites() {
	var formHdlr = $('table.AddFavoritesForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	addFavoritesHdlr.html('');
	$('div.AddFavorites').find('a.rpcDetails').html('');
	$('div.AddFavorites').find('a.responseDetails').html('');
};      
      

function getFavorites() {
	var srvc = 'user/favorites', argv = '', call = '';

	var formHdlr = $('table.GetFavoritesForm'), sessionidHdlr = formHdlr
			.find('input.sessionid'), favoritelistHdlr = formHdlr.find('input.favoritelist');
    var video_stream_typeHdlr = formHdlr.find('input.video_stream_type');
    
	argv = 'sessionid=' + sessionidHdlr.val() + '&favoritelist=' + favoritelistHdlr.val() + '&video_stream_type=' + video_stream_typeHdlr.val();

	call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(getFavoritesHdlr, call);

	$('div.GetFavorites').find('a.rpcDetails').html(cntntUri);
};

function clearGetFavorites() {
	var formHdlr = $('table.GetFavoritesForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getFavoritesHdlr.html('');
	$('div.GetFavorites').find('a.rpcDetails').html('');
};  
      


function removeFavorites() {
	var srvc = 'user/favorites', url = '', data = '';

	var formHdlr = $('table.RemoveFavoritesForm'), 
		productskuHdlr = formHdlr.find('input.productsku'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
	    favoritetypeHdlr = formHdlr.find('input.favoritetype'),
	    favoritelistHdlr = formHdlr.find('input.favoritelist');;

	data = 'sessionid=' + sessionidHdlr.val() + '&favoritetype=' + favoritetypeHdlr.val() + '&favoritelist=' + favoritelistHdlr.val();

	url = RISrvrUri + srvc + '/' + productskuHdlr.val() + '?' + data;

	ajaxCall('delete', url, '', 'RemoveFavorites');

	$('div.RemoveFavorites').find('a.rpcDetails').html(url);
};


function clearRemoveFavorites() {
	var formHdlr = $('table.RemoveFavoritesForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	removeFavoritesHdlr.html('');
	$('div.RemoveFavorites').find('a.rpcDetails').html('');
	$('div.RemoveFavorites').find('a.responseDetails').html('');
};   

function getBookmarks() {
	var srvc = 'user/bookmarks', argv = '', call = '';

	var formHdlr = $('table.GetBookmarksForm'), sessionidHdlr = formHdlr
			.find('input.sessionid');

	argv = 'sessionid=' + sessionidHdlr.val();

	call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(getBookmarksHdlr, call);

	$('div.GetBookmarks').find('a.rpcDetails').html(cntntUri);
};

function clearGetBookmarks() {
	var formHdlr = $('table.GetBookmarksForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getBookmarksHdlr.html('');
	$('div.GetBookmarks').find('a.rpcDetails').html('');
}; 
  

function login() {
	var srvc = 'user/authentication/login', url = '', data = '';

	var formHdlr = $('table.LoginForm'), 
		usernameHdlr = formHdlr.find('input.username'), 
		passwordHdlr = formHdlr.find('input.password');

	data = 'username=' + usernameHdlr.val() + '&password=' + passwordHdlr.val();

	url = RISrvrUri + srvc;

	ajaxCall('post', url, data, 'Login');

	$('div.Login').find('a.rpcDetails').html(url);
};


function clearLogin() {
	var formHdlr = $('table.LoginForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	loginHdlr.html('');
	$('div.Login').find('a.rpcDetails').html('');
	$('div.Login').find('a.responseDetails').html('');
};   

function logout() {
	var srvc = 'user/authentication/logout', url = '', data = '';

	var formHdlr = $('table.LogoutForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'); 

	data = 'sessionid=' + sessionidHdlr.val();

	url = RISrvrUri + srvc;

	ajaxCall('post', url, data, 'Logout');

	$('div.Logout').find('a.rpcDetails').html(url);
};


function clearLogout() {
	var formHdlr = $('table.LogoutForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	logoutHdlr.html('');
	$('div.Logout').find('a.rpcDetails').html('');
	$('div.Logout').find('a.responseDetails').html('');
};   

function changePassword() {
	var srvc = 'user/authentication/changepassword', url = '', data = '';

	var formHdlr = $('table.ChangePasswordForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
		old_passwordHdlr = formHdlr.find('input.old_password'),
		passwordHdlr = formHdlr.find('input.password'); 

	data = 'sessionid=' + sessionidHdlr.val() + '&old_password=' + old_passwordHdlr.val() + '&password=' + passwordHdlr.val();

	url = RISrvrUri + srvc;

	ajaxCall('post', url, data, 'ChangePassword');

	$('div.ChangePassword').find('a.rpcDetails').html(url);
};


function clearChangePassword() {
	var formHdlr = $('table.ChangePasswordForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	changePasswordHdlr.html('');
	$('div.ChangePassword').find('a.rpcDetails').html('');
	$('div.ChangePassword').find('a.responseDetails').html('');
};   


function resetPassword() {
	var srvc = 'user/authentication/resetpassword', url = '', data = '';

	var formHdlr = $('table.ResetPasswordForm'), 
		emailHdlr = formHdlr.find('input.email'); 

	data = 'email=' + emailHdlr.val();

	url = RISrvrUri + srvc;

	ajaxCall('post', url, data, 'ResetPassword');

	$('div.ResetPassword').find('a.rpcDetails').html(url);
};


function clearResetPassword() {
	var formHdlr = $('table.ResetPasswordForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	resetPasswordHdlr.html('');
	$('div.ResetPassword').find('a.rpcDetails').html('');
	$('div.ResetPassword').find('a.responseDetails').html('');
};   

function resetPasswordValidate() {
	var srvc = 'user/authentication/resetpassword/validate', url = '', data = '';

	var formHdlr = $('table.ResetPasswordValidateForm'); 
	var passwordHdlr = formHdlr.find('input.password');
	var confirmationHdlr = formHdlr.find('input.confirmation');
	var guidHdlr = formHdlr.find('input.guid');

	data = 'password=' + passwordHdlr.val() + '&confirmation=' + confirmationHdlr.val() + '&guid=' + guidHdlr.val();

	url = RISrvrUri + srvc;

	ajaxCall('post', url, data, 'ResetPasswordValidate');

	$('div.ResetPasswordValidate').find('a.rpcDetails').html(url);
};


function clearResetPasswordValidate() {
	var formHdlr = $('table.ResetPasswordValidateForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	resetPasswordValidateHdlr.html('');
	$('div.ResetPasswordValidate').find('a.rpcDetails').html('');
	$('div.ResetPasswordValidate').find('a.responseDetails').html('');
};   

function getProfile() {
	var srvc = 'user/profile', argv = '';
	var formHdlr = $('table.GetProfileForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid');

	argv = 'sessionid=' + sessionidHdlr.val() + '';

	var call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(getProfileHdlr, call);

	$('div.GetProfile').find('a.rpcDetails').html(cntntUri);
};

function clearGetProfile() {
	var formHdlr = $('table.GetProfileForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getProfileHdlr.html('');
	$('div.GetProfile').find('a.rpcDetails').html('');
};   

function updateProfile() {
    var srvc = 'user/profile', url = '', data = '';

    var formHdlr = $('table.UpdateProfileForm'),
            sessionidHdlr = formHdlr.find('input.sessionid'),
            usernameHdlr = formHdlr.find('input.username'),
            emailHdlr = formHdlr.find('input.email'),
            firstnameHdlr = formHdlr.find('input.firstname'),
            lastnameHdlr = formHdlr.find('input.lastname');

    data = 'sessionid=' + sessionidHdlr.val() + '&username=' + usernameHdlr.val() +'&email=' + emailHdlr.val() + 
            '&firstname=' + firstnameHdlr.val() + '&lastname=' + lastnameHdlr.val()+ '';


    url = RISrvrUri + srvc;

    ajaxCall('post', url, data, 'UpdateProfile');

    $('div.UpdateProfile').find('a.rpcDetails').html(url);
};



function clearUpdateProfile() {
	var formHdlr = $('table.UpdateProfileForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	updateProfileHdlr.html('');
	$('div.UpdateProfile').find('a.rpcDetails').html('');
	$('div.UpdateProfile').find('a.responseDetails').html('');
};   



function purchase() {
	var srvc = 'store/purchase', url = '', data = '';

	var formHdlr = $('table.PurchaseForm'), productskuHdlr = formHdlr
			.find('input.productsku'), productidHdlr = formHdlr
			.find('input.productid'), sessionidHdlr = formHdlr
			.find('input.sessionid'), paymentinformationHdlr = formHdlr
			.find('input.paymentinformation'), pinHdlr = formHdlr
			.find('input.pin');

	data = 'productsku=' + productskuHdlr.val() + '&productid='
			+ productidHdlr.val() + '&sessionid=' + sessionidHdlr.val()
			+ '&paymentinformation=' + paymentinformationHdlr.val() + '&pin='
			+ pinHdlr.val();

	url = RISrvrUri + srvc;

	ajaxCall('post', url, data, 'Purchase');

	$('div.Purchase').find('a.rpcDetails').html(url);
};

function clearPurchase() {
	var formHdlr = $('table.PurchaseForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	purchaseHdlr.html('');
	$('div.Purchase').find('a.rpcDetails').html('');
	$('div.Purchase').find('a.responseDetails').html('');
};     

      
function getRegions() {
	var srvc = 'programdata/regions', argv = '', call = '';

	//var formHdlr = $('table.GetRegionsForm'), startrecordHdlr = formHdlr
	//		.find('input.startrecord'), pagesizeHdlr = formHdlr.find('input.pagesize');

	//argv = 'startrecord=' + startrecordHdlr.val() + '&pagesize=' + pagesizeHdlr.val();

	call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(getRegionsHdlr, call);

	$('div.GetRegions').find('a.rpcDetails').html(cntntUri);
};

function clearGetRegions() {
	var formHdlr = $('table.GetRegionsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getRegionsHdlr.html('');
	$('div.GetRegions').find('a.rpcDetails').html('');
}; 
        

function getChannels() {
	var srvc = 'programdata/regions', argv = '', call = '';

	var formHdlr = $('table.GetChannelsForm'), sessionidHdlr = formHdlr
	.find('input.sessionid'), regionidHdlr = formHdlr
	.find('input.regionid'), startrecordHdlr = formHdlr.find('input.startrecord'), pagesizeHdlr = formHdlr
	.find('input.pagesize'), video_stream_typeHdlr = formHdlr.find('input.video_stream_type');

	argv =  'sessionid=' + sessionidHdlr.val() + '&startrecord=' + startrecordHdlr.val() + '&pagesize=' + pagesizeHdlr.val() + '&video_stream_type=' + video_stream_typeHdlr.val();

	call = srvc + '/' + regionidHdlr.val() + '/channels' + '?' + argv;

	var cntntUri = loadReferenceContent(getChannelsHdlr, call);

	$('div.GetChannels').find('a.rpcDetails').html(cntntUri);
};

function clearGetChannels() {
	var formHdlr = $('table.GetChannelsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getChannelsHdlr.html('');
	$('div.GetChannels').find('a.rpcDetails').html('');
};
           

function getChannelsByChannelPks() {
	var srvc = 'programdata/regions', argv = '', call = '';

	var formHdlr = $('table.GetChannelsByChannelPksForm'), sessionidHdlr = formHdlr
	.find('input.sessionid'), regionidHdlr = formHdlr
	.find('input.regionid'), startrecordHdlr = formHdlr.find('input.startrecord'), pagesizeHdlr = formHdlr
	.find('input.pagesize'), channelpksHdlr = formHdlr.find('input.channelpks'), video_stream_typeHdlr = formHdlr.find('input.video_stream_type');

	argv =  'sessionid=' + sessionidHdlr.val() + '&startrecord=' + startrecordHdlr.val() + '&pagesize=' + pagesizeHdlr.val() + '&video_stream_type=' + video_stream_typeHdlr.val();

	call = srvc + '/' + regionidHdlr.val() + '/channels/' + channelpksHdlr.val() + '?' + argv;

	var cntntUri = loadReferenceContent(getChannelsByChannelPksHdlr, call);

	$('div.GetChannelsByChannelPks').find('a.rpcDetails').html(cntntUri);
};

function clearGetChannelsByChannelPks() {
	var formHdlr = $('table.GetChannelsByChannelPksForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getChannelsByChannelPksHdlr.html('');
	$('div.GetChannelsByChannelPks').find('a.rpcDetails').html('');
};

function getSchedules() {
	var srvc = 'programdata/regions', argv = '', call = '';

	var formHdlr = $('table.GetSchedulesForm'), regionidHdlr = formHdlr
			.find('input.regionid'), starttimeHdlr = formHdlr
			.find('input.starttime'), durationHdlr = formHdlr
			.find('input.duration');

	argv = 'starttime=' + starttimeHdlr.val() + '&duration=' + durationHdlr.val();

	call = srvc + '/' + regionidHdlr.val() + '/schedules' + '?'  + argv;

	var cntntUri = loadReferenceContent(getSchedulesHdlr, call);

	$('div.GetSchedules').find('a.rpcDetails').html(cntntUri);
};

function clearGetSchedules() {
	var formHdlr = $('table.GetSchedulesForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getSchedulesHdlr.html('');
	$('div.GetSchedules').find('a.rpcDetails').html('');
};  
  
function getSchedulesByChannelIds() {
	var srvc = 'programdata/regions', argv = '', call = '';

	var formHdlr = $('table.GetSchedulesByChannelIdsForm'), regionidHdlr = formHdlr
			.find('input.regionid'), channelidsHdlr = formHdlr
			.find('input.channelids'), starttimeHdlr = formHdlr
			.find('input.starttime'), durationHdlr = formHdlr
			.find('input.duration');

	argv = 'starttime=' + starttimeHdlr.val() + '&duration=' + durationHdlr.val();

	call = srvc + '/' + regionidHdlr.val() + '/schedules/' + channelidsHdlr.val() + '?'  + argv;

	var cntntUri = loadReferenceContent(getSchedulesByChannelIdsHdlr, call);

	$('div.GetSchedulesByChannelIds').find('a.rpcDetails').html(cntntUri);
};

function clearGetSchedulesByChannelIds() {
	var formHdlr = $('table.GetSchedulesByChannelIdsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getSchedulesByChannelIdsHdlr.html('');
	$('div.GetSchedulesByChannelIds').find('a.rpcDetails').html('');
};  


function getPurchaseHistory() {
	var srvc = 'account/history/purchases', argv = '', call = '';

	var formHdlr = $('table.GetPurchaseHistoryForm'), sessionidHdlr = formHdlr
			.find('input.sessionid'), pagesizeHdlr = formHdlr
			.find('input.pagesize'), startrecordHdlr = formHdlr
			.find('input.startrecord'), sortfieldHdlr = formHdlr
			.find('input.sortfield'), sortorderHdlr = formHdlr
			.find('input.sortorder');

	argv = 'sessionid=' + sessionidHdlr.val() + '&pagesize=' + pagesizeHdlr.val() + '&startrecord=' + startrecordHdlr.val() + '&sortfield=' + sortfieldHdlr.val() + '&sortorder=' + sortorderHdlr.val();

	call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(getPurchaseHistoryHdlr, call);

	$('div.GetPurchaseHistory').find('a.rpcDetails').html(cntntUri);
};

function clearGetPurchaseHistory() {
	var formHdlr = $('table.GetPurchaseHistoryForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getPurchaseHistoryHdlr.html('');
	$('div.GetPurchaseHistory').find('a.rpcDetails').html('');
};

function getEntitlements() {
	var srvc = 'account/entitlements', argv = '', call = '';

	var formHdlr = $('table.GetEntitlementsForm'), sessionidHdlr = formHdlr
		.find('input.sessionid'), filtersHdlr = formHdlr
		.find('input.filters'), pagesizeHdlr = formHdlr
		.find('input.pagesize'), startrecordHdlr = formHdlr
		.find('input.startrecord'), sortfieldHdlr = formHdlr
		.find('input.sortfield'), sortorderHdlr = formHdlr
		.find('input.sortorder'), streamtypeHdlr = formHdlr
		.find('input.video_stream_type');

	argv = 'sessionid=' + sessionidHdlr.val() + '&filters=' + filtersHdlr.val() + '&pagesize=' + pagesizeHdlr.val() + '&startrecord=' + startrecordHdlr.val() + '&sortfield=' + sortfieldHdlr.val() + '&sortorder=' + sortorderHdlr.val() + '&video_stream_type=' + streamtypeHdlr.val();

	call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(getEntitlementsHdlr, call);

	$('div.GetEntitlements').find('a.rpcDetails').html(cntntUri);
};

function clearGetEntitlements() {
	var formHdlr = $('table.GetEntitlementsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getEntitlementsHdlr.html('');
	$('div.GetEntitlements').find('a.rpcDetails').html('');
};

function deleteEntitlements() {
	var srvc = 'account/entitlements', argv = '', url = '';

	var formHdlr = $('table.DeleteEntitlementsForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
		productskuHdlr = formHdlr.find('input.productsku'),
		productidHdlr = formHdlr.find('input.productid'),
		pinHdlr = formHdlr.find('input.pin');

	argv = 'sessionid=' + sessionidHdlr.val() + '&productsku=' + productskuHdlr.val() + '&productid=' + productidHdlr.val() + '&pin=' + pinHdlr.val();

	url = RISrvrUri + srvc + '?' + argv;

	ajaxCall('delete', url, '', 'DeleteEntitlements');
	
	$('div.DeleteEntitlements').find('a.rpcDetails').html(url);
};

function clearDeleteEntitlements() {
	var formHdlr = $('table.DeleteEntitlementsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	deleteEntitlementsHdlr.html('');
	$('div.DeleteEntitlements').find('a.rpcDetails').html('');
	$('div.DeleteEntitlements').find('a.responseDetails').html('');
};

function getSettings() {
	var srvc = 'account/settings', argv = '', call = '';

	var formHdlr = $('table.GetSettingsForm'), sessionidHdlr = formHdlr
			.find('input.sessionid');

	argv = 'sessionid=' + sessionidHdlr.val();

	call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(getSettingsHdlr, call);

	$('div.GetSettings').find('a.rpcDetails').html(cntntUri);
};

function clearGetSettings() {
	var formHdlr = $('table.GetSettingsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getSettingsHdlr.html('');
	$('div.GetSettings').find('a.rpcDetails').html('');
};

function getSettingsParentalRatings() {
	var srvc = 'account/settings/parentalcontrols', argv = '', call = '';

	var formHdlr = $('table.GetSettingsParentalRatingsForm'), sessionidHdlr = formHdlr
			.find('input.sessionid');

	argv = 'sessionid=' + sessionidHdlr.val();

	call = srvc + '?' + argv;

	var cntntUri = loadReferenceContent(getSettingsParentalRatingsHdlr, call);

	$('div.GetSettingsParentalRatings').find('a.rpcDetails').html(cntntUri);
};

function clearGetSettingsParentalRatings() {
	var formHdlr = $('table.GetSettingsParentalRatingsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getSettingsParentalRatingsHdlr.html('');
	$('div.GetSettingsParentalRatings').find('a.rpcDetails').html('');
};

function register() {
	var srvc = 'account/register', url = '', data = '';

	var formHdlr = $('table.RegisterForm'), 
		usernameHdlr = formHdlr.find('input.username'), 
		emailHdlr = formHdlr.find('input.email'), 
		passwordHdlr = formHdlr.find('input.password'), 
		firstnameHdlr = formHdlr.find('input.firstname'), 
		lastnameHdlr = formHdlr.find('input.lastname'), 
		parentalpinHdlr = formHdlr.find('input.parentalpin'),
		purchasepinHdlr = formHdlr.find('input.purchasepin'),
	    regionidHdlr = formHdlr.find('input.regionid'),
	    accountnumberHdlr = formHdlr.find('input.accountnumber'),
	    addressHdlr = formHdlr.find('input.address'),
	    cityHdlr = formHdlr.find('input.city'),
	    stateHdlr = formHdlr.find('input.state'),
	    zipHdlr = formHdlr.find('input.zip'),
	    jidHdlr = formHdlr.find('input.jid');

	data = 'username=' + usernameHdlr.val() + '&email=' + emailHdlr.val() + '&password=' + passwordHdlr.val() + 
		'&firstname=' + firstnameHdlr.val() + '&lastname=' + lastnameHdlr.val() + '&parentalpin=' + parentalpinHdlr.val() +
		'&purchasepin=' + purchasepinHdlr.val() + '&regionid=' + regionidHdlr.val() + '&accountnumber=' + accountnumberHdlr.val() + 
		'&address=' + addressHdlr.val() + '&city=' + cityHdlr.val() + '&state=' + stateHdlr.val() +
		'&zip=' + zipHdlr.val() + '&jid=' + jidHdlr.val() + '';

	url = RISrvrUri + srvc + '?' + data;

	ajaxCall('put', url, '', 'Register');

	$('div.Register').find('a.rpcDetails').html(url);
};


function clearRegister() {
	var formHdlr = $('table.RegisterForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	registerHdlr.html('');
	$('div.Register').find('a.rpcDetails').html('');
	$('div.Register').find('a.responseDetails').html('');
};   


function updateSettingsParentalRatings() {
	var srvc = 'account/settings/parentalcontrols', url = '', data = '';

	var formHdlr = $('table.UpdateSettingsParentalRatingsForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'), 
		parentalpinHdlr = formHdlr.find('input.parentalpin'),
		tvblockingonHdlr = formHdlr.find('input.tvblockingon'), 
		tvblockingunratedonHdlr = formHdlr.find('input.tvblockingunratedon'), 
		tvblockinglevelHdlr = formHdlr.find('input.tvblockinglevel'), 
		movieblockingonHdlr = formHdlr.find('input.movieblockingon'),
		movieblockingunratedonHdlr = formHdlr.find('input.movieblockingunratedon'),
		movieblockinglevelHdlr = formHdlr.find('input.movieblockinglevel'); 

	data = 'sessionid=' + sessionidHdlr.val() + '&parentalpin=' + parentalpinHdlr.val() + '&tvblockingon=' + tvblockingonHdlr.val() + 
		'&tvblockingunratedon=' + tvblockingunratedonHdlr.val() + '&tvblockinglevel=' + tvblockinglevelHdlr.val() + '&movieblockingon=' + movieblockingonHdlr.val() +
		'&movieblockingunratedon=' + movieblockingunratedonHdlr.val() + '&movieblockinglevel=' + movieblockinglevelHdlr.val() + '';

	url = RISrvrUri + srvc;

	ajaxCall('post', url, data, 'UpdateSettingsParentalRatings');

	$('div.UpdateSettingsParentalRatings').find('a.rpcDetails').html(url);
};


function clearUpdateSettingsParentalRatings() {
	var formHdlr = $('table.UpdateSettingsParentalRatingsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	updateSettingsParentalRatingsHdlr.html('');
	$('div.UpdateSettingsParentalRatings').find('a.rpcDetails').html('');
	$('div.UpdateSettingsParentalRatings').find('a.responseDetails').html('');
};

function updateAccountPins() {
	var srvc = 'account/settings', url = '', data = '';

	var formHdlr = $('table.UpdateAccountPinsForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'), 
		old_parentalpinHdlr = formHdlr.find('input.old_parentalpin'),
		parentalpinHdlr = formHdlr.find('input.parentalpin'), 
		old_purchasepinHdlr = formHdlr.find('input.old_purchasepin'), 
		purchasepinlHdlr = formHdlr.find('input.purchasepin'),
        regionidHdlr = formHdlr.find('input.regionid'),
	    addressHdlr = formHdlr.find('input.address'),
	    cityHdlr = formHdlr.find('input.city'),
	    stateHdlr = formHdlr.find('input.state'),
	    zipHdlr = formHdlr.find('input.zip');

	data = 'sessionid=' + sessionidHdlr.val() + '&old_parentalpin=' + old_parentalpinHdlr.val() + '&parentalpin=' + parentalpinHdlr.val() + 
		'&old_purchasepin=' + old_purchasepinHdlr.val() + '&purchasepin=' + purchasepinlHdlr.val() + '&regionid=' + regionidHdlr.val() + 
		'&address=' + addressHdlr.val() + '&city=' + cityHdlr.val() + '&state=' + stateHdlr.val() + '&zip=' + zipHdlr.val()+ '';

	url = RISrvrUri + srvc;

	ajaxCall('post', url, data, 'UpdateAccountPins');

	$('div.UpdateAccountPins').find('a.rpcDetails').html(url);
};


function clearUpdateAccountPins() {
	var formHdlr = $('table.UpdateAccountPins');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	updateAccountPinsHdlr.html('');
	$('div.UpdateAccountPins').find('a.rpcDetails').html('');
	$('div.UpdateAccountPins').find('a.responseDetails').html('');
};


function callCreateUser() {
	var srvc = 'user/profile', url = '', data = '';

	var formHdlr = $('table.CreateUserForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'), 
		usernameHdlr = formHdlr.find('input.username'), 
		emaillHdlr = formHdlr.find('input.email'), 
		lastnameHdlr = formHdlr.find('input.lastname'),
		firstnameHdlr = formHdlr.find('input.firstname'),
		passwordHdlr = formHdlr.find('input.password'),
		jidHdlr = formHdlr.find('input.jid'); 

	data = 'sessionid=' + sessionidHdlr.val() + 
		'&username=' + usernameHdlr.val() + '&email=' + emaillHdlr.val() + '&lastname=' + lastnameHdlr.val() +
		'&firstname=' + firstnameHdlr.val() + '&password=' + passwordHdlr.val() + '&jid=' + jidHdlr.val() + '';

	url = RISrvrUri + srvc + '?' + data;

	ajaxCall('put', url, '', 'CreateUser');

	$('div.CreateUser').find('a.rpcDetails').html(url);
};


function clearCreateUser() {
	var formHdlr = $('table.CreateUserForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	createUserHdlr.html('');
	$('div.CreateUser').find('a.rpcDetails').html('');
	$('div.CreateUser').find('a.responseDetails').html('');
};

function callAddBookmark() {
	var srvc = 'user/bookmarks', url = '', data = '';

	var formHdlr = $('table.AddBookmarkForm'), 
		productskuHdlr = formHdlr.find('input.productsku'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
		bookmarkHdlr = formHdlr.find('input.bookmarklocation'),
		componentidHdlr = formHdlr.find('input.componentid');
		
	data = 'sessionid=' + sessionidHdlr.val()+'&bookmarklocation='+bookmarkHdlr.val()+'&componentid='+componentidHdlr.val();

	url = RISrvrUri + srvc + '/' + productskuHdlr.val() + '?' + data;

	ajaxCall('put', url, '', 'AddBookmark');

	$('div.AddBookmark').find('a.rpcDetails').html(url);
};

function clearAddBookmark() {
	var formHdlr = $('table.AddBookmarkForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	addBookmarkHdlr.html('');
	$('div.AddBookmark').find('a.rpcDetails').html('');
	$('div.AddBookmark').find('a.responseDetails').html('');
};

function callDeleteBookmark() {
	var srvc = 'user/bookmarks', url = '', data = '';

	var formHdlr = $('table.DeleteBookmarkForm'), 
		productskuHdlr = formHdlr.find('input.productsku'), 
		sessionidHdlr = formHdlr.find('input.sessionid');
		
	data = 'sessionid=' + sessionidHdlr.val();

	url = RISrvrUri + srvc + '/' + productskuHdlr.val() + '?' + data;

	ajaxCall('delete', url, '', 'DeleteBookmark');

	$('div.DeleteBookmark').find('a.rpcDetails').html(url);
};

function clearDeleteBookmark() {
	var formHdlr = $('table.DeleteBookmarkForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	deleteBookmarkHdlr.html('');
	$('div.DeleteBookmark').find('a.rpcDetails').html('');
	$('div.DeleteBookmark').find('a.responseDetails').html('');
};

function callAddDevice() {
	var srvc = 'account/devices', url = '', data = '';

	var formHdlr = $('table.AddDeviceForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
		deviceidHdlr = formHdlr.find('input.deviceid'), 
		devicenameHdlr = formHdlr.find('input.devicename'),
		devicetypeHdlr = formHdlr.find('input.devicetype');
		
	data = 'sessionid=' + sessionidHdlr.val() + '&deviceid=' + deviceidHdlr.val() + '&devicename=' + devicenameHdlr.val() + '&devicetype=' + devicetypeHdlr.val();

	url = RISrvrUri + srvc + '?' + data;

	ajaxCall('put', url, '', 'AddDevice');

	$('div.AddDevice').find('a.rpcDetails').html(url);
};

function clearAddDevice() {
	var formHdlr = $('table.AddDeviceForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	addDeviceHdlr.html('');
	$('div.AddDevice').find('a.rpcDetails').html('');
	$('div.AddDevice').find('a.responseDetails').html('');
};


function callUpdateDevice() {
	var srvc = 'account/devices', url = '', data = '';

	var formHdlr = $('table.UpdateDeviceForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
		deviceidHdlr = formHdlr.find('input.deviceid'), 
		devicenameHdlr = formHdlr.find('input.devicename');
		
	data = 'sessionid=' + sessionidHdlr.val() + '&deviceid=' + deviceidHdlr.val() + '&devicename=' + devicenameHdlr.val();

	url = RISrvrUri + srvc + '?' + data;

	ajaxCall('post', url, '', 'UpdateDevice');

	$('div.UpdateDevice').find('a.rpcDetails').html(url);
};

function clearUpdateDevice() {
	var formHdlr = $('table.UpdateDeviceForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	updateDeviceHdlr.html('');
	$('div.UpdateDevice').find('a.rpcDetails').html('');
	$('div.UpdateDevice').find('a.responseDetails').html('');
};


function callDeleteDevice() {
	var srvc = 'account/devices', url = '', data = '';

	var formHdlr = $('table.UpdateDeviceForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
		deviceidHdlr = formHdlr.find('input.deviceid'); 
		
	data = 'sessionid=' + sessionidHdlr.val() + '&deviceid=' + deviceidHdlr.val();

	url = RISrvrUri + srvc + '?' + data;

	ajaxCall('delete', url, '', 'DeleteDevice');

	$('div.DeleteDevice').find('a.rpcDetails').html(url);
};

function clearDeleteDevice() {
	var formHdlr = $('table.DeleteDeviceForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	deleteDeviceHdlr.html('');
	$('div.DeleteDevice').find('a.rpcDetails').html('');
	$('div.DeleteDevice').find('a.responseDetails').html('');
};

function callGetAccountDevices() {
	var srvc = 'account/devices', url = '', data = '';

	var formHdlr = $('table.GetAccountDevicesForm'), 
		sessionidHdlr = formHdlr.find('input.sessionid'); 
		
	data = 'sessionid=' + sessionidHdlr.val();
	url = srvc + '?' + data;
	
	var cntntUri = loadReferenceContent(getAccountDevicesHdlr, url);

	$('div.GetAccountDevices').find('a.rpcDetails').html(cntntUri);	
};

function clearGetAccountDevices() {
	var formHdlr = $('table.GetAccountDevicesForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getAccountDevicesHdlr.html('');
	$('div.GetAccountDevices').find('a.rpcDetails').html('');
	$('div.GetAccountDevices').find('a.responseDetails').html('');
};

function deleteBlockedChannels() {
	var srvc = 'account/settings/blockedchannels', url = '', argv = '';
	var formHdlr = $('table.DeleteBlockedChannelsForm'), 
		channelsHdlr = formHdlr.find('input.channels'), 
		sessionidHdlr = formHdlr.find('input.sessionid'),
		parentalpinHdlr = formHdlr.find('input.parentalpin'); 

	argv = 'sessionid=' + sessionidHdlr.val()+'&parentalpin='+parentalpinHdlr.val();

	url = RISrvrUri + srvc + '/' + channelsHdlr.val() + '?' + argv;

	ajaxCall('delete', url, '', 'DeleteBlockedChannels');
	
	$('div.DeleteBlockedChannels').find('a.rpcDetails').html(url);
};

function clearDeleteBlockedChannels() {
	var formHdlr = $('table.DeleteBlockedChannelsForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	deleteBlockedChannelsHdlr.html('');
	$('div.DeleteBlockedChannels').find('a.rpcDetails').html('');
	$('div.DeleteBlockedChannels').find('a.responseDetails').html('');
};

function callGetProgramSchedule() {
	var srvc = 'programdata/regions', url = '';

	var formHdlr = $('table.GetProgramScheduleForm'), 
		regionidHdlr = formHdlr.find('input.regionid'),
		programidHdlr = formHdlr.find('input.programid'),
		pagesizeHdlr = formHdlr.find('input.pagesize'),
		durationHdlr = formHdlr.find('input.duration'),
		starttimeHdlr = formHdlr.find('input.starttime'),
		startrecordHdlr = formHdlr.find('input.startrecord');
		
    var data = 'pagesize=' + pagesizeHdlr.val() + '&startrecord=' + startrecordHdlr.val() + '&starttime=' + starttimeHdlr.val() + '&duration=' + durationHdlr.val();

	url = RISrvrUri + srvc + '/' + regionidHdlr.val() + '/programs/' + programidHdlr.val() + '?' + data;

	ajaxCall('get', url, '', 'GetProgramSchedule');

	$('div.GetProgramSchedule').find('a.rpcDetails').html(url);
};

function clearGetProgramSchedule() {
	var formHdlr = $('table.GetProgramScheduleForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getProgramScheduleHdlr.html('');
	$('div.GetProgramSchedule').find('a.rpcDetails').html('');
	$('div.GetProgramSchedule').find('a.responseDetails').html('');
};


function callGetModifiedSchedules() {
	var srvc = 'programdata/regions', url = '';

	var formHdlr = $('table.GetModifiedSchedulesForm'), 
		regionidHdlr = formHdlr.find('input.regionid'),
		lastdateHdlr = formHdlr.find('input.lastdate');
		
    var data = 'lastdate=' + lastdateHdlr.val();

	url = RISrvrUri + srvc + '/' + regionidHdlr.val() + '/schedule/check?' + data;

	ajaxCall('get', url, '', 'GetModifiedSchedules');

	$('div.GetModifiedSchedules').find('a.rpcDetails').html(url);
};

function clearGetModifiedSchedules() {
	var formHdlr = $('table.GetModifiedSchedulesForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	getModifiedScheduleHdlr.html('');
	$('div.GetModifiedSchedules').find('a.rpcDetails').html('');
	$('div.GetModifiedSchedules').find('a.responseDetails').html('');
};


function callDeleteUser() {
	var srvc = 'user/profile', url = '', data = '';

	var formHdlr = $('table.DeleteUserForm'), 
		sessionIdHdlr = formHdlr.find('input.sessionid'), 
		usernameHdlr = formHdlr.find('input.username'); 

	data = 'sessionid=' + sessionIdHdlr.val() + 
		'&username=' + usernameHdlr.val() + '';

	url = RISrvrUri + srvc + '?' + data;

	ajaxCall('delete', url, '', 'DeleteUser');

	$('div.DeleteUser').find('a.rpcDetails').html(url);
};


function clearDeleteUser() {
	var formHdlr = $('table.DeleteUserForm');

	formHdlr.find('input').each(function() {
		$(this).val('');
	});

	deleteUserHdlr.html('');
	$('div.DeleteUser').find('a.rpcDetails').html('');
	$('div.DeleteUser').find('a.responseDetails').html('');
};

function getProviders() {
	var srvc = 'catalog/providers';

	var call = srvc;

	var cntntUri = loadReferenceContent(getProvidersHdlr, call);

	$('div.GetProviders').find('a.rpcDetails').html(cntntUri);
};

function clearGetProviders() {
	getProvidersHdlr.html('');
	$('div.GetProviders').find('a.rpcDetails').html('');
};

function getProviderDetails() {
	var srvc = 'catalog/providers', url = '';

	var formHdlr = $('table.GetProviderDetailsForm');
	var providerKeyHdlr = formHdlr.find('input.providerkey');

	url = srvc + '/' + providerKeyHdlr.val();

	var cntntUri = loadReferenceContent(getProviderDetailsHdlr, url);

	$('div.GetProviderDetails').find('a.rpcDetails').html(cntntUri);
};

function clearGetProviderDetails() {
	getProviderDetailsHdlr.html('');
	$('div.GetProviderDetails').find('a.rpcDetails').html('');
};

function getSubscriptinsBySubKey() {
	var srvc = 'catalog/subscriptions';

	var formHdlr = $('table.GetSubscriptinsBySubKeyForm'); 
	var sub_keyHdlr = formHdlr.find('input.sub_key'); 

	var url = srvc + '/' + sub_keyHdlr.val();

	var cntntUri = loadReferenceContent(getSubscriptinsBySubKeyHdlr, url);

	$('div.GetSubscriptinsBySubKey').find('a.rpcDetails').html(cntntUri);
};

function clearGetSubscriptinsBySubKey() {
	getSubscriptinsBySubKeyHdlr.html('');
	$('div.GetSubscriptinsBySubKey').find('a.rpcDetails').html('');
};


function getVodPlayBackClear() {
      $('code#GetVodPlayBackViewerLogin').html('');
      $('code#GetVodPlayBackViewerCat').html('');
      $('code#GetVodPlayBackViewerPurchase').html('');
      $('code#GetVodPlayBackViewerDetail').html('');

}
function getVodPlayBack() {
	var srvc = 'user/authentication/login', url = '', data = '';

	var formHdlr = $('table.GetVodPlayBackForm'), 
		usernameHdlr = formHdlr.find('input.username'), 
		passwordHdlr = formHdlr.find('input.password');

	data = 'username=' + usernameHdlr.val() + '&password=' + passwordHdlr.val();

	url = RISrvrUri + srvc;
        var sessionid = '';

        $.ajax({
           type: 'POST',
           url:  url, 
           data: data,
           dataType: 	"json",
           success:	function(rsp, textStatus, jqXHR) {
              var text = jqXHR.responseText;
              var output = JSON.parse(text);
              sessionid = output.data.sessionId;
              console.log(output);
              var new_text = JSON.stringify(output,undefined,4);
              $('code#GetVodPlayBackViewerLogin').html(syntaxHighlight(new_text));
              srvc = 'catalog/category';

              var categoryIdHdlr = formHdlr.find('input.categoryid'); 

              var argv = 'returnpromocats=' + '&returnproducts=' + 'true'+ '&pagesize=' + '2' + '&startrecord=' + '0' +	'';
              var call = RISrvrUri + srvc + '/' + categoryIdHdlr.val() + '?' + argv;

              $.ajax({
                 type: 'GET',
                 url:  call, 
                 dataType: 	"json",
                 success:	function(rsp, textStatus, jqXHR) {
                    var text = jqXHR.responseText;
                    var output = JSON.parse(text);
                    console.log(output);
                    var new_text = JSON.stringify(output,undefined,4);
                    $('code#GetVodPlayBackViewerCat').html(syntaxHighlight(new_text));
                    srvc = 'store/purchase', url = '', data = '';

                    var productskuHdlr = formHdlr
                    .find('input.productsku'), pinHdlr = formHdlr
                    .find('input.pin'),productidHdlr = formHdlr.find('input.productid');

                    data = 'productsku=' + productskuHdlr.val() + '&productid='
                    + productidHdlr.val() + '&sessionid=' + sessionid
                    + '&paymentinformation=' + '{"type":"account"}' + '&pin='
                    + pinHdlr.val();

                    url = RISrvrUri + srvc;
                    $.ajax({
                       type: 'POST',
                       url:  url, 
                       data: data,
                       dataType:"json",
                       success:	function(rsp, textStatus, jqXHR) {
                          var text = jqXHR.responseText;
                          var output = JSON.parse(text);
                          console.log(output);
                          var new_text = JSON.stringify(output,undefined,4);
                          $('code#GetVodPlayBackViewerPurchase').html(syntaxHighlight(new_text));
                          var srvc = 'catalog/product', url = '', argv = '';
                          url = RISrvrUri + srvc + '/' + productskuHdlr.val();
                          argv = 'sessionid=' + sessionid + '&video_stream_type=HLS' +  '&productsize=' +'&parentalpin=1234';
                          var call = url + '?' + argv;
                          $.ajax({
                             type: 'GET',
                             url:  call, 
                             dataType: 	"json",
                             success:	function(rsp, textStatus, jqXHR) {
                                var text = jqXHR.responseText;
                                var output = JSON.parse(text);
                                console.log(output);
                                var new_text = JSON.stringify(output,undefined,4);
                                $('code#GetVodPlayBackViewerDetail').html(syntaxHighlight(new_text));
                             }});
                       }});

                 }});
           }});
}
