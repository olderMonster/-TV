//
//  ZQPhoneCodeController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/12.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQPhoneCodeController.h"
#import "BMChineseSort.h"
#import "ZQPhoneCodeSectionHeader.h"
#import "OMSearchBar.h"
@interface ZQPhoneCodeController ()<UITableViewDataSource , UITableViewDelegate , UISearchBarDelegate>

@property (nonatomic , strong)UIView *searchView;
@property (nonatomic , strong)UISearchBar *codeSearchBar;
@property (nonatomic , strong)UITableView *codeTableView;

@property (nonatomic , strong)NSArray *indexArray;
@property (nonatomic , strong)NSArray *codeArray;

@end

@implementation ZQPhoneCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"国家和地区";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.codeTableView];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.searchView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    self.codeSearchBar.frame = CGRectMake(5, 5, self.searchView.bounds.size.width - 10, self.searchView.bounds.size.height - 10);
    self.codeTableView.frame = CGRectMake(0, CGRectGetMaxY(self.searchView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.searchView.frame));
    
}


#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.codeArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.codeArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    cell.textLabel.text = self.codeArray[indexPath.section][indexPath.row];
    return cell;
}

//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return self.indexArray;
//}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *sectionHeaderIdentifier = @"sectionHeaderIdentifier";
    ZQPhoneCodeSectionHeader *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderIdentifier];
    if (headerView == nil) {
        headerView = [[ZQPhoneCodeSectionHeader alloc]initWithReuseIdentifier:sectionHeaderIdentifier];
    }
    headerView.title = self.indexArray[section];
    return headerView;
}


#pragma mark -- UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

#pragma mark -- Getters and setters
- (UIView *)searchView{
    if (_searchView == nil) {
        _searchView = [[UIView alloc]init];
        _searchView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
        [_searchView addSubview:self.codeSearchBar];
    }
    return _searchView;
}

- (UISearchBar *)codeSearchBar{
    if (_codeSearchBar == nil) {
        _codeSearchBar = [[UISearchBar alloc]init];
        _codeSearchBar.placeholder = @"搜索";
        [_codeSearchBar sizeToFit];
        _codeSearchBar.delegate = self;
        _codeSearchBar.layer.masksToBounds = YES;
        _codeSearchBar.layer.cornerRadius = 2;
        
        
        //找到取消按钮
//        UIButton *cancelBtn = _codeSearchBar.subviews[0].subviews[2];
//        //修改标题和标题颜色
//        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [cancelBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        for (UIView *view in _codeSearchBar.subviews) {
            // for before iOS7.0
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
                break;
            }
            
            // for later iOS7.0(include)
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
                [[view.subviews objectAtIndex:0] removeFromSuperview];
                
                for (UIView *subView in view.subviews) {
                    if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                        UITextField *field = (UITextField *)subView;
                        field.font = [UIFont systemFontOfSize:12];
                    }
                }
                
                break;
            }
        }
    }
        return _codeSearchBar;

}

- (UITableView *)codeTableView{
    if (_codeTableView == nil) {
        _codeTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _codeTableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _codeTableView.dataSource = self;
        _codeTableView.delegate = self;
        _codeTableView.tableFooterView = [[UIView alloc]init];
    }
    return _codeTableView;
}

- (NSArray *)codeArray{
    if (_codeArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"phoneCode" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
        //这里分别得到国家一级对应的phoneCode
        NSArray *countries = dict[@"countries"];
        NSArray *codes = dict[@"codes"];
        
        NSMutableDictionary *codesMDict = [NSMutableDictionary dictionary];
        for (NSInteger index = 0; index < countries.count; index++) {
            [codesMDict setObject:[NSString stringWithFormat:@"%@",codes[index]] forKey:countries[index]];
        }
        
        self.indexArray = [BMChineseSort IndexArray:countries];
        NSArray *sortedCounsArray = [BMChineseSort LetterSortArray:countries];
        
        NSMutableArray *countriesMArray = [NSMutableArray array];
        for (NSArray *array in sortedCounsArray) {
            NSMutableArray *sortedArray = [NSMutableArray array];
            for (NSString *countryName in array) {
                NSString *code = codesMDict[countryName];
                NSString *countryCodeStr = [NSString stringWithFormat:@"%@ +%@",countryName,code];
                [sortedArray addObject:countryCodeStr];
            }
            [countriesMArray addObject:sortedArray];
        }
        
        _codeArray = countriesMArray;
    }
    return _codeArray;
}

@end
