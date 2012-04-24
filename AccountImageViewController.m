//
//  AccountImageViewController.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/25/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "AccountImageViewController.h"


@implementation AccountImageViewController
@synthesize accountName, accountImage;
@synthesize scrollView;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	imageView = [[UIImageView alloc] initWithImage:accountImage];
		
	
	
	scrollView.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
	
	NSLog(@"%fx%f",imageView.frame.size.width, imageView.frame.size.height);
	
	//scrollView.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
	scrollView.maximumZoomScale = 4.0;
	scrollView.minimumZoomScale = 0.50;
	scrollView.clipsToBounds = YES;
	scrollView.delegate = self;
	[scrollView setZoomScale:0.50 animated:YES];
    [scrollView addSubview:imageView];
	
	self.title = accountName;		
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return imageView;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
	return YES;
}
 */


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
	[accountName release];
	[accountImage release];
	[imageView release];
	[scrollView release];
	[super dealloc];
}


@end
