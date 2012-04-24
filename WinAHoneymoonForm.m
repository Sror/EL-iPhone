//
//  WinAHoneymoonForm.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/26/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "WinAHoneymoonForm.h"
#import "Reachability.h"
#import "RegexKitLite.h"

@implementation WinAHoneymoonForm

@synthesize scrollView;	
@synthesize firstName;
@synthesize lastName;
@synthesize emailAddress;
@synthesize address1;
@synthesize address2;
@synthesize city;
@synthesize state;
@synthesize zip;
@synthesize numberOfPeople;
@synthesize pricePerPerson;
@synthesize eventDate;
@synthesize typeOfSite;
@synthesize weddingCounty;
@synthesize sendActivity;
@synthesize abtUrHoneymoonTable;




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Win a Honeymoon";	
	scrollView.contentSize = CGSizeMake(320, 1800);
	[scrollView setCanCancelContentTouches:NO];
	[scrollView flashScrollIndicators];
	
	abtUrHoneymoonTable = [[UITableView alloc] initWithFrame:CGRectMake(13,1380,300,337) style:UITableViewStylePlain];
    abtUrHoneymoonTable.rowHeight = 30;
	[abtUrHoneymoonTable setScrollEnabled:YES];
	[abtUrHoneymoonTable setDelegate:self];
	[abtUrHoneymoonTable setDataSource:self];
	[abtUrHoneymoonTable setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:abtUrHoneymoonTable];
	
	
	/********************************
	 INTERNET TEST
	 ********************************/
	internetReach = [[Reachability reachabilityWithHostName: @"www.locationsmagazine.com"] retain];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	[internetReach release];
	
	if (netStatus == NotReachable) {
		//[activityIndicator stopAnimating];
		//[activityIndicator setHidden:YES];
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Internet Connection Not Available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		alert.tag = 1;
		[alert show];	
	}
	
		
	siteArray = [[NSArray alloc] initWithObjects:@"Catering Hall",@"Club",@"Conference Center",@"Country Club",@"Country Inn",
				                                 @"Event Site",@"Hotel",@"Loft",@"Mansion",@"Museum",@"Oceanfront / Wavefront",
												 @"Private Club",@"Restaurant",@"Sports Event Site",@"Temple",@"Townhouse",@"Yatch / Boat",nil];
	
	countyArray = [[NSArray alloc] initWithObjects:@"--New York City--",
				   @"Bronx",
				   @"Brooklyn",
				   @"Manhattan",
				   @"Queens",
				   @"Staten Island",
				   @"--New York State--",
				   @"Dutchess",
				   @"Hudson Valley",
				   @"Orange",
				   @"Putnam",
				   @"Rockland",
				   @"Sullivan",
				   @"Ulster",
				   @"Westchester",
				   @"--Long Island--",
				   @"Nassau",
				   @"Suffolk",
				   @"--New Jersey--",
				   @"Atlantic",
				   @"Bergen",
				   @"Burlington",
				   @"Essex",
				   @"Hudson",
				   @"Hunterdon",
				   @"Mercer",
				   @"Middlesex",
				   @"Monmouth",
				   @"Morris",
				   @"Ocean",
				   @"Passaic",
				   @"Somerset",
				   @"Sussex",
				   @"Union",
				   @"Warren",
				   @"--Honeymoon--",
				   @"Anguilla",
				   @"Antigua",
				   @"Bahamas",
				   @"Barbados",
				   @"Bermuda",
				   @"British Virgin Islands",
				   @"China",
				   @"Cuba",
				   @"Dominican Republic",
				   @"Jamaica",
				   @"Las Vegas",
				   @"Honolulu, Hawaii",
				   @"Maui, Hawaii",
				   @"Oahu, Hawaii",
				   @"Miami Beach",
				   @"Rome, Italy",
				   @"Paris, France",
				   @"Poconos",
				   @"St. Barths, FWI",
				   @"St Lucia",
				   @"St. Martin, FWI",
				   @"Travel",nil];
	
	aboutYourHoneymoonArray = [[NSArray alloc] initWithObjects:@"Antigua", 
							   @"Bahamas", @"Bermuda", 
							   @"British Virgin Islands (BVI)", 
							   @"France", @"Hawaii", @"Italy", 
							   @"Jamaica", @"St. Barts", @"St. Lucia", @"St. Martin", nil];
	
	/*****************************
	 ***Initialization of Strings
	 *****************************/
	typeSite = [[NSString alloc] initWithString:[siteArray objectAtIndex:0]];
	weddCounty = [[NSString alloc] initWithString:[countyArray objectAtIndex:1]];
	honeyMoonCountry = [[NSString alloc] initWithString:@""];

	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	df.dateStyle = NSDateFormatterShortStyle;
	eventDateString = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@",[df stringFromDate:[NSDate date]]]];
	[df release];
	
	
	
	/*********************************
	 *End of Initialization of Strings
	 ********************************/
	[eventDate addTarget:self action:@selector(dateChangedByUser:) forControlEvents:UIControlEventValueChanged];
	[eventDate setDate:[NSDate date]];
	[eventDate setMinimumDate:[NSDate date]];
		
	[self.weddingCounty selectRow:1 inComponent:0 animated:YES];
	
	typeOfSite.tag = 0;
	weddingCounty.tag = 1;
	
}


/****************************
    DELEGATE FUNCTIONS
 ****************************/

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return NO;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	/*Type of Site*/
	if(pickerView.tag == 0){	
		return [siteArray count];
	}
	/*Wedding County*/
	if(pickerView.tag == 1){	
		return [countyArray count];
	}
	return 0;
}


-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	/*Type of Site*/
	if(pickerView.tag == 0){	
		return [siteArray objectAtIndex:row];
	}
	/*Wedding County*/
	if(pickerView.tag == 1){	
		return [countyArray objectAtIndex:row];
	}
	
	return @"";
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	if(pickerView.tag == 1){
		if([[[countyArray objectAtIndex:row] substringToIndex:1] isEqualToString:@"-"]){
			[pickerView selectRow:(row+1) inComponent:component animated:YES];
			weddCounty = [countyArray objectAtIndex:(row+1)];
		}else {
			weddCounty = [countyArray objectAtIndex:row];
		}
	}
	
	if(pickerView.tag == 0){
		typeSite = [siteArray objectAtIndex:row];
	}
}

/****************************
 FORM VALIDATION FUNCTIONS
 ****************************/

-(IBAction) submitWinForm:(id)sender{
	
	
	NSMutableString *errors  = [[[NSMutableString alloc] init] autorelease];
	BOOL isError = FALSE;
	
	if ([firstName.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"First Name is required.\n"];
	}
	if ([lastName.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Last Name is required.\n"];
	}
	
	if ([emailAddress.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Email is required.\n"];
		
	}else if(![self validateEmail:emailAddress.text]){
		isError = TRUE;
		[errors appendString: @"Email Address is invalid.\n"];
	}
	
	if ([address1.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Address1 is required.\n"];
	}
	if ([city.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"City is required.\n"];
	}
	if ([state.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"State is required.\n"];
	}
	if ([zip.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Zip is required.\n"];
	}
	if ([numberOfPeople.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Number of people is required.\n"];
		
	}else if(![self isNumber:numberOfPeople.text]){
		isError = TRUE;
		[errors appendString: @"Number of people shoud be a number.\n"];
	}
	
	if ([pricePerPerson.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Price / Person is required.\n"];
		
	}else if(![self isNumber:pricePerPerson.text]){
		isError = TRUE;
		[errors appendString: @"Price / Person shoud be a number.\n"];
	}
	
	if ([honeyMoonCountry isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"About your Honeymoon is required.\n"];
	}
	
	if(isError){
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Form Errors" message:errors delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];	
	}else{
	
		[sendActivity startAnimating];
		// Submit Form
		NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\"> \
								 <soap:Header/> \
								 <soap:Body> \
									<tem:SubmitWinAHoneymoon> \
										<tem:firstName>%@</tem:firstName> \
										<tem:lastName>%@</tem:lastName> \
										<tem:emailAddress>%@</tem:emailAddress> \
										<tem:address1>%@</tem:address1> \
										<tem:address2>%@</tem:address2> \
										<tem:city>%@</tem:city> \
										<tem:state>%@</tem:state> \
										<tem:zip>%@</tem:zip> \
										<tem:numberOfPeople>%@</tem:numberOfPeople> \
										<tem:pricePerPerson>%@</tem:pricePerPerson> \
										<tem:typeOfSite>%@</tem:typeOfSite> \
										<tem:weddingCounty>%@</tem:weddingCounty> \
										<tem:eventDate>%@</tem:eventDate> \
										<tem:honeymoonCountry>%@</tem:honeymoonCountry> \
									</tem:SubmitWinAHoneymoon> \
								 </soap:Body> \
								 </soap:Envelope>",
								 firstName.text,
								 lastName.text,
								 emailAddress.text,
								 address1.text,
								 address2.text,
								 city.text,
								 state.text,
								 zip.text,
								 numberOfPeople.text,
								 pricePerPerson.text,
								 typeSite,
								 weddCounty,
								 eventDateString,
								 honeyMoonCountry
								 ];
		
		webservice = [[WebServices alloc] init];
		[webservice setDelegate:self];
		[webservice execWebService:soapMessage];	
		[eventDateString release];
	}
}

/****************************
 CUSTOM FUNCTIONS
 ****************************/
- (void)setDelegate:(id)adelegate{
	delegate = adelegate;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	/*No Internet Connection Alert*/
	if (buttonIndex == 0 && alertView.tag == 1) {
		[delegate dismissWinAHoneymoon:self];
	}
	/* Honeymoon Sent / Error */
	if(alertView.tag == 3 && buttonIndex == 0){
		[self.navigationController popViewControllerAnimated:YES];
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

-(BOOL)validateEmail:(NSString *)email{
	NSString *strEmailMatchstring=@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
	if([email isMatchedByRegex:strEmailMatchstring]){
		return YES;
	}
	else{
		return NO;
	}
}

-(BOOL)isNumber:(NSString *)string{
	NSString *strNumberMatchstring=@"\\b([0-9]+)\\b";
	if([string isMatchedByRegex:strNumberMatchstring]){
		return YES;
	}
	else{
		return NO;
	}
}

- (void)dateChangedByUser:(id)sender{		
		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		df.dateStyle = NSDateFormatterShortStyle;
		eventDateString = [[NSString stringWithFormat:@"%@",[df stringFromDate:eventDate.date]] retain];
		[df release];
}



/********************************
 XMLPARSER DELEGATE FUNCTIONS
 ********************************/

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {

}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
	
	if([string isEqualToString:@"sent"]){
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Success" message:@"Thank you for entering the Honeymoon Sweepstakes." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		alert.tag = 3;
		[alert show];	
		[sendActivity stopAnimating];
	}
	if([string isEqualToString:@"error"]){
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error adding to Win A Honeymoon, Please try later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		alert.tag = 3;
		[alert show];	
		[sendActivity stopAnimating];
	}
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{ }

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
	[parser release];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
	[parser release];
}

/****************************
 TABLEVIEW FUNCTIONS
 ****************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [aboutYourHoneymoonArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text = [aboutYourHoneymoonArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if([[tableView cellForRowAtIndexPath:indexPath] accessoryType] == UITableViewCellAccessoryCheckmark){
		[[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
		
		if([honeyMoonCountry isEqualToString:[NSString stringWithFormat:@",%@",[aboutYourHoneymoonArray objectAtIndex:indexPath.row]]]){
			honeyMoonCountry = [[honeyMoonCountry stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",[aboutYourHoneymoonArray objectAtIndex:indexPath.row]] withString:@""] retain];
		}else{
			honeyMoonCountry = [[honeyMoonCountry stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@",%@",[aboutYourHoneymoonArray objectAtIndex:indexPath.row]] withString:@""] retain];
		}
	}else{
		[[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
		if([honeyMoonCountry isEqualToString:@""]){
			honeyMoonCountry = [[honeyMoonCountry stringByAppendingString:[NSString stringWithFormat:@"%@",[aboutYourHoneymoonArray objectAtIndex:indexPath.row]]] retain];
		}else{
			honeyMoonCountry = [[honeyMoonCountry stringByAppendingString:[NSString stringWithFormat:@",%@",[aboutYourHoneymoonArray objectAtIndex:indexPath.row]]] retain];
		}
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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

     [scrollView release];	
	 [firstName release];
	 [lastName release];
	 [emailAddress release];
	 [address1 release];
	 [address2 release];
	 [city release];
	 [state release];
	 [zip release];
	 [numberOfPeople release];
	 [pricePerPerson release];
	 [eventDate release];
	 [typeOfSite release];
	 [weddingCounty release];
	 [sendActivity release];
	 [abtUrHoneymoonTable release];
	
	
	[siteArray release];
	[countyArray release];
	[aboutYourHoneymoonArray release];
	[webservice setDelegate:nil];
	[webservice release];
	[honeyMoonCountry release];
	[eventDateString release];
	//[xmlParser release];
	[typeSite release];
	[weddCounty release];
	[super dealloc];
}


@end
