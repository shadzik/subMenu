//
//  SubViewController.h
//  subMenu
//
//  Created by Bartosz Świątek on 21.09.2012.
//  Copyright (c) 2012 Bartosz Świątek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubViewController : UITableViewController <UIScrollViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UISearchBar *searchView;
    BOOL isSearching,shouldHide;
    UISearchDisplayController *searchDisplayController;
}
    
@end

