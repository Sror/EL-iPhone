//
//  RulesAndRegulations.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 2/22/11.
//  Copyright 2011 EventLocations.us. All rights reserved.
//

#import "RulesAndRegulations.h"


@implementation RulesAndRegulations
@synthesize rulesView;

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
	self.title = @"Rules & Regulations";
	
	NSString *textFilePath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath], @"rules.html"];
	[rulesView loadHTMLString:[NSString stringWithContentsOfFile:textFilePath encoding:NSUTF8StringEncoding error:nil] baseURL:nil];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
	[rulesView release];
    [super dealloc];
}


@end
