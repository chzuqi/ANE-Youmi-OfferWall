//
//  DomodExtensionHandler.h
//  DomodOfferWall
//
//  Created by CZQ on 14-5-29.
//
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "YoumiTypeConversion.h"
#import "YouMiConfig.h"
#import "YouMiWall.h"
#import  "YouMiWallSpot.h"
#import "YouMiPointsManager.h"


@interface YoumiExtensionHandler : NSObject{

}

//声明immobView
@property (nonatomic, assign) FREContext context;
@property (nonatomic, retain) YoumiTypeConversion *converter;


- (id)initWithContext:(FREContext)extensionContext;

//设置用户id(optional)
- (FREObject)setUserId:(FREObject)freUserId;

//初始化
- (FREObject)initWithAppid:(FREObject)freAppid andAppSecret:(FREObject)freAppsecret;

//显示积分墙
- (FREObject)showOfferWall:(FREObject)freOffer;

//显示插播
- (FREObject)showSpot;

//查询积分
- (FREObject)queryPoint;

//消耗积分
- (FREObject)spendPoints:(FREObject)frePoint;

@end
