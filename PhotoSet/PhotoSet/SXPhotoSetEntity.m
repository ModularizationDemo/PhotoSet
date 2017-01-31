//
//  SXPhotoSetEntity.m
//  SXNews
//
//  Created by 董 尚先 on 15/2/3.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SXPhotoSetEntity.h"
#import "SXPhotosDetailEntity.h"

@implementation SXPhotoSetEntity

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"photos" : [SXPhotosDetailEntity class]};
}

@end
