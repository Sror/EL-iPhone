//
//  AccountScrollView.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 1/9/11.
//  Copyright 2011 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LocAcc.h"


@interface AccountScrollView : UIViewController  <UIScrollViewDelegate> {

	UIScrollView *scrollView;
	UIPageControl *pageControl;
    
	NSInteger kNumberOfPages;
	NSInteger currentPage;
	
	NSMutableArray *accounts;
	NSMutableArray *viewControllers;

    BOOL pageControlUsed;	
	BOOL didTheInitialScroll;
}
@property (nonatomic) NSInteger kNumberOfPages;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, retain) NSMutableArray *accounts;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (void) loadScrollViewWithPage:(int)page;
- (void) scrollViewDidScroll:(UIScrollView *)sender;
- (IBAction) changePage:(id)sender;



@end

@protocol AccountScrollViewControllerDelegate
- (void) callme;
- (void) openEmailAccount:(LocAcc *)account;
- (void) openAccountMap:(LocAcc *)account;
- (void) openAccountImage:(NSString *)accountName ImageLink:(UIImage *)image;

@end


