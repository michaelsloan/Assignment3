//
//  ViewController.m
//  Assignment3
//
//  Created by Build User on 2/4/14.
//  Copyright (c) 2014 Pitt. All rights reserved.
//

#import "ViewController.h"
#import "Fruit.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [_fillCart setTitle:@"Fill Cart" forState:UIControlStateNormal];
    [_emptyCart setTitle:@"Empty Cart" forState:UIControlStateNormal];
    [_selectAll setTitle:@"Select All" forState:UIControlStateNormal];
    _allSelected = NO;
    _cart = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i=0; i<50; i++) {
        Fruit *tempFruit = [[Fruit alloc] initWithWithName:@"Bananas" andColor:@"Yellow" andShape:@"Curvy"];
        tempFruit.url = @"http://en.m.wikipedia.org/wiki/Banana";
        [_cart addObject:tempFruit];
    }
    
    //_cartView = [UITableView alloc] init
    
    self.title = @"Banana Bar";
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)selectAllOrNone:(id)sender{
    _allSelected = !_allSelected;
    
    if(_allSelected){
        [_selectAll setTitle:@"Select None" forState:UIControlStateNormal];
    } else {
        [_selectAll setTitle:@"Select All" forState:UIControlStateNormal];
    }
    
    [_cartView reloadData];
}

//Should remove all of the fruit in the cart.
-(IBAction)removeAllFruitInCart:(id)sender
{
    _cart = [[NSMutableArray alloc] initWithCapacity:0];
    
    [_cartView reloadData];
}

//should add 50 bananas to the cart and display them!
-(IBAction)fillCartWithBananas:(id)sender
{
    _allSelected = NO;
    _cart = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i=0; i<50; i++) {
        Fruit *tempFruit = [[Fruit alloc] initWithWithName:@"Bananas" andColor:@"Yellow" andShape:@"Curvy"];
        tempFruit.url = @"http://en.m.wikipedia.org/wiki/Banana";
        [_cart addObject:tempFruit];
    }
    
    [_cartView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([_cart count] == 0){
        return 1;
    }
    return [_cart count];
}
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Fruit";
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell == Nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    if([_cart count] == 0){
        cell.textLabel.text = @"No Fruit in Cart";
        cell.detailTextLabel.text = @"";
        
    } else {
        Fruit * tempFruit = [_cart objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [tempFruit name];
        cell.detailTextLabel.text = [tempFruit color];
        
        if(_allSelected){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Fruit * tempFruit = [_cart objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    DetailViewController * tempView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle: nil];

    tempView.url = tempFruit.url;

    [self.navigationController pushViewController:tempView animated:YES];
    
    [tempView viewWillAppear:YES];
}

@end
