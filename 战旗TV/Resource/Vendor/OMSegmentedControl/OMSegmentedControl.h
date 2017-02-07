//
//  OMSegmentedControl.h
//  仿熊猫TV
//
//  Created by kehwa on 16/5/12.
//  Copyright © 2016年 kehwa. All rights reserved.
//



/*
 *
 *  当segmentControl中的item没有正常显示的时候需要在控制器中加入self.automaticallyAdjustsScrollViewInsets = NO;即可显示正常
 *
 */


/*
 * 1. 长按住某个已经被选中的item，item的颜色会变化
 * 2. 选中某个item的时候item应该自动滑动到屏幕中央
 *
 */



#import <UIKit/UIKit.h>
@class OMSegmentedControl;

typedef NS_ENUM(NSInteger,OMSegmentedControlMode) {
    OMSegmentedControlModeShowAll,          //展示所有的item，item过多的时候可以滑动
    OMSegmentedControlModeShowMore          //展示所有的item，item过多的时候可以滑动，但是会在最右侧显示一个more按钮
};


typedef NS_ENUM(NSInteger,OMSegmentedControlItemMode) {
    OMSegmentedControlItemModeSlipeBottom,                   //底部标识滑动模式
    OMSegmentedControlItemModeBackgroundSelected             //背景选中模式
};



@protocol OMSegmentedControlDelegate <NSObject>

@required
- (void)segmentControl:(OMSegmentedControl *)segControl didSelectSegmentIndex:(NSInteger)segmentIndex;
@optional
- (void)didSelectMorePannelOfSegmentControl:(OMSegmentedControl *)segControl;

@end


@interface OMSegmentedControl : UIView


@property (nonatomic , copy)NSString *sepImageName;
//更多按钮的背景图片
@property (nonatomic , copy)NSString *moreImageName;
// 当前选中索引
@property (nonatomic , assign)NSInteger selectedSegmentIndex;
//未选中状态的文本颜色
@property (nonatomic , strong)UIColor *normalTextColor;
//选中状态的文本颜色
@property (nonatomic , strong)UIColor *selectedTextColor;
//未选中状态的背景颜色
@property (nonatomic , strong)UIColor *normalBackgroundColor;
//选中状态的背景颜色
@property (nonatomic , strong)UIColor *selectedBackgroundColor;
//字体大小
@property (nonatomic , strong)UIFont *font;

//在OMSegmentedControlModeSwipe以下属性有效
//滑块颜色
@property (nonatomic , strong)UIColor *slipeColor;
//滑块高度
@property (nonatomic , assign)CGFloat slipeHeight;

//在OMSegmentedControlModeSwipe以下属性无效
//边框颜色
@property (nonatomic , strong)UIColor *borderColor;
//边框宽度（高度）
@property (nonatomic , assign)CGFloat borderWidth;
//边框的弧度
@property (nonatomic , assign)CGFloat borderRadius;
//显示下边框，默认为否
@property (nonatomic , assign)BOOL showBottomBoder;

@property (nonatomic , weak)id<OMSegmentedControlDelegate>segmentControlDelegate;


- (instancetype)initWithSegMode:(OMSegmentedControlMode)segMode segItemMode:(OMSegmentedControlItemMode)itemMode;

//设置数据源，如果key不为空，那么items为字典，否者未字符串
- (void)items:(NSArray *)items key:(NSString *)key;
//修改指定索引处的文本
- (void)editTitle:(NSString *)changedText index:(NSInteger)segmentIndex;

//修改指定索引item未选中时的背景图片
- (void)setNormalBackgroundImage:(UIImage *)backgroundImage segmentIndex:(NSInteger)segmentIndex;
//修改指定索引item选中时的背景图片
- (void)setSelectedBackgroundImage:(UIImage *)backgroundImage segmentIndex:(NSInteger)segmentIndex;


@end
