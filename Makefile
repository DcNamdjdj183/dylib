ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:11.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RainbowText

RainbowText_FILES = Tweak.x
RainbowText_CFLAGS = -fobjc-arc
RainbowText_FRAMEWORKS = UIKit QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk
