//
//  OMPlayerView.m
//  MiaoBo
//
//  Created by kehwa on 16/7/12.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "OMPlayerView.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface OMPlayerView()

@property (atomic, retain) id <IJKMediaPlayback> player;


//是否全屏
@property (nonatomic , assign)BOOL isFullScreen;

//当前视频的可见区域
@property (nonatomic , strong)UIView *playerView;

@property (nonatomic , strong)UIImageView *navigationBar;
@property (nonatomic , strong)UIButton *backButton;         //返回按钮
@property (nonatomic , strong)UIButton *fullButton;         //全屏按钮

@end

@implementation OMPlayerView


- (instancetype)initWithUrlString:(NSString *)urlString{
    self = [super init];
    if (self) {
        
        self.backImageName = @"btn_return_bar_normal";
        self.fullImageName = @"player_por_full_normal";
        self.fullHightlightImageName = @"player_por_full_pressed@2x";
        self.cancelFullImageName = @"player_land_por_normal@2x";
        self.cancelFullHightImageName = @"player_land_por_pressed@2x";
        
        //给视频添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
        tap.numberOfTapsRequired = 1;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    
        _player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:urlString withOptions:nil];
        [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
        
        _playerView = [self.player view];
        _playerView.backgroundColor = [UIColor blackColor];
        _playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_playerView];
        [_player prepareToPlay];
        
        
        _navigationBar = [[UIImageView alloc]init];
        _navigationBar.userInteractionEnabled = YES;
        _navigationBar.backgroundColor = [UIColor blackColor];
        _navigationBar.alpha = 0.5;
        [self addSubview:_navigationBar];
        
        [self addPlayerObserver];
        
        [_navigationBar addSubview:self.backButton];
        [self addSubview:self.fullButton];
        
        
        //延迟3s后隐藏视屏面板上的所有ui
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.navigationBar.hidden = YES;
            weakSelf.fullButton.hidden = YES;
        });
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.playerView.frame = self.bounds;
    
    self.navigationBar.frame = CGRectMake(0, 0, self.bounds.size.width, 44);
    self.backButton.frame = CGRectMake(10, 7, 30, 30);

    self.fullButton.frame = CGRectMake(self.bounds.size.width - 10 - 25, self.bounds.size.height - 10 - 25, 25, 25);

}


- (void)setUrlString:(NSString *)urlString{
    
    if (self.player == nil) {
        _player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:urlString withOptions:nil];
        [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
        [_player prepareToPlay];
        _playerView = [self.player view];
        _playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self addPlayerObserver];
    }

}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
}

- (void)addPlayerObserver{
    //添加通知之前先移除，避免出现重复添加
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    switch (_player.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}


#pragma mark - public method
- (void)play{
    if ([self.player isPlaying]) {
        [self.player pause];
    }else{
        [self.player play];
    }
}

- (void)stop{
    if ([self.player isPlaying]) {
        [self.player stop];
    }
}

#pragma mark -- private method
//获取当前显示控制器
- (UIViewController *)activityViewController
{
    
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


#pragma mark -- event response
- (void)singleTap{
    if (!self.hiddenNavigationBar) {
        self.navigationBar.hidden = NO;
    }
    
    if (!self.hiddenFullButton) {
        self.fullButton.hidden = NO;
    }
    
    //延迟3s后隐藏视屏面板上的所有ui
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.navigationBar.hidden = YES;
        weakSelf.fullButton.hidden = YES;
    });
}


- (void)backAction{
    
    if (self.isFullScreen){
        [self fullAction];
    }else{
        if ([self.delegate respondsToSelector:@selector(back)]){
            [self.delegate back];
        }
    }
}


- (void)fullAction{
    
    UIViewController *currentShowVC = [self activityViewController];
    [currentShowVC.view bringSubviewToFront:self];
    
    if (self.isFullScreen){
        //全屏状态下取消全屏
        currentShowVC.view.backgroundColor = [UIColor whiteColor];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.isFullScreen = NO;
            
            currentShowVC.view.transform = CGAffineTransformIdentity;
            currentShowVC.view.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            //修改全屏按钮的背景图片
            [self.fullButton setBackgroundImage:[UIImage imageNamed:self.fullImageName] forState:UIControlStateNormal];
            [self.fullButton setBackgroundImage:[UIImage imageNamed:self.fullHightlightImageName] forState:UIControlStateHighlighted];
        }];
        
      
        
    }else{
        
        currentShowVC.view.backgroundColor = [UIColor blackColor];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.isFullScreen = YES;
            
            //旋转90度，成为横屏状态
            currentShowVC.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            currentShowVC.view.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
            
            //修改全屏按钮的背景图片
            [self.fullButton setBackgroundImage:[UIImage imageNamed:self.cancelFullImageName] forState:UIControlStateNormal];
            [self.fullButton setBackgroundImage:[UIImage imageNamed:self.cancelFullHightImageName] forState:UIControlStateHighlighted];
        }];
        
    }

    
}


#pragma mark -- getters and setters
- (UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setBackgroundImage:[UIImage imageNamed:self.backImageName] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)fullButton{
    if (_fullButton == nil) {
        _fullButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullButton setBackgroundImage:[UIImage imageNamed:self.fullImageName] forState:UIControlStateNormal];
        [_fullButton setBackgroundImage:[UIImage imageNamed:self.fullHightlightImageName] forState:UIControlStateHighlighted];
        [_fullButton addTarget:self action:@selector(fullAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullButton;
}


- (void)setHiddenNavigationBar:(BOOL)hiddenNavigationBar{
    _hiddenNavigationBar = hiddenNavigationBar;
    self.navigationBar.hidden = YES;
}

- (void)setHiddenFullButton:(BOOL)hiddenFullButton{
    _hiddenFullButton = hiddenFullButton;
    self.fullButton.hidden = YES;
}

@end
