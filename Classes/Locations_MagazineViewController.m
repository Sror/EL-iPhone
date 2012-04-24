//
//  Locations_MagazineViewController.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright LocationsMagazine.Com 2010. All rights reserved.
//

#import "Locations_MagazineViewController.h"
#import "SearchCountyViewController.h"
#import "SearchSiteViewController.h"


@implementation Locations_MagazineViewController
@synthesize aboutUsViewController;
//@synthesize searchServicesViewController, searchCaterersViewController, winAHoneymoonViewController,findABridalShowViewController, searchCountyViewController, searchSiteViewController;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor =[UIColor colorWithPatternImage: [UIImage imageNamed:@"Loc-background.png"]];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}
*/




-(IBAction) showInfo:(id) sender{
	aboutUsViewController = [[AboutUs alloc] init];
	[self presentModalViewController:aboutUsViewController animated:YES];
	[aboutUsViewController release];
}

-(IBAction) showSearchCounty:(id) sender{
	
	navigationController = [[NavigationController alloc] init];
	navigationController.whichViewController = 1;
	[self presentModalViewController:navigationController animated:YES];
	[navigationController release];
	//searchCountyViewController = [[SearchCountyViewController alloc] init];
	//[self presentModalViewController:searchCountyViewController animated:YES];
	//[searchCountyViewController release];
}

-(IBAction) showSearchSite:(id) sender{
	navigationController = [[NavigationController alloc] init];
	navigationController.whichViewController = 2;
	[self presentModalViewController:navigationController animated:YES];
	[navigationController release];
	
	//searchSiteViewController = [[SearchSiteViewController alloc] init];
	//[self presentModalViewController:searchSiteViewController animated:YES];
	//[searchSiteViewController release];
}

-(IBAction) showSearchServices:(id) sender{
	navigationController = [[NavigationController alloc] init];
	navigationController.whichViewController = 3;
	[self presentModalViewController:navigationController animated:YES];
	[navigationController release];
	
	//searchServicesViewController = [[SearchServicesViewController alloc] init];
	//[self presentModalViewController:searchServicesViewController animated:YES];
	//[searchServicesViewController release];
}

-(IBAction) showSearchCaterers:(id) sender{
	navigationController = [[NavigationController alloc] init];
	navigationController.whichViewController = 4;
	[self presentModalViewController:navigationController animated:YES];
	[navigationController release];
	
	//searchCaterersViewController = [[SearchCaterersViewController alloc] init];
	//[self presentModalViewController:searchCaterersViewController animated:YES];
	//[searchCaterersViewController release];
}


-(IBAction) showWinAHoneymoon:(id) sender{
	navigationController = [[NavigationController alloc] init];
	navigationController.whichViewController = 5;
	[self presentModalViewController:navigationController animated:YES];
	[navigationController release];
	
	//winAHoneymoonViewController = [[WinAHoneymoonViewController alloc] init];
	//[self presentModalViewController:winAHoneymoonViewController animated:YES];
	//[winAHoneymoonViewController release];
}

-(IBAction) showFindABridalShow:(id) sender{
	
	navigationController = [[NavigationController alloc] init];
	navigationController.whichViewController = 6;
	[self presentModalViewController:navigationController animated:YES];
	[navigationController release];
	//findABridalShowViewController = [[FindABridalShowViewController alloc] init];
	//[self presentModalViewController:findABridalShowViewController animated:YES];
	//[findABridalShowViewController release];
}




- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	//[aboutUsViewController release];
}

@end
