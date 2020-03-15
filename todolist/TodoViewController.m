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
#import "MaterialDialogs.h"
#import "MaterialTextFields.h"

@interface TodoViewController ()<IGListAdapterDataSource, UITextViewDelegate>
    @property(nonatomic) MDCDialogTransitionController *dialogTransitionController;
    @property(nonatomic) MDCTextInputControllerUnderline *textFieldController;
@end

@implementation TodoViewController {
    IGListAdapter *_adapter;
    NSArray<NSString *> *_todos;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _todos = [NSArray array];
        UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
        self.navigationItem.rightBarButtonItem = add;
    }
    
    return self;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Todos";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - IGListAdapterDataSource

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[[[NSDate date] description]];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    return [[TodoSectionController alloc] initWithTodos:_todos];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

# pragma mark private method

-(void) add {
    MDCAlertController *alertController =
    [MDCAlertController alertControllerWithTitle:@"Add todo"
                                         message:nil];

    MDCMultilineTextField *textField = [[MDCMultilineTextField alloc] init];
    textField.placeholder = @"Name";
    textField.textView.delegate = self;

    self.textFieldController = [[MDCTextInputControllerUnderline alloc] initWithTextInput:textField];
    _textFieldController.floatingEnabled = NO;

    alertController.accessoryView = textField;
    
    __weak typeof(self) weakSelf = self;
    MDCAlertAction *alertAction =
        [MDCAlertAction actionWithTitle:@"OK"
                                handler:^(MDCAlertAction *action) {
            typeof(self) strongSelf = weakSelf;
            if(!strongSelf) {
                return;
            }
            
            NSArray *newTodos = [strongSelf->_todos arrayByAddingObject:textField.text];
            strongSelf->_todos = newTodos;
            [strongSelf updateTodos];
        }];

    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) updateTodos {
    [_adapter performUpdatesAnimated:YES completion:nil];
}

@end
