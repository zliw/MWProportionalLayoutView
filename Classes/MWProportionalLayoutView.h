//
//  MWPartionedView.h
//  Costly
//
//  Created by martin on 06/05/14.
//  Copyright (c) 2014 Martin Wilz. All rights reserved.
//

#import <UIKit/UIKit.h>


/** values for the layout algorithm */
typedef enum MWProportionalLayoutMethod
{
    /** larger rectangles get positioned on the right side */
    MWProportionalLayoutRightSplit,
    /** larger rectangles get positioned on the left side */
    MWProportionalLayoutLeftSplit
} MWProportionalLayoutMethod;


/** a UIView subclass for managing the size and position of subview by
 a list of given weights. Currently only one hard-codec layout
 algorithm is available. To use this class use the method
 setSubviews:withWeights:
 */

@interface MWProportionalLayoutView : UIView

/** set this property to configure the layout algorithm. see `MWProportionalLayoutMethod` for values
 */
@property (assign) MWProportionalLayoutMethod layoutMethod;

/** set the subviews and their weights to be managed by this view.
 @param subviews a NSArray of UIView instances
 @param weights  a NSArray of NSNumbers. must be the same length as subviews. the ordering determines the view for the weight.
 */
- (void)setSubviews:(NSArray *)subviews withWeights:(NSArray *)weights;

@end
