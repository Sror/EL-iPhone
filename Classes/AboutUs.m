//
//  AboutUs.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "AboutUs.h"
#import "Reachability.h"

@implementation AboutUs
@synthesize doneButton;
@synthesize about;
@synthesize additionalInfo;
@synthesize aboutActivityIndicator;
@synthesize additionalActivityIndicator;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[aboutActivityIndicator startAnimating];
	[additionalActivityIndicator startAnimating];
	[additionalInfo flashScrollIndicators];
	[about flashScrollIndicators];
	getAbout = [[GetTextData alloc] init];
	getAdditional = [[GetTextData alloc] init];
	
	/********************************
	 INTERNET TEST
	 ********************************/
	internetReach = [[Reachability reachabilityWithHostName: @"www.locationsmagazine.com"] retain];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	[internetReach release];
	
	
	if (netStatus == NotReachable) {
	//if (YES) {
		[aboutActivityIndicator stopAnimating];
		[additionalActivityIndicator stopAnimating];
		
		

		about.text = @"Established in 1993, Event Locations is the #1 source for finding a venue for Weddings, Social Occasions and Corporate Events in the NY / NJ metro area.";
		additionalInfo.text = @"Locate a venue for your wedding, corporate event, bar/bat mitzvah, birthday or anniversary. FIND an upcoming Bridal Show. NY TIMES: Featured on the Front Cover of the NY Times \"Weddings\" with major editorial. Our 2011 magazine contains 204 pages with color photos & detailed room info. Available at Barnes & Noble and Border Books in the \"Wedding\" section, at Bridal Shows, plus newsstands. Call 212-288-4745 for store near you";
		
	}else{
		[getAbout setDelegate:self];
		[getAbout setTag:1];
		[getAbout getTextData:@"http://locationsmagazine.com/admina/pages/fixes/iphone/text_data_iphone.php?what=about&accid=7909"];
		
		[getAdditional setDelegate:self];
		[getAdditional setTag:2];
		[getAdditional getTextData:@"http://locationsmagazine.com/admina/pages/fixes/iphone/text_data_iphone.php?what=additional&accid=7909"];			
	}
}



/****************************
 CUSTOM FUNCTIONS
 ****************************/

- (void) gettingTextDataDone:(GetTextData*)gettextdata data:(NSMutableData *)webData{
	
	if(gettextdata.tag == 1){
		NSString *aboutData = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
		about.text = aboutData;
		[aboutData release];
		[aboutActivityIndicator stopAnimating];
		[about flashScrollIndicators];
	}
	 
	if(gettextdata.tag == 2){
		NSString *additionalInfoData = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
		additionalInfo.text = additionalInfoData;
		[additionalInfoData release];
		[additionalActivityIndicator stopAnimating];
		[additionalInfo flashScrollIndicators];
	}

}

-(IBAction) dismissAboutUs:(id) sender{
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction) sendContactEmail{

	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setToRecipients:[NSArray arrayWithObjects:@"info@locationsmagazine.com", nil]];
	[picker setSubject:@"Locations Magazine iPhone(v1.0.2)"];
	/*
	UIImage *roboPic = [UIImage imageNamed:@"RobotWithPencil.jpg"];
	NSData *imageData = UIImageJPEGRepresentation(roboPic, 1);
	[picker addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"RobotWithPencil.jpg"];
	
	NSString *emailBody = @"";
	[picker setMessageBody:emailBody isHTML:YES];
	*/

	[self presentModalViewController:picker animated:YES];

	[picker release];
}


/**************************************
 MFMessageComposer Delegate Functions
 *************************************/

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	
	[self dismissModalViewControllerAnimated:YES];	
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
	[getAbout setDelegate:nil];
	[getAbout release];
	[getAdditional setDelegate:nil];
	[getAdditional release];
	
	[doneButton release];
	[about release];
	[additionalInfo release];
	[aboutActivityIndicator release];
	[additionalActivityIndicator release];
	 [super dealloc];
}


@end
