//
//  GetImage.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "GetImage.h"


@implementation GetImage

@synthesize dataURL;

- (id)init {
    if (self = [super init] ){
	}
	return self;
}

- (void)setDelegate:(id)adelegate{
	delegate = adelegate;
}


- (void) getImage:(NSString*)dataURLFromUser{
	NSURL* url = [NSURL URLWithString:dataURLFromUser];	
	NSURLRequest* request = [NSURLRequest requestWithURL:url];
	
	NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self] ;
	connection = connection;
	receivedData = [[NSMutableData data] retain];
}

/************************************
 *NSURLConnection Delegate Functions*
 ************************************/

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[receivedData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
	
	//UIImage* image = [[UIImage alloc] initWithData:receivedData];
	//imageView.image = image;
	
	if(delegate != nil){
		[delegate gettingImageDone:self data:receivedData];
	}
		
	[connection release];
	[receivedData release];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	[connection release];
	[receivedData release];
}



- (void) dealloc{
	
	[dataURL release];
	[super dealloc];
}

@end
