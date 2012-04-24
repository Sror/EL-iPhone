//
//  BridalShows.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/26/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "BridalShows.h"


@implementation BridalShows
@synthesize bridalShowId, company, day, date, location, address, cost;


- (id)init {
    if (self = [super init] ){
	}
	return self;
}


-(void)dealloc{
	[super dealloc];
	[company release];
	[day release];
	[date release];
	[location release];
	[address release];
	//[cost release];
}



@end
