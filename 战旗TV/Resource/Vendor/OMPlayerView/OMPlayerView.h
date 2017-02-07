//
//  OMPlayerView.h
//  MiaoBo
//
//  Created by kehwa on 16/7/12.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OMPlayerViewDelegate <NSObject>

- (void)back;

@end

@interface OMPlayerView : UIView

@property (nonatomic , copy)NSString *urlString;
@property (nonatomic , copy)NSString *backImageName;
@property (nonatomic , copy)NSString *fullImageName;
@property (nonatomic , copy)NSString *fullHightlightImageName;
@property (nonatomic , copy)NSString *cancelFullImageName;
@property (nonatomic , copy)NSString *cancelFullHightImageName;

@property (nonatomic , assign)BOOL hiddenNavigationBar;
@property (nonatomic , assign)BOOL hiddenFullButton;

@property (nonatomic , weak)id<OMPlayerViewDelegate>delegate;

- (instancetype)initWithUrlString:(NSString *)urlString;

- (void)play;
- (void)stop;

@end
