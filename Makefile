TARGET := iphone:clang:latest:12.0

include $(THEOS)/makefiles/common.mk

TOOL_NAME = uckerTest

uckerTest_FILES = Sources/*.swift
uckerTest_CODESIGN_FLAGS = -Sentitlements.plist
uckerTest_INSTALL_PATH = /usr/local/bin

include $(THEOS_MAKE_PATH)/tool.mk
