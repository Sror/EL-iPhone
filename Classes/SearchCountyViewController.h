//
//  SearchCountyViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "County.h"
#import "WebServices.h"

@class Reachability;
@interface SearchCountyViewController : UIViewController <UITableViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate> {
	
	NSXMLParser *xmlParser;
	Boolean idFound;
	Boolean nameFound;
	Boolean stateFound;

	NSMutableArray *keys;
	NSMutableArray *counties;
	County* county;
	
	NSMutableArray *sectionCount;
	NSInteger rowCount;
	
	WebServices* webservice;
	Reachability* internetReach;
	
	IBOutlet UIActivityIndicatorView* activityIndicator;
	IBOutlet UITableView* countyTable;
	
	id delegate;
}

@property(nonatomic, retain) UIActivityIndicatorView*  activityIndicator;
@property(nonatomic, retain) UITableView* countyTable;

@property(nonatomic, retain) NSMutableArray *counties;
@property(nonatomic, retain) NSMutableArray *keys;
@property(nonatomic, retain) NSMutableArray *sectionCount;

- (void) dismissSearchCounty:(id) sender;
- (void) setDelegate:(id)adelegate;
- (NSInteger)getRowNumber:(NSInteger)section indexrow:(NSInteger)row;

@end


@protocol SearchCountyViewControllerDelegate
- (void) homeButtonPressed:(id)sender;
@end
