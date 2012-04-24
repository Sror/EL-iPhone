//
//  NavigationController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/20/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchCountyViewController.h"
#import "SearchSiteViewController.h"
#import "SearchServicesViewController.h"
#import "SearchCaterersViewController.h"
#import "WinAHoneymoonViewController.h"
#import "FindABridalShowViewController.h"
#import "HoneymoonView.h"



@interface NavigationController : UIViewController{
	UINavigationController *navigationController;	
	NSInteger whichViewController;
	
	SearchCountyViewController *searchCountyController;
	SearchSiteViewController *searchSiteViewController;
	SearchServicesViewController *searchServicesViewController;
	SearchCaterersViewController *searchCaterersViewController;
	HoneymoonView *winAHoneymoonViewController;
	FindABridalShowViewController *findABridalShowViewController;
}

@property(nonatomic) NSInteger whichViewController;

@end

