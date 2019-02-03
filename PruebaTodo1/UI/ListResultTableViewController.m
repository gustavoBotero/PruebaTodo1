//
//  ListResultTableViewController.m
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 1/31/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import "ListResultTableViewController.h"
#import "ListGamesTableViewCell.h"
#import "ResponseGeneric.h"
#import "GameDetailTableViewController.h"

@interface ListResultTableViewController ()

@property NSString *idGame;

@end

@implementation ListResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.object.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listGamesCell"];
    
    ListGamesTableViewCell *cell = (ListGamesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"listGamesCell" forIndexPath:indexPath];
    
    ResponseGeneric *object = self.object[indexPath.row];
    
    cell.lblTitleGames.text = object.string;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.idGame = self.object[indexPath.row].idObject;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"topTwentyDeatilGame" sender:nil];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"topTwentyDeatilGame"]) {
        GameDetailTableViewController *gameDetailTableViewController = segue.destinationViewController;
        gameDetailTableViewController.idGame = self.idGame;
    }
}


@end
