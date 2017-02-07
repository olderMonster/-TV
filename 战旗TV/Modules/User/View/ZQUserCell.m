//
//  ZQUserCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/5.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQUserCell.h"
#import <Masonry/Masonry.h>
@interface ZQUserCell()

@property (nonatomic , strong)UIImageView *iconImageView;
@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UIImageView *nMsgImageView;

@end

@implementation ZQUserCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_titleLabel];
        
        _nMsgImageView = [[UIImageView alloc]init];
        _nMsgImageView.image = [UIImage imageNamed:@"ic_new_01"];
        _nMsgImageView.hidden = YES;
        [self.contentView addSubview:_nMsgImageView];
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(self.contentView).with.offset(-20);
        make.width.equalTo(self.iconImageView.mas_height);
        make.left.equalTo(@10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.nMsgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right).with.offset(5);
        make.width.equalTo(@25);
        make.height.equalTo(@16);
    }];
    
}


- (void)setItem:(NSDictionary *)item{
    _item = item;
    
    self.iconImageView.image = [UIImage imageNamed:item[@"imageName"]];
    self.titleLabel.text = item[@"title"];
    
    if (item[@"titleColor"]){
        self.titleLabel.textColor = item[@"titleColor"];
    }else{
        self.titleLabel.textColor = [UIColor blackColor];
    }
    
    if (item[@"new"]){
        self.nMsgImageView.hidden = NO;
    }else{
        self.nMsgImageView.hidden = YES;
    }
}



@end
