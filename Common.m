//
//  Common.m
//  Shew_v4
//
//  Created by Ben Liu on 19/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import "Common.h"

@implementation Common

@synthesize location= _location;

//Static vairable
static int userid;
+(int)userid {return userid;}


+(void)setUserid: (int)uid
{
    userid= uid;
}


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


// With location
- (NSString *)deviceLocation
{
    NSString *theLocation = [NSString stringWithFormat:@"%f,%f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    return theLocation;
}

- (void)viewDidLoad
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [self.locationManager startUpdatingLocation];
}


// post to server
- (void)postToAction:(NSString *)content
{
    
    NSInteger success = 0;
    
    @try {
    
        NSString *post =[[NSString alloc] initWithFormat:@"%@",content];
        NSLog(@"PostData: %@",post);
    
        NSURL *url=[NSURL URLWithString:@"http://54.210.200.34/activity.php"];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
        NSLog(@"Response code: %ld", (long)[response statusCode]);
    
        if ([response statusCode] >= 200 && [response statusCode] < 300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
        
            NSError *error = nil;
            NSDictionary *jsonData = [NSJSONSerialization
                                      JSONObjectWithData:urlData
                                      options:NSJSONReadingMutableContainers
                                      error:&error];
        
            success = [jsonData[@"success"] integerValue];
            NSLog(@"Success: %ld",(long)success);
        
            if(success == 1)
            {
                // Login Success
                NSLog(@"Login SUCCESS");
            } else {
            
                NSString *error_msg = (NSString *) jsonData[@"error_message"];
                [Common alertStatus:error_msg :@"Sign in Failed!" :0];
            }
        
        } else {
            //if (error) NSLog(@"Error: %@", error);
            [Common alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [Common alertStatus:@"Sign in Failed." :@"Error!" :0];
    }

    // Login Success code
    if (success) {
        NSLog(@"Action Sent");
        // Go to the other view controller
        //[self performSegueWithIdentifier:@"login_success" sender:self];
    }
}



@end
