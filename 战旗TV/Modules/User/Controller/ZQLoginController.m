//
//  ZQLoginController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/4.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQLoginController.h"
#import <Masonry/Masonry.h>
#import "ZQRegisterController.h"
@interface ZQLoginController ()

@property (nonatomic , strong)UIImageView *logoImageView;
@property (nonatomic , strong)UITextField *accountField;
@property (nonatomic , strong)UIView *accountLineView;
@property (nonatomic , strong)UITextField *passwordField;
@property (nonatomic , strong)UIView *passwordLineView;
@property (nonatomic , strong)UIButton *showPsdButton;
@property (nonatomic , strong)UIButton *loginButton;
@property (nonatomic , strong)UIButton *overseaLoginButton;
@property (nonatomic , strong)UIButton *losePsdButton;

@property (nonatomic , strong)UIButton *qqButton;
@property (nonatomic , strong)UIButton *wxButton;
@property (nonatomic , strong)UIButton *wbButton;
@property (nonatomic , strong)UIView *threePartLineView;
@property (nonatomic , strong)UILabel *threePartLabel;

@end

@implementation ZQLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupItems];
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.accountLineView];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.passwordLineView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.overseaLoginButton];
    [self.view addSubview:self.losePsdButton];
    
    [self.view addSubview:self.qqButton];
    [self.view addSubview:self.wbButton];
    [self.view addSubview:self.wxButton];
    [self.view addSubview:self.threePartLineView];
    [self.view addSubview:self.threePartLabel];
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@20);
        make.width.equalTo(@(290 * 0.5));
        make.height.equalTo(@(152 * 0.5));
    }];
    
    [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.logoImageView.mas_bottom).with.offset(40);
        make.right.equalTo(self.view).with.offset(-15);
        make.height.equalTo(@35);
    }];
    
    [self.accountLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.accountField);
        make.height.equalTo(@1);
    }];
    
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.accountField);
        make.top.equalTo(self.accountField.mas_bottom).with.offset(10);
    }];
    
    [self.passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.passwordField);
        make.height.equalTo(@1);
    }];
    
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.accountField);
        make.top.equalTo(self.passwordField.mas_bottom).with.offset(15);
        make.height.equalTo(@35);
    }];

    [self.overseaLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginButton);
        make.top.equalTo(self.loginButton.mas_bottom).with.offset(5);
    }];

    
    [self.losePsdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginButton);
        make.top.equalTo(self.overseaLoginButton);
    }];
    
    
    CGFloat gap = 50;
    CGFloat itemWidth = (self.view.bounds.size.width - 4 * gap)/3;
    [self.qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(gap));
        make.bottom.equalTo(self.view).with.offset(-40);
        make.width.height.equalTo(@(itemWidth));
    }];
    [self.wbButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.width.height.equalTo(self.qqButton);
    }];
    [self.wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wbButton.mas_right).with.offset(gap);
        make.bottom.width.height.equalTo(self.qqButton);
    }];
    
    
    [self.threePartLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.accountField);
        make.bottom.equalTo(self.qqButton.mas_top).with.offset(-30);
        make.height.equalTo(@1);
    }];
    
    CGSize textSize = [self.threePartLabel.text sizeWithAttributes:@{NSFontAttributeName:self.threePartLabel.font}];
    [self.threePartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.threePartLineView);
        make.width.equalTo(@(textSize.width + 30));
    }];
    
}


#pragma mark -- Private method
- (void)setupItems{
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(dismissLoginVC) forControlEvents:UIControlEventTouchUpInside];
    closeButton.frame = CGRectMake(0, 0, 15, 15);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(0, 0, 28, 20);
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:registerButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}


#pragma mark -- event response
- (void)dismissLoginVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerAction{
    [self.navigationController pushViewController:[[ZQRegisterController alloc]init] animated:YES];
}

- (void)showPassword:(UIButton *)button{
    button.selected = !button.selected;
    
    if (button.selected) {
        //显示密码
        self.passwordField.secureTextEntry = NO;
    }else{
        self.passwordField.secureTextEntry = YES;
    }
    
}


#pragma mark -- getters and setters
- (UIImageView *)logoImageView{
    if (_logoImageView == nil) {
        //290 x 152
        _logoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_logo"]];
    }
    return _logoImageView;
}

- (UITextField *)accountField{
    if (_accountField == nil) {
        _accountField = [[UITextField alloc]init];
        _accountField.font = [UIFont systemFontOfSize:13];
        _accountField.placeholder = @"请填写账号/手机号";
        [_accountField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        [_accountField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _accountField;
}

- (UIView *)accountLineView{
    if (_accountLineView == nil) {
        _accountLineView = [[UIView alloc]init];
        _accountLineView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
    }
    return _accountLineView;
}

- (UITextField *)passwordField{
    if (_passwordField == nil) {
        _passwordField = [[UITextField alloc]init];
        _passwordField.font = [UIFont systemFontOfSize:13];
        _passwordField.placeholder = @"请输入密码";
        [_passwordField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
        [_passwordField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        _passwordField.secureTextEntry = YES;
        _passwordField.rightViewMode = UITextFieldViewModeAlways;
        _passwordField.rightView = self.showPsdButton;
        
    }
    return _passwordField;
}


- (UIView *)passwordLineView{
    if (_passwordLineView == nil) {
        _passwordLineView = [[UIView alloc]init];
        _passwordLineView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
    }
    return _passwordLineView;
}


- (UIButton *)showPsdButton{
    if (_showPsdButton == nil) {
        _showPsdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _showPsdButton.frame = CGRectMake(0, 0, 20, 20);
        [_showPsdButton setBackgroundImage:[UIImage imageNamed:@"login_hidesecret"] forState:UIControlStateNormal];
        [_showPsdButton setBackgroundImage:[UIImage imageNamed:@"login_showsecret"] forState:UIControlStateSelected];
        [_showPsdButton addTarget:self action:@selector(showPassword:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showPsdButton;
}


- (UIButton *)loginButton{
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        [_loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _loginButton;
}


- (UIButton *)overseaLoginButton{
    if (_overseaLoginButton == nil) {
        _overseaLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_overseaLoginButton setTitle:@"海外手机登陆" forState:UIControlStateNormal];
        [_overseaLoginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _overseaLoginButton.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _overseaLoginButton;
}

- (UIButton *)losePsdButton{
    if (_losePsdButton == nil) {
        _losePsdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_losePsdButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_losePsdButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _losePsdButton.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _losePsdButton;
}


- (UIButton *)qqButton{
    if (_qqButton == nil) {
        _qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqButton setBackgroundImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
    }
    return _qqButton;
}

- (UIButton *)wxButton{
    if (_wxButton == nil) {
        _wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxButton setBackgroundImage:[UIImage imageNamed:@"login_wx"] forState:UIControlStateNormal];
    }
    return _wxButton;
}

- (UIButton *)wbButton{
    if (_wbButton == nil) {
        _wbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wbButton setBackgroundImage:[UIImage imageNamed:@"login_wb"] forState:UIControlStateNormal];
    }
    return _wbButton;
}


- (UIView *)threePartLineView{
    if (_threePartLineView == nil) {
        _threePartLineView = [[UIView alloc]init];
        _threePartLineView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
    }
    return _threePartLineView;
}

- (UILabel *)threePartLabel{
    if (_threePartLabel == nil) {
        _threePartLabel = [[UILabel alloc]init];
        _threePartLabel.backgroundColor = [UIColor whiteColor];
        _threePartLabel.font = [UIFont systemFontOfSize:10];
        _threePartLabel.textColor = [UIColor grayColor];
        _threePartLabel.text = @"其他登录方式";
        _threePartLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _threePartLabel;
}

@end
