//
//  HsBaseTableViewCell.m
//  HsDefindViewDemo
//
//  Created by 王金东 on 14-7-25.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsBaseTableViewCell.h"



 NSString *const HsCellKeyForImageView = @"image";
 NSString *const HsCellKeyForTitleView = @"title";
 NSString *const HsCellKeyForDetailView = @"detail";

 NSString *const HsCellColorForTitleView = @"titleColor";
 NSString *const HsCellFontForTitleView = @"titleFont";

 NSString *const HsCellColorForDetailView = @"detailColor";
 NSString *const HsCellFontForDetailView = @"detailFont";



 NSString *const HsCellKeySelectedBlock = @"onSelected";

@implementation HsBaseTableViewCell

+ (instancetype)sharedInstance{
    static HsBaseTableViewCell *cell;
    if (cell!= nil) {
        return cell;
    }
    @synchronized(self) {
        cell = [[HsBaseTableViewCell alloc] init];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       self.keyForImageView = HsCellKeyForImageView;
       self.keyForTitleView = HsCellKeyForTitleView;
       self.keyForDetailView = HsCellKeyForDetailView;
    }
    return self;
}

- (void)setKeyForTitleView:(NSString *)keyForTitleView{
    if(keyForTitleView != nil){
        _keyForTitleView = keyForTitleView;
    }
}

- (void)setKeyForImageView:(NSString *)keyForImageView{
    if(keyForImageView != nil){
        _keyForImageView = keyForImageView;
    }
}
- (void)setKeyForDetailView:(NSString *)keyForDetailView{
    if(keyForDetailView != nil){
        _keyForDetailView = keyForDetailView;
    }
}

- (CGFloat)baseTableView:(UITableView *)tableView cellInfo:(id)dataInfo{
    return 44.0f;
}

- (void)setDataInfo:(id)dataInfo{
    _dataInfo = dataInfo;
    if(self.dataInfo != nil){
        //渲染数据源
        if([self.dataInfo isKindOfClass:[NSString class]]){
            self.textLabel.text = self.dataInfo;
        }else if([self.dataInfo isKindOfClass:[NSDictionary class]]){
            NSDictionary *dic = self.dataInfo;
            NSString *image = dic[self.keyForImageView];
            if([image isKindOfClass:[NSString class]]){
                self.imageView.image = [UIImage imageNamed:image];
            }
            NSString *title = dic[self.keyForTitleView];
            if(title.length > 0){
                self.textLabel.text = title;
            }
            NSString *detail = dic[self.keyForDetailView];
            if(detail.length > 0){
                self.detailTextLabel.text = detail;
            }
            //样式设置
            UIColor *titleColor = dic[HsCellColorForTitleView];
            UIFont *titleFont = dic[HsCellFontForTitleView];
            if(titleColor != nil){
                self.textLabel.textColor = titleColor;
            }
            if(titleFont != nil){
                self.textLabel.font = titleFont;
            }
            
            UIColor *detailColor = dic[HsCellColorForDetailView];
            UIFont *detailfont = dic[HsCellFontForDetailView];
            if(detailColor != nil){
                self.detailTextLabel.textColor = detailColor;
            }
            if(detailfont != nil){
                self.detailTextLabel.font = detailfont;
            }
            
        }
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


/**
 ** 为了cell构造数据源方便 增加NSDictionary的Category
 **/
@implementation NSDictionary (celldatainfo)

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName detail:(NSString *)detail selected:(OnSelectedRowBlock)block{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:title forKey:HsCellKeyForTitleView];
    [dic setValue:imageName forKey:HsCellKeyForImageView];
    [dic setValue:detail forKey:HsCellKeyForDetailView];
    [dic setValue:block forKey:HsCellKeySelectedBlock];
    return dic;
}

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName detail:(NSString *)detail{
    return [self title:title imageName:imageName detail:detail selected:nil];
}

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName{
    return [self title:title imageName:imageName detail:nil];
}

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName selected:(OnSelectedRowBlock)block{
    return [self title:title imageName:imageName detail:nil selected:block];
}

+ (instancetype)title:(NSString *)title detail:(NSString *)detail selected:(OnSelectedRowBlock)block{
    return [self title:title imageName:nil detail:detail selected:block];
}

+ (instancetype)title:(NSString *)title selected:(OnSelectedRowBlock)block{
    return [self title:title imageName:nil detail:nil selected:block];
}

+ (instancetype)title:(NSString *)title detail:(NSString *)detail{
    return [self title:title imageName:nil detail:detail];
}

+ (instancetype)title:(NSString *)title{
    return [self title:title imageName:nil];
}

@end
