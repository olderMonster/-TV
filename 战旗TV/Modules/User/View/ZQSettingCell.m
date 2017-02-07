//
//  ZQSettingCell.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/6.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "ZQSettingCell.h"
#import <Masonry/Masonry.h>
@interface ZQSettingCell()

@property (nonatomic , strong)UILabel *titleLabel;
@property (nonatomic , strong)UILabel *desLabel;
@property (nonatomic , strong)UIImageView *arrowImageView;
@property (nonatomic , strong)UILabel *arrowTextLabel;
@property (nonatomic , strong)UISwitch *rightSwitch;

@end

@implementation ZQSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_titleLabel];
        
        _desLabel = [[UILabel alloc]init];
        _desLabel.textColor = [UIColor grayColor];
        _desLabel.font = [UIFont systemFontOfSize:9];
        _desLabel.hidden = YES;
        [self.contentView addSubview:_desLabel];
        
        _arrowImageView = [[UIImageView alloc]init];
        _arrowImageView.image = [UIImage imageNamed:@"more_arrow"];
        _arrowImageView.hidden = YES;
        [self.contentView addSubview:_arrowImageView];
        
        _arrowTextLabel = [[UILabel alloc]init];
        _arrowTextLabel.hidden = YES;
        _arrowTextLabel.textColor = [UIColor grayColor];
        _arrowTextLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_arrowTextLabel];
        
        _rightSwitch = [[UISwitch alloc]init];
        _rightSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
        _rightSwitch.hidden = YES;
        _rightSwitch.onTintColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        [self.contentView addSubview:_rightSwitch];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(15);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).with.offset(-10);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.width.height.equalTo(@5);
    }];
    
    [self.arrowTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImageView.mas_left).with.offset(-5);
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-10);
    }];
    
}


#pragma mark -- getters and setters
- (void)setSettingDict:(NSDictionary *)settingDict{
    
    _settingDict = settingDict;
    
    self.titleLabel.text = settingDict[@"title"];
    
    if (settingDict[@"subTitle"]) {
        
        self.desLabel.text = settingDict[@"subTitle"];
        
        self.desLabel.hidden = NO;
        self.arrowImageView.hidden = YES;
        self.rightSwitch.hidden = YES;
        self.arrowTextLabel.hidden = YES;
        
    }else if (settingDict[@"arrow"]){
    
        self.desLabel.hidden = YES;
        self.arrowImageView.hidden = NO;
        self.rightSwitch.hidden = YES;
        
        if (settingDict[@"arrowText"]){
            self.arrowTextLabel.text = settingDict[@"arrowText"];
            self.arrowTextLabel.hidden = NO;
        }
        
    }else if (settingDict[@"switch"]){
        
        self.rightSwitch.on = [settingDict[@"open"] boolValue];
        
        self.desLabel.hidden = YES;
        self.arrowImageView.hidden = YES;
        self.rightSwitch.hidden = NO;
        self.arrowTextLabel.hidden = YES;
        
    }
    
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setSubTitleFont:(UIFont *)subTitleFont{
    _subTitleFont = subTitleFont;
    self.desLabel.font = subTitleFont;
}

- (void)setArrowTextFont:(UIFont *)arrowTextFont{
    _arrowTextFont = arrowTextFont;
    self.arrowTextLabel.font = arrowTextFont;
}


@end
