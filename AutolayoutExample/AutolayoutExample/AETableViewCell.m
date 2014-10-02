//
//  AETableViewCell.m
//  AutolayoutExample
//
//  Created by Ben Norris on 10/2/14.
//  Copyright (c) 2014 BSN Design. All rights reserved.
//

#import "AETableViewCell.h"

static const CGFloat margin = 10.0;

@implementation AETableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.photoButton = [UIButton new];
//    self.photoButton.frame = CGRectMake(margin, 6, 48, 48);
    [self.photoButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.photoButton setTintColor:[UIColor whiteColor]];
    [self.photoButton setBackgroundColor:[UIColor blueColor]];
    [self.contentView addSubview:self.photoButton];
    
    self.nameField = [UITextField new];
//    self.nameField.frame = CGRectMake(margin + 48 + margin, 6, 125, 48);
    self.nameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:self.nameField];
    
    self.scoreField = [UITextField new];
//    self.scoreField.frame = CGRectMake(margin + 48 + margin + 125 + margin, 6, 55, 48);
    self.scoreField.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:self.scoreField];
    
    self.scoreStepper = [UIStepper new];
//    self.scoreStepper.frame = CGRectMake(margin + 48 + margin + 125 + margin + 55 + margin, 15, 0, 0);
    [self.contentView addSubview:self.scoreStepper];
    
    // CONSTRAINTS
    
    // Turn off Autoresizing Mask Layout Constraints that are on by default
    [self.photoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scoreField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scoreStepper setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Make a dictionary of all the views you need to lay out
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_photoButton, _nameField, _scoreField, _scoreStepper);
    
    // Space everything out by default spaces with flexible space between score and stepper with min width on name and score
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_photoButton]-[_nameField]-[_scoreField]-[_scoreStepper]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
//    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_photoButton]-[_nameField(>=95)]-[_scoreField(>=40)]-(>=0)-[_scoreStepper]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];

    // Add the constraint to the common ancestor of all the views you want to lay out
    [self.contentView addConstraints:constraints];
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.photoButton.layer.cornerRadius = self.photoButton.frame.size.width / 2;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
