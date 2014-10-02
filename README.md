AutolayoutExample
=================

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
