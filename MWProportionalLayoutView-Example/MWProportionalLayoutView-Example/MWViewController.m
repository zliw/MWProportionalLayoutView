//
//  MWViewController.m
//  MWProportionalLayoutView-Example
//
//  Created by martin on 06/06/14.
//  Copyright (c) 2014 Martin Wilz. All rights reserved.
//

#import "MWViewController.h"
#import "MWProportionalLayoutView.h"

@interface MWViewController ()

@property (weak, nonatomic) IBOutlet MWProportionalLayoutView *layoutView;
@property (strong, nonatomic) NSMutableArray *buttons;

@end

@implementation MWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *titles = @[@"50%", @"25%", @"12.5%", @"6.25%", @"6.25%"];

    NSMutableArray *percentages = [NSMutableArray arrayWithCapacity:titles.count];
    CGFloat value = 8;

    for (NSUInteger i = 0 ; i < titles.count; i++) {
        [percentages addObject:@(value)];

        // last object takes the rest
        if (i < titles.count - 2) value /= 2;
    }

    self.buttons = [NSMutableArray arrayWithCapacity:titles.count];

    for (NSUInteger i = 0 ; i < titles.count; i++) {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

        [button setTitle:titles[i] forState:UIControlStateNormal];


        button.backgroundColor = [UIColor colorWithHue:((CGFloat)i) / titles.count * 0.5
                                            saturation:0.75
                                            brightness:0.5
                                                 alpha:1];

        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.borderWidth = 0.5;

        [button addTarget:self
                   action:@selector(buttonTapped:)
         forControlEvents:UIControlEventTouchUpInside];

        [self.buttons addObject:button];
    }

    [self.layoutView setSubviews:self.buttons withWeights:percentages];
}

- (IBAction)buttonTapped:(id)sender
{
    NSInteger index = [self.buttons indexOfObject:sender];

    if (index >= 0 && index != NSNotFound) {

        NSLog (@"button at index %d pressed", index);
    }
}

@end
