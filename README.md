AutolayoutExample
=================

## step1
### Actions
Comment out all frame code and create horizontal constraints for all of the views in the custom cells.

### Code Changes
```
  // Remove all frame code
//    self.photoButton.frame = CGRectMake(margin, 6, 48, 48);
//    self.nameField.frame = CGRectMake(margin + 48 + margin, 6, 125, 48);
//    self.scoreField.frame = CGRectMake(margin + 48 + margin + 125 + margin, 6, 55, 48);
//    self.scoreStepper.frame = CGRectMake(margin + 48 + margin + 125 + margin + 55 + margin, 15, 0, 0);

    // CONSTRAINTS
    
    // Make a dictionary of all the views you need to lay out
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_photoButton, _nameField, _scoreField, _scoreStepper);
    
    // Space everything out by default spaces
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_photoButton]-[_nameField]-[_scoreField]-[_scoreStepper]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
    
    // Add the constraint to the common ancestor of all the views you want to lay out
    [self.contentView addConstraints:constraints];
```

*Note:* `NSDictionaryOfVariableBindings` is a macro to help create a dictionary based on variables. Using `self.photoButton` instead of `_photoButton` will cause errors.

*Note:* The `constraintsWithVisualFormat` syntax essentially takes an ASCII art representation of the views you want to layout, and allows you to define spaces between views (defined with `[ ]` syntax) and/or the superview (using `|`), width (when defining horizontal constraints) of objects, and priority of constraints. See the [Visual Format Language](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage/VisualFormatLanguage.html#//apple_ref/doc/uid/TP40010853-CH3-SW1) appendix for more examples and explanation.

*Note:* After defining the constraint, it must be added to a view that has all of the affected views in its descendant hierarchy. If you are laying views out relative to their superview, typically the constraint will be added to the superview. Technically, it should be added to the closest ancestor to all of the views, where a view is an ancestor of itself.

### Problems Remaining
- **Visual:** Most of the controls in the cell are not visible
- **In Console:** Problems with NSAutoresizingMaskLayoutConstraints

*Note:* This helpful hint from the console guides us in the right direction:
```
(Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints)
```
