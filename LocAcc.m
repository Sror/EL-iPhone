//
//  Account.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/21/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "LocAcc.h"


@implementation LocAcc
@synthesize accountid, accountname, contact, comment, address1, city, accountstate, url, zip, serviceid, servicename, map;


- (id)init {
    if (self = [super init] ){
	}
	return self;
}


-(void)dealloc{
	[accountname release];
	[contact release];
	[comment release];
	[address1 release];
	[city release];
	[accountstate release];
	[url release];
	[zip release];
	[servicename release];
	[super dealloc];
}
@end
