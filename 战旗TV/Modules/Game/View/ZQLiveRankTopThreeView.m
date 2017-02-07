//
//  ZQLiveRankTopThreeView.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/10.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQLiveRankTopThreeView.h"
#import "NSString+AXNetworkingMethods.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ZQLiveRankTopThreeView()

@property (nonatomic , strong)UIImageView *avatarImageView;
@property (nonatomic , strong)UIImageView *rankImageView;
@property (nonatomic , strong)UIImageView *levelImageView;
@property (nonatomic , strong)UILabel *anchorLabel;
@property (nonatomic , strong)UILabel *nicknameLabel;
@property (nonatomic , strong)UILabel *scoreLabel;

@end

@implementation ZQLiveRankTopThreeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _avatarImageView = [[UIImageView alloc]init];
        [self addSubview:_avatarImageView];
        
        _rankImageView = [[UIImageView alloc]init];
        [self addSubview:_rankImageView];
        
        _levelImageView = [[UIImageView alloc] init]; //64 x 28
        [self addSubview:_levelImageView];
        
        _anchorLabel = [[UILabel alloc]init];
        _anchorLabel.font = [UIFont systemFontOfSize:10];
        _anchorLabel.textColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        _anchorLabel.textAlignment = NSTextAlignmentCenter;
        _anchorLabel.text = @"主播"; //这里显示主播的关键字
        [self addSubview:_anchorLabel];
        
        _nicknameLabel = [[UILabel alloc]init];
        _nicknameLabel.backgroundColor = [UIColor whiteColor];
        _nicknameLabel.font = [UIFont systemFontOfSize:10];
        _nicknameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nicknameLabel];
        
        _scoreLabel = [[UILabel alloc]init];
//        _scoreLabel.backgroundColor = [UIColor whiteColor];
        _scoreLabel.font = [UIFont systemFontOfSize:10];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_scoreLabel];
        
    }
    return self;
}


- (void)setFrame:(CGRect)frame{
    frame.size.height = frame.size.width + 20 + 12 + 10;
    [super setFrame:frame];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.rank == 1) {
        self.avatarImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
        self.anchorLabel.textColor = [UIColor whiteColor];
    }else{
        self.avatarImageView.frame = CGRectMake(5,5, self.bounds.size.width - 10, self.bounds.size.width - 10);
        self.anchorLabel.textColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
    }
    
    self.rankImageView.frame = self.avatarImageView.frame;
    
    self.levelImageView.frame = CGRectMake(self.bounds.size.width * 0.5 - 16, CGRectGetMaxY(self.avatarImageView.frame) - 14, 32, 14);
    self.anchorLabel.frame = CGRectMake(self.levelImageView.frame.origin.x, self.levelImageView.frame.origin.y, self.levelImageView.bounds.size.width - 7, self.levelImageView.bounds.size.height);
    self.nicknameLabel.frame = CGRectMake(5, CGRectGetMaxY(self.avatarImageView.frame), self.bounds.size.width - 10, 20);
    self.scoreLabel.frame = CGRectMake(5, CGRectGetMaxY(self.nicknameLabel.frame), self.bounds.size.width - 10, 12);
    
    
}


- (void)setUser:(NSDictionary *)user{
    _user = user;
    
    NSString *avatar = [user[@"avatar"] httpsToHttp];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@-big",avatar]] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    NSString *level = [user[@"level"] integerValue]< 10?[NSString stringWithFormat:@"0%@",user[@"level"]]:[NSString stringWithFormat:@"%@",user[@"level"]];
    self.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_dengji%@",level]];
    
    self.nicknameLabel.text = user[@"nickname"];
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",user[@"score"]];
    
}

- (void)setRank:(NSInteger)rank{
    
    _rank = rank;
    
    if (rank == 1) {
        self.rankImageView.image = [UIImage imageNamed:@"ic_diyiming"];
    }else if (rank == 2){
        self.rankImageView.image = [UIImage imageNamed:@"ic_dierming"];
    }else if (rank == 3){
        self.rankImageView.image = [UIImage imageNamed:@"ic_disanming"];
    }
    
}


@end
