/*
 * YoumiOfferWall.m
 * YoumiOfferWall
 *
 * Created by CZQ on 14-6-12.
 * Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
 */

#import "YoumiOfferWall.h"
#import "YoumiExtensionHandler.h"

static YoumiExtensionHandler* youmi;

/* YoumiOfferWallExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void YoumiOfferWallExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    NSLog(@"Entering YoumiOfferWallExtInitializer()");

    *extDataToSet = NULL;
    *ctxInitializerToSet = &YoumiOfferWallContextInitializer;
    *ctxFinalizerToSet = &YoumiOfferWallContextFinalizer;

    NSLog(@"Exiting YoumiOfferWallExtInitializer()");
}

/* YoumiOfferWallExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void YoumiOfferWallExtFinalizer(void* extData) 
{
    NSLog(@"Entering YoumiOfferWallExtFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting YoumiOfferWallExtFinalizer()");
    return;
}

/* YoumiOfferWallContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void YoumiOfferWallContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");
    
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     */
    static FRENamedFunction func[] = 
    {
        MAP_FUNCTION(setUserId, NULL),
        MAP_FUNCTION(init, NULL),
        MAP_FUNCTION(showOfferWall, NULL),
        MAP_FUNCTION(showSpot, NULL),
        MAP_FUNCTION(queryPoint, NULL),
        MAP_FUNCTION(spendPoints, NULL),
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    youmi = [[YoumiExtensionHandler alloc]initWithContext:ctx];
    
    NSLog(@"Exiting ContextInitializer()");
}

/* YoumiOfferWallContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void YoumiOfferWallContextFinalizer(FREContext ctx)
{
    NSLog(@"Entering ContextFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}


ANE_FUNCTION(setUserId)
{
    return [youmi setUserId:argv[0]];
}
ANE_FUNCTION(init)
{
    return [youmi initWithAppid:argv[0] andAppSecret:argv[1]];
}
ANE_FUNCTION(showOfferWall)
{
    return [youmi showOfferWall:argv[0]];
}
ANE_FUNCTION(showSpot)
{
    return [youmi showSpot];
}
ANE_FUNCTION(queryPoint)
{
    return [youmi queryPoint];
}
ANE_FUNCTION(spendPoints)
{
    return [youmi spendPoints:argv[0]];
}

