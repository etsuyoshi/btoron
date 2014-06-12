//
//  ETRootViewController.m
//  BToron
//
//  Created by EndoTsuyoshi on 2014/06/12.
//  Copyright (c) 2014年 tuyo.en. All rights reserved.
//

#import "ETCoinotoronViewController.h"
#import "ETBTCGuildViewController.h"
#import "ETRootViewController.h"

@interface ETRootViewController (){
    UITableView *myTableView;
    
    NSMutableArray *arrPool;
    
    int heightForRow;
    int heightForHeader;
    int heightForFooter;
}

@end

@implementation ETRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    heightForRow = 50;
    heightForFooter = 0;
    heightForHeader = 0;
    
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width,
                                                              self.view.bounds.size.height)
                                              style:UITableViewStyleGrouped];
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor whiteColor];
    
    myTableView.scrollEnabled = YES;
    
    [self.view addSubview:myTableView];
    
    
    arrPool = [NSMutableArray arrayWithObjects:@"Coinotoron",@"BTC Guild",
               nil];
    
    
    NSLog(@"viewdidload");
    
    [myTableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    myTableView.contentSize = CGSizeMake(self.view.bounds.size.width,
//                                         heightForHeader + heightForFooter + heightForRow * arrPool.count);
//    [myTableView reloadData];
//    
//    NSLog(@"viewdidappear");
}


-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *nextViewCon = nil;
    if([arrPool[indexPath.row] isEqualToString:@"Coinotoron"]){
        nextViewCon = [[ETCoinotoronViewController alloc]init];
    }else{
        nextViewCon = [[ETBTCGuildViewController alloc]init];
    }
    [self presentViewController:nextViewCon
                       animated:YES
                     completion:nil];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = nil;
    cellIdentifier =
    [NSString stringWithFormat:@"cellIdentifier%d%d",
     (int)indexPath.section,(int)indexPath.row];
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellIdentifier];
        if((int)indexPath.row % 2 == 0){
            cell.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.05f];
        }else{
            cell.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.05f];
        }
        
        UILabel *lblPool = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,
                                                                    heightForRow)];
        lblPool.font = [UIFont systemFontOfSize:12.0f];
        lblPool.text = arrPool[indexPath.row];
        lblPool.textAlignment = NSTextAlignmentCenter;
        lblPool.center = CGPointMake(lblPool.center.x, lblPool.center.y);
        [cell.contentView addSubview:lblPool];
    }
    
    return cell;
    
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrPool.count;
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return heightForRow;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return heightForFooter;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return heightForHeader;
}



@end
