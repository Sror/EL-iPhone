//
//  HoneymoonView.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 1/16/11.
//  Copyright 2011 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "County.h"
#import "LocAcc.h"
#import "WebServices.h"

@class Reachability;
@interface HoneymoonView : UIViewController <UITableViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate>{

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
	
	id delegate;
	
	NSMutableArray *keys;	
	NSMutableArray *sectionCount;
	NSMutableArray *accounts;	
	LocAcc *account;
	
	
	
	NSInteger rowCount;
	
	WebServices* webservice;
	Reachability* internetReach;
	
	IBOutlet UIActivityIndicatorView* activityIndicator;
	IBOutlet UITableView* countyTable;
}

@property(nonatomic, retain) NSMutableArray *accounts;
@property(nonatomic, retain) NSMutableArray *keys;
@property(nonatomic, retain) NSMutableArray *sectionCount;

- (void) dismissHoneymoonView:(id) sender;
- (void) openWinAHoneymoonView:(id) sender;
- (void) setDelegate:(id)adelegate;
- (NSInteger)getRowNumber:(NSInteger)section indexrow:(NSInteger)row;

@end

@protocol HoneymoonViewDelegate
- (void) homeButtonPressed:(id)sender;
@end