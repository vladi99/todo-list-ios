// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MaterialDialogs.h"

@interface MDCAlertController (Customize)

/**
 An optional custom icon view above the title of the alert.

 @discussion Use `titleIcon` to display icons or images.  Use `titleIconView` for custom views
             implementations. If both `titleIcon` are `titleIconView` are set, 'titleIcon' is
             ignored.

 @discussion Custom title views are aligned with the title and may be resized to fit.
 */
@property(nonatomic, strong, nullable) UIView *titleIconView;

/**
 The backing image view of `titleIcon`. Use `titleIcon` to set the icon or image. Use
 'titleIconImageView' to fine tune the appearance of `titleIcon` when necessary, for instance, to
 set up its `contentMode`.

 @discussion The `titleIcon` (and `titleIconImageView`) are aligned with the title and may be
             resized to fit.

 @discussion Use `titleIcon` to display icons or images.  Use `titleIconView` for custom views
             implementations. If both `titleIcon` are `titleIconView` are set, 'titleIcon' (and
             `titleIconImageView`) are ignored.
 */
@property(nonatomic, nullable, strong, readonly) UIImageView *titleIconImageView;

@end
