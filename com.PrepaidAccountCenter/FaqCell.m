//
//  DemoTableViewCell.m
//  RTLabelProject
//
//  Created by honcheng on 5/1/11.
//  Copyright 2011 honcheng. All rights reserved.
//

#import "FaqCell.h"


@implementation FaqCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
		_rtLabel = [FaqCell textLabel];
		[self.contentView addSubview:_rtLabel];
		[_rtLabel setBackgroundColor:[UIColor clearColor]];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        // Initialization code.
		_rtLabel = [FaqCell textLabel];
		[self.contentView addSubview:_rtLabel];
		[_rtLabel setBackgroundColor:[UIColor clearColor]];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGSize optimumSize = [self.rtLabel optimumSize];
	CGRect frame = [self.rtLabel frame];
	frame.size.height = (int)optimumSize.height+5; // +5 to fix height issue, this should be automatically fixed in iOS5
    frame.size.width = (int) self.contentView.frame.size.width;
	[self.rtLabel setFrame:frame];
//    NSMutableDictionary *viewsDictionary = [NSMutableDictionary dictionary];
//    [viewsDictionary addEntriesFromDictionary:NSDictionaryOfVariableBindings(_rtLabel)];
//    
//    
//    
//    // disable translatesAutoresizingMaskIntoConstraints in views for auto layout
//    [viewsDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
//     {
//         [obj setTranslatesAutoresizingMaskIntoConstraints:NO];
//     }];
//     NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:
//                           @"|-[_rtLabel]-|"
//                                                                options:kNilOptions
//                                                              metrics:nil
//                                                              views:viewsDictionary];
//    
   // [self.contentView addConstraints:constraints];
}

+ (RTLabel*)textLabel
{
	RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(10,10,300,100)];
    [label sizeToFit];
	//[label setFont:[UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:20]];
    [label setParagraphReplacement:@""];
  
	return label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

@end