//
//  HoneymoonView.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 1/16/11.
//  Copyright 2011 LocationsMagazine.Com. All rights reserved.
//

#import "HoneymoonView.h"
#import "Reachability.h"
#import "SelectSiteViewController.h"
#import "AccountScrollView.h"
#import "WinAHoneymoonViewController.h"


@implementation HoneymoonView
@synthesize accounts, keys, sectionCount;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
 self.title=@"Honeymoon & Wedding";
 UIBarButtonItem* homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissHoneymoonView:)];
 self.navigationItem.leftBarButtonItem = homeButton;
 [homeButton release];
 
 
	[activityIndicator startAnimating];
	accounts = [[NSMutableArray alloc] init];
	keys = [[NSMutableArray alloc] init];
	sectionCount = [[NSMutableArray alloc] init];
	rowCount = 0;
 
	/********************************
	 INTERNET TEST
	 ********************************/

	//internetReach = [[Reachability reachabilityForInternetConnection] retain];
	internetReach = [[Reachability reachabilityWithHostName: @"www.locationsmagazine.com"] retain];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	[internetReach release];

	
	if (netStatus == NotReachable) {
		[activityIndicator stopAnimating];
		[activityIndicator setHidden:YES];
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Internet Connection Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];	
	}

	if (netStatus == ReachableViaWiFi) {
		//NSLog(@"Internet Via Wifi");	
	}

	if (netStatus == ReachableViaWWAN) {
		//NSLog(@"Internet Via WWAN");	
	}

	NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\"><soap:Header/><soap:Body><tem:GetMobileEnabledHoneymoonAccounts/></soap:Body></soap:Envelope>"];
	webservice = [[WebServices alloc] init];
	[webservice setDelegate:self];
	[webservice execWebService:soapMessage];
}


/****************************
 CUSTOM FUNCTIONS
 ****************************/

- (void)setDelegate:(id)adelegate{
	delegate = adelegate;
}

-(void) dismissHoneymoonView:(id) sender{
	[delegate homeButtonPressed:self];
}

- (void) openWinAHoneymoonView:(id) sender{
	WinAHoneymoonViewController* winAHoneymoonViewController = [[WinAHoneymoonViewController alloc] init];	
	[winAHoneymoonViewController setDelegate:self];
	[self.navigationController pushViewController:winAHoneymoonViewController  animated:YES];
	[winAHoneymoonViewController release];	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [delegate homeButtonPressed:self];
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

-(NSInteger)getRowNumber:(NSInteger)section indexrow:(NSInteger)row{
	NSInteger cell;
	NSInteger sectionsCount = 0;
	NSInteger cnt;
	
	if (section==0) {
		cell=row;
	}else {
		sectionsCount = 0;
		for (cnt=section-1; cnt>=0; cnt--) {
			sectionsCount+=[[sectionCount objectAtIndex:cnt] integerValue];
		}
		
		cell = (NSInteger)(sectionsCount + row);
	}		
	return cell;
}


/********************************
 XMLPARSER DELEGATE FUNCTIONS
 ********************************/

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    	
	if([elementName isEqualToString:@"Id"]){
		idFound = TRUE;
	}
	if([elementName isEqualToString:@"Name"]){
		nameFound = TRUE;	
	}
	if([elementName isEqualToString:@"Contact"]){
		contactFound = TRUE;	
	}
	if([elementName isEqualToString:@"Comments"]){
		commentFound = TRUE;
	}
	if([elementName isEqualToString:@"Address1"]){
		address1Found = TRUE;	
	}
	if([elementName isEqualToString:@"City"]){
		cityFound = TRUE;	
	}
	if([elementName isEqualToString:@"State"]){
		stateFound = TRUE;
	}
	if([elementName isEqualToString:@"Url"]){
		urlFound = TRUE;
	}
	if([elementName isEqualToString:@"Zip"]){
		zipFound = TRUE;
	}
	if([elementName isEqualToString:@"Map"]){
		mapFound = TRUE;
	}
	
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
	
	
	NSString *stringx = [string retain];
	if (idFound) {
		account = [[LocAcc alloc] init];
		account.accountid = [stringx integerValue];
		idFound = FALSE;
	}
	if (nameFound) {
		account.accountname = stringx;
		nameFound = FALSE;
		if([[stringx substringToIndex:1] isEqualToString:@"-"]){
			[keys addObject:[stringx stringByReplacingOccurrencesOfString:@"-" withString:@""]];
		}
	}
	if (contactFound) {
		account.contact = stringx;		
		contactFound = FALSE;
	}
	if (commentFound) {
		account.comment = stringx;
		commentFound = FALSE;
	}
	if (address1Found) {
		account.address1 = stringx;		
		address1Found = FALSE;
	}
	if (cityFound) {
		account.city = stringx;
		cityFound = FALSE;
	}
	if (stateFound) {
		account.accountstate = stringx;		
		stateFound = FALSE;
	}
	if (urlFound) {
		account.url = stringx;		
		urlFound = FALSE;
	}
	if (zipFound) {
		account.zip = stringx;
		zipFound = FALSE;
	}

	if (mapFound) {
		account.map = [stringx integerValue];
		mapFound = FALSE;
		
		if(![[account.accountname substringToIndex:1] isEqualToString:@"-"]){
			[accounts addObject:account];
			rowCount++;
		}else{
			
			if([accounts count]!=0){
				[sectionCount addObject:[NSNumber numberWithInteger:rowCount]];
				rowCount = 0;
			}
		}
		
		//[accounts addObject:account];
		[account release];
		account = nil;		
	}
	
	
	[stringx release];
	
	/*
	if (idFound) {
		county = [[County alloc] init];
		county.countyid = [string integerValue];
		idFound = FALSE;
	}
	
	if (nameFound) {
		county.name = string;		
		nameFound = FALSE;
		if([[string substringToIndex:1] isEqualToString:@"-"]){
			[keys addObject:[string stringByReplacingOccurrencesOfString:@"-" withString:@""]];
		}
	}
	
	if (stateFound) {
		county.state = string;
		
		if(![[county.name substringToIndex:1] isEqualToString:@"-"]){
			[counties addObject:county];
			rowCount++;
		}else{
			
			
			if([counties count]!=0){
				[sectionCount addObject:[NSNumber numberWithInteger:rowCount]];
				rowCount = 0;
			}
		}
		
		[county release];
		county = nil;
		stateFound = FALSE;
	}
	 */
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ }


- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	//[parser release];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
	
	/*Last Section Count Added Here*/
	[sectionCount addObject:[NSNumber numberWithInteger:rowCount]];
	[activityIndicator stopAnimating];
	[activityIndicator setHidden:YES];
	[countyTable reloadData];
	//[parser release];
}


/****************************
 TABLEVEIW FUNCTIONS
 ****************************/

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [keys objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	if([accounts count] != 0){
		return [keys count];
	}else{
		return 0;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[sectionCount objectAtIndex:section] integerValue];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	account = [accounts objectAtIndex:[self getRowNumber:[indexPath section] indexrow:[indexPath row]]];
	
	cell.textLabel.text = account.accountname;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	AccountScrollView *accountDetailViewController = [[AccountScrollView alloc] initWithNibName:@"AccountScrollView" bundle:nil];
	accountDetailViewController.accounts = accounts;
	accountDetailViewController.currentPage = [self getRowNumber:[indexPath section] indexrow:[indexPath row]];
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sites" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationController pushViewController:accountDetailViewController animated:YES];
	[accountDetailViewController release];	
	[self.navigationItem.backBarButtonItem release];
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
	[accounts release];
	[webservice setDelegate:nil];
	[webservice release];
	[xmlParser release];
	[keys release];
	[sectionCount release];		
    [super dealloc];
}


@end
