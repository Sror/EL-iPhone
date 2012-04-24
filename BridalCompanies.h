//
//  BridalCompanies.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/24/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BridalCompanies : NSObject {
	NSInteger companyid;
	NSString* name;
	NSString* state;	
}

@property(nonatomic) NSInteger companyid;
@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* state;

@end
