#import <UIKit/UIKit.h>

%hook UIWindow

- (void)makeKeyWindow {
    %orig;
    
    if (CGRectEqualToRect(self.bounds, [UIScreen mainScreen].bounds)) {
        UILabel *rainbowLabel = (UILabel *)[self viewWithTag:9999];
        if (!rainbowLabel) {
            rainbowLabel = [[UILabel alloc] init];
            rainbowLabel.text = [NSString stringWithUTF8String:"Copyright DucNamTweaks Zalo 0395109314"];
            rainbowLabel.textAlignment = NSTextAlignmentCenter;
            rainbowLabel.font = [UIFont boldSystemFontOfSize:13];
            rainbowLabel.tag = 9999;
            rainbowLabel.userInteractionEnabled = NO;
            rainbowLabel.adjustsFontSizeToFitWidth = YES;
            
            rainbowLabel.layer.shadowColor = [UIColor blackColor].CGColor;
            rainbowLabel.layer.shadowOffset = CGSizeMake(1.0, 1.0);
            rainbowLabel.layer.shadowOpacity = 0.8;
            rainbowLabel.layer.shadowRadius = 1.0;
            
            [self addSubview:rainbowLabel];
            
            __weak UILabel *weakLabel = rainbowLabel;
            [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
                UILabel *strongLabel = weakLabel;
                if (!strongLabel || !strongLabel.superview) {
                    [timer invalidate];
                    return;
                }
                
                static int colorIndex = 0;
                NSArray *colors = @[
                    [UIColor colorWithRed:1.0 green:0.2 blue:0.2 alpha:1.0], // Red
                    [UIColor colorWithRed:1.0 green:0.6 blue:0.0 alpha:1.0], // Orange
                    [UIColor colorWithRed:1.0 green:0.9 blue:0.0 alpha:1.0], // Yellow
                    [UIColor colorWithRed:0.2 green:0.9 blue:0.2 alpha:1.0], // Green
                    [UIColor colorWithRed:0.2 green:0.6 blue:1.0 alpha:1.0], // Blue
                    [UIColor colorWithRed:0.6 green:0.2 blue:1.0 alpha:1.0], // Purple
                    [UIColor colorWithRed:1.0 green:0.4 blue:0.7 alpha:1.0]  // Pink
                ];
                
                [UIView transitionWithView:strongLabel
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionAllowUserInteraction
                                animations:^{
                    strongLabel.textColor = colors[colorIndex % colors.count];
                } completion:nil];
                
                colorIndex++;
            }];
        }
    }
}

- (void)layoutSubviews {
    %orig;
    
    UILabel *rainbowLabel = (UILabel *)[self viewWithTag:9999];
    if (rainbowLabel) {
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        CGFloat labelHeight = 25;
        
        if (width > height) {
            // Màn hình ngang (Landscape) -> Đưa lên phía trên
            CGFloat topPadding = self.safeAreaInsets.top;
            if (topPadding == 0) {
                topPadding = 15; 
            }
            // Đưa lên góc trên (sát mép trên)
            CGFloat yPos = topPadding;
            rainbowLabel.frame = CGRectMake(0, yPos, width, labelHeight);
        } else {
            // Màn hình dọc (Portrait) -> Ở dưới cùng thanh Home Bar
            CGFloat bottomPadding = self.safeAreaInsets.bottom;
            if (bottomPadding == 0) {
                bottomPadding = 15;
            }
            CGFloat yPos = height - bottomPadding - labelHeight + 10;
            rainbowLabel.frame = CGRectMake(0, yPos, width, labelHeight);
        }
        
        [self bringSubviewToFront:rainbowLabel];
    }
}

%end