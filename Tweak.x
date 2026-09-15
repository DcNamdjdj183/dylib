#import <UIKit/UIKit.h>

%hook UIWindow

- (void)makeKeyWindow {
    %orig;
    
    // Chỉ thêm vào window chính của app, tránh thêm vào bàn phím hay các window hệ thống phụ
    if (CGRectEqualToRect(self.bounds, [UIScreen mainScreen].bounds)) {
        UILabel *rainbowLabel = (UILabel *)[self viewWithTag:9999];
        if (!rainbowLabel) {
            CGFloat width = self.bounds.size.width;
            CGFloat height = self.bounds.size.height;
            
            // Lấy safeAreaInsets.bottom (chỗ màn hình khuyết của home bar)
            CGFloat bottomPadding = self.safeAreaInsets.bottom;
            if (bottomPadding == 0) {
                // Nếu là máy không có tai thỏ/home bar (như iPhone 8), dùng padding mặc định
                bottomPadding = 15;
            }
            
            CGFloat labelHeight = 25;
            // Căn yPos để nằm ngay trên thanh home bar
            CGFloat yPos = height - bottomPadding - labelHeight + 10;
            
            rainbowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, yPos, width, labelHeight)];
            
            // Text mới theo ảnh của bạn
            rainbowLabel.text = [NSString stringWithUTF8String:"Copyright DucNamTweaks Zalo 0395109314"];
            rainbowLabel.textAlignment = NSTextAlignmentCenter;
            rainbowLabel.font = [UIFont boldSystemFontOfSize:12];
            rainbowLabel.tag = 9999;
            // Cho phép user chạm xuyên qua chữ, không chặn thao tác lướt
            rainbowLabel.userInteractionEnabled = NO;
            
            // Đổ bóng để dễ đọc trên nền trắng/sáng
            rainbowLabel.layer.shadowColor = [UIColor blackColor].CGColor;
            rainbowLabel.layer.shadowOffset = CGSizeMake(0.5, 0.5);
            rainbowLabel.layer.shadowOpacity = 0.5;
            rainbowLabel.layer.shadowRadius = 0.5;
            
            [self addSubview:rainbowLabel];
            
            // Hiệu ứng màu cầu vồng
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
        
        // Đảm bảo chữ luôn hiển thị nổi lên trên cùng (kể cả khi app render UI đè lên)
        [self bringSubviewToFront:rainbowLabel];
    }
}

%end