//
//  Platform.h
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 1/31/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Platform : NSObject

@property (strong, nonatomic) NSString *idPlatform;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *url;

@end

NS_ASSUME_NONNULL_END
