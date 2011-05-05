//
//  viewtestAppDelegate.h
//  viewtest
//
//  Created by Sebastian Engel on 04.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class viewtestViewController;

@interface viewtestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    viewtestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet viewtestViewController *viewController;

@end

