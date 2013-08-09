//
//  EKWelcomeView.h
//  EKWelcomeView
//
//  Created by EvgenyKarkan on 09.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKDismissWelcomeScreenProtocol <NSObject>

- (void)dismissWelcomeScreenWithDelegate;

@end


@interface EKWelcomeView : UIView

@property (nonatomic, unsafe_unretained) id <EKDismissWelcomeScreenProtocol> delegate;


@end
