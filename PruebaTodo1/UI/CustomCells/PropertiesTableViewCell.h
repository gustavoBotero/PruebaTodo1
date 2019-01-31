//
//  PropertiesTableViewCell.h
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 1/31/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PropertiesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPropertyDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblProperties;

@end

NS_ASSUME_NONNULL_END
