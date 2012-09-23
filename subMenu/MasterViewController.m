//
//  MasterViewController.m
//  subMenu
//
//  Created by Bartosz Świątek on 21.09.2012.
//  Copyright (c) 2012 Bartosz Świątek. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    UIBarButtonItem *subButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(toggleSubMenu:)];
    self.navigationItem.leftBarButtonItem = subButton;
    
    //self.navigationController.view.layer.masksToBounds = NO;
    self.navigationController.view.layer.cornerRadius = 8; // if you like rounded corners
    self.navigationController.view.layer.shadowOffset = CGSizeMake(1, 0);
    self.navigationController.view.layer.shadowRadius = 5; //5
    self.navigationController.view.layer.shadowOpacity = 0.4;
    //self.navigationController.view.layer.borderColor = [UIColor blackColor].CGColor;
    //self.navigationController.view.layer.borderWidth = 0.6f;
    self.navigationController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.view.bounds].CGPath;
    
    submenu = [[SubViewController alloc] initWithStyle:UITableViewStylePlain];
    
    [self.navigationController.view addSubview:submenu.view];
    [[self.navigationController.view superview] insertSubview:submenu.view belowSubview:self.navigationController.view];
}

- (void)toggleSubMenu:(id)sender {
    
    CGRect location = self.navigationController.view.frame;
    
    if (location.origin.x > 0) {
        location.origin.x = 0;
    } else {
        location.origin.x += 260;
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.navigationController.view.frame = location;
        
    } completion:^(BOOL finished) {
        // disable the master view
        self.view.userInteractionEnabled = !(location.origin.x > 0);
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
