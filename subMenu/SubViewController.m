//
//  SubViewController.m
//  subMenu
//
//  Created by Bartosz Świątek on 21.09.2012.
//  Copyright (c) 2012 Bartosz Świątek. All rights reserved.
//

#import "SubViewController.h"
#import "MasterViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [super awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isSearching = NO;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.origin.y, 260, self.view.frame.size.height) style:UITableViewStylePlain];
      
//    UIEdgeInsets i = self.tableView.scrollIndicatorInsets;
//	i.top = self.tableView.contentOffset.y;
//	self.tableView.scrollIndicatorInsets = i;
    
    searchSpace = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    remaining = [[UINavigationBar alloc] initWithFrame:CGRectMake(260, 0, 60, 44)];
    remaining.clipsToBounds = YES;
    searchView = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 260, 44)];
    searchView.barStyle=UIBarStyleDefault;
    searchView.showsCancelButton=NO;
    searchView.autocorrectionType=UITextAutocorrectionTypeNo;
    searchView.autocapitalizationType=UITextAutocapitalizationTypeNone;
    searchView.delegate=self;
    searchView.placeholder = @"Search";
    [searchSpace addSubview:searchView];
    [searchSpace addSubview:remaining];
    [searchSpace sendSubviewToBack:remaining];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:searchSpace.frame];;
	
	[self.view addSubview:searchSpace];
    self.tableView.showsVerticalScrollIndicator = YES;
    
}

-(void) toggleRootView {
    //NSLog(@"Parent: %@", self.view.superview);
    CGRect location = self.view.window.rootViewController.view.frame;
    CGRect masterFrame = self.tableView.frame;
    CGRect searchFrame = searchView.frame;
    short shift = 0;
    
        if (location.origin.x == 260) {
            location.origin.x = 320;
            shift = 60;
            
        } else {
            location.origin.x = 260;
            shift = -60;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.view.window.rootViewController.view.frame = location;
            
            searchView.frame = CGRectMake(searchFrame.origin.x, searchFrame.origin.y, searchFrame.size.width+shift, searchFrame.size.height);
            self.tableView.frame = CGRectMake(masterFrame.origin.x, masterFrame.origin.y, masterFrame.size.width+shift, masterFrame.size.height);
                        
        } completion:^(BOOL finished) {
        }];

}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchView setShowsCancelButton:YES animated:YES];
    if (!isSearching) {
        [self toggleRootView];
        [remaining removeFromSuperview];
        isSearching = YES;
    }
    
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.tableView.scrollEnabled = NO;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    self.tableView.scrollEnabled = YES;
    [searchView resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchView.text = nil;
    [searchView resignFirstResponder];
    
    [searchSpace addSubview:remaining];
    [searchSpace sendSubviewToBack:remaining];
    [searchView setShowsCancelButton:NO animated:YES];
    if (isSearching) {
        [self toggleRootView];
        isSearching = NO;
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchView resignFirstResponder];
    for (UIView *possibleButton in searchView.subviews)
    {
        if ([possibleButton isKindOfClass:[UIButton class]])
        {
            UIButton *cancelButton = (UIButton*)possibleButton;
            cancelButton.enabled = YES;
            break;
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"Search bar position: X=%f,Y=%f", scrollView.contentOffset.x, scrollView.contentOffset.y);
    CGRect rect = searchView.frame;
    rect.origin.y = MIN(0, scrollView.contentOffset.y);
    searchView.frame = rect;
    /*
    if (scrollView.contentOffset.y > 0) {
        
		searchView.frame = CGRectMake(rect.origin.x, -1*scrollView.contentOffset.y, rect.size.width, rect.size.height);
        
	} else if (scrollView.contentOffset.y <= 0) {
        
		searchView.frame = CGRectMake(rect.origin.x, 0, rect.size.width, rect.size.height);
	}
    
	UIEdgeInsets i = scrollView.scrollIndicatorInsets;
    
	if (scrollView.contentOffset.y < rect.size.height) {
		int top = rect.size.height - scrollView.contentOffset.y;
		i.top = top > rect.size.height ? rect.size.height : top;
	} else {
		i.top = 0;
	}
    
	scrollView.scrollIndicatorInsets = i;
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [NSString stringWithFormat:@"Setting %d", indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
