//
//  SXPhotoSetViewModel.m
//  SXNews
//
//  Created by dongshangxian on 16/3/8.
//  Copyright © 2016年 ShangxianDante. All rights reserved.
//

#import "SXPhotoSetViewModel.h"
#import <HLNetworking/HLNetworking.h>
#import <YYModel/YYModel.h>

@implementation SXPhotoSetViewModel
- (instancetype)init
{
    if (self = [super init]) {
        [self setupRACCommand];
    }
    return self;
}

- (void)setupRACCommand
{
    @weakify(self);
    _fetchPhotoSetCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestForPhotoSetSuccess:^(NSDictionary *responseObject) {
                SXPhotoSetEntity *photoSet = [SXPhotoSetEntity yy_modelWithJSON:responseObject];
                self.photoSet = photoSet;
                [subscriber sendNext:photoSet];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
            }];
            return nil;
        }];
    }];
}

#pragma mark - **************** 下面相当于service的代码
- (void)requestForPhotoSetSuccess:(void (^)(NSDictionary *result))success
                          failure:(void (^)(NSError *error))failure{
    // 取出关键字
    NSArray *parameters = [[self.photosetID substringFromIndex:4] componentsSeparatedByString:@"|"];
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[parameters firstObject],[parameters lastObject]];
    
    CGFloat count =  [self.replyCount intValue];
    if (count > 10000) {
        self.replyCountBtnTitle = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        self.replyCountBtnTitle = [NSString stringWithFormat:@"%.0f跟帖",count];
    }

    [[HLAPIRequest request]
     .setMethod(GET)
     .setCustomURL(url)
     .success(^(id response){
        if (response) {
            success(response);
        }
    })
     .failure(^(NSError *error){
        failure(error);
    })
     start];
}

@end
