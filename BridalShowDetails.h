//
//  BridalShowDetails.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BridalShows.h"


@interface BridalShowDetails : UIViewController {

	
	BridalShows *bridalShow;
	
	IBOutlet UILabel *lableWebsite;
	IBOutlet UILabel *lableCompany;
	IBOutlet UILabel *lableLocation;
	IBOutlet UITextView *lableAddress;
	IBOutlet UILabel *lableDate;
	IBOutlet UILabel *lableTime;
	IBOutlet UILabel *companyNameLabel;
	IBOutlet UILabel *costLabel;
}

@property(nonatomic, retain) UITextView *lableAddress;
@property(nonatomic, retain) UILabel *lableWebsite;
@property(nonatomic, retain) UILabel *lableCompany;
@property(nonatomic, retain) UILabel *lableLocation;
@property(nonatomic, retain) UILabel *lableDate;
@property(nonatomic, retain) UILabel *lableTime;
@property(nonatomic, retain) UILabel *companyNameLabel;
@property(nonatomic, retain) UILabel *costLabel;

@property(nonatomic, retain) BridalShows *bridalShow;
- (IBAction) openAccountMap:(id)sender;

@end
