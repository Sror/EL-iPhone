//
//  SearchSiteViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocAcc.h"
#import "WebServices.h"


@class Reachability;
@interface SearchSiteViewController : UIViewController  <UITableViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate, UISearchBarDelegate>{

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
	NSMutableArray *searchAccounts;
	
	NSMutableArray *sectionCount;
	NSInteger rowCount;
	
	LocAcc *account;
	WebServices *webservice;
	Reachability *internetReach;
	
	
	id delegate;
	
	IBOutlet UIActivityIndicatorView* activityIndicator;
	IBOutlet UITableView* siteTable;
	IBOutlet UISearchBar *searchBar;
	
	BOOL searching;
	BOOL letUserSelectRow;
}

@property(nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@property(nonatomic, retain) UITableView* siteTable;
@property(nonatomic, retain) UISearchBar *searchBar;

@property(nonatomic, retain) NSMutableArray *accounts;
@property(nonatomic, retain) NSMutableArray *searchAccounts;
@property(nonatomic, retain) NSMutableArray *keys;
@property(nonatomic, retain) NSMutableArray *sectionCount;

- (void) dismissSearchSite:(id) sender;
- (void) setDelegate:(id)adelegate;
- (NSInteger)getRowNumber:(NSInteger)section indexrow:(NSInteger)row;
- (void) searchTableView;


@end

@protocol SearchSiteViewControllerDelegate
- (void) homeButtonPressed:(id)sender;
@end