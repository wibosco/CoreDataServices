//
//  CDEUserTableViewCell.m
//  CoreDataServicesiOSExample
//
//  Created by William Boles on 15/01/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "CDEUserTableViewCell.h"

#import <PureLayout/PureLayout.h>

static CGFloat const kCDEPadding = 28.0f;

@interface CDEUserTableViewCell ()

@property (nonatomic, strong, readwrite) UILabel *nameLabel;
@property (nonatomic, strong, readwrite) UILabel *ageLabel;

@end

@implementation CDEUserTableViewCell

#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.ageLabel];
    }
    
    return self;
}

#pragma mark - Subviews

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [UILabel newAutoLayoutView];
        _nameLabel.font = [UIFont fontWithName:@"HelveticaNeue"
                                          size:15.0f];
    }
    
    return _nameLabel;
}

- (UILabel *)ageLabel
{
    if (!_ageLabel)
    {
        _ageLabel = [UILabel newAutoLayoutView];
        _ageLabel.font = [UIFont fontWithName:@"HelveticaNeue"
                                         size:11.0f];
    }
    
    return _ageLabel;
}

#pragma mark - Autolayout

- (void)updateConstraints
{
    [super updateConstraints];
    
    /*-------------------------*/
    
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                     withInset:kCDEPadding];
    
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeTop
                                     withInset:4.0f];
    
    [self.nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight
                                     withInset:kCDEPadding];
    
    /*-------------------------*/
    
    [self.ageLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                    withInset:kCDEPadding];
    
    [self.ageLabel autoPinEdge:ALEdgeTop
                        toEdge:ALEdgeBottom
                        ofView:self.nameLabel];
    
    [self.ageLabel autoPinEdgeToSuperviewEdge:ALEdgeRight
                                    withInset:kCDEPadding];
    
    [self.ageLabel autoSetDimension:ALDimensionHeight
                             toSize:15.0f];
    
    /*-------------------------*/
}

#pragma mark - Identifier

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

#pragma mark - Layout

- (void)layoutByApplyingConstraints
{
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
