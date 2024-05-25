class ApiEndpoints {
  //Base URL
  static const baseUrl = 'https://maktab.sa/apiBack/v1/user/';
  //Auth
  static const login = "login";
  static const checkCode = "checkCode";
  static const changeCode = "changeCode";
  static const logout = "logout";
  static const profile = "profile";
  //User
  static const userTypes = "get_user_types";
  static const statistics = "statistics";
  static const userAgreement = "term";
  //Financial Transactions
  static const receivingMoneyMethod = 'receive_monies/';
  static const bankMethod = 'bank';
  static const stcMethod = 'stc';
  static const bankAccounts = 'bank_accounts';
  //Languages
  static const languages = "languages";
  //Settings
  static const settings = 'settings/';
  static const searchData = 'search_data';
  static const officeSettings = 'office_settings';
  //Office
  static const offices = 'offices/';
  static const updateOfficeInfo = 'updateInfo';
  static const updateViewer = 'updateViewer';
  static const downPayment = 'down_payment';
  static const addUnit = 'add_unit';
  static const specialOffices = 'special';
  static const favouriteOffices = 'favourites';
  static const myOffices = 'me';
  static const myUnits = 'my_units';
  static const incompleteOffices = 'incomplete';
  static const incompleteUnits = 'incomplete_units';
  static const addOfficeFiles = 'addFiles';
  static const updateOfficeFiles = 'updateFiles';
  static const deleteOfficeFiles = 'deleteFilesArrPost';
  static const deleteOfficeMainImage = 'deleteMainImage';
  static const updateOfficeDescription = 'update_description';
  static const updateOfficeCategory = 'update_category';
  static const updateOfficeTitle = 'update_title';
  static const updateOfficeStatus = 'update_status';
  static const updateOfficeInterface = 'update_interface';
  static const updateOfficeLocation = 'update_location';
  static const makeOfficeSpecial = 'make_special';
  static const addToAds = 'addToAds';
  static const saveToAds = 'save_to_ads';
  static const updateToAds = 'updateToAds';
  static const deleteFromAds = 'delete';
  static const deleteByAds = 'delete_by_ads';
  static const marketing = 'marketing';
  static const updateOfficeBasicInfo = 'update_name';
  static const updateOfficeLocationInfo = 'update_interface_location';
  //Maps
  static const googleMapsApi = 'https://maps.googleapis.com/maps/api/';
  static const geocoding = 'geocode/json';
  static const placeAutocomplete = 'place/autocomplete/json';
  static const placeDetails = 'place/details/json';
  //Details
  static const details = 'details/';
  //Services
  static const services = 'services/';
  //Features
  static const features = 'features/';
  //Prices
  static const prices = 'prices/';
  static const all = 'all';
  static const getById = 'get_by_id';
  //Facilities
  static const facilities = 'facilities/';
  //Comforts
  static const comforts = 'comforts/';
  //Offers
  static const offers = 'offers/';
  static const myOffers = 'my';
  static const saveOfficeOffer = 'save_offices';
  static const setOfferPrices = 'set_ads_price';
  static const updateOfferOffices = 'update_offices';
  static const statusOfferOffices = 'status_offices';
  static const deleteOfferOffices = 'delete_offices';
  static const deleteOfferPrice = 'delete_ads_price_id';
  //Calendars
  static const calendars = 'calenders/';
  static const office = 'office';
  static const deleteOffice = 'delete_office';
  //Favourites
  static const favourites = 'favorites/';
  static const addFavAds = 'add_fav_ads';
  //Evaluation
  static const evaluations = 'evaluations/';
  static const getMy = 'get_my';
  //Coupons
  static const coupons = 'coupons';
  static const setAdsPrice = '/set_ads_price';
  static const updateStatus = '/update_status';
  static const deleteAdsPrice = '/delete_ads_price_id';
  //Orders
  static const orders = 'orders/';
  static const pending = 'pending/1';
  static const cancel = 'cancel/1';
  //Reports
  static const reports = 'reports';
  //Notifications
  static const notifications = 'notifications/';
  static const notViewed = 'not_viewed';
  static const viewed = 'viewed';
  //Contract
  static const contracts = 'contracts/';
  //Contract Models
  static const contractModels = 'contract_models/';
  static const ready = 'readies';
  static const setStatus = 'setStatus';
  //Contract Ejar
  static const contractEjars = 'contract_ejars/';
  //Commissions
  static const commissions = 'commissions/';
  static const lessor = 'lessor';
  //CRUD
  static const crud = 'crud';
  static const cud = 'cud';
  static const create = 'create';
  static const save = 'save';
  static const update = 'update';
  static const delete = 'delete';
  //National Access
  static const verifyNationalID = 'verifyNationalID';
  static const verifyResidenceID = 'verifyResidenceID';
}
