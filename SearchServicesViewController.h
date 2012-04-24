//
//  SearchServicesViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "LocAcc.h"

@class Reachability;
@interface SearchServicesViewController : UIViewController <UITableViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate>{
	
	id delegate;
	
	NSXMLParser *xmlParser;
	NSMutableArray *accounts;
	NSMutableArray *sectionCount;
	NSMutableArray *sections;
	
	NSString *sectionName;
	NSInteger rowCount;
	
	WebServices* webservice;
	Reachability* internetReach;	
	LocAcc* account;

	IBOutlet UIActivityIndicatorView* activityIndicator;
	IBOutlet UITableView* servicesTable;
	
	//Boolean accountIdFound;
	//Boolean accountNameFound;
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
	Boolean isFirstSection;
	Boolean serviceIdFound;
	Boolean serviceNameFound;
	
}
@property(nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@property(nonatomic, retain) UITableView* servicesTable;

- (void) dismissSearchServices:(id) sender;
- (void) setDelegate:(id)adelegate;
- (NSInteger)getRowNumber:(NSInteger)section indexrow:(NSInteger)row;

@end

@protocol SearchServicesViewControllerDelegate
- (void) homeButtonPressed:(id)sender;
@end