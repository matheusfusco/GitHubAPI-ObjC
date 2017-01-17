//
//  RepositoryModel.m
//  desafio-ios
//
//  Created by Matheus Fusco on 17/01/17.
//  Copyright © 2017 MatheusFusco. All rights reserved.
//

#import "RepositoryModel.h"
#import "RepositoryService.h"
#import <MBProgressHUD.h>
#import "Repository.h"

@implementation RepositoryModel
@synthesize delegate;

-(void) fetchRepositories:(NSInteger) page {
    NSMutableArray * repositories = [[NSMutableArray alloc] init];
    
    UIViewController * curVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    MBProgressHUD * prog = [MBProgressHUD showHUDAddedTo:curVC.view animated:YES];
    [RepositoryService searchRepositoriesFor:@"Java" sortingBy:@"stars" orderingBy:@"asc" andPage:page response:^(id responseObject, NSError *error) {
        //NSLog(@"resp: %@", [[responseObject objectForKey:@"items"] objectAtIndex:0]);
        NSMutableArray * repoArray = [[NSMutableArray alloc] initWithArray:[responseObject objectForKey:@"items"]];
        //NSLog(@"repoArray: %@", repoArray);
        for (int i = 0; i < repoArray.count; i++) {
            NSDictionary * dict = [[NSDictionary alloc] init];
            dict = [repoArray objectAtIndex:i];

            Repository * rp = [MTLJSONAdapter modelOfClass:[Repository class] fromJSONDictionary:dict error:&error];
            //NSLog(@"rp: %@", rp);
            [repositories addObject:rp];
        }
        [prog hideAnimated:YES];
        [self.delegate fetchedRepositories:repositories];
    }];
}
@end
