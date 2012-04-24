//
//  SearchServicesViewController.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "SearchServicesViewController.h"
#import "Reachability.h"
#import "LocAcc.h"
#import "AccountDetailsViewController.h"
#import "AccountScrollView.h"

@implementation SearchServicesViewController
@synthesize activityIndicator;
@synthesize servicesTable;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[activityIndicator startAnimating];

	accounts = [[NSMutableArray alloc] init];
	sectionCount = [[NSMutableArray alloc] init];
	sections = [[NSMutableArray alloc] init];
	sectionName = [[NSString alloc] initWithString:@""];
	rowCount = 0;
	isFirstSection = TRUE;
	
	self.title = @"Search Services";
	self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Loc-background.png"]];

	
	UIBarButtonItem* homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSearchServices:)];
	self.navigationItem.leftBarButtonItem = homeButton;
	[homeButton release];
	

	/********************************
	 INTERNET TEST
	 ********************************/
	internetReach = [[Reachability reachabilityWithHostName: @"www.locationsmagazine.com"] retain];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	[internetReach release];
	
	if (netStatus == NotReachable) {
		[activityIndicator stopAnimating];
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Internet Connection Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];	
	}
	
	NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\"> \
															<soap:Header/> \
															<soap:Body><tem:GetServices/> \
															</soap:Body> \
														</soap:Envelope>"];
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

- (void) dismissSearchServices:(id) sender{
	[delegate homeButtonPressed:self];
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
	//self.navigationItem.leftBarButtonItem.enabled = TRUE;
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
    
	//NSLog(@"%@", elementName);	
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
	if([elementName isEqualToString:@"ServiceId"]){
		serviceIdFound = TRUE;
	}
	if([elementName isEqualToString:@"ServiceName"]){
		serviceNameFound = TRUE;	
	}
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
	//NSLog(@"%@", string);
	
	NSString *stringx = [string retain];
	if(idFound){
		account = [[LocAcc alloc] init];
		account.accountid = [stringx integerValue];
		idFound = FALSE;
	}
	if(nameFound){
		account.accountname = stringx;
		nameFound = FALSE;
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
	}
	
	if(serviceIdFound){
		account.serviceid = [stringx integerValue];
		serviceIdFound = FALSE;
	}
	if(serviceNameFound){
		account.servicename = stringx;
		serviceNameFound = FALSE;
		
		if(isFirstSection){
			sectionName = stringx;
			[sections addObject:stringx];
			isFirstSection = FALSE;
		}
		
		if(![sectionName isEqualToString:stringx]){
			sectionName = stringx;
			[sections addObject:stringx];
			[sectionCount addObject:[NSNumber numberWithInteger:rowCount]];
			rowCount = 0;
		}
		
		rowCount++;
		[accounts addObject:account];
		[account release];
		account = nil;
	}
	
	[stringx release];
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ }


- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	//[parser release];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
	
	[sectionCount addObject:[NSNumber numberWithInteger:rowCount]];
	[activityIndicator stopAnimating];
	[servicesTable reloadData];
	//[parser release];
}



/****************************
 TABLEVEIW FUNCTIONS
 ****************************/

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [sections objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [sections count];
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
	
	/*
	LocAcc *accountx = [accounts objectAtIndex:[self getRowNumber:[indexPath section] indexrow:[indexPath row]]];
	AccountDetailsViewController *accountDetailViewController = [[AccountDetailsViewController alloc] initWithNibName:@"AccountDetailsViewController" bundle:nil];
	accountDetailViewController.account =  accountx;
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Services" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationController pushViewController:accountDetailViewController animated:YES];
	[accountDetailViewController release];		
	*/
	
	AccountScrollView *accountDetailViewController = [[AccountScrollView alloc] initWithNibName:@"AccountScrollView" bundle:nil];
	accountDetailViewController.accounts  = accounts;
	accountDetailViewController.currentPage = [self getRowNumber:[indexPath section] indexrow:[indexPath row]];
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Services" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationController pushViewController:accountDetailViewController animated:YES];
	[accountDetailViewController release];
	[self.navigationItem.backBarButtonItem release];
}



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */



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
	[webservice setDelegate:nil];
	[webservice release];
	[xmlParser release];
	[accounts release];
	[sectionCount release];
	[sections release];
	[activityIndicator release];
	[servicesTable release];
	[super dealloc];
}


@end
