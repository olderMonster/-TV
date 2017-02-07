//
//  OMTextField.m
//  战旗TV
//
//  Created by 印聪 on 2017/1/11.
//  Copyright © 2017年 monster. All rights reserved.
//

#import "OMTextField.h"
#import <objc/runtime.h>
@interface OMTextField()<UITextFieldDelegate>

@property (nonatomic , strong)UITextField *inputField;
@property (nonatomic , strong)UIView *bottomLineView;

@property (nonatomic , assign)OMTextFieldType type;

@end

@implementation OMTextField
@synthesize text = _text;

- (instancetype)initWithType:(OMTextFieldType)type{
    self = [super init];
    if (self) {
        
        self.normalBorderColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:249/255.0 alpha:1.0];
        self.selctedBorderColor = [UIColor colorWithRed:88/255.0 green:195/255.0 blue:252/255.0 alpha:1.0];
        self.borderWidth = 1.0f;
        self.borderRadius = 2.0f;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderFont = self.font;
        self.type = type;
        
        _inputField = [[UITextField alloc] init];
        _inputField.font = self.font;
        _inputField.delegate = self;
        [self addSubview:_inputField];
        
        _bottomLineView = [[UIView alloc]init];
        _bottomLineView.hidden = YES;
        [self addSubview:_bottomLineView];
        
        if (self.type == OMTextFieldTypeBoderSelected) {
            _inputField.layer.masksToBounds = YES;
            _inputField.layer.cornerRadius = self.borderRadius;
            _inputField.layer.borderColor = self.normalBorderColor.CGColor;
            _inputField.layer.borderWidth = self.borderWidth;
        }
        
        if (self.type == OMTextFieldTypeBottomBoderSelected) {
            
            _bottomLineView.hidden = NO;
            _bottomLineView.backgroundColor = self.normalBorderColor;
        }
        
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.leftView) {
        
        CGRect leftViewRect = self.leftView.frame;
        if (leftViewRect.size.height > self.bounds.size.height) {
            leftViewRect.size.width = self.bounds.size.width * leftViewRect.size.height / self.bounds.size.height;
            self.leftView.frame = CGRectMake(0, 0, leftViewRect.size.width, self.bounds.size.height);
        }else{
            self.leftView.frame = CGRectMake(0, self.bounds.size.height * 0.5 - leftViewRect.size.height * 0.5, leftViewRect.size.width, leftViewRect.size.height);
        }
        
        self.inputField.frame = CGRectMake(leftViewRect.size.width + 5, 0, self.bounds.size.width - (leftViewRect.size.width + 5), self.bounds.size.height);
    }else{
        self.inputField.frame = self.bounds;
    }
    
    self.bottomLineView.frame = CGRectMake(0, self.bounds.size.height - self.borderWidth, self.bounds.size.width, self.borderWidth);
}

#pragma makr -- Event response
- (void)getFirstResponder{
    if (self.type == OMTextFieldTypeBoderSelected) {
        self.inputField.layer.borderColor = self.selctedBorderColor.CGColor;
    }
    if (self.type == OMTextFieldTypeBottomBoderSelected) {
        self.bottomLineView.backgroundColor = self.selctedBorderColor;
    }
    
}

- (void)loseFirstResponder{
    
    if (self.type == OMTextFieldTypeBoderSelected) {
        self.inputField.layer.borderColor = self.normalBorderColor.CGColor;
    }
    if (self.type == OMTextFieldTypeBottomBoderSelected) {
        self.bottomLineView.backgroundColor = self.normalBorderColor;
    }
}


#pragma mark -- UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self getFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self loseFirstResponder];
}


#pragma mark -- getters and setters
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.inputField.placeholder = placeholder;
}

- (void)setText:(NSString *)text{
    _text = text;
    self.inputField.text = text;
}

- (NSString *)text{
    return self.inputField.text;
}


- (void)setFont:(UIFont *)font{
    _font = font;
    self.inputField.font = font;
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    _placeholderFont = placeholderFont;
    [self.inputField setValue:[UIFont systemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self.inputField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
}


- (void)setLeftView:(UIView *)leftView{
    _leftView = leftView;
    
    [self addSubview:leftView];
    
}

@end
