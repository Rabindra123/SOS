//
//  DoctorRatingController.m
//  sos
//
//  Created by Rabi Chourasia on 16/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "DoctorRatingController.h"

@interface DoctorRatingController ()

@end

@implementation DoctorRatingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#pragma For Rating Star
    self.myRateview.notSelectedImage=[UIImage imageNamed:@"empty-star.png"];
    self.myRateview.halfSelectedImage=[UIImage imageNamed:nil];
    self.myRateview.fullSelectedImage=[UIImage imageNamed:@"greenstar.png"];
    self.myRateview.editable=YES;
    self.myRateview.maxRating=5;
   // self.myRateview.rating=rating;
    self.myRateview.delegate=self;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma rating star Delegate
- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    NSLog(@"rating%f",rating);
    // Score=rating;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapSubmit:(id)sender {
}
@end
