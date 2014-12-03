//
//  HsBaseFetchedResults.m
//  hospitalcloud_sc
//
//  Created by 王金东 on 14-10-27.
//  Copyright (c) 2014年 chenjiong. All rights reserved.
//

#import "HsBaseFetchedResults.h"

static  HsBaseFetchedResults *_instance;

@interface HsBaseFetchedResults ()

@property (readonly,strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation HsBaseFetchedResults

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;



+ (instancetype)shareInstance{
    @synchronized(self){
        if (_instance == nil) {
            _instance = [[HsBaseFetchedResults alloc] init];
        }
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self){
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    }
    return _instance;
}

//插入一个实体
- (void)insertEntity:(NSDictionary *)entityDic{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    NSManagedObject *object = [self buildManagedObjectByName:self.entityName];
    //赋值
    NSArray *allKeys = [entityDic allKeys];
    for (NSString *key in allKeys) {
        id value = entityDic[key];
        @try {
            [object setValue:value forKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception name]);
        }
    }
    //保存
    if (![context save:&error]) {
        NSLog(@"Unresolved insert error %@, %@", error, [error userInfo]);
        abort();
    }
}

//插入多个实体
- (void)insertEntitys:(NSArray *)entityArray{
    for(NSDictionary *entityDic in entityArray){
        [self insertEntity:entityDic];
    }    
}

//删除
- (void)deleteEntity:(NSManagedObject *)entity{
    [self.managedObjectContext deleteObject:entity];
    // 保存数据，持久化存储
    NSError *error =nil;
    if (![self.managedObjectContext save:&error]) {
       NSLog(@"Unresolved delete error %@, %@", error, [error userInfo]);
    }
}

//修改实体
- (void)updateEntity:(NSManagedObject *)entity  forInfoDic:(NSDictionary *)entityDic{
    //赋值
    NSArray *allKeys = [entityDic allKeys];
    for (NSString *key in allKeys) {
        id value = entityDic[key];
        @try {
            [entity setValue:value forKey:key];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",[exception name]);
        }
    }
    //保存
    NSManagedObjectContext *context = self.managedObjectContext;
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved update error %@, %@", error, [error userInfo]);
        abort();
    }
}

//带上条件 查询实体
- (NSArray *)queryEntityWithPredicate:(NSPredicate *)predicate{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Set the batch size to a suitable number.
    //[fetchRequest setFetchBatchSize:20];
    [fetchRequest setPredicate:predicate];
    NSError *error = nil;
    return [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

#pragma mark ------以下是初始化-我是分割线-查询到controller-------
- (NSFetchedResultsController *)fetchedResultsController{
    if (_fetchedResultsController != nil){
        return _fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    // Edit the sort key as appropriate.
    if(self.sortDescriptors != nil){
        [fetchRequest setSortDescriptors:self.sortDescriptors];
    }
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    //aFetchedResultsController.delegate = self;
    _fetchedResultsController = aFetchedResultsController;
    if (self.delegate != nil) {
        _fetchedResultsController.delegate = self.delegate;
    }
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    return aFetchedResultsController;
}


//设置委托
- (void)setDelegate:(id<NSFetchedResultsControllerDelegate>)delegate{
    if (_delegate != delegate) {
        _delegate = delegate;
        if (_fetchedResultsController != nil) {
             _fetchedResultsController.delegate = _delegate;
        }
    }
}

- (NSManagedObject *) buildManagedObjectByName:(NSString *)className
{
    NSManagedObject *_object = nil;
    _object = [NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:self.managedObjectContext];
    return _object;
}

- (NSManagedObject *)buildManagedObjectByClass:(Class)theClass
{
    NSManagedObject *_object = nil;
    _object = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(theClass) inManagedObjectContext:self.managedObjectContext];
    return _object;
}



#pragma mark   -- 获取NSManagedObjectContext对象 阻塞------------
- (NSString *)sqliteName{
    if (_sqliteName == nil) {
        NSString* userId = HsUserConfig.userId;
        if (!userId) {
            return nil;
        }
        userId = [userId stringByAppendingString:@".sqlite"];
        _sqliteName = userId;
    }
    return _sqliteName;
}
- (NSManagedObjectContext *)managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.momdName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.sqliteName];
    NSError *error = nil;
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption,
                                       [NSNumber numberWithBool:YES],
                                       NSInferMappingModelAutomaticallyOption, nil];
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:optionsDictionary error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

#pragma mark  ---------------------context------------------------
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//清除 推送对象
-(void)cleanContext{
    _managedObjectContext = nil;
    _managedObjectModel = nil;
    _persistentStoreCoordinator = nil;
}

//获取用户使用目录
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end



#pragma mark ------------我是分隔线-----------------
@implementation NSManagedObject (coredate_sql)

//插入一个实体
+ (void)insertEntity:(NSDictionary *)entityDic fetchedResults:(HsBaseFetchedResults *)fetchedResults{
    if (fetchedResults == nil) {
        fetchedResults = [HsBaseFetchedResults shareInstance];
    }
    fetchedResults.entityName = NSStringFromClass(self.class);
    [fetchedResults insertEntity:entityDic];
}

//插入多个实体
+ (void)insertEntitys:(NSArray *)entityArray fetchedResults:(HsBaseFetchedResults *)fetchedResults{
    for (NSDictionary *entityDic in entityArray) {
        [self insertEntity:entityDic fetchedResults:fetchedResults];
    }
}

//删除
- (void)deleteEntityWithFetchedResults:(HsBaseFetchedResults *)fetchedResults{
    if (fetchedResults == nil) {
        fetchedResults = [HsBaseFetchedResults shareInstance];
    }
    [fetchedResults deleteEntity:self];
}

//修改实体
- (void)updateEntity:(NSDictionary *)entityDic fetchedResults:(HsBaseFetchedResults *)fetchedResults{
    if (fetchedResults == nil) {
        fetchedResults = [HsBaseFetchedResults shareInstance];
    }
    [fetchedResults updateEntity:self forInfoDic:entityDic];
}

//带上条件 查询实体
- (NSArray *)queryEntityWithPredicate:(NSPredicate *)predicate fetchedResults:(HsBaseFetchedResults *)fetchedResults{
    if (fetchedResults == nil) {
        fetchedResults = [HsBaseFetchedResults shareInstance];
    }
   fetchedResults.entityName = NSStringFromClass(self.class);
   return [fetchedResults queryEntityWithPredicate:predicate];
}

@end
