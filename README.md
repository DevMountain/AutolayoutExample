AutolayoutExample
=================

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
