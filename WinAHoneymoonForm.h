//
//  WinAHoneymoonForm.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/26/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"

@class Reachability;
@interface WinAHoneymoonForm : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate, NSXMLParserDelegate> {

	IBOutlet UIScrollView* scrollView;	
	IBOutlet UITextField *firstName;
	IBOutlet UITextField *lastName;
	IBOutlet UITextField *emailAddress;
	IBOutlet UITextField *address1;
	IBOutlet UITextField *address2;
	IBOutlet UITextField *city;
	IBOutlet UITextField *state;
	IBOutlet UITextField *zip;
	IBOutlet UITextField *numberOfPeople;
	IBOutlet UITextField *pricePerPerson;
	IBOutlet UIDatePicker *eventDate;
	IBOutlet UIPickerView *typeOfSite;
	IBOutlet UIPickerView *weddingCounty;
	IBOutlet UIActivityIndicatorView *sendActivity;
	IBOutlet UITableView* abtUrHoneymoonTable;
	
	NSString *typeSite;
	NSString *weddCounty;
	NSString *honeyMoonCountry;
	NSString *eventDateString;
	
	NSArray *siteArray;
	NSArray *countyArray;
	NSArray *aboutYourHoneymoonArray;
	
	Reachability* internetReach;
	WebServices *webservice;
	NSXMLParser *xmlParser;
	
	id delegate;
}


@property(retain, nonatomic) UIScrollView* scrollView;	
@property(retain, nonatomic) UITextField *firstName;
@property(retain, nonatomic) UITextField *lastName;
@property(retain, nonatomic) UITextField *emailAddress;
@property(retain, nonatomic) UITextField *address1;
@property(retain, nonatomic) UITextField *address2;
@property(retain, nonatomic) UITextField *city;
@property(retain, nonatomic) UITextField *state;
@property(retain, nonatomic) UITextField *zip;
@property(retain, nonatomic) UITextField *numberOfPeople;
@property(retain, nonatomic) UITextField *pricePerPerson;
@property(retain, nonatomic) UIDatePicker *eventDate;
@property(retain, nonatomic) UIPickerView *typeOfSite;
@property(retain, nonatomic) UIPickerView *weddingCounty;
@property(retain, nonatomic) UIActivityIndicatorView *sendActivity;
@property(retain, nonatomic) UITableView* abtUrHoneymoonTable;


- (void) setDelegate:(id)adelegate;
- (BOOL) validateEmail:(NSString *)email;
- (BOOL) isNumber:(NSString *)string;

- (IBAction) submitWinForm:(id)sender;
- (void) dateChangedByUser:(id)sender;

@end

@protocol WinAHoneymoonFormDelegate
- (void) dismissWinAHoneymoon:(id)sender;
@end