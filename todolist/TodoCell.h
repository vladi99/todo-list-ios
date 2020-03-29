//
//  TodoCell.h
//  todolist
//
//  Created by Vladimir Petrov on 15/03/2020.
//  Copyright © 2020 Vladimir Petrov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialCards.h"
#import "MaterialButtons.h"

NS_ASSUME_NONNULL_BEGIN

@interface TodoCell : MDCCardCollectionCell

@property(nonatomic) NSString *text;
@property(nonatomic, readonly) MDCButton *deleteButton;

@end

NS_ASSUME_NONNULL_END
