//
//  Account.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/21/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LocAcc : NSObject {
	
	NSInteger accountid;
	NSString* accountname;
	NSString* contact;
	NSString* comment;
	NSString* address1;
	NSString* city;
	NSString* accountstate;
	NSString* url;
	NSString* zip;
	NSInteger serviceid;
	NSString* servicename;
	NSInteger map;
}

@property(nonatomic) NSInteger accountid;
@property(nonatomic, retain) NSString* accountname;
@property(nonatomic, retain) NSString* contact;
@property(nonatomic, retain) NSString* comment;
@property(nonatomic, retain) NSString* address1;
@property(nonatomic, retain) NSString* city;
@property(nonatomic, retain) NSString* accountstate;
@property(nonatomic, retain) NSString* url;
@property(nonatomic, retain) NSString* zip;
@property(nonatomic) NSInteger serviceid;
@property(nonatomic, retain) NSString* servicename;
@property(nonatomic) NSInteger map;

@end
