AutolayoutExample
=================

## step4
### Actions
Add a constraint to center the score horizontally in the cell.

### Code Changes

```
    // Try to center the score
    NSLayoutConstraint *actualScoreCenterConstraint =
    [NSLayoutConstraint constraintWithItem:_scoreField
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0];
    actualScoreCenterConstraint.priority = UILayoutPriorityDefaultHigh;
    [self.contentView addConstraint:actualScoreCenterConstraint];
```

*Note:* This is a constraint created used the Base API. Note that the priority has been set to `UILayoutPriorityDefaultHigh` (which is 750) to override the default of `UILayoutPriorityRequired` (which is 1000). This allows the minimum width of `_nameField` to win out when it might conflict with the attempt to center `_scoreField`.

### Problems Remaining
- **Visual:** Views are not centered vertically in the row
- **In Console:** Ambiguous layouts: y position of `_photoButton`, `_nameField`, `_scoreField`, and `_scoreStepper`; `_photoButton` width; `_nameField` x position and width
