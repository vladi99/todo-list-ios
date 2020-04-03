//
//  TodoSectionController.h
//  todolist
//
//  Created by Vladimir Petrov on 15/03/2020.
//  Copyright © 2020 Vladimir Petrov. All rights reserved.
//

#import <IGListKit/IGListKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TodoSectionController : IGListSectionController

-(instancetype)initWithTodos:(NSArray*)todos properties:(NSArray<NSString *> *)properties deleteCallback:(void (^)(NSInteger index))deleteCallback;

@end

NS_ASSUME_NONNULL_END
