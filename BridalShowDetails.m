//
//  BridalShowDetails.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "BridalShowDetails.h"
#import "BridalShowMap.h"


@implementation BridalShowDetails
@synthesize bridalShow;
@synthesize costLabel;
@synthesize lableWebsite;
@synthesize lableCompany;
@synthesize lableLocation;
@synthesize lableAddress;
@synthesize lableDate;
@synthesize lableTime;
@synthesize companyNameLabel;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Show Details";
	companyNameLabel.text = bridalShow.company;
	lableWebsite.text = @"";
	lableCompany.text = @"";//bridalShow.company;
	lableLocation.text = bridalShow.location;
	lableAddress.text = bridalShow.address;
	costLabel.text = bridalShow.cost;	
	
	NSArray *dateTime = [bridalShow.date componentsSeparatedByString:@" "];
	NSString *dateTimeString = [NSString stringWithFormat:@"%@ %@", [dateTime objectAtIndex:1], [dateTime objectAtIndex:2]];
	
	if ([[dateTime objectAtIndex:0] rangeOfString:@"PM"].location != NSNotFound) {
		dateTimeString = [dateTimeString stringByReplacingOccurrencesOfString:@":00 AM" withString:@" am"];
	}else{
		dateTimeString = [dateTimeString stringByReplacingOccurrencesOfString:@":00 PM" withString:@" pm"];
	}
	
	lableDate.text = [NSString stringWithFormat:@"%@, %@", bridalShow.day, [dateTime objectAtIndex:0]];
	lableTime.text = dateTimeString;//[NSString stringWithFormat:@"%@ %@", [dateTime objectAtIndex:1], [dateTime objectAtIndex:2]];
}

- (IBAction) openAccountMap:(id)sender{
	 BridalShowMap *accountMap = [[BridalShowMap alloc] initWithNibName:@"BridalShowMap" bundle:nil];
	 accountMap.bridalShowAddress = bridalShow.address;
	 accountMap.bridalShowName = bridalShow.location;
	 [self presentModalViewController:accountMap animated:YES];
	 [accountMap release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[bridalShow release];
	[costLabel release];
	[lableWebsite release];
	[lableCompany release];
	[lableLocation release];
	[lableAddress release];
	[lableDate release];
	[lableTime release];
	[companyNameLabel release];
    [super dealloc];
}


@end
