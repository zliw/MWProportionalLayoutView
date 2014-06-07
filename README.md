MWProportionalLayoutView
========================

A UIView subclass managing subviews.  Size and position is calculated according to given numbers.

## Requirements

`MWProportionalLayoutView` was written for ARC and requires iOS 7.0+ (but it should also work on earlier versions). 

## Usage

An example of the usage can be seen in the ```MWProportionalLayoutView-Example```-Folder. But currently usage is quite simple:

```obj-c

NSArray *myListOfViews = @[[UIView new], [UIView new], [UIView new]];
NSArray *myListOfWeights = @[@(4), @(2), @(1)];

MWProportionalLayoutView *layoutView = [[MWProportionalLayoutView alloc] initWithFrame:myFrame];

[layoutView setSubviews:myListOfViews withWeights:myListOfWeights];

```

In a real world example it would make sense to configure a different look on the views (e.g. background color, labels, etc).

This is, what the example application looks like :
![example](screenshots/screenshot.png)
