//
//  SCallDetailViewController.h
//  iPadTesting
//
//  Created by Raul Ramirez on 4/11/13.
//  Copyright (c) 2013 Raul Ramirez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCallDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
