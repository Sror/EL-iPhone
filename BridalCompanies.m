//
//  BridalCompanies.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/24/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "BridalCompanies.h"


@implementation BridalCompanies
@synthesize companyid, name, state;


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
