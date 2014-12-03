//
//  HsBaseFetchedResults.h
//  hospitalcloud_sc
//  用法：只需要使用NSManagedObject的insertEntity:fetchedResults:、deleteEntityWithFetchedResults、updateEntity:fetchedResults、queryEntityWithPredicate:fetchedResults 方法即可完成object的增删改查

//  可继承HsBaseFetchedResults对方法进行重写，增加些许业务逻辑
//  在applicationWillTerminate 调用 [[HsBaseFetchedResults shareInstance] saveContext];
//  Created by 王金东 on 14-10-27.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HsBaseFetchedResults : NSObject

+ (instancetype)shareInstance;

@property (nonatomic,assign) id<NSFetchedResultsControllerDelegate> delegate;

//获取NSManagedObjectContext对象
@property (readonly,nonatomic,strong) NSManagedObjectContext *managedObjectContext;
//排序条件
@property (nonatomic,strong) NSArray *sortDescriptors;
//控制器 显示出查询的数据
@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

//coreData 文件名称
@property (nonatomic,strong) NSString *momdName;

//数据库名称
@property (nonatomic,strong) NSString *sqliteName;

//实体名称
@property (nonatomic,strong) NSString *entityName;


#pragma mark ---方法--可重写，不过要调用super的方法-

//插入一个实体
- (void)insertEntity:(NSDictionary *)entityDic;

//插入多个实体
- (void)insertEntitys:(NSArray *)entityArray;

//删除
- (void)deleteEntity:(NSManagedObject *)entity;

//修改实体
- (void)updateEntity:(NSManagedObject *)entity  forInfoDic:(NSDictionary *)entityDic;

//带上条件 查询实体
- (NSArray *)queryEntityWithPredicate:(NSPredicate *)predicate;


- (void)saveContext;

//清除 推送对象
-(void)cleanContext;

@end


@interface NSManagedObject (coredate_sql)

//插入一个实体
+ (void)insertEntity:(NSDictionary *)entityDic fetchedResults:(HsBaseFetchedResults *)fetchedResults;

//插入多个实体
+ (void)insertEntitys:(NSArray *)entityArray fetchedResults:(HsBaseFetchedResults *)fetchedResults;

//删除
- (void)deleteEntityWithFetchedResults:(HsBaseFetchedResults *)fetchedResults;

//修改实体
- (void)updateEntity:(NSDictionary *)entityDic fetchedResults:(HsBaseFetchedResults *)fetchedResults;

//带上条件 查询实体
- (NSArray *)queryEntityWithPredicate:(NSPredicate *)predicate fetchedResults:(HsBaseFetchedResults *)fetchedResults;

@end
