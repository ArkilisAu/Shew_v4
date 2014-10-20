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

             
         } else {
             // User canceled the action
             NSLog(@"Returned 3!");
             //NSLog(@"The coutn value is %@", _result);
         }
     }];
}

// Shew the file button
- (IBAction)btnShew:(UIButton *)sender {
    if ([@"" compare:_label_FileName.text]==NSOrderedSame
        || [@"" compare:_label_FileSize.text]==NSOrderedSame)
    {
        [Common alertStatus:@"Emepty File name or File Size!" :@"Invalid File!" :0];
    }
    // shew the file
    else{
        
        NSLog(@"I am here");
        // get the current location
        Common *common = [[Common alloc] init];
        [common initLocation];
        NSLog(common.location);
        
        NSLog(@"I am here 2");
        
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
