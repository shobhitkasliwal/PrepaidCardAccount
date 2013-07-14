//
//  NSObject+CardInfo.h
//  com.PrepaidAccountCenter
//
//  Created by Shobhit Kasliwal on 7/13/13.
//  Copyright (c) 2013 Liventus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  CardInfo:NSObject
- (id)init;
- (id)initWithCardNumber:(NSString *)cardNum andExpiration:(NSString *)expiration andBalance:(NSString *)balance andStatus: (NSString*) status;
@property (nonatomic, strong) NSString* cardNumber;
@property (nonatomic, strong) NSString* cardExpiration;
@property (nonatomic, strong) NSString* cardBalance;
@property (nonatomic, strong) NSString* cardStatus;
@end
