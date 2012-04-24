//
//  BridalShowsList.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BridalShows.h"
#import "WebServices.h"


@class Reachability;
@interface BridalShowsList : UIViewController <UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate>{

	
	BridalShows *bridalShow;
	
	Reachability* internetReach;
	WebServices *webservice;
	
	NSXMLParser *xmlParser;
	NSMutableArray *shows;
	
	NSString *companyName;
	
	id delegate;
	Boolean idFound;
	Boolean companyFound;
	Boolean dayFound;
	Boolean dateFound;	
	Boolean locationFound;
	Boolean addressFound;
	Boolean costFound;
	
	UITableViewCell *tvCell;

	IBOutlet UITableView* showsTable;	
	IBOutlet UILabel *companyNameLabel;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	
}
@property(nonatomic, retain) BridalShows *bridalShow;
@property(nonatomic, retain) NSMutableArray *shows;
@property(nonatomic, retain) NSString *companyName;
@property (nonatomic, assign) IBOutlet UITableViewCell *tvCell;



- (void)setDelegate:(id)adelegate;

@end

@protocol BridalShowListControllerDelegate
- (void) dismissFindABridalShow:(id)sender;
@end
