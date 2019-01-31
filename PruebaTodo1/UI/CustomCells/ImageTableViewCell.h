//
//  ImageTableViewCell.h
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 1/31/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgGame;
@property (weak, nonatomic) IBOutlet UILabel *lblScoreGame;

@end

NS_ASSUME_NONNULL_END
