//
//  viewtestViewController.h
//  viewtest
//
//  Created by Sebastian Engel on 04.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface viewtestViewController : UIViewController <UIAccelerometerDelegate>{
	IBOutlet UILabel *labelX;
	IBOutlet UILabel *labelY;
	IBOutlet UILabel *labelZ;
	IBOutlet UILabel *labelYX;
	IBOutlet UILabel *labelAngle;
    
    IBOutlet UIProgressView *progressX;
    IBOutlet UIProgressView *progressY;
    IBOutlet UIProgressView *progressZ;
}
@property (nonatomic, retain) IBOutlet UILabel *labelX;
@property (nonatomic, retain) IBOutlet UILabel *labelY;
@property (nonatomic, retain) IBOutlet UILabel *labelZ;
@property (nonatomic, retain) IBOutlet UILabel *labelYX;
@property (nonatomic, retain) IBOutlet UILabel *labelAngle;

@property (nonatomic, retain) IBOutlet UIProgressView *progressX;
@property (nonatomic, retain) IBOutlet UIProgressView *progressY;
@property (nonatomic, retain) IBOutlet UIProgressView *progressZ;

@property (nonatomic, retain) UIAccelerometer *accelerometer;

@end