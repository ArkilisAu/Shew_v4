//
//  RecvTableViewController.h
//  Shew_v4
//
//  Created by Ben Liu on 26/10/2014.
//  Copyright (c) 2014 Ben Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "SWTableViewCell.h"

@interface RecvTableViewController : UITableViewController  <UITableViewDataSource, UITableViewDelegate, HomeModelProtocol>

@property (strong, nonatomic) IBOutlet UITableView *tableList;

@end
