//
//  RightCollectionViewCell.m
//  XLSlideMenuExample
//
//  Created by MengXianLiang on 2017/5/10.
//  Copyright © 2017年 MengXianLiang. All rights reserved.
//

#import "RightCollectionViewCell.h"

@implementation RightCollectionViewCell{
    UILabel *_titleLabel;
    UITextView *_textView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}


-(void)buildUI{
    
    self.layer.borderWidth = 1.50f;
    self.layer.cornerRadius = 5.0f;
    self.layer.borderColor = [UIColor colorWithRed:209/255.0f green:213/255.0f blue:218/255.0f alpha:1].CGColor;
    
    CGFloat titleHeight = 30.0f;
    CGFloat margin = 8.0f;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, margin, self.bounds.size.width - 2*margin, titleHeight)];
    _titleLabel.textColor = [UIColor colorWithRed:3/255.0f green:102/255.0f blue:214/255.0f alpha:1];
    [self.contentView addSubview:_titleLabel];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(margin, titleHeight + 2*margin, self.bounds.size.width - 2*margin, self.bounds.size.height - titleHeight - 3*margin)];
    _textView.editable = false;
    _textView.textColor = [UIColor colorWithRed:88/255.0f green:96/255.0f blue:105/255.0f alpha:1];
    [self.contentView addSubview:_textView];
}

-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

-(void)setSubTitle:(NSString *)subTitle{
    _textView.text = subTitle;
}

@end
