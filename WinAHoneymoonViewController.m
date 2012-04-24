//
//  WinAHoneymoonViewController.m
//  Locations Magazine
//
//  Created by Ujwal Trivedi on 11/13/10.
//  Copyright 2010 LocationsMagazine.Com. All rights reserved.
//

#import "WinAHoneymoonViewController.h"
#import "WinAHoneymoonForm.h"
#import "RulesAndRegulations.h"

@implementation WinAHoneymoonViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
	self.title = @"Win A Honeymoon";
	
	/*
	UIBarButtonItem* homeButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissWinAHoneymoon:)];
	self.navigationItem.leftBarButtonItem = homeButton;
	[homeButton release];
	 */
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


/****************************
 CUSTOM FUNCTIONS
 ****************************/
- (void)setDelegate:(id)adelegate{
	delegate = adelegate;
}

-(void) dismissWinAHoneymoon:(id) sender{
	[delegate homeButtonPressed:self];
}

- (IBAction) openForm:(id) sender{
	
	WinAHoneymoonForm *winAHoneymoonForm = [[WinAHoneymoonForm alloc] init];
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	[winAHoneymoonForm setDelegate:self];
	[self.navigationController pushViewController:winAHoneymoonForm animated:YES];
	//[winAHoneymoonForm setDelegate:nil];
	winAHoneymoonForm = nil;
	[winAHoneymoonForm release];
	[self.navigationItem.backBarButtonItem release];
}

- (IBAction) openRules:(id) sender{
	RulesAndRegulations *winAHoneymoonForm = [[RulesAndRegulations alloc] init];
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
	[self.navigationController pushViewController:winAHoneymoonForm animated:YES];
	winAHoneymoonForm = nil;
	[winAHoneymoonForm release];
	[self.navigationItem.backBarButtonItem release];
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
    [super dealloc];
}


@end
