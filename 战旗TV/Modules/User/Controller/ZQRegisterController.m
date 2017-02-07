//
//  ZQRegisterController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/11.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQRegisterController.h"
#import <Masonry/Masonry.h>
#import "OMTextField.h"
#import "ZQProtocolController.h"
#import "ZQPhoneCodeController.h"
@interface ZQRegisterController ()

@property (nonatomic , strong)UIImageView *logoImageView;
@property (nonatomic , strong)OMTextField *mobileField;
@property (nonatomic , strong)OMTextField *verficationCodeField;
@property (nonatomic , strong)OMTextField *nicknameField;
@property (nonatomic , strong)OMTextField *passwordField;
@property (nonatomic , strong)UIButton *registerButton;
@property (nonatomic , strong)UILabel *protocolLabel;
@property (nonatomic , strong)UILabel *protocolButton;

@property (nonatomic , strong)UIButton *phoneCodeButton;

@end

@implementation ZQRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"账号注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.mobileField];
    [self.view addSubview:self.verficationCodeField];
    [self.view addSubview:self.nicknameField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.protocolLabel];
    [self.view addSubview:self.protocolButton];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@20);
        make.width.equalTo(@(290 * 0.5));
        make.height.equalTo(@(152 * 0.5));
    }];
    
    [self.mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.logoImageView.mas_bottom).with.offset(40);
        make.right.equalTo(self.view).with.offset(-15);
        make.height.equalTo(@35);
    }];
    
    [self.verficationCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.mobileField);
        make.top.equalTo(self.mobileField.mas_bottom).with.offset(10);
    }];
    
    [self.nicknameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.mobileField);
        make.top.equalTo(self.verficationCodeField.mas_bottom).with.offset(10);
    }];
    
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.mobileField);
        make.top.equalTo(self.nicknameField.mas_bottom).with.offset(10);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.mobileField);
        make.top.equalTo(self.passwordField.mas_bottom).with.offset(15);
        make.height.equalTo(@35);
    }];
    
    [self.protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mobileField);
        make.top.equalTo(self.registerButton.mas_bottom).with.offset(10);
    }];
    
    [self.protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.protocolLabel.mas_right).with.offset(2);
        make.top.equalTo(self.protocolLabel);
    }];
    
}


#pragma mark -- Event response
- (void)showProtocol{
    [self.navigationController pushViewController:[[ZQProtocolController alloc]init] animated:YES];
}


- (void)selectPhoneCode{
    [self.navigationController pushViewController:[[ZQPhoneCodeController alloc]init] animated:YES];
}


#pragma mark -- Getters and setters
- (UIImageView *)logoImageView{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.image = [UIImage imageNamed:@"login_logo"];
    }
    return _logoImageView;
}
- (OMTextField *)mobileField{
    if (_mobileField == nil) {
        _mobileField = [[OMTextField alloc]initWithType:OMTextFieldTypeBottomBoderSelected];
        _mobileField.backgroundColor = [UIColor whiteColor];
        _mobileField.placeholder = @"请输入您的手机号码";
        _mobileField.font = [UIFont systemFontOfSize:13];
        _mobileField.leftView = self.phoneCodeButton;
    }
    return _mobileField;
}

- (OMTextField *)verficationCodeField{
    if (_verficationCodeField == nil) {
        _verficationCodeField = [[OMTextField alloc]initWithType:OMTextFieldTypeBottomBoderSelected];
        _verficationCodeField.backgroundColor = [UIColor whiteColor];
        _verficationCodeField.placeholder = @"输入验证码";
        _verficationCodeField.font = [UIFont systemFontOfSize:13];
    }
    return _verficationCodeField;
}

- (OMTextField *)nicknameField{
    if (_nicknameField == nil) {
        _nicknameField = [[OMTextField alloc]initWithType:OMTextFieldTypeBottomBoderSelected];
        _nicknameField.backgroundColor = [UIColor whiteColor];
        _nicknameField.placeholder = @"昵称(24个字符以内)";
        _nicknameField.font = [UIFont systemFontOfSize:13];
    }
    return _nicknameField;
}

- (OMTextField *)passwordField{
    if (_passwordField == nil) {
        _passwordField = [[OMTextField alloc]initWithType:OMTextFieldTypeBottomBoderSelected];
        _passwordField.backgroundColor = [UIColor whiteColor];
        _passwordField.placeholder = @"请输入密码";
        _passwordField.font = [UIFont systemFontOfSize:13];
    }
    return _passwordField;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        [_registerButton setTitle:@"注册并登录" forState:UIControlStateNormal];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _registerButton;
}

- (UILabel *)protocolLabel{
    if (_protocolLabel == nil) {
        _protocolLabel = [[UILabel alloc]init];
        _protocolLabel.textColor = [UIColor grayColor];
        _protocolLabel.font = [UIFont systemFontOfSize:10];
        _protocolLabel.text = @"点击注册即表示同意";
    }
    return _protocolLabel;
}

- (UILabel *)protocolButton{
    if (_protocolButton == nil) {
        _protocolButton = [[UILabel alloc]init];
        _protocolButton.textColor = [UIColor blackColor];
        _protocolButton.font = [UIFont systemFontOfSize:10];
        _protocolButton.userInteractionEnabled = YES;
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"《注册协议和隐私政策》"];
        NSRange contentRange = {0, [content length]};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        _protocolButton.attributedText = content;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showProtocol)];
        tap.numberOfTapsRequired = 1;
        [_protocolButton addGestureRecognizer:tap];
    }
    return _protocolButton;
}

- (UIButton *)phoneCodeButton{
    if (_phoneCodeButton == nil) {
        _phoneCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneCodeButton.frame = CGRectMake(0, 0, 30, 20);
        [_phoneCodeButton setTitle:@"+86" forState:UIControlStateNormal];
        [_phoneCodeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _phoneCodeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_phoneCodeButton addTarget:self action:@selector(selectPhoneCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneCodeButton;
}


@end
