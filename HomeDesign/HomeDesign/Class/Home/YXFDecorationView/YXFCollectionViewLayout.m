//
//  YXFCollectionViewLayout.m
//  HomeDesign
//
//  Created by 杨晓芬 on 15/11/23.
//  Copyright © 2015年 四川青创智和网络科技有限公司. All rights reserved.
//

#import "YXFCollectionViewLayout.h"

static NSString *kDecorationReuserIdentifier = @"section_background";

@implementation YXFCollectionViewLayout

+ (Class)layoutAttributesClass
{
    return [YXFCollectionViewLayoutAttributes class];
}

- (void)prepareLayout{
    [super prepareLayout];
    [self registerClass:[YXFCollectionReusableView class] forDecorationViewOfKind:kDecorationReuserIdentifier];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:attributes];
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        
        // Look for the first item in a row
        if (attribute.representedElementKind == UICollectionElementCategoryCell
            && attribute.frame.origin.x == self.sectionInset.left) {
            
            // Create decoration attributes
            YXFCollectionViewLayoutAttributes *decorationAttributes =
            [YXFCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationReuserIdentifier
                                                                        withIndexPath:attribute.indexPath];
            // Make the decoration view span the entire row (you can do item by item as well.  I just
            // chose to do it this way)
            decorationAttributes.frame =
            CGRectMake(0,
                       attribute.frame.origin.y-(self.sectionInset.top),
                       self.collectionViewContentSize.width,
                       self.itemSize.height+(self.minimumLineSpacing+self.sectionInset.top+self.sectionInset.bottom));
            
            // Set the zIndex to be behind the item
            decorationAttributes.zIndex = attribute.zIndex-1;
            
            // Add the attribute to the list
            [allAttributes addObject:decorationAttributes];
        }
    }
    return allAttributes;
}

@end


@implementation YXFCollectionViewLayoutAttributes
+ (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind withIndexPath:(nonnull NSIndexPath *)indexPath
{
    YXFCollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    NSLog(@"???????????????????????%ld", (long)indexPath.section);
    if (indexPath.section == 2) {
        layoutAttributes.color = [RGBColor colorWithHexString:@"#3c3c3c"];
    }
    return layoutAttributes;
}

- (id)copyWithZone:(NSZone *)zone
{
    YXFCollectionViewLayoutAttributes *newAttributes = [super copyWithZone:zone];
    newAttributes.color = [self.color copyWithZone:zone];
    return newAttributes;
}

@end


@implementation YXFCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    YXFCollectionViewLayoutAttributes *ecLayoutAttributes = (YXFCollectionViewLayoutAttributes*)layoutAttributes;
    self.backgroundColor = ecLayoutAttributes.color;
}

@end