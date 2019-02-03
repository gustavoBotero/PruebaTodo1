//
//  Game.h
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 1/31/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Game : NSObject

@property (strong, nonatomic) NSString *idGame;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *storyline;

@end

NS_ASSUME_NONNULL_END
