//
//  GeoCoder.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/4/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "GeoCoder.h"


@implementation GeoCoder


-(CLLocationCoordinate2D) addressLocation:(NSString *)address1 city:(NSString *)city state:(NSString *)state zip:(NSString *)zip {
		
	NSString *address = [NSString stringWithFormat:@"%@,%@,%@,$@",
						 address1,
						 city,
						 state,
						 zip];
	
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@,US&output=csv&key=ABQIAAAAIGnE1iKT70fYfMte8D_l3RSQyeWbdHpSxqpdSbkSvM_2pOglIRQVfVMR0ZGgWNCpuZiv9ItEVeBUig", [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
	
	NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
	double latitude = 0.0;
	double longitude = 0.0;
	
	if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
		latitude = [[listItems objectAtIndex:2] doubleValue];
		longitude = [[listItems objectAtIndex:3] doubleValue];
	}
	else {
		NSLog(@"Error Geo Coding");
	}
	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;
	
	return location;
}


- (CLLocationCoordinate2D) addressLocationAllInOne:(NSString*)addressx{

	NSString *address = [NSString stringWithFormat:@"%@", addressx];
	
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@,US&output=csv&key=ABQIAAAAIGnE1iKT70fYfMte8D_l3RSQyeWbdHpSxqpdSbkSvM_2pOglIRQVfVMR0ZGgWNCpuZiv9ItEVeBUig", [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString] encoding:NSUTF8StringEncoding error:nil];
	
	NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
	double latitude = 0.0;
	double longitude = 0.0;
	
	if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
		latitude = [[listItems objectAtIndex:2] doubleValue];
		longitude = [[listItems objectAtIndex:3] doubleValue];
	}
	else {
		NSLog(@"Error Geo Coding");
	}
	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;
	
	return location;
}


@end
