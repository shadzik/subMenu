//
//  SubViewController.h
//  subMenu
//
//  Created by Bartosz Świątek on 21.09.2012.
//  Copyright (c) 2012 Bartosz Świątek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubViewController : UITableViewController <UIScrollViewDelegate,UISearchBarDelegate>
{
    //UIView *searchView;
    UISearchBar *searchView;
    UIView *searchSpace;
    UINavigationBar *remaining;
    BOOL isSearching;
}
    
@end

