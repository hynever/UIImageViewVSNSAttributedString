//
//  ViewController.m
//  UIImageView和NSAttributedString对比
//
//  Created by 黄勇 on 16/1/25.
//  Copyright © 2016年 xfz. All rights reserved.
//

#import "ViewController.h"

static NSInteger const kImageCount = 24;

//#define kImageHeight [UIScreen mainScreen].bounds.size.height
#define kImageHeight 1000

@interface ViewController ()

@property(nonatomic,strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    self.scrollView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    self.scrollView.contentSize = CGSizeMake(screenSize.width, kImageCount*kImageHeight);
    [self loadAttributedString];
//    [self loadImageView];
}

-(void)loadImageView
{
    for (NSInteger index = 0; index < kImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [self image];
        [self.scrollView addSubview:imageView];
        imageView.frame = CGRectMake(0, index*kImageHeight, self.scrollView.frame.size.width, kImageHeight);
    }
}

-(void)loadAttributedString
{
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    for (NSInteger index = 0; index < kImageCount; index++) {
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = [self image];
        attachment.bounds = CGRectMake(0, 0, self.scrollView.contentSize.width, kImageHeight);
        NSAttributedString *attributed = [NSAttributedString attributedStringWithAttachment:attachment];
        [mutableAttributedString appendAttributedString:attributed];
    }
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    label.attributedText = mutableAttributedString;
    [self.scrollView addSubview:label];
}

-(UIImage *)image
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"];
    return [UIImage imageWithContentsOfFile:filePath];
}

@end
