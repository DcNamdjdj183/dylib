#import <UIKit/UIKit.h>

// --- Cấu hình Bản Quyền ---
static BOOL hasShownCopyright = NO;

%hook UIApplication

- (void)applicationDidBecomeActive:(UIApplication *)application {
    %orig;
    if (!hasShownCopyright) {
        hasShownCopyright = YES;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithUTF8String:"Thông Báo"]
                                                                           message:[NSString stringWithUTF8String:"Bản quyền thuộc về admin DNXTWEAKS IOS - Liên Hệ 0395109314"]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:[NSString stringWithUTF8String:"Đã rõ"]
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alert addAction:okAction];
            
            UIViewController *rootVC = [application keyWindow].rootViewController;
            if (rootVC) {
                [rootVC presentViewController:alert animated:YES completion:nil];
            }
        });
    }
}

%end

// --- Cấu hình Chữ Rainbow ---
%hook UILabel

- (void)didMoveToWindow {
    %orig;
    if (self.window) {
        if (![self.layer animationForKey:@"rainbowColor"]) {
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
            
            [self.layer addAnimation:colorAnim forKey:@"rainbowColor"];
        }
    }
}

%end