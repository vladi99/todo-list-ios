//
//  TodoCell.m
//  todolist
//
//  Created by Vladimir Petrov on 15/03/2020.
//  Copyright © 2020 Vladimir Petrov. All rights reserved.
//

#import "TodoCell.h"
#import <YogaKit/UIView+Yoga.h>
#import "MaterialButtons.h"

@implementation TodoCell {
    UILabel *_label;
    MDCButton *_deleteButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor grayColor];

        _label = [[UILabel alloc] init];
        _label.text = @"Text";
        [self.contentView addSubview:_label];
        
        _deleteButton = [[MDCButton alloc] initWithFrame:CGRectZero];
        _deleteButton.layer.borderColor = [UIColor blackColor].CGColor;
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [self.contentView addSubview:_deleteButton];
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.flexDirection = YGFlexDirectionRow;
    }];
    
    [_label configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
        layout.margin = YGPointValue(8);
        layout.flexGrow = 1;
    }];
    
    [_deleteButton configureLayoutWithBlock:^(YGLayout * _Nonnull layout) {
        layout.isEnabled = YES;
    }];
    
    [self.contentView.yoga applyLayoutPreservingOrigin:YES];
}

- (void)setText:(NSString *)text {
    _label.text = text;
}

@end
