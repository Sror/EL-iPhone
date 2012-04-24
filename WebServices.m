//
//  WebServices.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "WebServices.h"


@implementation WebServices


- (id)init {

    if (self = [super init] ){
	}
	return self;
}


- (void)setDelegate:(id)adelegate{
	delegate = adelegate;
}


- (void) execWebService:(NSString*)soapMessage {

	NSURL *url = [NSURL URLWithString:@"http://locationsmagazine.com/admina/services/iphone.asmx"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[request addValue:@"text/xml; charset=utf-8"  forHTTPHeaderField:@"Content-Type"];
	[request addValue:msgLength forHTTPHeaderField:@"Content-Length"];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if(conn){
		webData = [[NSMutableData data] retain];
	}
	else{
		NSLog(@"theConnection is NULL");
	}
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
	[webData setLength: 0];
}


-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
	[webData appendData:data];
}

-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error {
	[webData release];
    [connection release];
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
	
	if(delegate !=nil){
		[delegate gettingDataFinish:self data:webData];
	}
	
	[webData release];
	[connection release];
}

- (void)dealloc {
    [super dealloc];
}


@end
