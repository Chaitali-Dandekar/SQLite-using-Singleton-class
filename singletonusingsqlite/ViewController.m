//
//  ViewController.m
//  singletonusingsqlite
//
//  Created by Felix-ITS 004 on 12/10/17.
//  Copyright © 2017 sonal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDatabase];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)createDatabase
{
    NSString *createQuery=@"create table if not exists taskTable(taskId text,taskName text)";
    BOOL success=[self executeQuery:createQuery];
    if(success)
    {
        NSLog(@"Database created");
    }
}
-(NSString *)getDatabasePath
{
    NSArray *docArray=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath=[[docArray firstObject]stringByAppendingString:@"myTaskDatabase.db"];
    return docPath;
}
-(BOOL)executeQuery:(NSString *)query
{
    BOOL success=0;
    sqlite3_stmt *statement;
    const char *cQuery=[query UTF8String];
    const char *databasePath=[[self getDatabasePath] UTF8String];
    if(sqlite3_open(databasePath,&taskDatabase)==SQLITE_OK)
    {
        if(sqlite3_prepare_v2(taskDatabase,cQuery,-1,&statement,NULL)==SQLITE_OK)
        {
            if(sqlite3_step(statement)==SQLITE_DONE)
            {
                success=1;
            }
            else
            {
                NSLog(@"%s in sqlite step",sqlite3_errmsg(taskDatabase));
            }
        }
        else
        {
            NSLog(@"%s in sqlite prepare v2",sqlite3_errmsg(taskDatabase));
            
        }
    }
    else
    {
        NSLog(@"%s in sqlite opening database",sqlite3_errmsg(taskDatabase));
        
    }
    
    return success;
}


-(void)getAlltasks:(NSString *)query
{
    self.tasknamearray=[[NSMutableArray alloc]init];
    _IDArray = [[NSMutableArray alloc]init];
    
    sqlite3_stmt *statement;
    const char *cQuery=[query UTF8String];
    const char *databasePath=[[self getDatabasePath] UTF8String];
    if(sqlite3_open(databasePath,&taskDatabase)==SQLITE_OK)
    {
        if(sqlite3_prepare_v2(taskDatabase,cQuery,-1,&statement,NULL)==SQLITE_OK)
        {
            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                unsigned const char *tName=sqlite3_column_text(statement,1);
                NSString *tasknm=[NSString stringWithFormat:@"%s",tName];
                [self.tasknamearray addObject:tasknm];
                
                unsigned const char *tID=sqlite3_column_text(statement,0);
                NSString *taskID=[NSString stringWithFormat:@"%s",tID];
                [self.IDArray addObject:taskID];
                
                
            }
            
        }
        else
        {
            NSLog(@"%s in sqlite prepare v2",sqlite3_errmsg(taskDatabase));
            
        }
    }
    else
    {
        NSLog(@"%s in sqlite opening database",sqlite3_errmsg(taskDatabase));
    }
    sqlite3_close(taskDatabase);
    sqlite3_finalize(statement);
    
}



    // Do any additional setup after loading the view, typically from a nib.


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
