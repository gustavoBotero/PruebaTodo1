//
//  GameDetailTableViewController.m
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 1/31/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import "GameDetailTableViewController.h"
#import "Game.h"
#import "DescriptionTableViewCell.h"
#import "ShareTableViewCell.h"

@interface GameDetailTableViewController ()

@property Game *game;

@end

@implementation GameDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //NSString *bodyString = [NSString stringWithFormat: @"fields *; where id = %@;", self.idGame];
    NSString *bodyString = [NSString stringWithFormat: @"fields *; where id = 1942;"];
    [self retreiveGameDetail: @"https://api-v3.igdb.com/games/" body:bodyString];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"";
    UITableViewCell *cell = UITableViewCell.new;
    
    if (indexPath.row == 0) {
        CellIdentifier = @"searchCell";
    } else if (indexPath.row == 1) {
        CellIdentifier = @"imageCell";
    } else if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        CellIdentifier = @"propertiesCell";
    } else if (indexPath.row == 5) {
        CellIdentifier = @"descriptionCell";
        DescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell" forIndexPath:indexPath];
        if (self.game.description == nil) {
            cell.lblGameDescription.text = @"No hay descripción para este juego";
        } else {
            cell.lblGameDescription.text = self.game.storyline;
        }
        return cell;
    } else if (indexPath.row == 6) {
        ShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shareCell" forIndexPath:indexPath];
        return cell;
    }
    
    return cell;
}

- (void)retreiveGameDetail:(NSString *)urlString body:(NSString *)body {
    
    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    NSString *bodyData = body;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [request setValue:@"bf52a985c6670a9b7bb9bf95949bd461" forHTTPHeaderField:@"user-key"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            
            NSError *err;
            NSArray *objectJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            
            if (err) {
                
            }
            
            for(NSDictionary *objectDict in objectJSON) {
                
                Game *game = Game.new;
                game.idGame = objectDict[@"id"];
                game.name = objectDict[@"name"];
                game.storyline = objectDict[@"storyline"];
                
                self.game = game;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [ self.tableView reloadData ];
            });
            
            NSLog(@"%@", self.game);
            // Success
            NSLog(@"URL Session Task Succeeded: HTTP %ld", ((NSHTTPURLResponse*)response).statusCode);
        }
        else {
            // Failure
            NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
        }
    }];
    [task resume];
}

@end
