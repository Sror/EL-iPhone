//
//  County.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/14/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "County.h"


@implementation County
@synthesize countyid, name, state;


- (id)init {
    if (self = [super init] ){
	}
	return self;
}


-(void)dealloc{
	[super dealloc];
	[name release];
	//[state release];
}

@end
