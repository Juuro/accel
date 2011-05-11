//
//  viewtestViewController.m
//  viewtest
//
//  Created by Sebastian Engel on 04.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "viewtestViewController.h"
#define kFilteringFactor 0.05

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation viewtestViewController

@synthesize labelX;
@synthesize labelY;
@synthesize labelZ;
@synthesize labelOrientation;
@synthesize labelAngle;

@synthesize progressX;
@synthesize progressY;
@synthesize progressZ;

@synthesize accelerometer;

- (void)vibrate {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
	self.accelerometer = [UIAccelerometer sharedAccelerometer];
	self.accelerometer.updateInterval = .1;
	self.accelerometer.delegate = self;
    [super viewDidLoad];
}

- (NSString *)stringFromOrientation:(UIDeviceOrientation) orientation {
    
    NSString *orientationString;
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            orientationString = @"Portrait";
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            orientationString = @"Portrait Upside Down";
            break;
        case UIDeviceOrientationLandscapeLeft:
            orientationString = @"Landscape Left";
            break;
        case UIDeviceOrientationLandscapeRight:
            orientationString = @"Landscape Right";
            break;
        case UIDeviceOrientationFaceUp:
            orientationString = @"Face Up";
            break;
        case UIDeviceOrientationFaceDown:
            orientationString = @"Face Down";
            break;
        case UIDeviceOrientationUnknown:
            orientationString = @"Unknown";
            break;
        default: 
            orientationString = @"Not Known";
            break;
    }
    return orientationString;
}

- (void)accelerometer:(UIAccelerometer *)accel didAccelerate:(UIAcceleration *)acceleration {    
    
    labelX.text = [NSString stringWithFormat:@"%@%f", @"X: ", acceleration.x];
    labelY.text = [NSString stringWithFormat:@"%@%f", @"Y: ", acceleration.y];
    labelZ.text = [NSString stringWithFormat:@"%@%f", @"Z: ", acceleration.z];	
    
    self.progressX.progress = ABS(acceleration.x);
    self.progressY.progress = ABS(acceleration.y);
    self.progressZ.progress = ABS(acceleration.z); 
    
    UIDevice *device = [UIDevice currentDevice];
    labelOrientation.text = [self stringFromOrientation:device.orientation];
    
    float accelX = [acceleration x]; 
    float accelY = [acceleration y];
    float accelZ = [acceleration z];
    
    float angle;
    float angle2;
    
    switch (device.orientation) {
        case UIDeviceOrientationPortrait:
            angle = atan2(-accelY, accelZ);
            angle = RadiansToDegrees(angle);
            labelAngle.text = [NSString stringWithFormat:@"%f", angle];
            
            angle2 = atan2(accelY, -accelX);
            [arrowImage setTransform:CGAffineTransformMakeRotation(angle2)];
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            angle = atan2(accelY, -accelZ);
            angle = -(RadiansToDegrees(angle)-180);
            labelAngle.text = [NSString stringWithFormat:@"%f", angle];
            
            angle2 = atan2(-accelY, accelX);
            [arrowImage setTransform:CGAffineTransformMakeRotation(angle2)];
            break;
        case UIDeviceOrientationLandscapeLeft:
            angle = atan2(-accelX, accelZ);
            angle = RadiansToDegrees(angle);
            labelAngle.text = [NSString stringWithFormat:@"%f", angle];
            
            angle2 = atan2(-accelY, accelX)+DegreesToRadians(90);
            [arrowImage setTransform:CGAffineTransformMakeRotation(angle2)];
            break;
        case UIDeviceOrientationLandscapeRight:
            angle = atan2(accelX, -accelZ);
            angle = -(RadiansToDegrees(angle)-180);
            labelAngle.text = [NSString stringWithFormat:@"%f", angle];
            
            angle2 = atan2(accelY, -accelX)+DegreesToRadians(90);
            [arrowImage setTransform:CGAffineTransformMakeRotation(angle2)];
            break;
        case UIDeviceOrientationFaceUp:
            labelAngle.text = @"Face Up";
            break;
        case UIDeviceOrientationFaceDown:
            labelAngle.text = @"Face Down";
            break;
        case UIDeviceOrientationUnknown:
            labelAngle.text = @"Unknown";
            break;
        default: 
            labelAngle.text = @"Not Known";
            break;
    }
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
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
    [labelX release];
    [labelY release];
    [labelZ release];
    
    [progressX release];
    [progressY release];
    [progressZ release];
    
    accelerometer.delegate = nil;
    [accelerometer release];
    
    [super dealloc];
}

@end
