//
//  Annotation.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 12/4/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Annotation : NSObject <MKAnnotation>{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subTitle;
}

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *subTitle;

@end
