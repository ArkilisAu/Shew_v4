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
             _label_FileSize.text= [NSString stringWithFormat: @"%lld", _result.size];

             
         } else {
             // User canceled the action
             NSLog(@"Returned 3!");
             //NSLog(@"The coutn value is %@", _result);
         }
     }];
}

@end
