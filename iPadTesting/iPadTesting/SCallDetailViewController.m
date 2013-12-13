//
//  SCallDetailViewController.m
//  iPadTesting
//
//  Created by Raul Ramirez on 4/11/13.
//  Copyright (c) 2013 Raul Ramirez. All rights reserved.
//

#import "SCallDetailViewController.h"

@interface SCallDetailViewController ()
- (void)configureView;
@end

@implementation SCallDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
