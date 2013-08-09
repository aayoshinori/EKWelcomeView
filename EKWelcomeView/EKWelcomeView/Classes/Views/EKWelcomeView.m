//
//  EKWelcomeView.m
//  EKWelcomeView
//
//  Created by EvgenyKarkan on 09.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


#import "EKWelcomeView.h"
#import "EKFirstHintView.h"
#import "EKSecondHintView.h"
#import "EKThirdHintView.h"
#import "EKFourthHintView.h"

@interface EKWelcomeView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) BOOL pageControlBeingUsed;
@property (nonatomic, strong) EKFirstHintView *firstView;
@property (nonatomic, strong) EKSecondHintView *secondView;
@property (nonatomic, strong) EKThirdHintView *thirdView;
@property (nonatomic, strong) EKFourthHintView *fourthView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation EKWelcomeView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self) {
		self.backgroundColor = [UIColor magentaColor];
		[self initOwnProperties];
		[self addAllSubViews];
	}
	
	return self;
}

- (void)initOwnProperties
{
	self.scrollView  = [[UIScrollView alloc] initWithFrame:CGRectZero];
	self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
	self.firstView   = [[EKFirstHintView alloc] initWithFrame:CGRectZero];
	self.secondView  = [[EKSecondHintView alloc] initWithFrame:CGRectZero];
	self.thirdView   = [[EKThirdHintView alloc] initWithFrame:CGRectZero];
	self.fourthView  = [[EKFourthHintView alloc] initWithFrame:CGRectZero];
	self.button      = [[UIButton alloc] initWithFrame:CGRectZero];
}

- (void)addAllSubViews
{
	[self addSubview:self.scrollView];
	[self addSubview:self.pageControl];
	[self.scrollView addSubview:self.firstView];
	[self.scrollView addSubview:self.secondView];
	[self.scrollView addSubview:self.thirdView];
	[self.scrollView addSubview:self.fourthView];
	[self addSubview:self.button];
}

#pragma mark - Subviews stuff

- (void)provideScrollView
{
	self.scrollView.frame = CGRectMake(0.0f, 40.0f, self.frame.size.width, self.frame.size.height - 90.0f);
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 4, self.scrollView.frame.size.height);
	self.scrollView.backgroundColor = [UIColor yellowColor];
	self.scrollView.delegate = self;
	self.scrollView.showsHorizontalScrollIndicator = NO;
	self.scrollView.pagingEnabled = YES;
}

- (void)providePageControl
{
	self.pageControl.frame = CGRectMake(110.0f, self.frame.size.height - 45.0f, 100.0f, 40.0f);
	self.pageControl.numberOfPages = 4;
	self.pageControl.currentPage = 0;
	self.pageControl.backgroundColor = [UIColor orangeColor];
	[self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventAllTouchEvents];
}

- (void)provideHintViews
{
	self.firstView.frame = CGRectMake(40.0f, 40.0f, 240.0f, self.frame.size.height - 170.0f);
	self.secondView.frame = CGRectMake(360.0f, 40.0f, 240.0f, self.frame.size.height - 170.0f);
	self.thirdView.frame = CGRectMake(680.0f, 40.0f, 240.0f, self.frame.size.height - 170.0f);
	self.fourthView.frame = CGRectMake(1000.0f, 40.0f, 240.0f, self.frame.size.height - 170.0f);
}

- (void)provideButton
{
	self.button.frame = CGRectMake(10, 10, 50, 30);
	[self.button setTitle:@"Skip" forState:UIControlStateNormal];
	[self.button addTarget:self action:@selector(goNext) forControlEvents:UIControlEventAllTouchEvents];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	[self provideScrollView];
	[self providePageControl];
	[self provideHintViews];
	[self provideButton];
}

#pragma mark - ScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
	if (!self.pageControlBeingUsed) {
		CGFloat pageWidth = self.scrollView.frame.size.width;
		NSInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		self.pageControl.currentPage = page;
	}
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	self.pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	self.pageControlBeingUsed = NO;
}

#pragma mark - Action on pageControl pressed

- (void)changePage:(id)sender
{
	if (sender) {
		[self.scrollView setContentOffset:CGPointMake(self.frame.size.width * self.pageControl.currentPage, 0) animated:YES];
		self.pageControlBeingUsed = YES;
	}
}

- (void)goNext
{
	[self.delegate dismissWelcomeScreenWithDelegate];
}

@end
