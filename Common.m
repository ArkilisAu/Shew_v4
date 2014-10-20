//
//  Common.m
//  Shew_v4
//
//  Created by Ben Liu on 19/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import "Common.h"

@implementation Common
{
    CLLocationManager *locationManager;
}


@synthesize location= _location;
//@synthesize locationManager= _locationManager;


// Static method on alert
+ (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}


// Get location
- (void)initLocation
{
 
    locationManager = [[CLLocationManager alloc] init];   
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    [locationManager requestWhenInUseAuthorization]; // Add This Line
    NSLog(@"RT");
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;

    if (currentLocation != nil)
    {
        NSLog(@"%.8f",currentLocation.coordinate.longitude);
        self.location= [NSString stringWithFormat:@"%.8f,%.8f", currentLocation.coordinate.longitude, currentLocation.coordinate.latitude];
    }
}


@end
