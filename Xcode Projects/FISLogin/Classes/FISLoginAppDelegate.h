//
//  FISLoginAppDelegate.h
//  FISLogin
//
//  Created by Raul Ramirez on 1/5/11.
//  Copyright 2011 FIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FISLoginViewController;

@interface FISLoginAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    FISLoginViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet FISLoginViewController *viewController;

@end

