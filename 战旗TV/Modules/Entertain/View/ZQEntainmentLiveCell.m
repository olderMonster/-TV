//
//  ZQEntainmentLiveCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/12.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQEntainmentLiveCell.h"
#import "OMPlayerView.h"
#import "ZQEntainmentLiveInfoController.h"
@interface ZQEntainmentLiveCell()

@property (nonatomic , strong)UIImageView *loadingImageView;
@property (nonatomic , strong)ZQEntainmentLiveInfoController *infoVC;
@property (nonatomic , strong)UIButton *closeButton;

@property (nonatomic , assign)CGFloat infoViewStartFrameX;
@property (nonatomic , assign)CGPoint startPoint;
@property (nonatomic , assign)CGPoint endPoint;



@end

@implementation ZQEntainmentLiveCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _loadingImageView = [[UIImageView alloc]init];
        _loadingImageView.image = [UIImage imageNamed:@"global_marquee"];
        [self.contentView addSubview:_loadingImageView];
        
        _infoVC = [[ZQEntainmentLiveInfoController alloc]init];
        [self.contentView addSubview:_infoVC.view];
        
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"btn_live_close_normal"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_closeButton];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //y = 状态栏高度 + anchoView（主播信息）的y值 + （anchoView的高度 - closeButton高度）*0.5
    self.closeButton.frame = CGRectMake(self.contentView.bounds.size.width - 30, 20 + 10 +  (30 - 20) * 0.5, 20, 20);
    self.infoVC.view.frame = self.contentView.bounds;
}


#pragma mark -- Event response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    UITouch *touch = touches.anyObject;
    self.startPoint = [touch locationInView:self];
    self.infoViewStartFrameX = self.infoVC.view.frame.origin.x;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    self.endPoint = [touch locationInView:self];

    CGFloat distance = self.endPoint.x - self.startPoint.x;

    [UIView animateWithDuration:0.1 animations:^{

        //向右滑动中
        if (distance > 0 && self.infoVC.view.frame.origin.x <= self.contentView.bounds.size.width){
            self.infoVC.view.frame = CGRectMake(distance, self.infoVC.view.frame.origin.y, self.infoVC.view.bounds.size.width, self.infoVC.view.bounds.size.height);
        }

        //向左滑动中
        if (distance < 0 && self.infoVC.view.frame.origin.x > 0 && self.infoVC.view.frame.origin.x <= self.contentView.bounds.size.width)  {
            self.infoVC.view.frame = CGRectMake(self.contentView.bounds.size.width + distance, self.infoVC.view.frame.origin.y, self.infoVC.view.bounds.size.width, self.infoVC.view.bounds.size.height);
        }
    }];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    UITouch *touch = touches.anyObject;
    self.endPoint = [touch locationInView:self];

    //获取触摸点移动的距离，个人那句触摸点移动的距离判定移动的方向
    CGFloat distance = self.endPoint.x - self.startPoint.x;

    //根据触摸结束的时候view的横坐标来判断是否是弹回去还是
    CGFloat frameX = self.infoVC.view.frame.origin.x;
    
    //向右滑动结束
    if (distance > 0  && self.infoViewStartFrameX == 0) {

        [UIView animateWithDuration:0.1 animations:^{
            if (frameX >= self.contentView.bounds.size.width * 0.5) {
                //当滑动的距离超过屏幕宽度的一半的时候则自动划出屏幕外边,此时空白view（leftBlankView）自动覆盖到当前的屏幕可视区域，以接受左划的手势
                self.infoVC.view.frame = CGRectMake(self.contentView.bounds.size.width, self.infoVC.view.frame.origin.y, self.infoVC.view.bounds.size.width, self.infoVC.view.bounds.size.height);
            }else{
                //当滑动的距离不足屏幕宽度的一半的时候自动弹回初始位置
                self.infoVC.view.frame = CGRectMake(0, self.infoVC.view.frame.origin.y, self.infoVC.view.bounds.size.width, self.infoVC.view.bounds.size.height);
            }
        }];

    }

    //向左滑动结束
    if (distance < 0  && self.infoViewStartFrameX == self.contentView.bounds.size.width) {

        [UIView animateWithDuration:0.1 animations:^{
            if (fabs(distance) >= self.contentView.bounds.size.width * 0.5) {
                //当向左滑动的距离大于屏幕的宽度的时候，infoVC自动回到当前可视区域，同时leftBlankView也回到初始位置（屏幕左侧）
                self.infoVC.view.frame = CGRectMake(0, self.infoVC.view.frame.origin.y, self.infoVC.view.bounds.size.width, self.infoVC.view.bounds.size.height);
            }else{
                //当向左滑动的距离不足屏幕宽度的一半的时候，infoVC回到原始位置（屏幕外边）
                self.infoVC.view.frame = CGRectMake(self.infoVC.view.bounds.size.width, self.infoVC.view.frame.origin.y, self.infoVC.view.bounds.size.width, self.contentView.bounds.size.height);
            }
        }];

    }

}


#pragma mark -- event response
-(void)closeAction{
    if ([self.delegate respondsToSelector:@selector(closeLiving)]) {
        [self.delegate closeLiving];
    }
}


#pragma makr -- Getters and setters
- (void)setVideoId:(NSString *)videoId{
    _videoId = videoId;
    
    for (UIView *subView in self.contentView.subviews) {
        if ([subView isKindOfClass:[OMPlayerView class]]) {
            [subView removeFromSuperview];
            break;
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"http://dlhls.cdn.zhanqi.tv/zqlive/%@.m3u8",videoId];
    OMPlayerView *playView = [[OMPlayerView alloc] initWithUrlString:url];
    if (self.type == ZQEntainmentLiveCellTypeBaiBianZhuBo) {
        CGFloat height = [UIScreen mainScreen].bounds.size.width * 9 /16;
        playView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
    }else if (self.type == ZQEntainmentLiveCellTypeDaRenMeiPai){
        playView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }
    
    playView.center = self.contentView.center;
    playView.hiddenFullButton = YES;
    playView.hiddenNavigationBar = YES;
    [self.contentView insertSubview:playView atIndex:0];
}

- (void)setAnchor:(NSDictionary *)anchor{
    _anchor = anchor;
    self.infoVC.anchor = anchor;
}

- (void)setAnchors:(NSArray *)anchors{
    _anchors = anchors;
    self.infoVC.anchors = anchors;
}



@end
