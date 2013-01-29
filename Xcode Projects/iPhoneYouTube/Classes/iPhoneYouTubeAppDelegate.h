//
//  iPhoneYouTubeAppDelegate.h
//  iPhoneYouTube
//
//  Created by Raul Ramirez on 1/5/11.
//  Copyright 2011 FIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPhoneYouTubeViewController;

@interface iPhoneYouTubeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iPhoneYouTubeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iPhoneYouTubeViewController *viewController;

@end

