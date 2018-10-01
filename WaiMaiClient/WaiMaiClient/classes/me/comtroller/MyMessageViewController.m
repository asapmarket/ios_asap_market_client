//
//  MyMessageViewController.m
//  WaiMaiClient
//
//  Created by 王 on 2017/7/24.
//  Copyright © 2017年 王. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyMessageCell.h"
#import "MyMessageModel.h"
#import "MeServer.h"

@interface MyMessageViewController ()


@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTopBarTitle:NSLocalizedString(kVipMessage, nil)];
    if (self.dataArray.count == 0) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)requestData:(BOOL)isLoadMore{
    if (!isLoadMore){
        self.page = 1;
        [MeServer messageListWithPage:self.page Success:^(MessageBaseModel *result) {
            self.dataArray = result.rows;
            [self.tableView.mj_header endRefreshing];
            if (self.dataArray.count < 10) {
                self.canLoadMore = NO;
            }
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }else{
        self.page ++;
        [MeServer messageListWithPage:self.page Success:^(MessageBaseModel *result) {
            [self.dataArray addObject: result.rows];
            if (result.rows.count < 10) {
                self.canLoadMore = NO;
            }
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [self errorResponsText:error];
        }];
    }
}


#pragma UITabelViewDelegate

static NSString *MessageCellId = @"MessageCellId";

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyMessageCell *msgCell = [tableView dequeueReusableCellWithIdentifier:MessageCellId];
    if (msgCell == nil){
        msgCell = [[MyMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MessageCellId];
    }
    MyMessageModel *model = self.dataArray[indexPath.row];
    msgCell.model = model;
    
    [MeServer readMessageWithMessageId:model.message_id Success:^(id result) {
        
    } failure:^(NSError *error) {
        
    }];
    
    return msgCell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    // 从数据源中删除
    NSInteger r = indexPath.row;
    MyMessageModel *model = self.dataArray[r];
    
    [MeServer delMessageWithMessageId:model.message_id Success:^(id result) {
        [MBProgressHUD showSuccess:@""];
    } failure:^(NSError *error) {
        [self errorResponsText:error];
    }];
    
    [self.dataArray removeObjectAtIndex:r];
    
    // 从列表中删除
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [tableView endUpdates];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(kDelete, nil);
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
