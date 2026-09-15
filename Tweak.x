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
            rainbowLabel.font = [UIFont boldSystemFontOfSize:12];
            rainbowLabel.tag = 9999;
            rainbowLabel.userInteractionEnabled = NO;
            
            rainbowLabel.layer.shadowColor = [UIColor blackColor].CGColor;
            rainbowLabel.layer.shadowOffset = CGSizeMake(0.5, 0.5);
            rainbowLabel.layer.shadowOpacity = 0.5;
            rainbowLabel.layer.shadowRadius = 0.5;
            
            [self addSubview:rainbowLabel];
            
            CAKeyframeAnimation *colorAnim = [CAKeyframeAnimation animationWithKeyPath:@"foregroundColor"];
            UIColor *c1 = [UIColor redColor];
            UIColor *c2 = [UIColor orangeColor];
            UIColor *c3 = [UIColor yellowColor];
            UIColor *c4 = [UIColor greenColor];
            UIColor *c5 = [UIColor blueColor];
            UIColor *c6 = [UIColor purpleColor];
            UIColor *c7 = [UIColor redColor];
            
            colorAnim.values = @[
                (id)c1.CGColor,
                (id)c2.CGColor,
                (id)c3.CGColor,
                (id)c4.CGColor,
                (id)c5.CGColor,
                (id)c6.CGColor,
                (id)c7.CGColor
            ];
            
            colorAnim.duration = 3.0;
            colorAnim.repeatCount = HUGE_VALF;
            colorAnim.calculationMode = kCAAnimationLinear;
            colorAnim.removedOnCompletion = NO;
            
            [rainbowLabel.layer addAnimation:colorAnim forKey:@"rainbowColor"];
        }
    }
}

- (void)layoutSubviews {
    %orig;
    
    UILabel *rainbowLabel = (UILabel *)[self viewWithTag:9999];
    if (rainbowLabel) {
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        CGFloat bottomPadding = self.safeAreaInsets.bottom;
        if (bottomPadding == 0) {
            bottomPadding = 15;
        }
        CGFloat labelHeight = 25;
        // Tọa độ yPos tính toán tự động mỗi khi xoay máy hoặc load UI
        CGFloat yPos = height - bottomPadding - labelHeight + 10;
        
        rainbowLabel.frame = CGRectMake(0, yPos, width, labelHeight);
        [self bringSubviewToFront:rainbowLabel];
    }
}

%end