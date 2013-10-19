//
//  SingletonCardInfo.h
//  com.PrepaidAccountCenter
//
//  Created by Shobhit Kasliwal on 7/14/13.
//  Copyright (c) 2013 Liventus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardInfo.h"

@interface SingletonGeneric : NSObject
@property (nonatomic, strong) NSMutableArray *UserCardInformation;
@property (nonatomic,strong)CardInfo *SelectedCard;
@property (nonatomic,strong) NSMutableDictionary *UserCredenitalInfo;
@property (nonatomic,weak) NSString* CountryListVersion;
@property (nonatomic,weak) NSString* StateListVersion;

+(SingletonGeneric*) UserCardInfo;
-(void)RetriveUserCardInfo:(NSString*)userName;
-(void)SetSelectedCardInfo:(int) index;

-(void) setAllCardInfo: (NSMutableArray*) arrCardInfo;
-(void) addCardInfo: (CardInfo*) cinfo;


@end
