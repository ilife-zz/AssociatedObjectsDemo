//
//  ANViewController.m
//  associatedObjectsDemo
//
//  Created by Avinash Nehra on 3/26/14.
//  Copyright (c) 2014 Avinash Nehra. All rights reserved.
//

#import "ANViewController.h"
#import <objc/runtime.h>

static  NSString * const cellReuseIdentifier = @"cellIdentity";
static char kAssociatedObjectKey;

@interface ANViewController ()

@end

@implementation ANViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.930 blue:0.711 alpha:1.000];
    
    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    
    // If button was not created. Create it.
    if (![cell viewWithTag:189]) {
        UIButton *button = [[UIButton alloc] initWithFrame:(CGRect){100, 10, 50, 20}];
        button.backgroundColor = [UIColor colorWithRed:1.000 green:0.498 blue:0.342 alpha:1.000];
        button.tag = 189;
        
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%d", indexPath.row] forState:UIControlStateNormal];
        
        // Setting an associated value for a given object using a given key and association policy.
        objc_setAssociatedObject(button, "cell", cell, OBJC_ASSOCIATION_ASSIGN);
        
        [cell addSubview:button];
    }
    
    return cell;
}

- (void)buttonPressed:(id)sender {
    
    // Returns the value associated with a given object for a given key.
    UITableViewCell *cellReference = objc_getAssociatedObject(sender, "cell");
    cellReference.backgroundColor = [UIColor colorWithRed:1.000 green:0.930 blue:0.711 alpha:1.000];
}

@end
