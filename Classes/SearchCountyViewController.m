//
//  SearchCountyViewController.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "SearchCountyViewController.h"
#import "Reachability.h"
#import "SelectSiteViewController.h"

@implementation SearchCountyViewController
@synthesize counties, keys, sectionCount;
@synthesize activityIndicator;
@synthesize countyTable;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"Search by County";
	self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Loc-background.png"]];

	
	UIBarButtonItem* homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSearchCounty:)];
	self.navigationItem.leftBarButtonItem = homeButton;
	//self.navigationItem.leftBarButtonItem.enabled = FALSE;
	[homeButton release];
		
	
	[activityIndicator startAnimating];
	counties = [[NSMutableArray alloc] init];
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
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Internet Connection Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];	
	}
	
	if (netStatus == ReachableViaWiFi) {
		//NSLog(@"Internet Via Wifi");	
	}
	
	if (netStatus == ReachableViaWWAN) {
		//NSLog(@"Internet Via WWAN");	
	}
	
	NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\"><soap:Header/><soap:Body><tem:GetCounties/></soap:Body></soap:Envelope>"];
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

-(void) dismissSearchCounty:(id) sender{	
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
	if([elementName isEqualToString:@"State"]){
		stateFound = TRUE;
	}
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
	

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
			
			/*If 0 then it is the first section so don't add it*/
			if([counties count]!=0){
				[sectionCount addObject:[NSNumber numberWithInteger:rowCount]];
				rowCount = 0;
			}
		}
		
		[string release];
		[county release];
		county = nil;
		stateFound = FALSE;
	}
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ }


- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	//[parser release];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
	
	/*Last Section Count Added Here*/
	[sectionCount addObject:[NSNumber numberWithInteger:rowCount]];
	[activityIndicator stopAnimating];
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
	if([counties count] != 0){
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
	
	county = [counties objectAtIndex:[self getRowNumber:[indexPath section] indexrow:[indexPath row]]];
	
	cell.textLabel.text = county.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	SelectSiteViewController *siteViewController = [[SelectSiteViewController alloc] initWithNibName:@"SelectSiteViewController" bundle:nil];
	County *countyx = [counties objectAtIndex:[self getRowNumber:[indexPath section] indexrow:[indexPath row]]];
	siteViewController.county  = countyx;
	
	
	[siteViewController setDelegate:self];
	//[countyx release];
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Counties" style:UIBarButtonItemStylePlain target:nil action:nil];
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
	[webservice setDelegate:nil];
	[webservice release];
	[xmlParser release];
	[keys release];
	[counties release];
	[sectionCount release];
	
	[activityIndicator release];
	[countyTable release];
	[super dealloc];
}


@end
