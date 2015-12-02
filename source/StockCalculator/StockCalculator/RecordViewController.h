//
//  RecordViewController.h
//  cnstockcalculator
//
//  Created by zuohaitao on 15/10/13.
//  Copyright © 2015年 zuohaitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchResultsUpdating>
@property IBOutlet UIBarButtonItem* edit;
-(IBAction)edit:(id)sender;

//@property IBOutlet UISearchBar* searchbar;

@property IBOutlet UIBarButtonItem* search;

-(IBAction)select:(id)sender;

@property (nonatomic, strong) UISearchController *searcher;

@end

