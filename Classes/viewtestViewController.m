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
@synthesize labelYX;
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
    [super viewDidLoad];
	//[labelX setText:@"fixed"];
	/*
	UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
	accel.delegate = self;
	accel.updateInterval = 1.0f/60.0f;
	 */
	self.accelerometer = [UIAccelerometer sharedAccelerometer];
	self.accelerometer.updateInterval = .1;
	self.accelerometer.delegate = self;
}



- (void)accelerometer:(UIAccelerometer *)accel didAccelerate:(UIAcceleration *)aceler {
	
    float accelX; 
    float accelY; 
    float accelZ;  
    
    accelX = aceler.x * kFilteringFactor + accelX * (1.0 - kFilteringFactor);
    accelY = aceler.y * kFilteringFactor + accelY * (1.0 - kFilteringFactor);
    accelZ = aceler.z * kFilteringFactor + accelZ * (1.0 - kFilteringFactor);
    
    
    
    labelX.text = [NSString stringWithFormat:@"%@%f", @"X: ", aceler.x];
    labelY.text = [NSString stringWithFormat:@"%@%f", @"Y: ", aceler.y];
    labelZ.text = [NSString stringWithFormat:@"%@%f", @"Z: ", aceler.z];
	
    
    self.progressX.progress = ABS(aceler.x);
    self.progressY.progress = ABS(aceler.y);
    self.progressZ.progress = ABS(aceler.z);
    
    
    float angleYX = atan2(accelY, accelX);
    
    float angle;
    NSString *blub;
    
    if(accelY < 0.1 && (accelX > 0.5 || accelZ > 0.5)){
        [labelYX setText:@"Landscape!"];
    }
    else if(accelX < 0.1 && (accelY > 0.5 || accelZ > 0.5)){
        [labelYX setText:@"Portrait!"];  
    
    }
    

    if(angleYX >= -2.25 && angleYX <= -0.25)
	{
        /// Orientation is regular Portrait
        angle = atan2(accelZ, accelX);        
        angle = -RadiansToDegrees(angle);
        blub = @"1";
	}
	else if(angleYX >= -1.75 && angleYX <= 0.75)
	{
        /// Orientation is Landscape with Home Button on the Left
        angle = atan2(accelX, accelZ);        
        angle = RadiansToDegrees(angle);
        blub = @"2";
	}
	else if(angleYX >= 0.75 && angleYX <= 2.25)
	{
        /// Orientation is Portrait flipped upside down
        angle = atan2(accelY, accelZ);        
        angle = -RadiansToDegrees(angle);
        blub = @"3";
	}
	else if(angleYX <= -2.25 || angleYX >= 2.25)
	{
        /// Orientation is Landscape with Home Button on the Right
        angle = atan2(accelY, accelX);        
        angle = -RadiansToDegrees(angle);
        blub = @"4";
	}
    
    
    //angle = atan2(accelX, accelZ);        
    //angle = atan2(accelZ, accelY);       
    //angle = -RadiansToDegrees(angle);    
        
    //labelYX.text = blub;
    labelAngle.text = [NSString stringWithFormat:@"%f", angle];
    //labelYX.text = [NSString stringWithFormat:@"%f", angleYX];
    
       
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
    [super dealloc];
}

@end
