//
//  DomodExtensionHandler.m
//  DomodOfferWall
//
//  Created by CZQ on 14-5-29.
//
//

#import "YoumiExtensionHandler.h"

@implementation YoumiExtensionHandler

@synthesize context;
@synthesize converter;

#pragma mark -

- (id)initWithContext:(FREContext)extensionContext
{
    self = [super init];
    if (self) {
        self.context = extensionContext;
        self.converter = [[[YoumiTypeConversion alloc] init] autorelease];
    }
    return self;
}

- (void)dealloc {
    self.context = nil;
    self.converter = nil;
    [super dealloc];
}


#pragma mark - Manager Delegate



#pragma main function

//设置用户id(optional)
- (FREObject)setUserId:(FREObject)freUserId
{
    NSString *userId;
    if ([self.converter FREGetObject:freUserId asString:&userId] != FRE_OK)
    {
        return NULL;
    }
    // [可选] 例如开发者的应用是有登录功能的，则可以使用登录后的用户账号来替代有米为每台机器提供的标识（有米会为每台设备生成的唯一标识符）。
    [YouMiConfig setUserID:userId];
    return NULL;
}

- (FREObject)initWithAppid:(FREObject)freAppid andAppSecret:(FREObject)freAppsecret
{
    NSString *appid;
    if ([self.converter FREGetObject:freAppid asString:&appid] != FRE_OK)
    {
        return NULL;
    }
    NSString *appsecret;
    if ([self.converter FREGetObject:freAppsecret asString:&appsecret] != FRE_OK)
    {
        return NULL;
    }
    [YouMiConfig setUseInAppStore:YES];  // [可选]开启内置appStore，详细请看YouMiSDK常见问题解答
    [YouMiConfig launchWithAppID:appid appSecret:appsecret];
    [YouMiConfig setFullScreenWindow:[[UIApplication sharedApplication] keyWindow]];
    //积分墙初始化
    [YouMiWall enable];
    //让sdk帮忙存储积分，提供增加减少积分接口（积分托管）
    [YouMiPointsManager enable];

    return NULL;
}

- (FREObject)showOfferWall:(FREObject)freOffer
{
    NSInteger offer =  [self.converter FREGetObjectAsInteger:freOffer];
    if (offer == 1){
        [YouMiWall showOffers:YES didShowBlock:^{
            NSLog(@"有米积分墙已显示");
        } didDismissBlock:^{
            NSLog(@"有米积分墙已退出");
        }];
    }else{
        [YouMiWall showOffers:NO didShowBlock:^{
            NSLog(@"有米推荐墙已显示");
        } didDismissBlock:^{
            NSLog(@"有米推荐墙已退出");
        }];
    }
    return NULL;
}

- (FREObject)showSpot
{
    if ([YouMiWallSpot isReady]) {
        [YouMiWallSpot showSpotViewWithBlock:^{
            NSLog(@"积分插播退出");
        }];
    }
    return NULL;
}

//查询积分
- (FREObject)queryPoint
{
    int *points = [YouMiPointsManager pointsRemained];
//    self.pointsLabel.text = [NSString stringWithFormat:@"当前积分: %d", *points];
    // write computed sum to a FREObject variable, which will be returned back to AS3
    FREObject pointToReturn = nil;
    FRENewObjectFromInt32(*points, &pointToReturn);
    free(points);
    return pointToReturn;
}

- (FREObject)spendPoints:(FREObject)frePoint
{
    NSInteger point =  [self.converter FREGetObjectAsInteger:frePoint];
    [YouMiPointsManager spendPoints:point];
    return NULL;
}


@end
