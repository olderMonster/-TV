//
//  ZQAnchorLiveInfoView.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/9.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQAnchorLiveInfoViewDelegate <NSObject>

- (void)subscribeAnchor:(UIButton *)subsButton textButton:(UIButton *)subsTextButton;

@end

@interface ZQAnchorLiveInfoView : UIView

@property (nonatomic , strong)NSDictionary *anchor;

@property (nonatomic , weak)id<ZQAnchorLiveInfoViewDelegate>delegate;
@end
