AutolayoutExample
=================

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
