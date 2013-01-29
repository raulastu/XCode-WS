//
//  FISLoginViewController.h
//  FISLogin
//
//  Created by Raul Ramirez on 1/5/11.
//  Copyright 2011 FIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FISLoginViewController : UIViewController {
	UITextField *name;
	UITextField *password;
	UILabel *slabel;
}
@property (retain, nonatomic) IBOutlet  UITextField *name;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UILabel *sLabel;

-(IBAction) sLiding: (id) sender;
-(IBAction) goAwayKeyBoard: (id)sender;
-(IBAction) tapBackground: (id)sender;
@end

