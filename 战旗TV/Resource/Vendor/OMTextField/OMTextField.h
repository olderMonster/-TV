//
//  OMTextField.h
//  战旗TV
//
//  Created by 印聪 on 2017/1/11.
//  Copyright © 2017年 monster. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , OMTextFieldType) {
    OMTextFieldTypeBoderSelected,
    OMTextFieldTypeBottomBoderSelected
};

@interface OMTextField : UIView

@property (nonatomic , copy)NSString *text;
@property (nonatomic , copy)NSString *placeholder; 
@property (nonatomic , strong)UIFont *font;  //字体大小
@property (nonatomic , strong)UIFont *placeholderFont; //默认等于font
@property (nonatomic , strong)UIColor *placeholderColor; //必须先设置placeholder


@property (nonatomic , strong)UIView *leftView;
@property (nonatomic , strong)UIView *rightView;

//未编辑时的边框颜色
@property (nonatomic , strong)UIColor *normalBorderColor;
//编辑时的边框颜色
@property (nonatomic , strong)UIColor *selctedBorderColor;
//边框圆角
@property (nonatomic , assign)CGFloat borderRadius;
//边框宽度
@property (nonatomic , assign)CGFloat borderWidth;

- (instancetype)initWithType:(OMTextFieldType)type;


@end
