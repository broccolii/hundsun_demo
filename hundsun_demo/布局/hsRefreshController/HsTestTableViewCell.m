//
//  HsTestTableViewCell.m
//  HsDefindViewDemo
//
//  Created by 王金东 on 14-7-26.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import "HsTestTableViewCell.h"

@implementation HsTestTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setDataInfo:(id)dataInfo{
    self.textLabel.text = dataInfo;
    self.imageView.image = [UIImage imageNamed:@"Icon114.png"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
