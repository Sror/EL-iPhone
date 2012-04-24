//
//  AccountEmail.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/28/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "AccountEmail.h"
#import "RegexKitLite.h"


@implementation AccountEmail
@synthesize accountName, accountId;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
		[super viewDidLoad];
		//[titleLabel setText:[NSString stringWithFormat:@"Email: %@", accountName]];
		self.title	= [NSString stringWithFormat:@"Email: %@", accountName];
		scrollView.contentSize = CGSizeMake(320, 650);
		[scrollView setCanCancelContentTouches:NO];
		[scrollView flashScrollIndicators];
}

/********************************
	CUSTOM FUNCTIONS
 ********************************/

- (IBAction) cancelEmail:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) sendEmail:(id)sender{
	NSMutableString *errors  = [[[NSMutableString alloc] init] autorelease];
	BOOL isError = FALSE;
	
	if ([firstName.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Name is required.\n"];
	}
	
	if ([emailAddress.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Email is required.\n"];
		
	}else if(![self validateEmail:emailAddress.text]){
		isError = TRUE;
		[errors appendString: @"Email Address is invalid.\n"];
	}
	
	if ([subject.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Subject is required.\n"];
	}
	if ([message.text isEqualToString:@""]) {
		isError = TRUE;
		[errors appendString: @"Message is required.\n"];
	}
	
	if(isError){
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Form Errors" message:errors delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[alert show];	
	}else{
		
		[sendActivity startAnimating];
		// Submit Send Email Form
		NSString *soapMessage = [NSString stringWithFormat:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\"> \
								 <soap:Header/> \
								 <soap:Body> \
								 <tem:SendAccountEmail> \
									<tem:name>%@</tem:name> \
									<tem:email>%@</tem:email> \
									<tem:subject>%@</tem:subject> \
									<tem:message>%@</tem:message> \
									<tem:accid>%d</tem:accid> \
								 </tem:SendAccountEmail> \
								 </soap:Body> \
								 </soap:Envelope>",
								 firstName.text,
								 emailAddress.text,
								 subject.text,
								 message.text,
								 accountId
								 ];
		
		webservice = [[WebServices alloc] init];
		[webservice setDelegate:self];
		[webservice execWebService:soapMessage];		
	}
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

/****************************
	DELEGATE FUNCTIONS
 ****************************/

- (void) gettingDataFinish:(WebServices*) webservice data:(NSMutableData*) webData{
	
	if (xmlParser){
        [xmlParser release];
    }    
	xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return NO;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	
	if(alertView.tag == 3 && buttonIndex == 0){
		[self.navigationController popViewControllerAnimated:YES];
	}
	
}

/********************************
 XMLPARSER DELEGATE FUNCTIONS
 ********************************/

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
	
}

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string{
	if([string isEqualToString:@"sent"]){
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Locations Magazine" message:@"Your email has been sent." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		alert.tag = 3;
		[alert show];	
		[sendActivity stopAnimating];
	}
	if([string isEqualToString:@"error"]){
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Locations Magazine" message:@"Error sending email, Please try later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
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
    [super dealloc];
	[accountName release];
	[webservice setDelegate:nil];
	[webservice release];
}


@end
