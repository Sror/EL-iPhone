//
//  FindABridalShowViewController.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "FindABridalShowViewController.h"
#import "Reachability.h"
#import "BridalShowsList.h"


@implementation FindABridalShowViewController
@synthesize companies, keys, sectionCount;
@synthesize activityIndicator;
@synthesize bridalCompanyTable;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	self.title=@"Find A Bridal Show";
	self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"Loc-background.png"]];

	UIBarButtonItem* homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissFindABridalShow:)];
	self.navigationItem.leftBarButtonItem = homeButton;
	[homeButton release];
	
	
	[activityIndicator startAnimating];
	companies = [[NSMutableArray alloc] init];
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
	
	NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\"><soap:Header/><soap:Body><tem:GetBridalCompanies/></soap:Body></soap:Envelope>"];
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

-(void) dismissFindABridalShow:(id) sender{
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
	if([elementName isEqualToString:@"State"]){
		stateFound = TRUE;
	}
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
	
	if (idFound) {
		company = [[BridalCompanies alloc] init];
		company.companyid = [string integerValue];
		idFound = FALSE;
	}
	
	if (nameFound) {
		company.name = string;		
		nameFound = FALSE;
		/*
		if([[string substringToIndex:1] isEqualToString:@"-"]){
			[keys addObject:[string stringByReplacingOccurrencesOfString:@"-" withString:@""]];
		}
		 */
	}
	
	if (stateFound) {
		company.state = string;
		
		if([[string substringToIndex:1] isEqualToString:@"-"]){
			[keys addObject:[string stringByReplacingOccurrencesOfString:@"-" withString:@""]];
		}
		
		if(![[company.state substringToIndex:1] isEqualToString:@"-"]){
			//[companies addObject:company];
			//rowCount++;
		}else{
			//If 0 then it is the first section so don't add it
			if([companies count]!=0){
				[sectionCount addObject:[NSNumber numberWithInteger:rowCount]];
				rowCount = 0;
			}			
		}
		
		[companies addObject:company];
		rowCount++;
		
		[company release];
		company = nil;
		[string release];
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
	[bridalCompanyTable reloadData];
}

/****************************
 TABLEVEIW FUNCTIONS
 ****************************/

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [keys objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	if([companies count] != 0){
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
	
	company = [companies objectAtIndex:[self getRowNumber:[indexPath section] indexrow:[indexPath row]]];
	
	cell.textLabel.text = company.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	BridalShowsList *siteViewController = [[BridalShowsList alloc] initWithNibName:@"BridalShowsList" bundle:nil];
	BridalCompanies *companyx = [companies objectAtIndex:[self getRowNumber:[indexPath section] indexrow:[indexPath row]]];
	siteViewController.companyName = companyx.name;
	[siteViewController setDelegate:self];
	
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Companies" style:UIBarButtonItemStylePlain target:nil action:nil];
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
	[companies release];
	[sectionCount release];	
	[activityIndicator release];
	[bridalCompanyTable release];
    [super dealloc];
}


@end
