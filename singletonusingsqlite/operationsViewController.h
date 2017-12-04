//
//  operationsViewController.h
//  singletonusingsqlite
//
//  Created by Felix-ITS 004 on 12/10/17.
//  Copyright © 2017 sonal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface operationsViewController : UIViewController


- (IBAction)insertbtn:(id)sender;
- (IBAction)updatebtn:(id)sender;

- (IBAction)deleltebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *tf1;

@property (strong, nonatomic) IBOutlet UITextField *tf2;



@end
