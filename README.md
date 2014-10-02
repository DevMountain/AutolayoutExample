SOLUTION: AutolayoutExample
=================

A quick example project to demonstrate auto layout with Objective-C.

#### Background/Resource
Auto Layout is a powerful way to layout views for iOS development in a future-friendly, device-agnostic way. Some of the best resources to get started learning about it are:

- [Apple's Auto Layout Guide](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/Introduction/Introduction.html#//apple_ref/doc/uid/TP40010853-CH13-SW1)
- [Introduction to Auto Layout video from WWDC 2012](https://developer.apple.com/videos/wwdc/2012/#202)
- [Best Pratices for Mastering Auto Layout video from WWDC 2012](https://developer.apple.com/videos/wwdc/2012/#228)

There are three ways to implement auto layout constraints (of class `NSLayoutConstraint`), and should generally be done in the following order of preference:

1. Interface Builder
2. Visual Format Language
3. Base API

There are three problems that can occur with auto layout, and they are almost always related to contraints:

1. Unsatisfiable constraints (shows as errors in console)
2. Ambiguous layout (can be seen in console by pausing application and entering `po [[UIWindow keyWindow] _autolayoutTrace]`)
3. Undesirable layouts (everything works properly, but is not laid out as you want)

This example will focus on demonstrating how to use auto layout exclusively in code. Each branch represents a step in the process and includes the code needed to complete the step, which has been commented out.

# Branches (steps)
## master
### Description
A simple table with custom cells, laid out using frames.

### Problems Remaining
Cells do not adjust to landscape view, and content is pushed off screen when editing.

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

## step2
### Actions
All views have `setTranslatesAutoresizingMaskIntoConstraints` on by default. This must be turned off in order for our manually-applied constraints to work.

### Code Changes

```
    // Turn off Autoresizing Mask Layout Constraints that are on by default
    [self.photoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scoreField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scoreStepper setTranslatesAutoresizingMaskIntoConstraints:NO];
```

### Problems Remaining
- **Visual:** Controls are stretched horizontally in a way that we do not want
- **In Console:** Ambiguous layouts: y position of `_photoButton`, `_nameField`, `_scoreField`, and `_scoreStepper`; width of `_photoButton`, `_nameField`, and `_scoreField`; x position of `_nameField` and `_scoreField`

*Reminder:* Discover ambiguous layouts by pausing app and typing `po [[UIWindow keyWindow] _autolayoutTrace]` in the console.

The reason for the ambiguous layouts is that we have not given enough information for the views to define their size and position. The `UITextField` views have an intrinsic size based on their content, and the `UIStepper` has an intrinsic size, and so the `UIButton` stretches its width.

## step3
### Actions
Give the text fields a minimum width so that they don't get smashed, and add some space between the score and the stepper.

### Code Changes

```
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_photoButton]-[_nameField(>=95)]-[_scoreField(>=40)]-(>=0)-[_scoreStepper]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
```

*Note:* The syntax for adding a minimum width defines an inequality `>=95` to set a minimum width of 95 points. The width could be set with a simple number or an equality `==95`. The `-` between views (e.g. `[_photoButton]` and `[_nameField]`) defines a system default constraint of 8 points.

### Problems Remaining
- **Visual:** Too much space between score and stepper
- **In Console:** Ambiguous layouts: y position of `_photoButton`, `_nameField`, `_scoreField`, and `_scoreStepper`

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

## step5
### Actions
Center all views vertically by defining the height for the button. Since the horizontal contraint was set with the option `NSLayoutFormatAlignAllCenterY`, defining the height for one view will cause all views in the cell to adjust their Y position to stay centered vertically.

### Code Changes

```
    // Stretch the photo button to the available height of the row, thus centering everything vertically
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_photoButton]-|" options:0 metrics:nil views:viewsDictionary];
    [self.contentView addConstraints:constraints];
```

*Note:* The `V:` prefix defines this contraint as being vertical. Rotate the objects in your mind, and the ASCII art model continues to apply. This defines the position of `_photoButton` as being the standard distance away from the top and bottom of its superview, which makes it stretch vertically to fill that space.

### Problems Remaining
- **Visual:** `_photoButton` has the wrong aspect ratio (incorrect width) and so is not a circle
- **In Console:** Ambiguous layouts: `_photoButton` width; `_nameField` x position and width

## step6
### Actions
Define the width of `_photoButton` to correct the aspect ratio and define all constraints needed for an unambiguous layout.

### Code Changes

```
    // Make the photo button 1:1
    NSLayoutConstraint *photoButtonAspectRatioConstraint =
    [NSLayoutConstraint constraintWithItem:_photoButton
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:_photoButton
                                 attribute:NSLayoutAttributeHeight
                                multiplier:1.0
                                  constant:0];
    [self.photoButton addConstraint:photoButtonAspectRatioConstraint];
```

*Note:* As identified in the [Auto Layout documentation](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutinCode/AutoLayoutinCode.html#//apple_ref/doc/uid/TP40010853-CH11-SW1), this is an example of a time when Visual Format Language cannot define the constraint:

> The visual format language prefers good visualization over completeness of expressibility. Although most of the constraints that are useful in real user interfaces can be expressed using the language, some cannot. One useful constraint that cannot be expressed is a fixed aspect ratio (for example, `imageView.width = 2 * imageView.height`). To create such a constraint, you can use `constraintWithItem:attribute:relatedBy:toItem:attribute:multiplier:constant:`.

## solution
### Description
All layout concerns have been resolved. Content adjusts to rotation, even when the cell height gets smaller in landscape mode. Content also adjusts properly when editing the table.
