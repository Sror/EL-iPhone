//
//  AboutUs.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "GetTextData.h"

@class Reachability;
@interface AboutUs : UIViewController  <MFMailComposeViewControllerDelegate>{
	
	IBOutlet UIBarButtonItem* doneButton;
	IBOutlet UITextView *about;
	IBOutlet UITextView *additionalInfo;
	IBOutlet UIActivityIndicatorView *aboutActivityIndicator;
	IBOutlet UIActivityIndicatorView *additionalActivityIndicator;
	
	GetTextData *getAbout;
	GetTextData *getAdditional;
	Reachability *internetReach;
}

@property(nonatomic, retain) UIBarButtonItem* doneButton;
@property(nonatomic, retain) UITextView *about;
@property(nonatomic, retain) UITextView *additionalInfo;
@property(nonatomic, retain) UIActivityIndicatorView *aboutActivityIndicator;
@property(nonatomic, retain) UIActivityIndicatorView *additionalActivityIndicator;


- (IBAction) dismissAboutUs:(id) sender;
- (IBAction) sendContactEmail;

@end
