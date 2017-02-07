//
//  OMSegmentedControl.m
//  仿熊猫TV
//
//  Created by kehwa on 16/5/12.
//  Copyright © 2016年 kehwa. All rights reserved.
//

#import "OMSegmentedControl.h"

#define defaultSlipeHeight 2

@interface OMSegmentedControl()

@property (nonatomic , assign)OMSegmentedControlMode segMode;
@property (nonatomic , assign)OMSegmentedControlItemMode segItemMode;


//显示item的scrollView
@property (nonatomic , strong)UIScrollView *segScrollView;

//右侧的按钮区域
@property (nonatomic , strong)UIView *moreView;
@property (nonatomic , strong)UIImageView *leftImageView;
@property (nonatomic , strong)UIButton *moreButton;


//item下方的滑块
@property (nonatomic , strong)UIView *slipeView;
@property (nonatomic , strong)UIView *bottomBoderView;



//装载item信息的数组
@property (nonatomic , strong)NSArray *items;
//如果items中为字典，那么itemKey这应该是需要显示的信息的key值
@property (nonatomic , strong)NSString *itemKey;
//装载itemBtn的数组
@property (nonatomic , strong)NSMutableArray <UIButton *> *btnItems;


//记录上次选中的按钮
@property (nonatomic , strong)UIButton *lastSelectedButton;


@end

@implementation OMSegmentedControl


- (instancetype)initWithSegMode:(OMSegmentedControlMode)segMode segItemMode:(OMSegmentedControlItemMode)itemMode{
    self = [super init];
    if (self) {
        
        self.selectedSegmentIndex = 0;
        self.normalTextColor = [UIColor blackColor];
        self.selectedTextColor = [UIColor redColor];
        self.normalBackgroundColor = [UIColor whiteColor];
        self.selectedBackgroundColor = [UIColor redColor];
        self.slipeColor = [UIColor redColor];
        self.slipeHeight = 2;
        self.font = [UIFont systemFontOfSize:11];
        self.showBottomBoder = NO;
        
        
        _segScrollView = [[UIScrollView alloc] init];
        _segScrollView.backgroundColor = [UIColor whiteColor];
        _segScrollView.showsVerticalScrollIndicator = NO;
        _segScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_segScrollView];
        
        
        _bottomBoderView = [[UIView alloc]init];
        _bottomBoderView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        _bottomBoderView.hidden = !self.showBottomBoder;
        [_segScrollView addSubview:_bottomBoderView];
        
        if (segMode == OMSegmentedControlModeShowMore){
            _moreView = [[UIView alloc]init];
            _moreView.backgroundColor = [UIColor whiteColor];
            [self addSubview:_moreView];
            
            _leftImageView = [[UIImageView alloc]init];
            [self addSubview:_leftImageView];
            
            _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
            [_moreView addSubview:_moreButton];
            
        }
        
        if (itemMode == OMSegmentedControlItemModeSlipeBottom){
            _slipeView = [[UIView alloc] init];
            _slipeView.backgroundColor = [UIColor redColor];
            [_segScrollView addSubview:_slipeView];
            [_segScrollView bringSubviewToFront:_slipeView];
            
            self.selectedBackgroundColor = self.normalBackgroundColor;
            
        }
        
        if (itemMode != OMSegmentedControlItemModeSlipeBottom){
            _slipeView.hidden = YES;
        }
        
        _segMode = segMode;
        _segItemMode = itemMode;
    }
    return self;
}




- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.bottomBoderView.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
    
    
    if (self.segMode == OMSegmentedControlModeShowMore){
        self.moreView.frame = CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);
        
        self.moreButton.bounds = CGRectMake(0, 0, self.moreView.bounds.size.height * 0.6, self.moreView.bounds.size.height * 0.6);
        self.moreButton.center = CGPointMake(self.moreView.bounds.size.width*0.5, self.moreView.bounds.size.height*0.5);
        
        
        self.leftImageView.frame = CGRectMake(self.moreView.frame.origin.x - 2, 0, 2, self.bounds.size.height);
        self.segScrollView.frame = CGRectMake(0, 0, self.moreView.frame.origin.x, self.bounds.size.height);
    }else{
        self.segScrollView.frame = self.bounds;
    }
    
    
    
    if (self.btnItems.count){
        
        UIButton *priviousBtn;
        
        for (NSInteger index = 0; index < self.btnItems.count; index++) {
            
            UIButton *button = self.btnItems[index];
            
            NSString *itemName = self.itemKey?self.items[index][self.itemKey]:self.items[index];
            CGSize itemSize = [itemName sizeWithAttributes:[[NSDictionary alloc]initWithObjectsAndKeys:button.titleLabel.font,NSFontAttributeName, nil]];

            CGFloat height = (self.segScrollView.frame.size.height - 2 * self.borderWidth);
            
            if (index == 0){
                button.frame = CGRectMake(self.borderWidth, self.borderWidth, itemSize.width + 10,height);
            }else{
                button.frame = CGRectMake(CGRectGetMaxX(priviousBtn.frame), self.borderWidth, itemSize.width + 10, height);
            }
            
            
            priviousBtn = button;
            
            //当设置了按钮的frame之后就替换掉原btn
            [self.btnItems replaceObjectAtIndex:index withObject:button];
            
            if (index == self.btnItems.count - 1){
                //当显示的item较多时可以滑动
                if (CGRectGetMaxX(priviousBtn.frame) > self.segScrollView.frame.size.width){
                    self.segScrollView.contentSize = CGSizeMake(CGRectGetMaxX(priviousBtn.frame), 0);
                }else{
                    
                    CGFloat width = (self.segScrollView.frame.size.width - 2 * self.borderWidth) / self.btnItems.count;
                    
                    for (NSInteger index = 0; index < self.btnItems.count; index++) {
                        
                         UIButton *btn = self.btnItems[index];
                        
                        if (index == 0){
                            btn.frame = CGRectMake(self.borderWidth, self.borderWidth, width, self.segScrollView.frame.size.height);
                        }else{
                            btn.frame = CGRectMake(CGRectGetMaxX(priviousBtn.frame), self.borderWidth, width, priviousBtn.bounds.size.height);
                        }
                        
                        priviousBtn = btn;
                        
                        //当设置了按钮的frame之后就替换掉原btn
                        [self.btnItems replaceObjectAtIndex:index withObject:btn];
                    }
                    
                }
            }
            
        }
        
        
        
        
        if (self.segItemMode == OMSegmentedControlItemModeSlipeBottom){
            //给slipeView一个初始位置,这里需要通过selectedSegmentIndex确定初始位置，避免在self进行了tranform等操作后滑块的位置出错
            if(self.btnItems.count && self.selectedSegmentIndex < self.btnItems.count){
                UIButton *button = (UIButton *)self.btnItems[self.selectedSegmentIndex];
                self.slipeView.frame = CGRectMake(button.frame.origin.x, self.lastSelectedButton.frame.size.height - self.slipeHeight, self.lastSelectedButton.frame.size.width + self.borderWidth * 2, self.slipeHeight);
                [self.segScrollView bringSubviewToFront:self.slipeView];
            }
        }
        
        //默认选中用户指定索引的item，若用户未指定，那么默认选中第一个
        [self setSelectedSegmentIndex:self.selectedSegmentIndex];
        
    }
    
}



#pragma mark -- private method
//颜色值转图片
- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark -- setters

- (void)setSepImageName:(NSString *)sepImageName{
    _sepImageName = sepImageName;
    
    if (self.segMode == OMSegmentedControlModeShowMore) {
        self.leftImageView.image = [UIImage imageNamed:sepImageName];
    }
}

- (void)setMoreImageName:(NSString *)moreImageName{
    _moreImageName = moreImageName;
    
    if (self.segMode == OMSegmentedControlModeShowMore) {
        [self.moreButton setBackgroundImage:[UIImage imageNamed:moreImageName] forState:UIControlStateNormal];
    }
}

- (void)setBorderColor:(UIColor *)borderColor{
    
    _borderColor = borderColor;
    
    if(self.segItemMode != OMSegmentedControlItemModeSlipeBottom){
        self.layer.borderColor = borderColor.CGColor;
    }
    
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    
    _borderWidth = borderWidth;
    if(self.segItemMode != OMSegmentedControlItemModeSlipeBottom){
       self.layer.borderWidth = borderWidth;
        
    }
    
}

- (void)setBorderRadius:(CGFloat)borderRadius{
    _borderRadius = borderRadius;
    if(self.segItemMode != OMSegmentedControlItemModeSlipeBottom){
        self.layer.cornerRadius = borderRadius;
    }
    
}


- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex{
    _selectedSegmentIndex = selectedSegmentIndex;
    if (self.btnItems.count && selectedSegmentIndex < self.btnItems.count){
        UIButton *button = (UIButton *)self.btnItems[selectedSegmentIndex];
        [self itemAction:button];
    }
    
}

//未选中时的文字颜色
- (void)setNormalTextColor:(UIColor *)normalTextColor{
    
    _normalTextColor = normalTextColor;
    
    for (UIButton *button in self.btnItems) {
        [button setTitleColor:normalTextColor forState:UIControlStateNormal];
    }
}

//选中时的文字颜色
- (void)setSelectedTextColor:(UIColor *)selectedTextColor{
    
    _selectedTextColor = selectedTextColor;
    
    for (UIButton *button in self.btnItems) {
        [button setTitleColor:selectedTextColor forState:UIControlStateSelected];
        [button setTitleColor:selectedTextColor forState:UIControlStateHighlighted];
    }
}



//字体大小
- (void)setFont:(UIFont *)font{
    _font = font;
    
    if (self.btnItems.count) {
        for (UIButton *button in self.btnItems) {
            button.titleLabel.font = font;
        }
    }
    
}



//未选中时的背景颜色
- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor{
    _normalBackgroundColor = normalBackgroundColor;
    
    if(self.segItemMode == OMSegmentedControlItemModeBackgroundSelected){
        if (self.btnItems.count) {
            for (UIButton *button in self.btnItems) {
                [button setBackgroundImage:[self createImageWithColor:normalBackgroundColor] forState:UIControlStateNormal];
            }
        }
    }
    
}

//选中时的背景颜色
- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor{
    _selectedBackgroundColor = selectedBackgroundColor;
    
    if(self.segItemMode == OMSegmentedControlItemModeBackgroundSelected){
        if (self.btnItems.count) {
            for (UIButton *button in self.btnItems) {
                [button setBackgroundImage:[self createImageWithColor:selectedBackgroundColor] forState:UIControlStateSelected];
                [button setBackgroundImage:[self createImageWithColor:selectedBackgroundColor] forState:UIControlStateHighlighted];
            }
        }
    }
    
}



- (void)setSlipeColor:(UIColor *)slipeColor{
    _slipeColor = slipeColor;
    if (self.segItemMode == OMSegmentedControlItemModeSlipeBottom){
        self.slipeView.backgroundColor = slipeColor;
    }
    
}

- (void)setSlipeHeight:(CGFloat)slipeHeight{
    _slipeHeight = slipeHeight;
    
    if (self.segItemMode == OMSegmentedControlItemModeSlipeBottom){
        CGRect slipeRect = self.slipeView.frame;
        slipeRect.size.height = slipeHeight;
        self.slipeView.frame = slipeRect;
    }
    
}


- (void)setShowBottomBoder:(BOOL)showBottomBoder{
    _showBottomBoder = showBottomBoder;
    
    self.bottomBoderView.hidden = !showBottomBoder;
    
}


- (NSMutableArray <UIButton *> *)btnItems{
    if (_btnItems == nil) {
        _btnItems = [NSMutableArray array];
    }
    return _btnItems;
}


#pragma mark -- public method
- (void)setNormalBackgroundImage:(UIImage *)backgroundImage segmentIndex:(NSInteger)segmentIndex{
    UIButton *button = (UIButton *)self.btnItems[segmentIndex];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

- (void)setSelectedBackgroundImage:(UIImage *)backgroundImage segmentIndex:(NSInteger)segmentIndex{
    UIButton *button = (UIButton *)self.btnItems[segmentIndex];
    [button setBackgroundImage:backgroundImage forState:UIControlStateSelected];
}

- (void)editTitle:(NSString *)changedText index:(NSInteger)segmentIndex{
    
    if (self.btnItems.count && segmentIndex < self.btnItems.count) {
        UIButton *button = (UIButton *)self.btnItems[segmentIndex];
        [button setTitle:changedText forState:UIControlStateNormal];
        [self.btnItems replaceObjectAtIndex:segmentIndex withObject:button];
    }
    
}


- (void)items:(NSArray *)items key:(NSString *)key{
    
    self.items = nil;
    self.itemKey = nil;
    self.btnItems = nil;
    
    self.items = items;
    self.itemKey = key;
    
    
    for (NSInteger index = 0; index < items.count; index++) {
        
        NSString *itemName = key?items[index][key]:items[index];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[self createImageWithColor:self.normalBackgroundColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[self createImageWithColor:self.selectedBackgroundColor] forState:UIControlStateSelected];
        [button setTitle:itemName forState:UIControlStateNormal];
        [button setTitleColor:self.normalTextColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
        [button setTitleColor:self.selectedTextColor forState:UIControlStateHighlighted];
        button.titleLabel.font = self.font;
        button.tag = index;
        [button addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.segScrollView addSubview:button];
        
        [self.btnItems addObject:button];
        
        if (index == items.count - 1){
            [self.segScrollView insertSubview:self.bottomBoderView aboveSubview:button];
            [self.segScrollView bringSubviewToFront:self.slipeView];
        }
        
    }
    
    
    [self setNeedsLayout];
    
}

#pragma mark -- event response
- (void)itemAction:(UIButton *)button{
    
    if ([button isEqual:self.lastSelectedButton] || !button){
        return;
    }
    
    self.lastSelectedButton.selected = NO;
    button.selected = YES;
    self.lastSelectedButton = button;
        
    if (self.segItemMode == OMSegmentedControlItemModeSlipeBottom) {
        
        [UIView animateWithDuration:0.2 animations:^{
            CGFloat h = self.slipeHeight != 0?self.slipeHeight:defaultSlipeHeight;
            self.slipeView.bounds = CGRectMake(0, 0, button.bounds.size.width + self.borderWidth * 2, h);
            self.slipeView.center = CGPointMake(button.center.x, self.slipeView.center.y);
        }];
    }else{
        self.slipeView.hidden = YES;
    }
    
    
    
    //判断当前button是否在屏幕中央
    //TODO 点击按钮后若处于可互动模式那么按钮应自动居中

    if ([self.segmentControlDelegate respondsToSelector:@selector(segmentControl:didSelectSegmentIndex:)]) {
        _selectedSegmentIndex = button.tag;
        [self.segmentControlDelegate segmentControl:self didSelectSegmentIndex:button.tag];
    }
    
}


- (void)moreAction:(UIButton *)button{
    
    if (self.segMode == OMSegmentedControlModeShowMore) {
        if ([self.segmentControlDelegate respondsToSelector:@selector(didSelectMorePannelOfSegmentControl:)]){
            [self.segmentControlDelegate didSelectMorePannelOfSegmentControl:self];
        }
    }
    
}



@end
