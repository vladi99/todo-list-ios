//
//  ViewController.m
//  todolist
//
//  Created by Vladimir Petrov on 15/03/2020.
//  Copyright © 2020 Vladimir Petrov. All rights reserved.
//

#import "ViewController.h"
#import "TodoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        TodoViewController *todoVC = [[TodoViewController alloc] init];
        [self addChildViewController:todoVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
