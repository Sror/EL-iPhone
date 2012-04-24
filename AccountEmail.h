//
//  AccountEmail.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/28/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"


@class Reachability;
@interface AccountEmail : UIViewController <UITextFieldDelegate, UIAlertViewDelegate, NSXMLParserDelegate>{

	IBOutlet UIScrollView* scrollView;
	IBOutlet UITextField *firstName;
	IBOutlet UITextField *emailAddress;
	IBOutlet UITextField *subject;
	IBOutlet UITextView *message;
	IBOutlet UILabel *titleLabel;
	IBOutlet UIButton *sendButton;
	IBOutlet UIActivityIndicatorView *sendActivity;
	
	NSString *accountName;
	NSInteger accountId;
	
	Reachability* internetReach;
	WebServices *webservice;
	NSXMLParser *xmlParser;
}

@property(nonatomic, retain) NSString *accountName;
@property(nonatomic) NSInteger accountId;


- (IBAction) cancelEmail:(id)sender;
- (IBAction) sendEmail:(id)sender;
- (BOOL)validateEmail:(NSString *)email;

@end
