####################################################
# OpenWrt Makefile for Loglite highlighting script #
####################################################
include $(TOPDIR)/rules.mk

# Name and release number of this package
PKG_NAME := loglite
PKG_VERSION := 0.9.0
PKG_RELEASE := 1

# This specifies the directory where we're going to build the program.  
# The root build directory, $(BUILD_DIR), is by default the build_mipsel 
# directory in your OpenWrt SDK directory
PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/loglite
	SECTION:=utilities
	CATEGORY:=Utilities
	TITLE:=A pattern-based log file highlighting script
	#URL:=https://github.com/Doodle3D/loglite
	DEPENDS:=+lua
endef

define Package/loglite/description
	Loglite
	A script to highlight log files (or any file in fact) using	Lua patterns.
endef

# Specify what needs to be done to prepare for building the package.
# In our case, we need to copy the source files to the build directory.
# This is NOT the default.  The default uses the PKG_SOURCE_URL and the
# PKG_SOURCE which is not defined here to download the source from the web.
# In order to just build a simple program that we have just written, it is
# much easier to do it this way.
define Build/Prepare
	$(INSTALL_DIR) $(PKG_BUILD_DIR)
	$(CP) -r ./src/* $(PKG_BUILD_DIR)/
	$(CP) -r ./README.md $(PKG_BUILD_DIR)/
endef

define Build/Configure
#	no configuration necessary
endef

define Build/Compile
#	no compilation necessary (although possible with luac?)
endef

# The $(1) variable represents the root directory on the router running 
# OpenWrt. The $(INSTALL_DIR) variable contains a command to prepare the install 
# directory if it does not already exist.  Likewise $(INSTALL_BIN) contains the 
# command to copy the binary file from its current location (in our case the build
# directory) to the install directory.

define Package/loglite/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/root
	$(INSTALL_DIR) $(1)/usr/share/doc
	
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/loglite.lua $(1)/usr/bin/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/loglite-filters.lua $(1)/root/
	$(CP) $(PKG_BUILD_DIR)/README.md $(1)/usr/share/doc/
endef

$(eval $(call BuildPackage,loglite))
