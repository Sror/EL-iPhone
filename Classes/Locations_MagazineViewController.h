//
//  Locations_MagazineViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright LocationsMagazine.Com 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutUs.h"

#import "SearchCountyViewController.h"
#import "SearchSiteViewController.h"
#import "SearchServicesViewController.h"
#import "SearchCaterersViewController.h"
#import "WinAHoneymoonViewController.h"
#import "FindABridalShowViewController.h"


#import "NavigationController.h"


@interface Locations_MagazineViewController : UIViewController {

	IBOutlet UIButton* infoButton;	
	IBOutlet UIButton* searchCountyButton;	
	IBOutlet UIButton* searchSiteButton;
	IBOutlet UIButton* searchServicesButton;	
	IBOutlet UIButton* searchCaterersButton;
	IBOutlet UIButton* winAHoneymoonButton;	
	IBOutlet UIButton* findABridalShowButton;	
	
	AboutUs *aboutUsViewController;
	NavigationController *navigationController;
	
}

@property(nonatomic, retain) AboutUs *aboutUsViewController;


/*
SearchCountyViewController *searchCountyViewController;
SearchSiteViewController *searchSiteViewController;
SearchServicesViewController *searchServicesViewController;
SearchCaterersViewController *searchCaterersViewController;
WinAHoneymoonViewController *winAHoneymoonViewController;
FindABridalShowViewController *findABridalShowViewController;


@property(nonatomic, retain) SearchCountyViewController *searchCountyViewController;
@property(nonatomic, retain) SearchSiteViewController *searchSiteViewController;
@property(nonatomic, retain) SearchServicesViewController *searchServicesViewController;
@property(nonatomic, retain) SearchCaterersViewController *searchCaterersViewController;
@property(nonatomic, retain) WinAHoneymoonViewController *winAHoneymoonViewController;
@property(nonatomic, retain) FindABridalShowViewController *findABridalShowViewController;
*/

-(IBAction) showInfo:(id) sender;
-(IBAction) showSearchCounty:(id) sender;
-(IBAction) showSearchSite:(id) sender;
-(IBAction) showSearchServices:(id) sender;
-(IBAction) showSearchCaterers:(id) sender;
-(IBAction) showWinAHoneymoon:(id) sender;
-(IBAction) showFindABridalShow:(id) sender;


@end

