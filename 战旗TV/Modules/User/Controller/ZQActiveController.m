//
//  ZQActiveController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/11.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQActiveController.h"
#import "ZQOfficialAnnounceCell.h"
#import "ZQOfficialAnnouncementManager.h"
#import <MJRefresh/MJRefresh.h>
@interface ZQActiveController ()<UITableViewDataSource , UITableViewDelegate , CTAPIManagerCallBackDelegate , CTAPIManagerInterceptor>

@property (nonatomic , strong)UITableView *allTableView;
@property (nonatomic , strong)ZQOfficialAnnouncementManager *annouceManager;
@property (nonatomic , strong)NSMutableArray *anounceMArray;

@property (nonatomic , assign)BOOL firstPage;

@end

@implementation ZQActiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.allTableView];
    
    [self.annouceManager loadData];
    
    [self setupRefresh];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.allTableView.frame = self.view.bounds;
}


#pragma mark -- Private method
- (void)setupRefresh{
    
    self.allTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.annouceManager refreshingAction:@selector(loadPage)];
    self.allTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self.annouceManager refreshingAction:@selector(loadNextPage)];
    
}

#pragma makr -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.anounceMArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    ZQOfficialAnnounceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ZQOfficialAnnounceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.notice = self.anounceMArray[indexPath.row];
    return cell;
}



#pragma mark -- CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager{
    NSDictionary *dict = [manager fetchDataWithReformer:nil];
    if (self.firstPage) {
        self.anounceMArray = [NSMutableArray arrayWithArray:dict[@"data"][@"news"]];
    }else{
        [self.anounceMArray addObjectsFromArray:dict[@"data"][@"news"]];
    }
    [self.allTableView reloadData];
}
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager{
    
}


#pragma mark -- CTAPIManagerInterceptor
- (void)manager:(CTAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    NSInteger page = [params[@"page"] integerValue];
    self.firstPage = page == 1?YES:NO;
    
    if (self.firstPage) {
        [self.allTableView.mj_header endRefreshing];
    }else{
        [self.allTableView.mj_footer endRefreshing];
    }
}



#pragma mark -- Getters and setters
- (UITableView *)allTableView{
    if (_allTableView == nil) {
        _allTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _allTableView.backgroundColor = [UIColor whiteColor];
        _allTableView.dataSource = self;
        _allTableView.delegate = self;
        _allTableView.tableFooterView = [[UIView alloc]init];
        _allTableView.rowHeight = 35;
    }
    return _allTableView;
}


- (ZQOfficialAnnouncementManager *)annouceManager{
    if (_annouceManager == nil) {
        _annouceManager = [[ZQOfficialAnnouncementManager alloc]init];
        _annouceManager.delegate = self;
        _annouceManager.interceptor = self;
        _annouceManager.officialType = @"active";
    }
    return _annouceManager;
}

- (NSMutableArray *)anounceMArray{
    if (_anounceMArray == nil) {
        _anounceMArray = [NSMutableArray array];
    }
    return _anounceMArray;
}

@end
