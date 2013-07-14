//
//  PAC_LoggedIn_HomeViewController.m
//  com.PrepaidAccountCenter
//
//  Created by Shobhit Kasliwal on 6/11/13.
//  Copyright (c) 2013 Liventus. All rights reserved.
//

#import "PAC_LoggedIn_HomeViewController.h"
#import "CardInfo.h"
#import "SingletonGeneric.h"
#import "PAC_ScrollCardView.h"
#import <QuartzCore/QuartzCore.h>
#import "ContactUs.h"
#import "Terms.h"
#import "Faq.h"

@interface PAC_LoggedIn_HomeViewController ()
@property (nonatomic, strong) NSArray *pageCardInformation;
@property (nonatomic, strong) NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;
@end

@implementation PAC_LoggedIn_HomeViewController


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
    
    _uiScrollCard.frame = CGRectMake(0, 5, _uiPageMainView.frame.size.width -20, 75);
	
    self.navigationItem.title=@"Prepaid Account Center";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Back"
                                   style:UIBarButtonItemStylePlain
                                   target:nil
                                   action:nil];
    self.navigationItem.backBarButtonItem=backButton;
  
//    
    
    // Do any additional setup after loading the view.
   
   
    [[SingletonGeneric UserCardInfo] RetriveUserCardInfo:@"Shobhit"];
    self.pageCardInformation = [[SingletonGeneric UserCardInfo] UserCardInformation];
    // setting the selected Card to 0 by Default
    [[SingletonGeneric UserCardInfo]SetSelectedCardInfo:0];
    
    
    NSInteger pageCount = self.pageCardInformation.count;
    
    if(pageCount ==1)
    {
        [self.uiPageControlScrollCard setHidden:YES];
    }
    
    // Set up the page control
    self.uiPageControlScrollCard.currentPage = 0;
    self.uiPageControlScrollCard.numberOfPages = pageCount;
    
    // Set up the array to hold the views for each page
    self.pageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < pageCount; ++i) {
        [self.pageViews addObject:[NSNull null]];
    }
    
    
    [self.uiContactUSView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowContactUS:)]];
    [self.uiTermsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowTerms:)]];
    [self.uiFaqView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowFaq:)]];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the content size of the scroll view
    CGSize pagesScrollViewSize = self.uiScrollCard.frame.size;
    self.uiScrollCard.contentSize = CGSizeMake(pagesScrollViewSize.width * self.pageCardInformation.count, pagesScrollViewSize.height);
    
    // Load the initial set of pages that are on screen
   [self loadVisiblePages];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)loadVisiblePages {
    // First, determine which page is currently visible
    CGFloat pageWidth = self.uiScrollCard.frame.size.width;
    NSInteger page = (NSInteger)floor((self.uiScrollCard.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.uiPageControlScrollCard.currentPage = page;
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    for (NSInteger i=lastPage+1; i<self.pageCardInformation.count; i++) {
        [self purgePage:i];
    }
}
- (void)loadPage:(NSInteger)page {
    if (page < 0 || page >= self.pageCardInformation.count) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first checking if you've already loaded it
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {
        CGRect frame = self.uiScrollCard.bounds;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        //frame = CGRectInset(frame, 10.0f, 0.0f);
        
        PAC_ScrollCardView *newPageView = [[PAC_ScrollCardView alloc] initWithFrame:CGRectMake(0, 0, self.uiScrollCard.frame.size.width , self.uiScrollCard.frame.size.height)];
        CardInfo *cinfo = [self.pageCardInformation objectAtIndex:page];
        [newPageView PopulateScrollCardView:cinfo];
        newPageView.layer.cornerRadius = 12;
        newPageView.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.frame = frame;
       
        [self.uiScrollCard addSubview:newPageView];
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}
- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= self.pageCardInformation.count) {
        // If it's outside the range of what you have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Load the pages that are now on screen
    [self loadVisiblePages];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self ResetScrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        
        [self ResetScrollView];
        
    }
}

- (void) ResetScrollView
{
    
    CGFloat pageWidth = self.uiScrollCard.bounds.size.width;
    int page = floor((self.uiScrollCard.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.uiPageControlScrollCard.currentPage = page;
    CGRect frame = self.uiScrollCard.frame;
    frame.origin.x = frame.size.width * (self.uiPageControlScrollCard.currentPage);
    frame.origin.y = 0;
    [self.uiScrollCard scrollRectToVisible:frame animated:YES];
    [[SingletonGeneric UserCardInfo] SetSelectedCardInfo:page];
    
}


-(void)ShowContactUS:(UITapGestureRecognizer *)sender {
    [self presentViewController:[[ContactUs alloc] init] animated:YES completion:nil];
}

-(void)ShowTerms:(UITapGestureRecognizer *)sender {
    [self presentViewController:[[Terms alloc] init] animated:YES completion:nil];
}

-(void)ShowFaq:(UITapGestureRecognizer *)sender{
    [self presentViewController:[[Faq alloc] init] animated:YES completion:nil];
}


@end
