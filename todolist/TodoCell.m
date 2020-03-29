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
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.10];

        _label = [[UILabel alloc] init];
        _label.text = @"Text";
        [self.contentView addSubview:_label];

        _deleteButton = [[MDCButton alloc] initWithFrame:CGRectZero];
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        _deleteButton.backgroundColor = [UIColor grayColor];
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
