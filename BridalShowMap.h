//
//  BridalShowMap.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 1/16/11.
//  Copyright 2011 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "GeoCoder.h"


@interface BridalShowMap : UIViewController <MKMapViewDelegate, UIAlertViewDelegate>{

	Annotation *annotationx;
	NSString *bridalShowAddress;
	NSString *bridalShowName;
	IBOutlet MKMapView *accountMap;
	IBOutlet UILabel *titleLabel;
}

@property(nonatomic, retain) NSString *bridalShowAddress;
@property(nonatomic, retain) NSString *bridalShowName;


- (IBAction) dismissAccountMap:(id)sender;
- (IBAction) getDirections:(id)sender;

@end