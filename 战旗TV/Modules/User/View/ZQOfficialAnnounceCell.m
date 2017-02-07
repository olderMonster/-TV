//
//  ZQOfficialAnnounceCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/11.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQOfficialAnnounceCell.h"
#import <Masonry/Masonry.h>

@interface ZQOfficialAnnounceCell()

@property (nonatomic , strong)UIImageView *tagImageView;
@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UIImageView *nextImageView;

@end

@implementation ZQOfficialAnnounceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tagImageView = [[UIImageView alloc]init]; //88 x 34
        _tagImageView.image = [UIImage imageNamed:@"ic_huodongzhongxin_hot"];
        [self.contentView addSubview:_tagImageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLabel];
        
        _nextImageView = [[UIImageView alloc]init];
        _nextImageView.image = [UIImage imageNamed:@"more_arrow"];
        [self.contentView addSubview:_nextImageView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.nextImageView.bounds = CGRectMake(0, 0, 5, 5);
    self.nextImageView.center = CGPointMake(self.contentView.bounds.size.width - 5 - self.nextImageView.bounds.size.width * 0.5, self.contentView.center.y);
    
    BOOL isHot = [self.notice[@"tag"] isEqualToString:@"hot"];
    if (isHot) {
        self.tagImageView.bounds = CGRectMake(0, 0, 88 * 0.4, 34 * 0.4);
        self.tagImageView.center = CGPointMake(15 + self.tagImageView.bounds.size.width * 0.5, self.contentView.center.y);
    }else{
        self.tagImageView.frame = CGRectZero;
    }
    

    
    CGFloat textleft = isHot?(CGRectGetMaxX(self.tagImageView.frame) + 5):15;
    self.titleLabel.frame = CGRectMake(textleft, 0, self.nextImageView.frame.origin.x - textleft - 10, self.contentView.bounds.size.height);
    
    
}


- (void)setNotice:(NSDictionary *)notice{
    _notice = notice;
    
    self.titleLabel.text = notice[@"title"];
}

@end
