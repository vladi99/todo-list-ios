//
//  TodoSectionController.m
//  todolist
//
//  Created by Vladimir Petrov on 15/03/2020.
//  Copyright © 2020 Vladimir Petrov. All rights reserved.
//

#import "TodoSectionController.h"
#import "TodoCell.h"
#import "DBManager.h"

@interface TodoCellController : NSObject

- (instancetype)initWithIndex:(NSInteger)index deleteCallback:(void (^)(NSInteger index)) deleteCallback;

- (void)didDelete;

@end

@implementation TodoCellController {
    NSInteger _index;
    void (^_deleteCallback)(NSInteger);
}

- (instancetype)initWithIndex:(NSInteger)index deleteCallback:(void (^)(NSInteger))deleteCallback {
    if (self = [super init]) {
        _index = index;
        _deleteCallback = deleteCallback;
    }
    return self;
}

- (void)didDelete {
    _deleteCallback(_index);
}

@end

@implementation TodoSectionController {
    NSArray *_todos;
    NSArray<TodoCellController *> *_cellControllers;
    NSArray<NSString *> *_properties;
}

- (instancetype)initWithTodos:(NSArray*)todos properties:(NSArray<NSString *> *)properties deleteCallback:(nonnull void (^)(NSInteger))deleteCallback {
    if (self = [super init]) {
        _todos = [todos copy];
        _properties = [properties copy];
        
        NSMutableArray *controllers = [NSMutableArray array];
        for (NSInteger i = 0; i < [_todos count]; ++i) {
            TodoCellController *controller = [[TodoCellController alloc] initWithIndex: i deleteCallback:deleteCallback];
            [controllers addObject:controller];
        }
        _cellControllers = controllers;
    }
    
    return self;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    return CGSizeMake(self.collectionContext.containerSize.width, 48);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    TodoCell *cell = [self.collectionContext dequeueReusableCellOfClass:[TodoCell class] forSectionController:self atIndex:index];
    
    NSInteger indexOfTitle = [_properties indexOfObject:@"title"];
    NSString *title = [[_todos objectAtIndex:index] objectAtIndex:indexOfTitle];
    
    cell.text = title;
    TodoCellController *controller = _cellControllers[index];
    [cell.deleteButton addTarget:controller action:@selector(didDelete) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NSInteger)numberOfItems {
    return [_todos count];
}

- (CGFloat)minimumLineSpacing {
    return 6;
}

@end
