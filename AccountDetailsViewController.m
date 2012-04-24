//
//  AccountDetailsViewController.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "AccountDetailsViewController.h"
#import "Reachability.h"
#import "AccountImageViewController.h"
#import "AccountMap.h"
#import "AccountEmail.h"
#import "AccountScrollView.h"



@implementation AccountDetailsViewController
@synthesize account;
@synthesize accountImageView;
@synthesize imageActivityIndicator;
@synthesize commentsActivityIndicator;
@synthesize mapButton;
@synthesize emailButton;
@synthesize callButton;
@synthesize addressLabel;
@synthesize roomCapLabel;
@synthesize websiteLabel;
@synthesize mentionImage;
@synthesize receptionCapLabel;

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
	 [super viewDidLoad];
	 self.title = account.accountname;
	 	 	 
	 //NSLog([[UIDevice currentDevice] platformString]);

	 /*
#if __IPHONE_3_2 == __IPHONE_OS_VERSION_MAX_ALLOWED
	 [callButton setHidden:YES];
	 emailButton.frame = CGRectMake(12, 368, 72, 27);
	 mentionImage.frame = CGRectMake(124, 368, 72, 27);
	 mapButton.frame = CGRectMake(239, 368, 72, 27);
#else
	 if([account.accountstate isEqualToString:@"NA"] && [account.zip isEqualToString:@"NA"]){
		 [mapButton setHidden:YES];
		 emailButton.frame = CGRectMake(12, 368, 72, 27);
		 mentionImage.frame = CGRectMake(124, 368, 72, 27);
		 callButton.frame = CGRectMake(239, 368, 72, 27);
	 }
#endif
	  */
	 
     isRoomCapLabelEmpty = FALSE; 
     isReceptionCapLabelEmpty = FALSE;

     
	 if(([account.accountstate isEqualToString:@"NA"] && [account.zip isEqualToString:@"NA"])  || account.map == 0){
		 [mapButton setHidden:YES];
		 emailButton.frame = CGRectMake(52, 368, 72, 27);
		 callButton.frame = CGRectMake(196, 368, 72, 27);
	 }
	 

	 if(([account.address1 isEqualToString:@"NA"] || [account.city isEqualToString:@"NA"] || [account.accountstate isEqualToString:@"NA"] || [account.zip isEqualToString:@"NA"]) || account.map == 0){
		 [addressLabel setText:@""];
	 }else{
		 [addressLabel setText:[NSString stringWithFormat:@"%@, %@, %@ - %@", account.address1, account.city, account.accountstate, account.zip]];
	 }
	 
	 [websiteLabel setText:account.url];

	 /********************************
	  INTERNET TEST
	  ********************************/
	 internetReach = [[Reachability reachabilityWithHostName: @"www.locationsmagazine.com"] retain];
	 NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	 [internetReach release];
	 
	 if (netStatus == NotReachable) {
		 UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Internet Connection Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		 alert.tag = 1;
		 [alert show];	
	 }
	 
	 NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\"><soap:Header/><soap:Body><tem:GetAccountImage><tem:accountid>%d</tem:accountid></tem:GetAccountImage></soap:Body></soap:Envelope>", account.accountid];
	 webservice = [[WebServices alloc] init];
	 getDinnerCap = [[GetTextData alloc] init];
	 getReceptionCap = [[GetTextData alloc] init];
	 getComments = [[GetTextData alloc] init];
	 getPhoneNumber =  [[GetTextData alloc] init];
	 
	
	 [webservice setDelegate:self];
	 [webservice execWebService:soapMessage];
	 [imageActivityIndicator startAnimating];
	 
	  
	 [getReceptionCap setDelegate:self];
	 [getReceptionCap getTextData:[NSString stringWithFormat:@"http://locationsmagazine.com/admina/pages/fixes/iphone/text_data_iphone.php?what=reception&accid=%d",account.accountid]];
	 [getReceptionCap setTag:3];
	 
	 
	 [getDinnerCap setDelegate:self];
	 [getDinnerCap getTextData:[NSString stringWithFormat:@"http://locationsmagazine.com/admina/pages/fixes/iphone/text_data_iphone.php?what=dinner&accid=%d",account.accountid]];
	 [getDinnerCap setTag:2];
	 	 
	 
	 [getComments setDelegate:self];
	 [getComments getTextData:[NSString stringWithFormat:@"http://locationsmagazine.com/admina/pages/fixes/iphone/text_data_iphone.php?what=comments&accid=%d",account.accountid]];
	 [getComments setTag:0];
	 [commentsActivityIndicator startAnimating];
	 
	 
	 [getPhoneNumber setDelegate:self];
	 [getPhoneNumber getTextData:[NSString stringWithFormat:@"http://locationsmagazine.com/admina/pages/fixes/iphone/acc_phone_number.php?accid=%d",account.accountid]];
	 [getPhoneNumber setTag:1];
	 [callButton setEnabled:NO];
	 	 
 }
 

/****************************
 CUSTOM FUNCTIONS
 ****************************/

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0 && alertView.tag	== 1) {
		//[self.navigationController popViewControllerAnimated:YES];
		[[scrollHolder navigationController] popViewControllerAnimated:YES];
	}	
	
	if (alertView.tag == 2) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", accountPhoneNumber]]];
	}	
}

- (void) gettingDataFinish:(WebServices*) webservice data:(NSMutableData*) webData{
	
	if (xmlParser){
        [xmlParser release];
    }    
	
	xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
	
}

- (void) gettingImageDone:(GetImage*)getimage data:(NSMutableData *)webData{
	//UIImage* image = [[UIImage alloc] initWithData:webData];
	accountImageView.image = [UIImage imageWithData:(NSData*)webData];//image;
	
	//[image release];
	[imageActivityIndicator stopAnimating];
}

- (void) gettingTextDataDone:(GetTextData*)gettextdata data:(NSMutableData *)webData{
	
	if(gettextdata.tag == 0){
		NSString *commentData = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
		comments.text = commentData;
		[commentData release];
		[commentsActivityIndicator stopAnimating];
		[comments flashScrollIndicators];
	}
	
	if(gettextdata.tag == 1){
		NSString *phoneData = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
		accountPhoneNumber = [phoneData retain];
		[phoneData release];
		[callButton setEnabled:YES];
	}
	
	if(gettextdata.tag == 2){
		NSString *roomCapacityData = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
		
		if([[roomCapacityData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
			[roomCapLabel setHidden:YES];
            isRoomCapLabelEmpty = TRUE; 
		}else{
			roomCapLabel.text = [NSString stringWithFormat:@"Room Capacity Dinner w/dancing: %@", roomCapacityData];
		}
		[roomCapacityData release];
	}
		
	if(gettextdata.tag == 3){
		NSString *receptionCapacityData = [[NSString alloc] initWithData:webData encoding:NSUTF8StringEncoding];
		
		if([[receptionCapacityData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
			[receptionCapLabel setHidden:YES];
            isReceptionCapLabelEmpty = TRUE;
		}else{
			receptionCapLabel.text = [NSString stringWithFormat:@"Room Capacity Reception: %@", receptionCapacityData];
		}
		[receptionCapacityData release];
	}
    
    [self resizeViews];
	
}	

- (void) resizeViews{
    
    if(!isRoomCapLabelEmpty && isReceptionCapLabelEmpty){
        //if reception is empty move cap dinner & comments up 1 step
        [roomCapLabel setFrame:CGRectMake(12, 234, 299, 21)];
        [comments setFrame:CGRectMake(7, 251, 306, 118)];
    }

    if(isRoomCapLabelEmpty && !isReceptionCapLabelEmpty){
        //if room cap dinner is empty move reception comments up 1 step
        [comments setFrame:CGRectMake(7, 251, 306, 118)];
    }

    if(isRoomCapLabelEmpty && isReceptionCapLabelEmpty){
      //if room cap dinner is empty move comments up 2 steps
        [comments setFrame:CGRectMake(7, 234, 306, 138)];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 
	[scrollHolder openAccountImage:account.accountname ImageLink:accountImageView.image];
	/*
	AccountImageViewController *accountImageViewController = [[AccountImageViewController alloc] initWithNibName:@"AccountImageViewController" bundle:nil];
	accountImageViewController.accountName = account.accountname;
	accountImageViewController.accountImage = accountImageView.image;
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationController pushViewController:accountImageViewController animated:YES];
	[accountImageViewController release];
	 */
}

- (IBAction) openAccountMap:(id)sender{
	[scrollHolder openAccountMap:self.account];
	/*
	AccountMap *accountMap = [[AccountMap alloc] initWithNibName:@"AccountMap" bundle:nil];
	accountMap.account = self.account;
	[self presentModalViewController:accountMap animated:YES];
	[accountMap release];
	*/
}

- (IBAction) openEmailAccount:(id)sender{
	[scrollHolder openEmailAccount:self.account];
	
	/*
	AccountEmail *accountEmail = [[AccountEmail alloc] initWithNibName:@"AccountEmail" bundle:nil];
	accountEmail.accountName = self.account.accountname;
	accountEmail.accountId = (NSInteger)self.account.accountid;
	
	[self.navigationController pushViewController:accountEmail animated:YES];
	//[self presentModalViewController:accountEmail animated:YES];
	[accountEmail release];	
	 */
}

- (IBAction) callAccount:(id)sender{
	
	if([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location != NSNotFound  || [[[UIDevice currentDevice] model] rangeOfString:@"iPod"].location != NSNotFound){
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@\n%@ \nThis device can't make calls\n\nPlease mention you saw it on\n\"EventLocations.us\"", account.accountname,accountPhoneNumber] message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		alert.tag = 3;
		[alert show];
		
		
	}else{
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Please mention you saw it on\n\"EventLocations.us\""] message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		alert.tag = 2;
		[alert show];
	}
}

- (void)setScrollHolder:(id)adelegate{
	scrollHolder = adelegate;
}



/********************************
 XMLPARSER DELEGATE FUNCTIONS
 ********************************/

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
	
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
	getImage = [[GetImage alloc] init];
	[getImage setDelegate:self];
	[getImage getImage:string];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ }

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	//[parser release];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
	//[parser release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	//[self releaseSubviews];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)releaseSubviews{
	for (UIView *view in [self view].subviews) {
		view = nil;
	}
}


- (void)dealloc {
	//[self releaseSubviews];
	[account release];
	[webservice setDelegate:nil];
	[webservice release];
	[getImage setDelegate:nil];
	[getImage release];
	[getComments setDelegate:nil];
	[getComments release];
	[getPhoneNumber setDelegate:nil];
	[getPhoneNumber release];
	[getDinnerCap setDelegate:nil];
	[getDinnerCap release];
	[getReceptionCap setDelegate:nil];
	[getReceptionCap release];
	[accountPhoneNumber release];
	[xmlParser release];
	
	[imageActivityIndicator release];
	[commentsActivityIndicator release];
	[accountImageView release];
	[mentionImage release];
	[roomCapLabel release];
	[receptionCapLabel release];
	[addressLabel release];
	[websiteLabel release];
	[mapButton release];
	[emailButton release];
	[callButton release];
	[super dealloc];
}


@end
