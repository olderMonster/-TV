//
//  ZQProtocolController.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/11.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQProtocolController.h"
#import <WebKit/WebKit.h>
@interface ZQProtocolController ()

@property (nonatomic , strong)WKWebView *protocolWebView;

@end

@implementation ZQProtocolController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册协议与隐私政策";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.protocolWebView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.protocolWebView.frame = self.view.bounds;
}


#pragma mark -- getters and setters
- (WKWebView *)protocolWebView{
    if (_protocolWebView) {
        
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"privacy-frame" ofType:@"html"];
        NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        
        _protocolWebView = [[WKWebView alloc]init];
        [_protocolWebView loadHTMLString:html baseURL:baseURL];
    }
    return _protocolWebView;
}


@end
