//
//  PlatformsTableViewController.m
//  PruebaTodo1
//
//  Created by Sara Yazmin Espinal Araque on 2/1/19.
//  Copyright © 2019 Gustavo Adolfo Botero Arango. All rights reserved.
//

#import "PlatformsTableViewController.h"
#import "PlatformsTableViewCell.h"
#import "Game.h"
#import "ListResultTableViewController.h"

@interface PlatformsTableViewController ()

@property (strong, nonatomic) Game *game;
@property NSString *idObject;
@property (strong, nonatomic) NSMutableArray<ResponseGeneric *> *objects;

@end

@implementation PlatformsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)platformGamesList: (NSString *)segue urlString:(NSString *)urlString body:(NSString *)body {
    
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
            NSMutableArray<ResponseGeneric *> *objects = NSMutableArray.new;
            for(NSDictionary *objectDict in objectJSON) {
                ResponseGeneric *object = ResponseGeneric.new;
                object.idObject = objectDict[@"id"];
                object.string = objectDict[@"name"];
                [objects addObject:object];
                self.objects = objects;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self performSegueWithIdentifier:segue sender:nil];
            });
            NSLog(@"URL Session Task Succeeded: HTTP %ld", ((NSHTTPURLResponse*)response).statusCode);
        }
        else {
            NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
        }
    }];
    [task resume];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"listGamesSegue"]) {
        ListResultTableViewController *listResultTableViewController = segue.destinationViewController;
        listResultTableViewController.object = self.objects;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.object.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ResponseGeneric *object = self.object[indexPath.row];
    self.idObject = object.idObject;
    NSString *bodyString = [NSString stringWithFormat: @"fields name,category,platforms; limit 10; where category = 0 & platforms = %@;", self.idObject];
    [self platformGamesList:@"listGamesSegue" urlString:@"https://api-v3.igdb.com/games/" body:bodyString];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlatformsTableViewCell *cell = (PlatformsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"platformsCell" forIndexPath:indexPath];
    ResponseGeneric *object = self.object[indexPath.row];
    cell.lblTitlePlatform.text = object.string;
    return cell;
}

@end
