//
//  MasterViewController.h
//  subMenu
//
//  Created by Bartosz Świątek on 21.09.2012.
//  Copyright (c) 2012 Bartosz Świątek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubViewController.h"

@interface MasterViewController : UITableViewController {
    SubViewController *submenu;
}

-(void)toggleSubMenu:(id)sender;

@end

