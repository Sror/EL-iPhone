//
//  BridalShowsList.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "BridalShowsList.h"
#import "BridalShowDetails.h"
#import "Reachability.h"

#define LOCATIONLABEL_TAG 1
#define DATELABEL_TAG 2


@implementation BridalShowsList
@synthesize bridalShow, shows, companyName, tvCell;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	self.title=@"Bridal Shows";
	[companyNameLabel setText:companyName];
	
	[activityIndicator startAnimating];
	shows = [[NSMutableArray alloc] init];
		
	/********************************
	 INTERNET TEST
	 ********************************/
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
	
	NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\"><soap:Header/><soap:Body><tem:GetBridalShows><tem:bridalCompany>%@</tem:bridalCompany></tem:GetBridalShows></soap:Body></soap:Envelope>", companyName];
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
		[delegate dismissFindABridalShow:self];
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

/********************************
 XMLPARSER DELEGATE FUNCTIONS
 ********************************/

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
	
	if([elementName isEqualToString:@"Id"]){
		idFound = TRUE;
	}
	if([elementName isEqualToString:@"Company"]){
		companyFound = TRUE;	
	}
	if([elementName isEqualToString:@"Day"]){
		dayFound = TRUE;	
	}
	if([elementName isEqualToString:@"Datex"]){
		dateFound = TRUE;
	}
	if([elementName isEqualToString:@"Location"]){
		locationFound = TRUE;	
	}
	if([elementName isEqualToString:@"Address"]){
		addressFound = TRUE;	
	}
	if([elementName isEqualToString:@"Cost"]){
		costFound = TRUE;
	}	
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
	
	//NSString *stringx = [string retain];
	if (idFound) {
		bridalShow = [[BridalShows alloc] init];
		bridalShow.bridalShowId = [string integerValue];
		idFound = FALSE;
	}
	if (companyFound) {
		bridalShow.company = string;
		companyFound = FALSE;
	}
	if (dayFound) {
		bridalShow.day = string;		
		dayFound = FALSE;
	}
	if (dateFound) {
		bridalShow.date = string;
		dateFound = FALSE;
	}
	if (locationFound) {
		bridalShow.location = string;		
		locationFound = FALSE;
	}
	if (addressFound) {
		bridalShow.address = string;
		addressFound = FALSE;
		
		[shows addObject:bridalShow];
		[bridalShow release];
		bridalShow = nil;
	}
	if (costFound) {
		bridalShow.cost = string;
		costFound = FALSE;
	}else{
		bridalShow.cost = @"na";
	}
	 
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ }

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	//[parser release];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
	/*Last Section Count Added Here*/
	[activityIndicator stopAnimating];
	[activityIndicator setHidden:YES];
	[showsTable reloadData];
	//[parser release];
}


/****************************
 TABLEVEIW FUNCTIONS
 ****************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	return [shows count];	
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"NewCell";

	UILabel *labelLocationCell;
	UILabel *labelDateCell;
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	
		
		labelLocationCell = [[UILabel alloc] initWithFrame:CGRectMake(12, 7, 272, 17)];
		labelDateCell = [[UILabel alloc] initWithFrame:CGRectMake(12, 22, 272, 21)];
		
		[labelLocationCell setBackgroundColor:[UIColor clearColor]];
		[labelLocationCell setTextColor:[UIColor blackColor]];
		[labelLocationCell setFont:[UIFont boldSystemFontOfSize:18]];
		labelLocationCell.tag = LOCATIONLABEL_TAG;
		[cell.contentView addSubview:labelLocationCell];
		[labelLocationCell release];
		
		[labelDateCell setBackgroundColor:[UIColor clearColor]];
		[labelDateCell setTextColor:[UIColor blackColor]];
		[labelDateCell setFont:[UIFont systemFontOfSize:14]];
		labelDateCell.tag = DATELABEL_TAG;
		[cell.contentView addSubview:labelDateCell];	
		[labelDateCell release];
		
    }else{		
		labelLocationCell = (UILabel *)[cell viewWithTag:LOCATIONLABEL_TAG];
		labelDateCell = (UILabel *)[cell viewWithTag:DATELABEL_TAG];
	}
	
	//labelLocationCell = (UILabel *)[cell viewWithTag:0];
	//labelDateCell = (UILabel *)[cell viewWithTag:1];

	BridalShows *showx;
	showx = [shows objectAtIndex:indexPath.row];
	
	//[labelDateCell setText:[NSString stringWithFormat:@"%@, %@", showx.location, showx.address]];	
	
	
	NSArray *dateTime = [showx.date componentsSeparatedByString:@" "];

	NSString *dateTimeString = [NSString stringWithFormat:@"%@ %@", [dateTime objectAtIndex:1], [dateTime objectAtIndex:2]];
	
	if ([[dateTime objectAtIndex:0] rangeOfString:@"PM"].location != NSNotFound) {
		dateTimeString = [dateTimeString stringByReplacingOccurrencesOfString:@":00 AM" withString:@" am"];
	}else{
		dateTimeString = [dateTimeString stringByReplacingOccurrencesOfString:@":00 PM" withString:@" pm"];
	}
	
	
	
	[labelDateCell setText:[NSString stringWithFormat:@"%@", showx.address]];
	//[labelLocationCell setText:[NSString stringWithFormat:@"%@, %@ @ %@", showx.day, [dateTime objectAtIndex:0], dateTimeString]];
	[labelLocationCell setText:[NSString stringWithFormat:@"%@, %@ @ %@", [dateTime objectAtIndex:0], showx.day, dateTimeString]];
	
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	BridalShowDetails *siteViewController = [[BridalShowDetails alloc] initWithNibName:@"BridalShowDetails" bundle:nil];
	siteViewController.bridalShow = [shows objectAtIndex:indexPath.row];
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Bridal Shows" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationController pushViewController:siteViewController animated:YES];
	[siteViewController release];	
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
	[companyName release];
	[webservice setDelegate:nil];
	[webservice release];
	[bridalShow release];
	[shows release];
	[xmlParser release];
	[activityIndicator release];
	[super dealloc];
}


@end
