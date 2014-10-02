AutolayoutExample
=================

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
