//
//  DetailViewController.h
//  subMenu
//
//  Created by Bartosz Świątek on 21.09.2012.
//  Copyright (c) 2012 Bartosz Świątek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
