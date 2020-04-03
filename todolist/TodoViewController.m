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
#import "DBManager.h"

@interface TodoViewController ()<IGListAdapterDataSource, UITextViewDelegate>

@property(nonatomic) MDCDialogTransitionController *dialogTransitionController;
@property(nonatomic) MDCTextInputControllerUnderline *textFieldController;
@property(nonatomic, strong) DBManager *dbManager;

-(void)loadData;

@end

@implementation TodoViewController {
    IGListAdapter *_adapter;
    NSArray *_todos;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
        self.navigationItem.rightBarButtonItem = add;
        self.navigationItem.title = @"Todos";
        
        self.dbManager = [[DBManager alloc] initWithDatabaseFileName:@"todolistdb.sql"];
        [self loadData];
    }
    
    return self;
}

- (void)loadView {
    IGListAdapterUpdater *updater = [[IGListAdapterUpdater alloc] init];
    IGListAdapter *adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor =[UIColor whiteColor];
    
    adapter.collectionView = collectionView;
    adapter.dataSource = self;
    _adapter = adapter;
    
    self.view  = collectionView;
}

-(void)loadData{
    NSString *query = @"select * from todos";

    if (_todos != nil) {
        _todos = nil;
    }
    _todos = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];

    [self updateTodos];
}

#pragma mark - IGListAdapterDataSource

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return @[ @([NSDate timeIntervalSinceReferenceDate]) ];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    __weak typeof(self) weakSelf = self;
    return [[TodoSectionController alloc] initWithTodos:_todos properties:self.dbManager.arrColumnNames deleteCallback:^(NSInteger index) {
        [weakSelf deleteItem:index];
    }];
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
        [MDCAlertAction actionWithTitle:@"Add TODO"
                                handler:^(MDCAlertAction *action) {
            typeof(self) strongSelf = weakSelf;
            if(!strongSelf) {
                return;
            }

            NSString *query = [NSString stringWithFormat:@"insert into todos values(null, '%@')", textField.text];
            [self.dbManager executeQuery:query];
            [self loadData];
        }];
    [alertController addAction:alertAction];

    MDCAlertAction *cancelAction = [MDCAlertAction actionWithTitle:@"Cancel" emphasis:MDCActionEmphasisMedium handler:^(MDCAlertAction *action) {}];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) deleteItem:(NSInteger)index {
    int recordIDToDelete = [[[_todos objectAtIndex:index] objectAtIndex:0] intValue];

    NSString *query = [NSString stringWithFormat:@"delete from todos where todoID=%d", recordIDToDelete];
    [self.dbManager executeQuery:query];
    [self loadData];
}

-(void) updateTodos {
    [_adapter performUpdatesAnimated:YES completion:nil];
}

@end
