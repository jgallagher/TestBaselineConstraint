//
//  BNRViewController.m
//  TestBaselineConstraint
//
//  Created by John Gallagher on 8/23/13.
//  Copyright (c) 2013 BigNerdRanch. All rights reserved.
//

#import "BNRViewController.h"

@interface BNRViewController ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) NSLayoutConstraint *whichConstraint;
- (IBAction)switchConstraint:(UISwitch *)sender;

@end

@implementation BNRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"A Label";
    [label setContentHuggingPriority:800 forAxis:UILayoutConstraintAxisHorizontal];
    self.label = label;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    textField.text = @"ABC";
    textField.backgroundColor = [UIColor whiteColor];
    self.textField = textField;
    
    UILabel *lowLabel = [[UILabel alloc] init];
    lowLabel.translatesAutoresizingMaskIntoConstraints = NO;
    lowLabel.text = @"A Longer Label";
    [lowLabel setContentCompressionResistancePriority:751 forAxis:UILayoutConstraintAxisVertical];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"200x300"]];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.backgroundColor = [UIColor greenColor];
    self.imageView = imageView;
    
    [self.view addSubview:label];
    [self.view addSubview:textField];
    [self.view addSubview:lowLabel];
    [self.view addSubview:imageView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(label, textField, lowLabel, imageView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[label]-[textField]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(120)-[label]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    self.whichConstraint = [NSLayoutConstraint constraintWithItem:label
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:textField
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0f
                                                         constant:0.0f];
    [self.view addConstraint:self.whichConstraint];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[lowLabel]-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[textField]-[lowLabel]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views];
    
    [self.view addConstraints:horizontalConstraints];
    
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:
                                    @"V:[lowLabel]-[imageView]-|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views];
    
    [self.view addConstraints:verticalConstraints];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"imageView frame = %@", NSStringFromCGRect(self.imageView.frame));
}

- (IBAction)switchConstraint:(UISwitch *)sender {
    [self.view removeConstraint:self.whichConstraint];
    
    if (sender.on) {
        self.whichConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.textField
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0f
                                                             constant:0.0f];
    } else {
        self.whichConstraint = [NSLayoutConstraint constraintWithItem:self.label
                                                            attribute:NSLayoutAttributeBaseline
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.textField
                                                            attribute:NSLayoutAttributeBaseline
                                                           multiplier:1.0f
                                                             constant:0.0f];
    }
    
    [self.view addConstraint:self.whichConstraint];
    [self.view needsUpdateConstraints];
}
@end
