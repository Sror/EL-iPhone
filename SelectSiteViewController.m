//
//  SelectSiteViewController.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/15/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "SelectSiteViewController.h"
#import "AccountDetailsViewController.h"
#import "AccountScrollView.h"
#import "Reachability.h"



@implementation SelectSiteViewController
@synthesize county, keys, sectionCount, accounts;;
@synthesize siteTable;

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
	 [super viewDidLoad];
	 
	 self.title=county.name;
	 self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Loc-background.png"]];

	 [activityIndicator startAnimating];
	 keys = [[NSArray alloc] initWithObjects:@"#",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
	 sectionCount = [[NSMutableArray alloc] init];
	 accounts = [[NSMutableArray alloc] init];
	 rowCount = 0;
	 
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

	 if (netStatus == ReachableViaWiFi) {
		 //NSLog(@"Internet Via Wifi");	
	 }	 
	 if (netStatus == ReachableViaWWAN) {
		 //NSLog(@"Internet Via WWAN");	
	 }
	
	 NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\"><soap:Header/><soap:Body><tem:GetAccountsByCounty><tem:countyid>%d</tem:countyid></tem:GetAccountsByCounty></soap:Body></soap:Envelope>", county.countyid];
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
		[delegate dismissSearchCounty:self];
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
	NSInteger cnt;
	NSInteger sectionsCount = 0;
	
	if (section==0) {
		cell=row;
	}else {
		sectionsCount = 0;
		for (cnt=section+1; cnt>=0; cnt--) {
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
	/*Last Section Count Added Here*/
	[sectionCount addObject:[NSNumber numberWithInteger:rowCount]];
	[activityIndicator stopAnimating];
	[siteTable reloadData];
	//[parser release];
}


/****************************
 TABLEVEIW FUNCTIONS
 ****************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	if([accounts count]==0){
		return 0;
	}else if ([accounts count] < 20) {
		return 1;	
	}else{
		return [keys count];
	}
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
if ([accounts count] < 20){
	return [accounts count];
}else {
		
	NSInteger i = 0;
	NSInteger counter = 0;
	
	NSString *firstChar= [[NSString alloc] initWithString:@""];
	
	for (i=0; i<[accounts count]; i++) {
		LocAcc *accountx = [accounts objectAtIndex:i];
		firstChar = [accountx.accountname substringToIndex:1];
		firstChar = [firstChar uppercaseString];
		
		if(section==0){
			if(
			   [firstChar isEqualToString:@"0"] ||
			   [firstChar isEqualToString:@"1"] ||
			   [firstChar isEqualToString:@"2"] ||
			   [firstChar isEqualToString:@"3"] ||
			   [firstChar isEqualToString:@"4"] ||
			   [firstChar isEqualToString:@"5"] ||
			   [firstChar isEqualToString:@"6"] ||
			   [firstChar isEqualToString:@"7"] ||
			   [firstChar isEqualToString:@"8"] ||
			   [firstChar isEqualToString:@"9"]
			   ){
				counter++;
			}
		}
		if([firstChar isEqualToString:[keys objectAtIndex:section]]){
			counter++;
		}
	}
	
	NSNumber* counterAsInteger = [NSNumber numberWithInt:counter];
	[sectionCount addObject:counterAsInteger];
	return counter;
}
	
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
	
	if ([accounts count]!=0 && [accounts count] < 20){
		return [[NSArray alloc] initWithObjects:nil];
	}
	if([accounts count] > 20) {
		return keys;
	}
	return [[NSArray alloc] initWithObjects:nil];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
	if([accounts count] < 20){
		return @"Sites";
	}else{
		return [keys objectAtIndex:section];
	}
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	LocAcc *accountx;
    
	if ([accounts count] < 20){
		accountx  = [accounts objectAtIndex:indexPath.row];
	}else{
		accountx = [accounts objectAtIndex:[self getRowNumber:[indexPath section] indexrow:[indexPath row]]];
	}
	
    cell.textLabel.text = accountx.accountname;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	/*
	
	AccountDetailsViewController *accountDetailViewController = [[AccountDetailsViewController alloc] initWithNibName:@"AccountDetailsViewController" bundle:nil];
	    
	if ([accounts count] < 20){
		accountDetailViewController.account  = [accounts objectAtIndex:indexPath.row];
	}else{
		accountDetailViewController.account = [accounts objectAtIndex:[self getRowNumber:[indexPath section] indexrow:[indexPath row]]];
	}
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sites" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationController pushViewController:accountDetailViewController animated:YES];
	[accountDetailViewController release];	
	*/
	
	
	AccountScrollView *accountDetailViewController = [[AccountScrollView alloc] initWithNibName:@"AccountScrollView" bundle:nil];
	accountDetailViewController.accounts  = accounts;
	
	if ([accounts count] < 20){
		accountDetailViewController.currentPage  = indexPath.row;
	}else{
		accountDetailViewController.currentPage = [self getRowNumber:[indexPath section] indexrow:[indexPath row]];
	}
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sites" style:UIBarButtonItemStylePlain target:nil action:nil];
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
	[county release];
	[xmlParser release];
	[keys release];
	[accounts release];
	[sectionCount release];
	
	[activityIndicator release];
	[siteTable release];
	[super dealloc];
}


@end
