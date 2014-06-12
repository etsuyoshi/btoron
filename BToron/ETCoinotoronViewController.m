//
//  ETViewController.m
//  BToron
//
//  Created by EndoTsuyoshi on 2014/06/10.
//  Copyright (c) 2014年 tuyo.en. All rights reserved.
//

#import "ETCoinotoronViewController.h"

@interface ETCoinotoronViewController (){
    NSArray *arrStrWorker;
    NSDictionary *dictJson;
    
    int heightForRow;
    int heightForHeader;
    int heightForFooter;
    
    UIButton *btnReturn;
}

@end



@implementation ETCoinotoronViewController{
    UITableView *myTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    heightForRow = 30;
    heightForFooter = 20;
    heightForHeader = 20;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    btnReturn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnReturn.frame = CGRectMake(0, 0, self.view.bounds.size.width/3,50);
//    btnReturn.titleLabel.text = @"Return";
    [btnReturn setTitle:@"Return"
               forState:UIControlStateNormal];
    [btnReturn addTarget:self action:@selector(return:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReturn];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40,
                                                               self.view.bounds.size.width,
                                                               self.view.bounds.size.height)
                                              style:UITableViewStylePlain];
    
    
    myTableView.dataSource = self;
    myTableView.delegate = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = [UIColor whiteColor];
    //myTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    myTableView.contentSize = CGSizeMake(self.view.bounds.size.width,
//                                         self.view.bounds.size.height*5);
    myTableView.scrollEnabled = YES;
    
    //self.view.backgroundColor = [UIColor blueColor];
    //refreshControl.contentInset = UIEdgeInsetsMake(-24, 0, 0, 0);
    
    
    NSString *strUrl = @"https://coinotron.com/coinotron/AccountServlet?action=api&api_key=B76B4056B7CD42B191D3FBFFBBAC810F";
//    NSString *strUrl = @"https://www.btcguild.com/api.php?api_key=2182923da723a7979e281cc2dbb18b0d";
    dictJson = [self getJson:strUrl];
    arrStrWorker = [self getWorkerFromJson:dictJson];
//    arrStrWorker = [self getWorker:strUrl];
    
    NSLog(@"username = %@", dictJson[@"username"]);
    NSLog(@"workers = %@", dictJson[@"workers"]);
    
    for(int i = 0;i < arrStrWorker.count;i++){
        NSLog(@"arrStrWorker[%d] = %@ : %@", i, arrStrWorker[i], dictJson[@"workers"][arrStrWorker[i]]);
    }
    
//    NSLog(@"wataryoichi.a73bg6q4 = %@", dict[@"workers"][@"wataryoichi.a73bg6q4"]);
//    NSLog(@"wataryoichi.c7fwtq3x = %@", dict[@"workers"][@"wataryoichi.c7fwtq3x"]);
    
    
    myTableView.contentSize = CGSizeMake(self.view.bounds.size.width,
                                         arrStrWorker.count * (heightForHeader + heightForRow*2 + heightForFooter));
    
    [myTableView reloadData];
    [self.view addSubview:myTableView];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.view.backgroundColor = [UIColor blueColor];
    
//    myTableView.frame = self.view.bounds;
    //myTableView.frame = [UIScreen mainScreen].bounds;
    myTableView.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width,
                                   [UIScreen mainScreen].bounds.size.height-40);
//    myTableView.frame = CGRectMake(0, 40,
//                                   self.view.bounds.size.width,
//                                   self.view.bounds.size.height);

    
    
//    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view];
    
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if((int)indexPath.row % 2 == 0){
            cell.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.05f];
            NSLog(@"cell[%d][%d] = %@", indexPath.section, indexPath.row, dictJson[@"workers"][arrStrWorker[indexPath.section]][@"alive"]);
            
            
            
            UILabel *lblKey = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/3.0f,heightForRow)];
            lblKey.font = [UIFont systemFontOfSize:12.0f];
            lblKey.text = @"alive";
            lblKey.textAlignment = NSTextAlignmentLeft;
            lblKey.center = CGPointMake(lblKey.center.x, heightForRow/2);
            [cell.contentView addSubview:lblKey];
            
            
            
            UILabel *lblAlive = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*2.0f/3.0f, 0,
                                                                         self.view.bounds.size.width/3.0f, heightForRow)];
            lblAlive.font = [UIFont systemFontOfSize:13.0f];
            if([dictJson[@"workers"][arrStrWorker[indexPath.section]][@"alive"] integerValue]){
                lblAlive.text = @"Yes";
            }else{
                lblAlive.text = @"No";
            }
            lblAlive.textAlignment = NSTextAlignmentRight;
            lblAlive.center = CGPointMake(lblAlive.center.x, heightForRow/2);
            [cell.contentView addSubview:lblAlive];
            
        }else{
            cell.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.03f];
            
            
            UILabel *lblKey = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/3.0f,20)];
            lblKey.font = [UIFont systemFontOfSize:12.0f];
            lblKey.text = @"hash-rate";
            lblKey.textAlignment = NSTextAlignmentLeft;
            lblKey.center = CGPointMake(lblKey.center.x, heightForRow/2);
            [cell.contentView addSubview:lblKey];
            
            
            UILabel *lblHash = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*2.0f/3.0f, 0,
                                                                        self.view.bounds.size.width/3.0f, heightForRow)];
            float hashrate = [dictJson[@"workers"][arrStrWorker[indexPath.section]][@"hashrate"] integerValue]/1000.0f;
            lblHash.text = [NSString stringWithFormat:@"%@%@",
                            [NSString stringWithFormat:@"%.2f", hashrate],
                            @"kh/sec"];
            lblHash.font = [UIFont systemFontOfSize:13.0f];
            lblHash.textAlignment = NSTextAlignmentRight;
            lblHash.center = CGPointMake(lblHash.center.x, heightForRow/2);
            [cell.contentView addSubview:lblHash];
            
            NSLog(@"cell[%d][%d] = %@", indexPath.section, indexPath.row, dictJson[@"workers"][arrStrWorker[indexPath.section]][@"hashrate"]);
        }
        
        
        
    }
    
    return cell;
    
}
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView{
    return (int)[arrStrWorker count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, heightForHeader)];
    label.text = arrStrWorker[(int)section];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.1f];
    label.textAlignment = NSTextAlignmentLeft;
    return  label;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, heightForFooter)];
    footer.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.1f];
    return footer;
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


-(NSDictionary *)getJson:(NSString *)strUrl{
    
    
    //B76B4056B7CD42B191D3FBFFBBAC810F
//    [[ETGetDataViewController sharedClient]
//     getJsonDataWithKey:@"B76B4056B7CD42B191D3FBFFBBAC810F"
//     completion:^(NSDictionary *results, NSError *error) {
//         
//         NSLog(@"success = %@", results);
//     }];
    
    
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSShiftJISStringEncoding error:nil];
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSLog(@"json = %@", json);
    
    return json;
    
    /*
    {"username":"wataryoichi",
        "workers":{
            "wataryoichi.a73bg6q4":{
                "alive":"1",
                "hashrate":"1894",
                "username":"wataryoichi.a73bg6q4"
            },
            "wataryoichi.c7fwtq3x":{
                "alive":"1",
                "hashrate":"1370",
                "username":"wataryoichi.c7fwtq3x"
            },
            "wataryoichi.c8nkifw5":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.c8nkifw5"
            },
            "wataryoichi.d3cj4fh9":{
                "alive":"1",
                "hashrate":"18",
                "username":"wataryoichi.d3cj4fh9"
            },"wataryoichi.g6bm2kph":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.g6bm2kph"
            },"wataryoichi.h6e7amt2":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.h6e7amt2"
            },
            "wataryoichi.i47f9smv":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.i47f9smv"
            },
            "wataryoichi.k5gueb8a":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.k5gueb8a"
            },
            "wataryoichi.p37wu2dn":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.p37wu2dn"
            },
            "wataryoichi.p7c9t5hi":{
                "alive":"1",
                "hashrate":"12",
                "username":"wataryoichi.p7c9t5hi"
            },
            "wataryoichi.p9w7gnsa":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.p9w7gnsa"
            },
            "wataryoichi.p9x3j2hf":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.p9x3j2hf"
            },
            "wataryoichi.r54tvckh":{
                    "alive":"0",
                "hashrate":"12",
                "username":"wataryoichi.r54tvckh"
            },
            "wataryoichi.r6usqkgv":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.r6usqkgv"
            },
            "wataryoichi.u3incxmt1":{
                "alive":"0",
                "hashrate":"12",
                "username":"wataryoichi.u3incxmt1"
            },
            "wataryoichi.v5rmag3p":{
                "alive":"1",
                "hashrate":"59",
                "username":"wataryoichi.v5rmag3p"
            },
            "wataryoichi.w7tgufsh":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.w7tgufsh"
            },
            "wataryoichi.w9istm72":{
                "alive":"1",
                "hashrate":"6",
                "username":"wataryoichi.w9istm72"
            },
            "wataryoichi.x5u83vya":{
                "alive":"0",
                "hashrate":"12",
                "username":"wataryoichi.x5u83vya"
            },
            "wataryoichi.y2pax7uz":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.y2pax7uz"
            },
            "wataryoichi.z54ce29h":{
                "alive":"0",
                "hashrate":"0",
                "username":"wataryoichi.z54ce29h"
            }
        }
    }
	
    */
    
}

-(NSArray *)getWorkerFromJson:(NSDictionary *)dictJson{
    NSArray *arrW = [dictJson[@"workers"] allKeys];
    return arrW;
}


//以下より上の方が良い
-(NSArray *)getWorker:(NSString *)strUrl{
    
    //ワーカーの名称を配列に格納
    NSURL *url = [NSURL URLWithString:strUrl];
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSShiftJISStringEncoding error:nil];
    
    NSMutableArray *arrW = [NSMutableArray array];
    NSArray *arrToken = [jsonString componentsSeparatedByString:@":{"];
    NSString *strTmp = nil;
    int i = 0;
    for(id token in arrToken){
        //NSLog(@"token = %@", token);
        //        NSLog(@"i = %d", i++);
        
        
        if(i != 0){//最初は不要(最後も不要)
            
            strTmp = [[token componentsSeparatedByString:@"},"] lastObject];
            
            //「"」削除
            strTmp = [strTmp stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            //NSLog(@"%d after = %@",i,  strTmp);
            
            [arrW addObject:strTmp];
        }
        i++;
    }
    
    //最後のトークンは不要："alive":"0","hashrate":"0","username":"wataryoichi.z54ce29h"}}}
    [arrW removeLastObject];
    
    for(int i = 0 ;i < arrW.count;i++){
        NSLog(@"arrW %d = %@", i, arrW[i]);
    }
    
    return arrW;
}

-(void)return:(id)sender{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
