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

#import "HippyAssert.h"
#import "HippyUtils.h"
#import "HippyImageViewManager.h"
#import "HippyImageView.h"
#import "HippyUIManager.h"
#import "TypeConverter.h"
#include "VFSUriLoader.h"


@implementation HippyImageViewManager

HIPPY_EXPORT_MODULE(Image);

HIPPY_EXPORT_VIEW_PROPERTY(blurRadius, CGFloat)
HIPPY_EXPORT_VIEW_PROPERTY(capInsets, UIEdgeInsets)
HIPPY_EXPORT_VIEW_PROPERTY(resizeMode, HippyResizeMode)
HIPPY_EXPORT_VIEW_PROPERTY(onLoadStart, HippyDirectEventBlock)
HIPPY_EXPORT_VIEW_PROPERTY(onProgress, HippyDirectEventBlock)
HIPPY_EXPORT_VIEW_PROPERTY(onError, HippyDirectEventBlock)
HIPPY_EXPORT_VIEW_PROPERTY(onPartialLoad, HippyDirectEventBlock)
HIPPY_EXPORT_VIEW_PROPERTY(onLoad, HippyDirectEventBlock)
HIPPY_EXPORT_VIEW_PROPERTY(onLoadEnd, HippyDirectEventBlock)
HIPPY_EXPORT_VIEW_PROPERTY(downSample, BOOL)
HIPPY_EXPORT_VIEW_PROPERTY(shape, HippyShapeMode)
HIPPY_CUSTOM_VIEW_PROPERTY(src, NSString, HippyImageView) {
    NSString *path = [HippyConvert NSString:json];
    [self loadImageSource:path forView:view];
}

HIPPY_CUSTOM_VIEW_PROPERTY(source, NSArray, HippyImageView) {
    NSArray *pathSources = [HippyConvert NSArray:json];
    if ([pathSources isKindOfClass:[NSArray class]]) {
        NSDictionary *dicSource = [pathSources firstObject];
        NSString *path = dicSource[@"uri"];
        [self loadImageSource:path forView:view];
    }
}

static NSOperationQueue *imageLoadOperationQueue(void) {
    static NSOperationQueue *opQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        opQueue = [[NSOperationQueue alloc] init];
    });
    return opQueue;
}

- (void)loadImageSource:(NSString *)path forView:(HippyImageView *)view {
    if (!path || !view) {
        return;
    }
    NSString *standardizeAssetUrlString = path;
    __weak HippyImageView *weakView = view;
    auto loader = [self.bridge.uiManager VFSUriLoader].lock();
    if (!loader) {
        return;
    }
    __weak __typeof(self)weakSelf = self;
    loader->RequestUntrustedContent(path, imageLoadOperationQueue(), nil,
                                    ^(NSData *data, NSDictionary *userInfo, NSURLResponse *response, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        HippyBridge *bridge = strongSelf.bridge;
        if (bridge) {
            id<HippyImageProviderProtocol> imageProvider = nil;
            for (Class<HippyImageProviderProtocol> cls in [bridge imageProviderClasses]) {
                if ([cls canHandleData:data]) {
                    imageProvider = [[(Class)cls alloc] init];
                    break;
                }
            }
            HippyAssert(imageProvider, @"Image Provider is required");
            imageProvider.imageDataPath = standardizeAssetUrlString;
            [imageProvider setImageData:data];
            // It is possible for User to return the image directly in userInfo,
            // So we need to check and skip the data decoding process if needed.
            UIImage *resultImage = userInfo ? userInfo[HippyVFSHandlerUserInfoImageKey] : nil;
            if (resultImage) {
                [imageProvider setDecodedImage:resultImage];
            }
            
            void (^reloadImageInMain)(void) = ^{
                HippyImageView *strongView = weakView;
                if (strongView) {
                    [strongView setImageProvider:imageProvider];
                    [strongView reloadImage];
                }
            };
            
            if([imageProvider imageCount] <= 1){
                // prepare the still image for display before setting it to the imageview
                [imageProvider prepareForDisplay:^(UIImage * _Nullable _) {
                    // subsequent call to the image provider will return the prepared image
                    dispatch_async(dispatch_get_main_queue(), reloadImageInMain);
                }];
            }else{
                dispatch_async(dispatch_get_main_queue(), reloadImageInMain);
            }
        }
    });
}

HIPPY_CUSTOM_VIEW_PROPERTY(tintColor, UIColor, HippyImageView) {
    view.tintColor = [HippyConvert UIColor:json] ?: defaultView.tintColor;
    view.renderingMode = json ? UIImageRenderingModeAlwaysTemplate : defaultView.renderingMode;
}

HIPPY_CUSTOM_VIEW_PROPERTY(defaultSource, NSString, HippyImageView) {
    NSString *source = [HippyConvert NSString:json];
    [self loadImageSource:source forView:view];
}

#define HIPPY_VIEW_BORDER_RADIUS_PROPERTY(SIDE)                                                                \
    HIPPY_CUSTOM_VIEW_PROPERTY(border##SIDE##Radius, CGFloat, HippyImageView) {                                \
        if ([view respondsToSelector:@selector(setBorder##SIDE##Radius:)]) {                                   \
            view.border##SIDE##Radius = json ? [HippyConvert CGFloat:json] : defaultView.border##SIDE##Radius; \
        }                                                                                                      \
    }

HIPPY_VIEW_BORDER_RADIUS_PROPERTY(TopLeft)
HIPPY_VIEW_BORDER_RADIUS_PROPERTY(TopRight)
HIPPY_VIEW_BORDER_RADIUS_PROPERTY(BottomLeft)
HIPPY_VIEW_BORDER_RADIUS_PROPERTY(BottomRight)

- (UIView *)view {
    return [[HippyImageView alloc] init];
}

@end
