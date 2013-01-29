//
//  FISLoginViewController.m
//  FISLogin
//
//  Created by Raul Ramirez on 1/5/11.
//  Copyright 2011 FIS. All rights reserved.
//

#import "FISLoginViewController.h"

@implementation FISLoginViewController
@synthesize name;
@synthesize password;
@synthesize sLabel;

-(IBAction) goAwayKeyBoard: (id)sender{
	[sender resignFirstResponder];
}

-(IBAction) tapBackground: (id)sender{
	[name resignFirstResponder];
	[password resignFirstResponder];
}

-(IBAction) sLiding: (id) sender{
	UISlider *s = (UISlider *) sender;
	int value = (int) s.value;
	NSString *newLabel = [[NSString alloc]initWithFormat:@"%i",value];
	sLabel.text = newLabel;
	[newLabel release];
	
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
	[name release];
	[password release];
	[sLabel release];
    [super dealloc];
	
}

@end
