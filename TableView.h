//
//  TableView.h
//  pocimy
//
//  Created by Sathish Chinniah on 22/02/16.
//  Copyright © 2016 Sathish Chinniah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableView : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *GymNmae;


@property (weak, nonatomic) IBOutlet UILabel *GymAdress;


@property (weak, nonatomic) IBOutlet UILabel *GymKm;
@property (weak, nonatomic) IBOutlet UIView *GymColorView;

@property (weak, nonatomic) IBOutlet UILabel *GymSubName;
@property (weak, nonatomic) IBOutlet UIButton *YogaBtn;

@property (weak, nonatomic) IBOutlet UIButton *GymBtn;
@property (weak, nonatomic) IBOutlet UIButton *AcrobicsBtn;

//@property (weak, nonatomic) IBOutlet UILabel *DanceBtn;



@property (weak, nonatomic) IBOutlet UIButton *DanceBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;




@end
