//
//  GeoCoder.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/4/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface GeoCoder : NSObject {

}

- (CLLocationCoordinate2D) addressLocation:(NSString*)address1 city:(NSString*)city state:(NSString*)state zip:(NSString*)zip;
- (CLLocationCoordinate2D) addressLocationAllInOne:(NSString*)addressx;

@end
