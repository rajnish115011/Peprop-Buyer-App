class API {




   //live
   // static String baseUrl="https://app.peprop.money";
   // static String banking_base="https://app.peprop.money";


   static String app_name="PeProp.Money";

  //demo
   static String baseUrl="https://poojaemerald.drmactive.in";
   static String banking_base="https://poojaemerald.drmactive.in";

   // static String baseUrl="https://demo.drmactive.in";
   // static String banking_base="https://demo.drmactive.in";
   static String ecpm_cat=baseUrl+"/property_list/public/api/v1/category-master";
   static String products=baseUrl+"/property_list/public/api/v1/products/";
   static String add_order=baseUrl+"/property_list/public/api/v1/add-order";
   static String my_order=baseUrl+"/property_list/public/api/v1/my-order";
   static String userdetails=baseUrl+"/property_list/public/api/v1/user-details";
   static String cancel_order=baseUrl+"/property_list/public/api/v1/cancel-order";
   static String track_order=baseUrl+"/property_list/public/api/v1/track-order";


   //  static String crm_base="https://crm.drmactive.com";

   static String profile_path = baseUrl + "/uploads/customer/";

  static String property_image = baseUrl + "/uploads/property/banner/";
  static String documents = baseUrl + "/uploads/document/banking/";
  static String builde_logo = baseUrl + "/uploads/builder/logo/";
  static String map_image = baseUrl + "/uploads/property/map/";
   static String event = baseUrl + "/uploads/event/";


   static String post_get = baseUrl + "/uploads/getposts/";
  static String bankImageUrl = baseUrl + '/uploads/loan/bank/';
   static String chnnale_partner_profile = baseUrl + '/uploads/channelpartner/profile/';
   static String builder_profile = baseUrl + '/uploads/builder/logo/';


   static String campaignList = baseUrl + "/apis/CampaignsApi/campaignList?campaign_id=";

  static String login = baseUrl + "/apis/Api/customerLoginSendOtp";
   static String getCampaignInquiryListByUserId = baseUrl + "/apis/CampaignsApi/getCampaignInquiryListByUserId";


   static String notificationsByUser = baseUrl + "/apis/Userapi/notificationsByUser";
   static String notificationsView = baseUrl + "/apis/Userapi/notificationsView";


   static String getInventoryByUserType = baseUrl + "/apis/Leadapi/getInventoryByUserType";
   static String get_show_inventory_details = baseUrl + "/apis/Leadapi/get_show_inventory_details";


   static String ifscCodeByBankName = banking_base + "/property_list/public/api/v1/ifscCodeByBankName";

   static String bankList = banking_base + "/property_list/public/api/v1/bankList";
  static String bank_master_list = baseUrl + "/apis/Listingapi/bank_master_list";
   static String bank_icons = baseUrl + "/apis/Listingapi/bank_master_list";
   static String sellListing = baseUrl + "/uploads/sellListing/";

   // https://demo.drmactive.com/uploads/sellListing/167041125820821m.png


   static String userRegistration = baseUrl + "/apis/Api/userRegistration";
  static String shareInventoryApi = baseUrl + "/apis/Leadapi/shareInventoryApi";
  static String assets=baseUrl+"/uploads/Amenities/logo/";
  static String getUserTypesToRegister = baseUrl + "/apis/Api/getUserTypesToRegister";
  static String getTowerList = baseUrl + "/apis/Propertyapi/getTowerList";
  static String getFloorList = baseUrl + "/apis/Propertyapi/getFloorList";
  static String getUnitPriceDetails = baseUrl + "/apis/Propertyapi/getUnitPriceDetails";
  static String getTypeDetailsByPropId = baseUrl + "/apis/Propertyapi/getTypeDetailsByPropId";
  static String getSpaceDetailsByPropId = baseUrl + "/apis/Propertyapi/getSpaceDetailsByPropId";
  static String rebookingOnlineOfflineFormData = baseUrl + "/apis/Leadapi/rebookingOnlineOfflineFormData";

   static String inventoryAcceptReject = baseUrl + "/apis/Leadapi/inventoryAcceptReject";
   static String upcommingSiteVisit = baseUrl + "/apis/Leadapi/upcommingSiteVisit";

  static String usersList = baseUrl + "/apis/Userapi/usersList";
  static String loginVerifyOtp = baseUrl + "/apis/Api/loginVerifyOtp";
  static String loginWithPassword = baseUrl + "/apis/Leadapi/getCustomerLogin";//
  static String commonRegistration = baseUrl + "/apis/Api/commonRegistration";
  static String getCompanyTypesList = baseUrl + "/apis/Api/getCompanyTypesList";
  static String generateMPIN = baseUrl + "/apis/Api/generateMPIN";
  static String validateMPIN = baseUrl + "/apis/Api/validateMPIN";
  static String getLeadList = baseUrl + "/apis/Leadapi/getLeadList";
  static String saveLeadGeneralDetail = baseUrl + "/apis/Leadapi/saveLeadGeneralDetail";
  static String getLeadScenarioResponse = baseUrl + '/apis/Leadapi/getLeadScenarioResponse';
  static String getActivityHistoryDetailByLeadID = baseUrl + "/apis/Leadapi/getActivityHistoryByLeadID";
  static String getAllNotesByLeadID = baseUrl + "/apis/Leadapi/getAllNotesByLeadID";
  static String getMeetingDetailByLeadID = baseUrl + "/apis/Leadapi/getMeetingDetailByLeadID";
  static String editRescheduleSiteVisit = baseUrl + '/apis/Leadapi/editRescheduleSiteVisit';
  static String seacrhPropertyLists = baseUrl + "/apis/Propertyapi/seacrhPropertyLists";
  static String getLeadScenarioStage = baseUrl + '/apis/Leadapi/getLeadScenarioStage';
  static String getSiteVisitDetailByLeadID = baseUrl + "/apis/Leadapi/getSiteVisitDetailByLeadID";
  static String editLeadRequirement = baseUrl + "/apis/Leadapi/editLeadRequirement";
  static String saveLeadRequirement = baseUrl + "/apis/Leadapi/saveLeadRequirement";
  static String getLeadSources = baseUrl + "/apis/Leadapi/getLeadSources";
  static String getLeadDetail = baseUrl + "/apis/Leadapi/getLeadDetail";
  static String editLeadGeneralDetail = baseUrl + "/apis/Leadapi/editLeadGeneralDetail";
  static String getLeadRequirementDetail = baseUrl + "/apis/Leadapi/getLeadRequirementDetail";
  static String requestforpartnership_list = baseUrl + "/apis/Propertyapi/requestforpartnership_list";
  static String gePropertyListByPropId = baseUrl + "/apis/Propertyapi/gePropertyListByPropId";
  static String city_search = baseUrl + "/apis/Userapi/city_search";
   static String city_property = baseUrl + "/apis/Userapi/city_property";



   static String getCurrencyList = baseUrl + "/apis/Api/getCurrencyList";
  static String document_inbox = baseUrl + "/apis/Userapi/document_inbox";
  static String deleteDocument_post = baseUrl + "/apis/Userapi/deleteDocument";
  static String all_master_data = baseUrl + "/apis/Userapi/all_master_data";
  static String getChannelPartnerList = baseUrl + "/apis/Userapi/all_channelpartner_bylimit";
  static String getLeadDetailByLeadID = baseUrl + "/apis/Leadapi/getLeadDetailByLeadID";
  static String getNewLeadUpcomingCall = baseUrl + "/apis/Leadapi/getNewLeadUpcomingCall";
  static String getUpcomingCallByLeadID = baseUrl + "/apis/Leadapi/getUpcomingCallByLeadID";
  static String getMissedByLeadID = baseUrl + "/apis/Leadapi/getMissedByLeadID";
  static String getAppointmentDetail = baseUrl + "/apis/Leadapi/getAppointmentDetail";
  static String getSiteVisitDetail = baseUrl + "/apis/Leadapi/getSiteVisitDetail";
  static String addSiteVisitByLeadID = baseUrl + "/apis/Leadapi/addSiteVisitByLeadID";
  static String addMeetingByLeadID = baseUrl + "/apis/Leadapi/addMeetingByLeadID";
  static String approveRequest = baseUrl + "/apis/propertyapi/approverequest";
  static String approveRejectRequest =baseUrl + "/apis/propertyapi/approvebyrequestid";
   static String addRentAgreement = baseUrl + "/apis/Userapi/addRentAgreement";
   static String saveActivityForSiteVisits = baseUrl + "/apis/Leadapi/saveActivityByLeadId";
   static String savePaymentForSiteVisits=baseUrl + "/apis/Leadapi/savePaymentDetail";
   static String getLeadrequirement = baseUrl + "/apis/Leadapi/getLeadrequirement";
   static String getPropertyType = baseUrl + "/apis/Leadapi/getPropertyType";
   static String gePropertyListbytype = baseUrl + "/apis/propertyapi/gePropertyListbytype";
   static String getDashboard = baseUrl + "/apis/Propertyapi/getDashboard";
   static String gePropertyListbySpace = baseUrl + "/apis/propertyapi/gePropertyListbySpace";
   static String offerTypesChildren = baseUrl + "/apis/OffersCampaignsApi/offerTypesChildren";
   static String OffersCampaignsApi_list = baseUrl + "/apis/OffersCampaignsApi/lists/";
   static String getCategory = baseUrl + "/apis/Couponsapi/getCategory";
   static String getCoupons = baseUrl + "/apis/Couponsapi/getCoupons";

   static String getLevelsOffers = baseUrl + "/apis/Couponsapi/getLevelsOffers";
   static String getBlog = baseUrl +"/apis/Propertyapi/getBlog";
   static String redeemGiftcard = baseUrl + "/apis/Couponsapi/redeemGiftcard";
   static String markCouponViewed = baseUrl + "/apis/Couponsapi/markCouponViewed";


   static String walletBalance = baseUrl + "/apis/Couponsapi/walletBalance";
   static String appContactAddress = baseUrl + "/apis/Leadapi/appContactAddress";

   static String SaveLeadRequirementDetail  = baseUrl + "/apis/Leadapi/SaveLeadRequirementDetail";

   static String logProductsView  = baseUrl + "/apis/Couponsapi/logProductsView";
   static String logGiftcardsView  = baseUrl + "/apis/Couponsapi/logGiftcardsView";




   static String isSpinned = baseUrl + "/apis/OffersCampaignsApi/isSpinned/";
   static String markSpinned = baseUrl + "/apis/OffersCampaignsApi/markSpinned/";
   static String userDeviceReferral = baseUrl + "/apis/Leadapi/userDeviceReferral";
   static String appDownload = baseUrl + "/apis/userapi/appDownload";





  static String getBookPropertyListbytype = baseUrl + "/apis/propertyapi/getBookPropertyListbytype";



  static String gePropertyListbytypeWithoutToken = baseUrl + "/apis/propertyapi/gePropertyListbytypeWithoutToken";

  static String save_partnership_request_form = baseUrl + "/apis/Propertyapi/save_partnership_request_form";

  static String getTaskType = baseUrl + "/apis/Leadapi/getTaskType";
  static String addTaskDetail = baseUrl + "/apis/Leadapi/addTaskDetail";
  static String getAllTaskByLeadID = baseUrl + "/apis/Leadapi/getAllTaskByLeadID";
  static String updateTask = baseUrl + "/apis/Leadapi/updateTask";
  static String getActivityCategory = baseUrl + "/apis/Leadapi/getActivityCategory";
  static String saveActivityById = baseUrl + "/apis/Leadapi/saveActivityById";
  static String getTimezoneList = baseUrl + "/apis/Leadapi/getTimezoneList";
  static String getOwnerList = baseUrl + "/apis/Leadapi/getOwnerList";
  static String updateTaskDetail = baseUrl + "/apis/Leadapi/updateTaskDetail";
  static String updateOwnerByID = baseUrl + "/apis/Leadapi/updateOwnerByID";

  static String searchTaskByDate = baseUrl + "/apis/Leadapi/searchTaskByDate";
  static String searchSiteVisitTaskByTaskID = baseUrl + "/apis/leadapi/searchSiteVisitTaskByTaskID";
  static String searchMeetingTaskByTaskID = baseUrl + "/apis/leadapi/searchMeetingTaskByTaskID";
  static String searchFollowUpTaskByTaskID = baseUrl + "/apis/Leadapi/searchFollowUpTaskByTaskID";
  static String searchCallTaskByTaskID = baseUrl + "/apis/leadapi/searchCallTaskByTaskID";
  static String getActivityStatusById = baseUrl + "/apis/leadapi/getActivityStatusById";
  static String getLeadcount = baseUrl + "/apis/leadapi/getLeadcount";
  static String updateLeadStageByID = baseUrl + "/apis/leadapi/updateLeadStageByID";


  static String checkAccountStatus = baseUrl + "/apis/Api/accountstatus";
  static String getAccountSummery = baseUrl + "/apis/Api/accountsumary";
  static String getBeneficiariesList = baseUrl + "/apis/Api/getbenificerylist";
  static String addInsideBeneficiaries = baseUrl + '/apis/Api/addbenificerygenotpinside';
  static String addbenificeryotpsubmitinside = baseUrl + "/apis/Api/addbenificeryotpsubmitinside";
  static String addOutsideBeneficiaries = baseUrl + '/apis/Api/addbenificerygenotpoutside';
  static String addBeneficiriesotpsubmitoutside = baseUrl + '/apis/Api/addbenificeryotpsubmitoutside';
  static String generateOTPforBanking = baseUrl + '/apis/Api/genrateotpforbanking';
  static String submitOTPforBanking = baseUrl + '/apis/Api/otpsubmitforbanking';
  static String getAccountStatement = baseUrl + '/apis/Api/useraccountstatement';

  // Fund Transfer API
  static String bankdetailfortransfer = baseUrl + '/apis/Api/bankdetailfortransfer';
  static String generateOtpForTransfer = baseUrl + '/apis/Api/genrateotpfortransfer';
  static String otpSubmitForTransfer = baseUrl + '/apis/Api/otpsubmitfortransfer';


  static String addLoanBasicDetailByApp = baseUrl + "/apis/Loanapi/addLoanBasicDetailByApp";
  static String getLoanBasicDetailByApp = baseUrl + "/apis/Loanapi/getLoanBasicDetailByApp";
  static String Listing = baseUrl + "/apis/RequirementsListingApi/Listing";
  static String searchPropForListing = baseUrl + "/apis/RequirementsListingApi/searchPropForListing";
  static String deleteList = baseUrl + "/apis/RequirementsListingApi/deleteList";
  static String likeDislikeList = baseUrl + "/apis/RequirementsListingApi/likeDislikeList";
  static String getAmenitiesList = baseUrl + "/apis/MasterValues/AmenitiesList";
  static String saveRequirementDetail = baseUrl + "/apis/Leadapi/saveRequirementDetail";
  static String getPropertDetailByPropID = baseUrl + "/apis/Leadapi/getPropertDetailByPropID";
  static String getPropertDetailByPropIDWithOutToken = baseUrl + "/apis/propertyapi/gePropertyListbytypeWithoutToken";
  static String click_to_call = baseUrl + "/apis/Ivr/click_to_call";

  //Get Customer Enqueries properties list
  static String getCustomerEnquiry = baseUrl + "/apis/Leadapi/getCustomerEnquiry";
  // get the list of channel partner of particuler broker/rm/channel partners
  static String getCPByLeadidCustomerEnquiry = baseUrl + "/apis/Leadapi/getCPByLeadidCustomerEnquiry";
  // get list of RMs of particuler lead.
  static String getRMByLeadidCustomerEnquiry = baseUrl + "/apis/Leadapi/getRMByLeadidCustomerEnquiry";
  static String getPropertyListbyuserid = baseUrl + "/apis/Leadapi/getPropertyListbyuserid";

  //Accept any customer inventory
  static String getCustomerAcceptReject =baseUrl + "/apis/Leadapi/customerAcceptReject";
  //get customer enqueries broker list
  static String getCustomerEnqueriesBroker =baseUrl + "/apis/Leadapi/getCustomerEnquirybroker";
  static String customerAcceptRejectProperty =baseUrl + "/apis/Leadapi/customerAcceptRejectProperty";
  static String getCustomerEnquiryCPbrokerProperty =baseUrl + "/apis/Leadapi/getCustomerEnquiryCPbrokerProperty";
  static String getUserProfileCP = baseUrl+'/apis/Usertracking/getUserProfileCP';

  static String allTransaction = baseUrl+'/apis/Leadapi/allTransaction';
  static String builderDetails = baseUrl+'/apis/Userapi/builderDetails';



  //Resgister Customer is he/she is not already of our customer.
  static String postCustomerRegistration = baseUrl + "/apis/Leadapi/getCustomerRegistration";
  static String getCustomerRegistrationSave = baseUrl + "/apis/Leadapi/getCustomerRegistrationSave";



  static String addPropertyLead = baseUrl + "/apis/Leadapi/addPropertyLead";
  static String addPropertyforlater = baseUrl + "/apis/Leadapi/addPropertyforlater";

  static String addBroker = baseUrl + "/apis/Leadapi/getBrokerRegistrationAPI";
  static String getBroker = baseUrl + "/apis/Leadapi/getBrokerRegistrationData";

  static String property_brochures = baseUrl + "/uploads/property/property_brochures/";

  // Save Loan Enqueries Form Data .
  static String saveLoanEnquery = baseUrl + "/apis/Userapi/saveLoanEnquiry";
  static String getLoanDetail = baseUrl + "/apis/Leadapi/getLoanDetail";
  static String campaignRegister = baseUrl + "/apis/CampaignsApi/campaignRegister";




  //Get All Channel Partners List data to the users..
  static String getAllChanelPartnerList = baseUrl + "/apis/Leadapi/getAllChanelPartnerList";

  // Get Inventory of Broker shared documents for customer on particular Properties .
  static String getRequirementRMCustomer = baseUrl + "/apis/Leadapi/getRequirementRMCustomer";
  // Save the Inventory details here.
  static String saveRMRequirementDetail = baseUrl + "/apis/Leadapi/saveRMRequirementDetail";
  //get post listing and requirements
  static String getMasters = baseUrl + "/api/v1/getMasters";
  static String getCities = baseUrl + "//api/v1/getCities";
  static String getPropertiesByCity = baseUrl + "/api/v1/getPropertiesByCity";
  static String getFeatures = baseUrl + "/api/v1/getFeatures";
  static String allProperty  = baseUrl + "/api/v1/allProperty";
  static String myListing  = baseUrl + "/api/v1/myListing";
  static String get_post_images  = baseUrl + "/images/";
  static String post_property  = baseUrl + "/api/v1/property";
  static String propertyDetails  = baseUrl + "/api/v1/propertyDetails";
  static String pathForAminities=baseUrl+"/property/amenities/";
  static String addRequirement  = baseUrl + "/api/v1/requirement";
  static String updateListingStatus=baseUrl+"/api/v1/updateListingStatus";



  /// Adhaar Card Verification API.
  static String uploadPanAdhaar =baseUrl+"/apis/Leadapi/uploadDocumentUser";

  /// new Banking APIs on CRM baseUrl.
  static String sendOtpVerify=baseUrl+"/property_list/public/api/v1/sendOtpVerify";
  static String otpVerify=baseUrl+"/property_list/public/api/v1/otpVerify";




  static String registerlead_by_prop_id = baseUrl + "/apis/Leadapi/registerlead_by_prop_id";
  static String lead_image = baseUrl + "/uploads/leads/";
  static String requirementShare = baseUrl + "/apis/Leadapi/requirementShare";
  static String addInterst=baseUrl+"/api/v1/addInterst";

  /// terms and conditions
  static String tnc=baseUrl+"/apis/Leadapi/tnc";
  static String getCustomerRMSiteVisitDetail=baseUrl+"/apis/Leadapi/getCustomerRMSiteVisitDetail";
  static String getCustomerRMrequirementData=baseUrl+"/apis/Leadapi/getCustomerRMrequirementData";

  /// sitevisits..
  static String getSiteVisitByConsumerId=baseUrl+"/apis/Leadapi/getSiteVisitByConsumerId";
  static String customersitevisitAcceptReject=baseUrl+"/apis/Leadapi/customersitevisitAcceptReject";


  /// SHow Interest
  static String show_intrest = baseUrl + "/apis/Leadapi/addPropertyforlater";


  ///Blog API
  static String blogAPI = 'https://www.ipropunited.com/wp-json/wp/v2/posts';
  static String blogAuthor = "https://www.ipropunited.com/wp-json/wp/v2/users/";
  static String blogMedia= "https://www.ipropunited.com/wp-json/wp/v2/media";
  static String blogCategory= "https://www.ipropunited.com/wp-json/wp/v2/categories?per_page=50";



  ///Loan Page
  static String loanMapping= baseUrl+"/apis/Loanapi/mapping_partial";
  static String loanEMail= baseUrl+"/apis/Loanapi/mapping_partial_email_byId";
  static String payBill=banking_base+"/property_list/public/api/v1/payBill";
  static String saveBillDetail=banking_base+"/property_list/public/api/v1/saveBillDetail";
  static String crm_legal_list= baseUrl+"/apis/Listingapi/crm_legal_list";
  static String slot_list= baseUrl+"/apis/Listingapi/slot_list";
  static String booking_slot_insert= baseUrl+"/apis/Propertyapi/booking_slot_insert";
  static String booking_slot_update= baseUrl+"/apis/Propertyapi/booking_slot_update";
  static String eventList_id= baseUrl+"/apis/CampaignsApi/eventList_id";
  static String event_speakers= baseUrl+"/uploads/event/";


  static String booking_slot_list= baseUrl+"/apis/Propertyapi/booking_slot_list";


  static String customerCheck = baseUrl + "/apis/Leadapi/customerCheck";
  static String customerInvite = baseUrl + "/apis/Leadapi/customerInvite";
  static String saveLoanEnquiry = baseUrl + "/apis/Userapi/saveLoanEnquiry";
  static String getLoanTypeMaster = baseUrl + "/apis/Usertracking/getLoanTypeMaster";
  static String getDataTaskIDByLeadID = baseUrl + "/apis/Leadapi/getDataTaskIDByLeadID";
  static String uoloadImagesbyleadtaskid = baseUrl + "/apis/Leadapi/uoloadImagesbyleadtaskid";
  static String getPropertyforlater = baseUrl + "/apis/Leadapi/getPropertyforlater";
  static String shareCostSheet = baseUrl + "/apis/Leadapi/shareCostSheet";
  static String savePayNowFormData = baseUrl+"/apis/Leadapi/savePayNowFormData";
  static String updatePayment = baseUrl+"/apis/Userapi/updatePayment";


  static String payOnlineOfflineFormData = baseUrl+"/apis/Leadapi/payOnlineOfflineFormData";
  static String editCustommerDetails = baseUrl+"/apis/Leadapi/editCustommerDetails";
  static String all_master_datas = baseUrl + "/apis/Userapi/all_master_data";
  static String crm_customer_requirment_insert = baseUrl+"/apis/Listingapi/crm_customer_requirment_insert";
  static String crm_customer_requirment_list = baseUrl+"/apis/Listingapi/crm_customer_requirment_list";
  static String getMyBookingDetails = baseUrl+"/apis/Propertyapi/getMyBookingDetails";
  static String genrateotpforForgetPassword = baseUrl+"/apis/Api/genrateotpforForgetPassword";
  static String validate_Forget_otp_verify = baseUrl+"/apis/Api/validate_Forget_otp_verify";
  static String forget_password = baseUrl+"/apis/Api/forget_password";
  static String getBbpsimageData = baseUrl+"/apis/Leadapi/getBbpsimageData";
  static String paymentRefund = baseUrl+"/apis/Leadapi/paymentRefund";
  static String passwordChange = baseUrl+"/apis/Userapi/passwordChange";
  static String getKYCstatus = baseUrl+"/apis/Userapi/getKYCstatus";
  static String milestoneDetails = baseUrl+"/apis/Userapi/milestoneDetails";
  static String document = baseUrl+"/uploads/banking/";
  static String checkAccountBalance=banking_base+"/property_list/public/api/v1/checkAccountBalance";
  static String checkUser=banking_base+"/property_list/public/api/v1/checkUser";
  static String miniStatement=banking_base+"/property_list/public/api/v1/miniStatement";
  static String accountHistory=banking_base+"/property_list/public/api/v1/accountHistory";
  static String listBenifecery=banking_base+"/property_list/public/api/v1/listBenifecery";
  static String benificeryAccountAdded=banking_base+"/property_list/public/api/v1/benificeryAccountAdded";
  static String blockAccount=banking_base+"/property_list/public/api/v1/blockAccount";
  static String aadhaarOTP=banking_base+"/property_list/public/api/v1/aadhaarOTP";
  static String aadhaarOTPVerify=banking_base+"/property_list/public/api/v1/aadhaarOTPVerify";
  static String verifyPan =banking_base+"/property_list/public/api/v1/verifyPan";
  static String createAccount=banking_base+"/property_list/public/api/v1/createAccount";
  static String bbpsicicitranaction=banking_base+"/property_list/public/api/v1/bbpsicicitranaction";
  static String bankTransferLive=banking_base+"/property_list/public/api/v1/bankTransferLive";
  static String bankTransfer=banking_base+"/property_list/public/api/v1/bankTransfer";
  static String booknowTransaction=banking_base+"/property_list/public/api/v1/booknowTransaction";
  static String milestonetransaction=banking_base+"/property_list/public/api/v1/milestonetransaction";
  static String operatorList = banking_base+"/property_list/public/api/v1/operatorList";
  static String fetchBillDetails =banking_base+"/property_list/public/api/v1/fetchBillDetails";


  //banking
  static String createToken=banking_base+"/property_list/public/api/v1/token";
  static String walletTransaction = banking_base+'/property_list/public/api/v1/walletTransaction';
  static String walletTransaction1 = banking_base+'/property_list/public/api/v1/walletTransaction';
  static String milestonesListsForBooking=baseUrl+"/apis/Userapi/milestonesListsForBooking";


}