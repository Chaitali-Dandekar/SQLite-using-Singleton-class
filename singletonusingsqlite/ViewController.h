//
//  ViewController.h
//  singletonusingsqlite
//
//  Created by Felix-ITS 004 on 12/10/17.
//  Copyright © 2017 sonal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    sqlite3 *taskDatabase; //database handler created
}
-(BOOL)executeQuery:(NSString *)query;
-(void)getAlltasks:(NSString *)query;
-(NSString *)getDatabasePath;
@property(nonatomic,retain)NSMutableArray *IDArray;
@property(nonatomic,retain) NSMutableArray *tasknamearray;
-(void)createDatabase;




@end

