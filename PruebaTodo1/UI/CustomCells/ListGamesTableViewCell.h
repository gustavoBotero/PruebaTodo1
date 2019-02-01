//
//  ListGamesTableViewCell.h
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 2/1/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListGamesTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgListGames;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleGames;

@end

NS_ASSUME_NONNULL_END
