/*!
 * iOS SDK
 *
 * Tencent is pleased to support the open source community by making
 * Hippy available.
 *
 * Copyright (C) 2019 THL A29 Limited, a Tencent company.
 * All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "HippyConvert.h"

NS_ASSUME_NONNULL_BEGIN

@interface HippyConvert (Transform)

+ (CATransform3D)CATransform3D:(id)json;
+ (CGFloat)convertToRadians:(id)json;
+ (CGFloat)convertDegToRadians:(CGFloat)deg;

@end

typedef NS_ENUM(NSInteger, NativeRenderAnimationType) {
    NativeRenderAnimationTypeSpring = 0,
    NativeRenderAnimationTypeLinear,
    NativeRenderAnimationTypeEaseIn,
    NativeRenderAnimationTypeEaseOut,
    NativeRenderAnimationTypeEaseInEaseOut,
    NativeRenderAnimationTypeKeyboard,
};

@interface HippyConvert (NativeRenderAnimationType)

+ (NativeRenderAnimationType)NativeRenderAnimationType:(id)json;

@end

typedef NS_ENUM(NSInteger, NativeRenderPointerEvents) {
    NativeRenderPointerEventsUnspecified = 0,  // Default
    NativeRenderPointerEventsNone,
    NativeRenderPointerEventsBoxNone,
    NativeRenderPointerEventsBoxOnly,
};

@interface HippyConvert (NativeRenderPointerEvents)

+ (NativeRenderPointerEvents)NativeRenderPointerEvents:(id)json;

@end

typedef NS_ENUM(NSInteger, NativeRenderBorderStyle) {
    NativeRenderBorderStyleSolid,
    NativeRenderBorderStyleDotted,
    NativeRenderBorderStyleDashed,
    NativeRenderBorderStyleNone,
};

@interface HippyConvert (NativeRenderBorderStyle)

+ (NativeRenderBorderStyle)NativeRenderBorderStyle:(id)json;

@end

typedef NS_ENUM(NSInteger, HippyTextDecorationLineType) {
    HippyTextDecorationLineTypeNone = 0,
    HippyTextDecorationLineTypeUnderline,
    HippyTextDecorationLineTypeStrikethrough,
    HippyTextDecorationLineTypeUnderlineStrikethrough,
};

/// Vertical alignment enum for text attachment,
/// similar to vertical-align in CSS (layout is different)
///
/// Default（Undefined）is baseline
typedef NS_ENUM(NSInteger, HippyTextVerticalAlignType) {
    HippyTextVerticalAlignUndefined = 0,
    HippyTextVerticalAlignBaseline = 1,
    HippyTextVerticalAlignBottom = 2,
    HippyTextVerticalAlignMiddle = 3,
    HippyTextVerticalAlignTop = 4,
};

@interface HippyConvert (NativeRenderTextEnumDefines)

+ (HippyTextDecorationLineType)HippyTextDecorationLineType:(id)json;

+ (HippyTextVerticalAlignType)HippyTextVerticalAlignType:(id)json;

@end

NS_ASSUME_NONNULL_END
