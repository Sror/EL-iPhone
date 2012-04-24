//
//  SelectSiteViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/15/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "County.h"
#import "LocAcc.h"
#import "WebServices.h"

@class Reachability;
@interface SelectSiteViewController : UIViewController <UITableViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate> {
	
	
	LocAcc *account;
	
	Reachability* internetReach;
	County *county;
	WebServices *webservice;
	
	NSXMLParser *xmlParser;
	NSMutableArray *keys;
	NSMutableArray *accounts;
	NSMutableArray *sectionCount;

	id delegate;
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
	
	NSInteger rowCount;
	
	IBOutlet UITableView* siteTable;	
	IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic, retain) UITableView* siteTable;
@property(nonatomic, retain) County *county;
@property(nonatomic, retain) NSMutableArray *accounts;
@property(nonatomic, retain) NSMutableArray *keys;
@property(nonatomic, retain) NSMutableArray *sectionCount;

- (void)setDelegate:(id)adelegate;
- (NSInteger)getRowNumber:(NSInteger)section indexrow:(NSInteger)row;



@end

@protocol SelectSiteViewControllerDelegate
- (void) dismissSearchCounty:(id)sender;
@end
