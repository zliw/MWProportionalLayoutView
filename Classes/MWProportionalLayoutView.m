//
//  MWPartionedView.m
//  Costly
//
//  Created by martin on 06/05/14.
//  Copyright (c) 2014 Martin Wilz. All rights reserved.
//

#import "MWProportionalLayoutView.h"

@interface MWProportionalLayoutView()

@property (strong, nonatomic) NSDictionary      *subviewDictionary;
@property (strong, nonatomic) NSArray           *sortedViews;
@property (strong, nonatomic) NSArray           *weights;

@end

@implementation MWProportionalLayoutView

- (void)setSubviews:(NSArray *)newViews withWeights:(NSArray *)weights;

{
    NSAssert(newViews.count == weights.count, @"subviews array size should be equal to weights size");

    self.sortedViews = nil;

    // remove old subviews not in new views
    for (UIView *view in self.subviews) {
        if ([newViews indexOfObject:view] == NSNotFound) {
          [view removeFromSuperview];
        }
    }

    // add new views not in subview array
    for (UIView *newView in newViews) {
        if ([self.subviews indexOfObject:newViews] == NSNotFound) {
            [self addSubview:newView];
        }
    }

    self.sortedViews = newViews;

    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // filter out calls triggered by addSubview
    if (! self.sortedViews) return;

    CGFloat addupPercentage = 0;
    CGRect currentRect = self.frame;
    CGRect slice;
    CGRect remainder;

    for (UIView *view in self.sortedViews) {
        CGFloat percentageOfCategory = ((NSNumber *)[self.subviewDictionary objectForKey:view]).doubleValue;

        CGSize size = currentRect.size;
        CGFloat slicePercentage = percentageOfCategory / ((100 - addupPercentage) / 100);

        // if rectangle is heigher than wide
        if (size.height > size.width) {
            CGRectDivide(currentRect, &slice, &remainder, currentRect.size.height * slicePercentage / 100, CGRectMinYEdge);
        }
        else {
            CGRectDivide(currentRect, &slice, &remainder, currentRect.size.width * slicePercentage / 100, CGRectMaxXEdge);
        }

        view.frame = slice;
        currentRect = remainder;
        addupPercentage += percentageOfCategory;
    }

    [super layoutSubviews];
}

@end
