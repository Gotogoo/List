//
//  DetailViewController.h
//  List
//
//  Created by Facheng Liang  on 25/07/2017.
//  Copyright © 2017 Facheng Liang . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

