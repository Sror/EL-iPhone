//
//  FindABridalShowViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BridalCompanies.h"
#import "WebServices.h"

@class Reachability;
@interface FindABridalShowViewController : UIViewController <UITableViewDelegate, NSXMLParserDelegate, UIAlertViewDelegate>{

	NSXMLParser *xmlParser;
	Boolean idFound;
	Boolean nameFound;
	Boolean stateFound;
	id delegate;
	
	NSMutableArray *keys;
	NSMutableArray *companies;
	
	BridalCompanies* company;
	
	NSMutableArray *sectionCount;
	NSInteger rowCount;
	
	WebServices* webservice;
	Reachability* internetReach;
	
	IBOutlet UIActivityIndicatorView* activityIndicator;
	IBOutlet UITableView* bridalCompanyTable;
}

@property(nonatomic, retain) UIActivityIndicatorView* activityIndicator;
@property(nonatomic, retain) UITableView* bridalCompanyTable;
@property(nonatomic, retain) NSMutableArray *companies;
@property(nonatomic, retain) NSMutableArray *keys;
@property(nonatomic, retain) NSMutableArray *sectionCount;

- (void) dismissFindABridalShow:(id) sender;
- (void) setDelegate:(id)adelegate;

@end

@protocol FindABridalShowViewControllerDelegate
- (void) homeButtonPressed:(id)sender;
@end