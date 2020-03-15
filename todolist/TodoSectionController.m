//
//  TodoSectionController.m
//  todolist
//
//  Created by Vladimir Petrov on 15/03/2020.
//  Copyright © 2020 Vladimir Petrov. All rights reserved.
//

#import "TodoSectionController.h"
#import "TodoCell.h"

@implementation TodoSectionController {
    NSArray<NSString *> *_todos;
}

-(instancetype)initWithTodos:(NSArray<NSString *> *)todos {
    if (self = [super init]) {
        _todos = [todos copy];
    }
    
    return self;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 48);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    TodoCell *cell = [self.collectionContext dequeueReusableCellOfClass:[TodoCell class] forSectionController:self atIndex:index];
    cell.text = _todos[index];
    return cell;
}

- (NSInteger)numberOfItems {
    return [_todos count];
}

- (CGFloat)minimumLineSpacing {
    return 8;
}

@end
