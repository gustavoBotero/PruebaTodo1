//
//  PlatformsTableViewController.h
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 2/1/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponseGeneric.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlatformsTableViewController : UITableViewController

@property (nonatomic, assign) NSMutableArray<ResponseGeneric *> * object;

@end

NS_ASSUME_NONNULL_END
