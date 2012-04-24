//
//  County.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/14/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface County : NSObject {

	NSInteger countyid;
	NSString* name;
	NSString* state;
	
}
@property(nonatomic) NSInteger countyid;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* state;

@end
