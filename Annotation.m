//
//  Annotation.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/4/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "Annotation.h"


@implementation Annotation
@synthesize coordinate, title, subTitle;

- (NSString *)subtitle{
	return subTitle;
}

- (NSString *)title{
	return title;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}


- (void) dealloc{
	[super dealloc];
	[title release];
	[subTitle release];
}
@end
