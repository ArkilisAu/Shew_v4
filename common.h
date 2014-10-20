//
//  Common.h
//  Shew_v4
//
//  Created by Ben Liu on 19/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Common : NSObject <CLLocationManagerDelegate>

// property location
@property (copy) NSString *location;
//@property CLLocationManager *locationManager;

// Static Declaration on alert
+ (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag;


// member function delaration
- (void)initLocation;


@end
