//
//  AccountMap.h
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/28/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocAcc.h"
#import "Annotation.h"
#import "GeoCoder.h"

@interface AccountMap : UIViewController <MKMapViewDelegate, UIAlertViewDelegate>{

	LocAcc *account;
	Annotation *annotationx;

	IBOutlet MKMapView *accountMap;
	IBOutlet UILabel *titleLabel;
}
@property(nonatomic, retain) LocAcc *account;

- (IBAction) dismissAccountMap:(id)sender;
- (IBAction) getDirections:(id)sender;


@end
