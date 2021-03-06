
@interface AppConstants : NSObject

/*    SERVICE Constants   */
#define SERVICE_BASE_URL @"https://test.prepaidcardstatus.com/MobileServices/JsonService.asmx/"
#define AUTHENTICATE_SERVICE_URL SERVICE_BASE_URL @"AuthenticateUser?UserName=%@&Password=%@&AuthenticationType=%@"
#define CREATE_CREDENTIAL_SERVICE_URL SERVICE_BASE_URL @"CreateLoginCredentials?UserName=%@&Password=%@"
#define ADD_CARD_TO_USER_SERVICE_URL SERVICE_BASE_URL @"AddCardToUserName?UserCredentialID=%@&CardNumber=%@&pin=%@"
#define FAQ_SERVICE_URL SERVICE_BASE_URL @"GetFaq?SiteconfigID=%@"
#define TERM_SERVICE_URL SERVICE_BASE_URL @"GetTerms?SiteconfigID=%@"
#define GET_PROFILE_SERVICE_URL SERVICE_BASE_URL @"GetCardProfile?Proxy=%@&WCSClientID=%@"
#define GET_TRANSACTION_SERVICE_URL SERVICE_BASE_URL @"GetTransactions?Proxy=%@&NoofDays=%@&WCSClientID=%@"
#define GET_PIN_SERVICE_URL SERVICE_BASE_URL @"GetCardPinInformation?Proxy=%@&WCSClientID=%@&SiteConfigID=%@"
#define COUNTRY_LIST_SERVICE SERVICE_BASE_URL @"GetCountryList"
#define STATE_LIST_SERVICE SERVICE_BASE_URL @"GetStateList"
#define SECONDARY_AUTHENTICATE_USER SERVICE_BASE_URL @"SecondaryAuthenticateUser?CardProxy=%@&WCSClientId=%@&SiteConfigId=%@&Value=%@"
#define UPDATE_CARD_PROFILE_SERVICE SERVICE_BASE_URL @"UpdateCardProfile?PersonId=%@&FirstName=%@&LastName=%@&Address1=%@&Address2=%@&City=%@&Country=%@&State=%@&Zip=%@&Phone=%@&Email=%@"
#define UPDATE_CARD_PIN_SERVICE SERVICE_BASE_URL @"UpdateCardPIN?CardProxy=%@&WCSClientId=%@&NewPIN=%@"
#define REMOVE_CARD_SERVICE SERVICE_BASE_URL @"RemoveCardFromUsername?CardProxy=%@&Username=%@"
#define ACTIVATE_CARD_SERVICE SERVICE_BASE_URL @"ActivateCard?CardProxy=%@&WCSClientId=%@"



/*    SERVICE Constants   */

/* Other Constants */
#define INTERNET_NOT_AVAILABLE_POPUP_TEXT @"Please check your internet connection."
#define INTERNET_NOT_AVAILABLE_POPUP_TITLE @"Message"
#define SERVICE_ERROR_POPUP_TEXT @"There is an error occured while processing your request. Please contact Customer support for more details."
#define SERVICE_ERROR_POPUP_TITLE @"Message"
#define LOGGEDIN_CREDENTIAL_KEY_USERNAME @"Username"
#define LOGGEDIN_CREDENTIAL_KEY_PASSWORD @"Password"
#define LOGGEDIN_CREDENTIAL_KEY_SELECTED_LOGIN_OPTION @"SelectedOption"
#define LOGGEDIN_OPTION_CARD @"LoginByCard"
#define LOGGEDIN_OPTION_USERNAME @"LoginByUsername"
#define LOGGEDIN_USERCREDNTIALID @"UserCredentialID"


#define  isTestEnvironment NO
/* Other Constants */


@end
