//
//  SearchCaterersViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocAcc.h"
#import "WebServices.h"


@class Reachability;
@interface SearchCaterersViewController : UIViewController <UITableViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate> {

	NSXMLParser *xmlParser;
	Boolean idFound;
	Boolean nameFound;
	Boolean contactFound;
	Boolean commentFound;
	Boolean address1Found;
	Boolean cityFound;
	Boolean stateFound;
	Boolean urlFound;
	Boolean zipFound;
	Boolean mapFound;
	
	NSMutableArray *keys;
	NSMutableArray *accounts;
	
	NSMutableArray *sectionCount;
	NSInteger rowCount;
	
	LocAcc *account;
	WebServices *webservice;
	Reachability *internetReach;
	
	IBOutlet UIActivityIndicatorView* activityIndicator;
	IBOutlet UITableView* caterersTable;
	
	id delegate;
}

@property(nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@property(nonatomic, retain) UITableView* caterersTable;

- (void) dismissSearchCaterers:(id) sender;
- (void) setDelegate:(id)adelegate;

@end

@protocol SearchCaterersViewControllerDelegate
- (void) homeButtonPressed:(id)sender;
@end