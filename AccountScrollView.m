//
//  AccountScrollView.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 1/9/11.
//  Copyright 2011 LocationsMagazine.Com. All rights reserved.
//

#import "AccountScrollView.h"
#import "AccountDetailsViewController.h"
#import "AccountImageViewController.h"
#import "AccountMap.h"
#import "AccountEmail.h"

//static NSUInteger kNumberOfPages = 6;


@implementation AccountScrollView
@synthesize scrollView, pageControl, viewControllers, kNumberOfPages, accounts, currentPage;

//- (void)awakeFromNib
- (void)viewDidLoad {
	[super viewDidLoad];
	
	//accounts = [[NSMutableArray alloc] init];
	didTheInitialScroll = NO;
	self.title = [[accounts objectAtIndex:currentPage] accountname];
	kNumberOfPages = [accounts count];
	
    //view controllers are created lazily
    //in the meantime, load the array with placeholders which will be replaced on demand
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
	int i =0;
    for (i = 0; i < kNumberOfPages; i++){
		[controllers addObject:[NSNull null]];
    }
    
	self.viewControllers = controllers;
    [controllers release];
    
	// a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = currentPage;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:currentPage];
    [self loadScrollViewWithPage:currentPage+1];
}


/*
 - (UIView *)view{
 return self.scrollView;
 }
 */

- (void)loadScrollViewWithPage:(int)page{
	
	if (page < 0)
        return;
	
    if (page >= kNumberOfPages)
        return;
    
    // replace the placeholder if necessary
    AccountDetailsViewController *controller = [viewControllers objectAtIndex:page];
	
    if ((NSNull *)controller == [NSNull null]){
        controller = [[AccountDetailsViewController alloc] init];
		controller.account = [accounts objectAtIndex:page];
		[controller setScrollHolder:self];
		
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil){
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
		
		controller.view.frame = frame;
		[scrollView addSubview:controller.view];
		
		if(!didTheInitialScroll){
			[scrollView setContentOffset:CGPointMake(frame.origin.x, 0) animated:NO];
			didTheInitialScroll=YES;
		}
	}
}

- (void) scrollViewDidScroll:(UIScrollView *)sender{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
	
    if (pageControlUsed){
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
	if(!didTheInitialScroll){
		return;
	}
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
	// load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
	
	//[self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
	self.title = [[accounts objectAtIndex:page] accountname];
}


// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender{
	/*
	 int page = pageControl.currentPage;
	 // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
	 [self loadScrollViewWithPage:page - 1];
	 [self loadScrollViewWithPage:page];
	 [self loadScrollViewWithPage:page + 1];
	 
	 // update the scroll view to the appropriate page
	 CGRect frame = scrollView.frame;
	 frame.origin.x = frame.size.width * page;
	 frame.origin.y = 0;
	 [scrollView scrollRectToVisible:frame animated:YES];
	 
	 // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
	 pageControlUsed = YES;
	 */
}

/****************************
 CUSTOM FUNCTIONS (DELEGATE)
 ****************************/

- (void) openAccountMap:(LocAcc *)account{
	AccountMap *accountMap = [[AccountMap alloc] initWithNibName:@"AccountMap" bundle:nil];
	accountMap.account = account;
	[self presentModalViewController:accountMap animated:YES];
	[accountMap release];
}

- (void) openEmailAccount:(LocAcc *)account{
	AccountEmail *accountEmail = [[AccountEmail alloc] initWithNibName:@"AccountEmail" bundle:nil];
	accountEmail.accountName =  account.accountname;
	accountEmail.accountId = (NSInteger)account.accountid;
	
	[self.navigationController pushViewController:accountEmail animated:YES];
	//[self presentModalViewController:accountEmail animated:YES];
	[accountEmail release];	
}

- (void) openAccountImage:(NSString *)accountName ImageLink:(UIImage *)image{
	AccountImageViewController *accountImageViewController = [[AccountImageViewController alloc] initWithNibName:@"AccountImageViewController" bundle:nil];
	accountImageViewController.accountName = accountName;
	accountImageViewController.accountImage = image;
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationController pushViewController:accountImageViewController animated:YES];
	[accountImageViewController release];
	[self.navigationItem.backBarButtonItem release];
}

- (void) callme{
	//NSLog(@"me called");
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
	/*
	CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	int i = 0;	
	
	
	for (i = page-1; i >= 0; i--){
		[self.viewControllers removeAllObjects];
    }
	
	self.viewControllers = nil;
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++){
		[controllers addObject:[NSNull null]];
    }
	self.viewControllers = controllers;
	[controllers release];
	*/
	 
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




- (void)dealloc {
	[viewControllers release];
    [scrollView release];
    [pageControl release];
	[accounts release];
    [super dealloc];
}


@end
