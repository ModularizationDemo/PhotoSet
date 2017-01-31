//
//  Target_PhotoSet.m
//  PhotoSet
//
//  Created by wangshiyu13 on 2017/1/31.
//  Copyright © 2017年 wangshiyu13. All rights reserved.
//

#import "Target_PhotoSet.h"
#import "SXPhotoSetPage.h"

@implementation Target_PhotoSet
- (UIViewController *)Action_aViewController:(NSDictionary *)params {
    SXPhotoSetPage *pc = [UIStoryboard storyboardWithName:@"SXPhotoSetPage" bundle:nil].instantiateInitialViewController;
    pc.photosetID = params[@"photosetID"];
    pc.replyCount = params[@"replyCount"];
    pc.boardid = params[@"boardid"];
    pc.docid = params[@"docid"];
    return pc;
}
@end
