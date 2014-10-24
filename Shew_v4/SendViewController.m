//
//  SendViewController.m
//  Shew_v4
//
//  Created by Ben Liu on 18/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import "SendViewController.h"
#import <DBChooser/DBChooser.h>
#import <DBChooser/DBChooserResult.h>
#import "Common.h"


@implementation SendViewController
{
    DBChooserResult *_result; // result received from last CHooser call
    
}


- (IBAction)btnSelectFile:(UIButton *)sender {
    NSLog(@"Start!");
    
    [[DBChooser defaultChooser] openChooserForLinkType:DBChooserLinkTypeDirect
                                    fromViewController:self completion:^(NSArray *results)
     {
         NSLog(@"Returned 1!");
         if ([results count]) {
             // Process results from Chooser
             _result = results[0];
             _label_FileName.text= _result.name;
             _label_FileSize.text= [NSString stringWithFormat: @"%lld Bytes", _result.size];
             _fileurl=_result.link;

             
         } else {
             // User canceled the action
             NSLog(@"Returned 3!");
             //NSLog(@"The coutn value is %@", _result);
         }
     }];
}

// Shew the file button
- (IBAction)btnShew:(UIButton *)sender {
    
    NSString *filename = _label_FileName.text;
    NSString *filesize = _label_FileSize.text;
    
    NSLog(@"filename %@", filename);
    NSLog(@"filesize %@", filesize);
    
    
    if (_label_FileName.text==(id)[NSNull null] || _label_FileName.text.length==0 ||
        _label_FileSize.text==(id)[NSNull null] || _label_FileSize.text.length==0 ||
        _fileurl==(id)[NSNull null] || _fileurl.length==0)
    {
        [Common alertStatus:@"Emepty File name or File Size!" :@"Invalid File!" :0];
    }
    // shew the file
    else{
        // get the current location
        Common *common = [[Common alloc] init];
        [common viewDidLoad];
        [Common alertStatus:[common deviceLocation]:@"Location":0];
        
        // post location to the server
        NSString *send;
        NSString *userid;
        NSString *type;
        NSString *latitude;
        NSString *longitude;

        
        type= @"description=SEND";
        userid= @"userid=1";
        
        NSString *location= [common deviceLocation];
        NSArray *ary_location = [location componentsSeparatedByString:@","];
        
        latitude= ary_location[0];
        longitude=ary_location[1];
        
        
        //NSLog(latitude);
        //NSLog(longitude);
        NSLog(@"userid in shew:%d", Common.userid);
        
        // Post data
        send= [NSString stringWithFormat:@"userid=%d&%@&latitude=%@&longitude=%@&fileurl=%@", Common.userid, type, latitude, longitude, _fileurl];
        [common postToAction:send];
        
   }
}

/*
- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}
 */

@end
