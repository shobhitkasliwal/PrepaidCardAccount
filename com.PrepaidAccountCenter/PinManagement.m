//
//  PinManagement.m
//  com.PrepaidAccountCenter
//
//  Created by Shobhit Kasliwal on 7/14/13.
//  Copyright (c) 2013 Liventus. All rights reserved.
//

#import "PinManagement.h"
#import "SingletonGeneric.h"
#import "UIColor+Hex.h"
#import "RTNetworkRequest.h"
#import "SVProgressHUD.h"
#import "AppConstants.h"

#define CHANGE_PIN_CONFIRMATION_POPUP_TAG 1
#define CHANGE_PIN_CONFIRMATION_POPUP_ERROR_TAG 2

@interface PinManagement ()

@end
CardInfo *cInfo;
@implementation PinManagement

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Pin Management";
    cInfo  =  [[SingletonGeneric UserCardInfo] SelectedCard];
    
    NSString* cardNumbertxt = [NSString stringWithFormat:@"%@%@", @"Card Account: ", cInfo.cardNumber  ];
    [_lblHeaderCard setText:cardNumbertxt];
    
    _uiHeader.colors = [NSArray arrayWithObjects:[UIColor colorWithHexString:@"9F9F9F"], [UIColor colorWithHexString:@"2F2F2F"], nil];
    _uiHeader.layer.cornerRadius = 8; // if you like rounded corners
    _uiHeader.layer.shadowOffset = CGSizeMake(-15, 20);
    _uiHeader.layer.shadowRadius = 5;
    _uiHeader.layer.shadowOpacity = 0.5;
    
    
    _uiPinView.layer.cornerRadius = 8; // if you like rounded corners
    _uiPinView.layer.shadowOffset = CGSizeMake(-15, 20);
    _uiPinView.layer.shadowRadius = 5;
    _uiPinView.layer.shadowOpacity = 0.5;
    
    [_btnChangePin useBlackStyle ];
    [_btnCancel useBlackStyle];
    
    [_txtPin setEnabled:NO];
	[_txtPin setAlpha:0.5];
    
    [SVProgressHUD showWithStatus:@"Retriving Pin.\n Please Wait..." maskType:SVProgressHUDMaskTypeGradient];
    
    RTNetworkRequest* networkRequest = [[RTNetworkRequest alloc] initWithDelegate:self];
    [networkRequest makeWebCall:[NSString stringWithFormat:GET_PIN_SERVICE_URL,cInfo.cardProxy, cInfo.WcsClientID, cInfo.SiteConfigID] httpMethod:RTHTTPMethodGET];
    
    
    [_lblViewPinMessage setNumberOfLines:0];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    gestureRecognizer.cancelsTouchesInView = NO; //so that action such as clear text field button can be pressed
    [self.view addGestureRecognizer:gestureRecognizer];
    // Do any additional setup after loading the view.
    [self ChangePinAvailable:cInfo.ChangePinAllowed];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [_lblViewPinMessage setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor clearColor];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LogoutClick:(id)sender {
    [self performSegueWithIdentifier:@"PinManagementLogout" sender:nil];
}

- (IBAction)hideKeyBoard:(id)sender
{
    [_txtNewPin resignFirstResponder];
    
}


-(void) serviceCallCompletedWithError:(NSError*) error
{
    
    [SVProgressHUD dismiss];
    
    NSString* str = [NSString stringWithFormat:@"An error occured while retriving PIN.\n Please contact customer support for more details."];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Message" message: str delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}
-(void)serviceCallCompleted:(BOOL)isSuccess withData:(NSMutableData *)respData currentCallType:(NSMutableString *)currentCallType
{
    [SVProgressHUD dismiss];
    NSMutableArray* responseArray = [NSJSONSerialization JSONObjectWithData:respData options:0 error:nil];
    if (responseArray != nil) {
        
        
        for (NSDictionary* dict in responseArray){
            
            if([dict count] == 1)
            {
                NSString* str = [dict objectForKey:@"Message"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Message" message: str delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            else{
                [_txtPin setText:[dict objectForKey:@"PIN"]];
                [_lblViewPinMessage setHidden:YES];
                if(cInfo.ViewChangePinMessage == YES)
                {
                    [_lblViewPinMessage setText:[dict objectForKey:@"PinMessage"]];
                    [_lblViewPinMessage setHidden:NO];
                }
                else{
                    [_lblViewPinMessage setHidden:YES];
                }
                
            }
        }
        
    }
    
    else
    {
        NSString* str = [NSString stringWithFormat:@"An error occured while retriving PIN.\n Please contact customer support for more details."];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Message" message: str delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
}

- (void)networkNotReachable{}
-(void) ChangePinAvailable:(BOOL) value
{
    if (!value)
    {
        [_txtNewPin setHidden:TRUE];
        [_btnChangePin setHidden:TRUE];
        _constraint_LabelTopSpace.constant = 60;
        
    }
    else{
        [_txtNewPin setHidden:FALSE];
        [_btnChangePin setHidden:FALSE];
        _constraint_LabelTopSpace.constant = 120;
    }
    //[_txtNewPin setHidden:FALSE];
    // [_btnChangePin setHidden:FALSE];
    
}




- (IBAction)btnChangePin_Click:(id)sender {
    NSString* Error = @"";
    if (_txtNewPin.text.length == 0)
    {
        Error = @"Please enter the new Pin.";
    }
    else if (_txtNewPin.text.length != 4)
    {
        Error = @"Pin must be 4 numbers.";
    }
    if (Error.length ==0 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Message" message:@"Are you sure you want to change pin ?"  delegate: self cancelButtonTitle:@"YES" otherButtonTitles:@"No", nil];
        alert.tag = CHANGE_PIN_CONFIRMATION_POPUP_TAG;
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message:Error delegate: self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = CHANGE_PIN_CONFIRMATION_POPUP_ERROR_TAG;
        [alert show];
    }
}


- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case CHANGE_PIN_CONFIRMATION_POPUP_TAG:
                if (buttonIndex == 0 )
                {
                    [SVProgressHUD showWithStatus:@"Updating Pin.\n Please Wait..." maskType:SVProgressHUDMaskTypeGradient];
                    
                }
            break;
        case CHANGE_PIN_CONFIRMATION_POPUP_ERROR_TAG:
        default:
            break;
    }
    if (alertView.tag == CHANGE_PIN_CONFIRMATION_POPUP_TAG &&   buttonIndex == 0){
      //  NSString* UserCredentialID = [[[SingletonGeneric UserCardInfo] UserCredenitalInfo] objectForKey:LOGGEDIN_USERCREDNTIALID];
     //   RTNetworkRequest* networkRequest = [[RTNetworkRequest alloc] initWithDelegate:self];
      //  networkRequest.currentCallType = [NSMutableString stringWithString:@"AddCardToUserService"];
       // [networkRequest makeWebCall:[NSString stringWithFormat:ADD_CARD_TO_USER_SERVICE_URL, UserCredentialID, LoggedinWithCard_CardNumber, LoggedinWithCard_SecurityPin] httpMethod:RTHTTPMethodGET];
    }else if (buttonIndex == 1){
        //reset clicked
    }
}
@end
