//
//  PAC_LoginViewViewController.h
//  com.PrepaidAccountCenter
//
//  Created by Shobhit Kasliwal on 6/7/13.
//  Copyright (c) 2013 Liventus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTNetworkRequest.h"
#import "OBGradientView.h"
#import "GradientButton.h"

@interface LoginViewController : UIViewController <RTNetworkRequestDelegate>
@property (strong, nonatomic) IBOutlet OBGradientView *vw_MainView;
@property (weak, nonatomic) IBOutlet UILabel *lblCardNumberUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblPasswordSecurityCode;
@property (weak, nonatomic) IBOutlet UIView *vwHorizontalLine;
@property (weak, nonatomic) IBOutlet UITextField *txtUsernameCard;
@property (weak, nonatomic) IBOutlet UITextField *txtPasswordSecPin;

@property (strong, nonatomic) IBOutlet UIView *vwLoginwithCard;
@property (strong, nonatomic) IBOutlet UISwitch *SwitchCardUsernameLogin;

- (IBAction)btnLogin_Click:(id)sender;
@property (weak, nonatomic) IBOutlet GradientButton *btnLogin;

@property (weak, nonatomic) IBOutlet UIView *vwLoginSwitch;
- (IBAction)SwitchCardUsernameLogin_ValueChanged:(UISwitch*)sender;
- (IBAction)hideKeyBoard:(id)sender;
@end
