//
//  AETableViewCell.h
//  AutolayoutExample
//
//  Created by Ben Norris on 10/2/14.
//  Copyright (c) 2014 BSN Design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AETableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *scoreField;
@property (nonatomic, strong) UIStepper *scoreStepper;

@end
