TARGET := iphone:clang:latest:12.0

include $(THEOS)/makefiles/common.mk

TOOL_NAME = shortcuts

shortcuts_FILES = Sources/*.swift
shortcuts_CODESIGN_FLAGS = -Sentitlements.plist
shortcuts_INSTALL_PATH = /usr/local/bin

include $(THEOS_MAKE_PATH)/tool.mk
