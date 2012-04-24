//
//  BridalShowMap.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 1/16/11.
//  Copyright 2011 LocationsMagazine.Com. All rights reserved.
//

#import "BridalShowMap.h"


@implementation BridalShowMap
@synthesize bridalShowAddress, bridalShowName;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	[titleLabel setText:bridalShowName];
	
	GeoCoder *geoCoder = [[GeoCoder alloc] init];
	[accountMap setDelegate:self];
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	
	span.latitudeDelta=0.1;
	span.longitudeDelta=0.1;
	
	CLLocationCoordinate2D location = [geoCoder addressLocationAllInOne:bridalShowAddress];
	region.span=span;
	region.center=location;
	[geoCoder release];
	
	if(annotationx != nil) {
		[accountMap removeAnnotation:annotationx];
		[annotationx release];
		annotationx = nil;
	}
	
	annotationx = [[Annotation alloc] initWithCoordinate:location];
	[annotationx setTitle:bridalShowName];
	[annotationx setSubTitle:[NSString stringWithFormat:@"%@",bridalShowAddress]];
	[accountMap addAnnotation:annotationx];
	[accountMap setRegion:region animated:TRUE];
	[accountMap regionThatFits:region];
}



/********************************
 CUSTOM FUNCTIONS
 ********************************/

- (IBAction) dismissAccountMap:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction) getDirections:(id)sender{
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Get Directions?" message:@"You're about to leave this application to get directions" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Get directions",nil] autorelease];
	[alert show];	
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
		
	}
	
	if(buttonIndex == 1){
		NSString* address = [NSString stringWithFormat:@"%@",bridalShowAddress];
		NSString* url = [NSString stringWithFormat: @"maps://maps.google.com/maps?x=x&daddr=%@&saddr=Current+Location&ttype=now&t=m",[address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
	}
}


/********************************
 MAP DELEGATE FUNCTIONS
 ********************************/
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
	MKPinAnnotationView *annotationView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentlocation"];
	annotationView.pinColor = MKPinAnnotationColorGreen;
	annotationView.canShowCallout = TRUE;
	annotationView.animatesDrop=TRUE;
	annotationView.calloutOffset = CGPointMake(-5, 5);
	return annotationView;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[bridalShowName release];
	[bridalShowAddress release];
	[annotationx release];
	accountMap.delegate = nil;	
    [super dealloc];
}


@end
