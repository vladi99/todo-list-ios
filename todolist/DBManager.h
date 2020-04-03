//
//  DBManager.h
//  todolist
//
//  Created by Vladimir Petrov on 03/04/2020.
//  Copyright © 2020 Vladimir Petrov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

@property (nonatomic, strong, nullable) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

-(instancetype)initWithDatabaseFileName:(NSString *)dbFilename;
-(NSArray *)loadDataFromDB:(NSString *)query;
-(void)executeQuery:(NSString *)query;

@end

NS_ASSUME_NONNULL_END
