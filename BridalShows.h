//
//  BridalShows.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/26/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BridalShows : NSObject {
	
	NSInteger bridalShowId;
	NSString* company;
	NSString* day;
	NSString* date;
	NSString* location;
	NSString* address;
	NSString* cost;
	
}

@property(nonatomic) NSInteger bridalShowId;
@property(nonatomic, retain) NSString* company;
@property(nonatomic, retain) NSString* day;
@property(nonatomic, retain) NSString* date;
@property(nonatomic, retain) NSString* location;
@property(nonatomic, retain) NSString* address;
@property(nonatomic, retain) NSString* cost;

@end
