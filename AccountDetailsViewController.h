//
//  AccountDetailsViewController.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocAcc.h"
#import "WebServices.h"
#import "GetImage.h"
#import "GetTextData.h"




@class Reachability;
@interface AccountDetailsViewController : UIViewController <NSXMLParserDelegate, UIAlertViewDelegate>{
	
	LocAcc *account;
	Reachability* internetReach;
	WebServices *webservice;
	GetImage *getImage;
	GetTextData *getComments;
	GetTextData *getPhoneNumber;
	GetTextData *getDinnerCap;
	GetTextData *getReceptionCap;
	
    BOOL isRoomCapLabelEmpty; 
    BOOL isReceptionCapLabelEmpty;
    
	NSString *accountPhoneNumber;
	NSXMLParser *xmlParser;
    
    
	IBOutlet UITextView *comments;

	
	IBOutlet UIImageView *accountImageView;
	IBOutlet UIActivityIndicatorView *imageActivityIndicator;
	IBOutlet UIActivityIndicatorView * commentsActivityIndicator;
	
	IBOutlet UIButton *mapButton;
	IBOutlet UIButton *emailButton;
	IBOutlet UIButton *callButton;
		
	IBOutlet UILabel *addressLabel;
	IBOutlet UILabel *roomCapLabel;
	IBOutlet UILabel *receptionCapLabel;

	IBOutlet UILabel *websiteLabel;
	IBOutlet UIImageView *mentionImage;
	
	id scrollHolder;
}

@property(nonatomic, retain) UIImageView *accountImageView;
@property(nonatomic, retain) UIImageView *mentionImage;

@property(nonatomic, retain) UIActivityIndicatorView *imageActivityIndicator;
@property(nonatomic, retain) UIActivityIndicatorView * commentsActivityIndicator;
@property(nonatomic, retain) UIButton *mapButton;
@property(nonatomic, retain) UIButton *emailButton;
@property(nonatomic, retain) UIButton *callButton;
@property(nonatomic, retain) UILabel *addressLabel;
@property(nonatomic, retain) UILabel *roomCapLabel;
@property(nonatomic, retain) UILabel *receptionCapLabel;
@property(nonatomic, retain) UILabel *websiteLabel;

@property(nonatomic, retain) LocAcc *account;
//@property(nonatomic, retain) NSString *accountPhoneNumber;

- (IBAction) openAccountMap:(id)sender;
- (IBAction) openEmailAccount:(id)sender;
- (IBAction) callAccount:(id)sender;
- (void) setScrollHolder:(id)adelegate;
- (void)releaseSubviews;
- (void) resizeViews;

@end
