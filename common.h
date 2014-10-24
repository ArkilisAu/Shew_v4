//
//  Common.h
//  Shew_v4
//
//  Created by Ben Liu on 19/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Common : UIViewController <CLLocationManagerDelegate>

// property user id
+(int)userid;

+(void)setUserid: (int)uid;

// property location
@property (copy) NSString *location;

// property location Manager
@property (nonatomic,retain) CLLocationManager *locationManager;

// Static Declaration on alert
+ (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag;

// property
@property (copy) NSString *url;

// member function delaration
//- (void)initLocation;
- (NSString *)deviceLocation;
- (void)viewDidLoad;
- (void)postToAction:(NSString *)content;



@end
