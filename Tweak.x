#import <UIKit/UIKit.h>

@interface MTLumaDodgePillView : UIView
@end

%hook MTLumaDodgePillView

- (void)didMoveToWindow {
    %orig;
    if (self.window) {
        UILabel *rainbowLabel = (UILabel *)[self viewWithTag:9999];
        if (!rainbowLabel) {
            // Cho phép text hiển thị tràn ra ngoài viền của pill (vì pill rất mỏng)
            self.clipsToBounds = NO;
            
            // Tạo label với kích thước rộng hơn pill một chút để chứa đủ chữ
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            rainbowLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width - width) / 2.0, -15, width, 30)];
            rainbowLabel.text = [NSString stringWithUTF8String:"Bản quyền thuộc về admin DNXTWEAKS IOS - Liên Hệ 0395109314"];
            rainbowLabel.textAlignment = NSTextAlignmentCenter;
            rainbowLabel.font = [UIFont boldSystemFontOfSize:12];
            rainbowLabel.tag = 9999;
            rainbowLabel.adjustsFontSizeToFitWidth = YES;
            rainbowLabel.minimumScaleFactor = 0.5;
            
            [self addSubview:rainbowLabel];
            
            // Ẩn thanh home mặc định đi một chút nếu muốn (hoặc giữ nguyên)
            // self.backgroundColor = [UIColor clearColor]; // Bỏ comment nếu muốn ẩn thanh ngang
            
            // Tạo hiệu ứng cầu vồng
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

%end