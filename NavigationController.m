//
//  NavigationController.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/20/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "NavigationController.h"


@implementation NavigationController
@synthesize whichViewController;

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
	
	navigationController = [[UINavigationController alloc] init];
	[self.view addSubview:navigationController.view];
	
		
	switch (whichViewController) {
		case 1:
			searchCountyController = [[SearchCountyViewController alloc] init];
			[searchCountyController setDelegate:self];
			[navigationController pushViewController:searchCountyController animated:NO];
			[searchCountyController release];
			break;
		case 2:
			searchSiteViewController = [[SearchSiteViewController alloc] init];		
			[searchSiteViewController setDelegate:self];
			[navigationController pushViewController:searchSiteViewController animated:NO];
			[searchSiteViewController release];
			break;
		case 3:
			searchServicesViewController = [[SearchServicesViewController alloc] init];	
			[searchServicesViewController setDelegate:self];
			[navigationController pushViewController:searchServicesViewController animated:NO];
			[searchServicesViewController release];
			break;
		case 4:
			searchCaterersViewController = [[SearchCaterersViewController alloc] init];	
			[searchCaterersViewController setDelegate:self];
			[navigationController pushViewController:searchCaterersViewController animated:NO];
			[searchCaterersViewController release];
			break;
		case 5:
			winAHoneymoonViewController = [[HoneymoonView alloc] init];	
			[winAHoneymoonViewController setDelegate:self];
			[navigationController pushViewController:winAHoneymoonViewController animated:NO];
			[winAHoneymoonViewController release];
			break;
		case 6:
			findABridalShowViewController = [[FindABridalShowViewController alloc] init];
			[findABridalShowViewController setDelegate:self];
			[navigationController pushViewController:findABridalShowViewController animated:NO];
			[findABridalShowViewController release];
			break;
		default:
			break;
	}
	
	
}

- (void) homeButtonPressed:(id)sender{
	[self dismissModalViewControllerAnimated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
 
	return NO;
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
	[navigationController release];
    [super dealloc];
}


@end
