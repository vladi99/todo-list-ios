//
//  TodoViewController.m
//  todolist
//
//  Created by Vladimir Petrov on 15/03/2020.
//  Copyright © 2020 Vladimir Petrov. All rights reserved.
//

#import "TodoViewController.h"
#import "TodoSectionController.h"
#import <IGListKit/IGListKit.h>

@interface TodoViewController ()<IGListAdapterDataSource>
    
@end

@implementation TodoViewController {
    IGListAdapter *_adapter;
}

- (void)loadView {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    IGListAdapter *adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    adapter.collectionView = collectionView;
    adapter.dataSource = self;
    _adapter = adapter;
    
    self.view  = collectionView;
}


#pragma mark - IGListAdapterDataSource

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [[TodoSectionController alloc] init];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

@end
