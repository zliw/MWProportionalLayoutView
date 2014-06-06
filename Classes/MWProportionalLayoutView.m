//
//  MWPartionedView.m
//  Costly
//
//  Created by martin on 06/05/14.
//  Copyright (c) 2014 Martin Wilz. All rights reserved.
//

#import "MWProportionalLayoutView.h"

@interface MWProportionalLayoutView()

@property (strong, nonatomic) NSMutableArray *sortedViews;
@property (strong, nonatomic) NSMutableArray *weights;

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

    // I'm going through some pain here to sort two arrays in sync.
    // Another way would be to force the user of this class to use
    // objects conforming to a protocol, so the weight can be read
    // from the object. Also I cannot use dictionaries, but the views
    // would have to conform to NSCopying, which is not the case
    // for the system views (probably with a reason).

    NSMutableArray *sortIndexes = [NSMutableArray arrayWithCapacity:newViews.count];

    for (NSUInteger i = 0 ; i < newViews.count ; i++) {
        [sortIndexes addObject:[NSNumber numberWithInteger:i]];
    }

    [sortIndexes sortedArrayUsingComparator:(NSComparisonResult (^)(id,id))^(NSNumber *obj1, NSNumber *obj2){
        return [weights[obj1.intValue] compare:weights[obj2.intValue]];
    }];

    self.sortedViews = [NSMutableArray arrayWithCapacity:newViews.count];
    self.weights = [NSMutableArray arrayWithCapacity:newViews.count];

    for (NSNumber *index in sortIndexes) {
        [self.weights addObject:[weights objectAtIndex:index.intValue]];
        [self.sortedViews addObject:[newViews objectAtIndex:index.intValue]];
    }

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

    for (NSUInteger index = 0; index < self.sortedViews.count; index++) {
        UIView *view = self.sortedViews[index];
        CGFloat percentageOfCategory = ((NSNumber *)self.weights[index]).doubleValue;

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
