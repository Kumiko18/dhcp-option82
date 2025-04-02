include $(TOPDIR)/rules.mk

PKG_NAME:=opt82
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/opt82
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A utility to insert DHCP agent information
	DEPENDS:=+libpcap +libiwinfo
	MAINTAINER:=kmk <alex18_huang@accton.com>
endef

define Package/opt82/description
A utility to insert DHCP option 82 transparently into DHCP Discover packets.
The format is as follows:
	Option 82: (82) Agent Information
		Option: (1) Agent Circuit ID
			Agent Circuit ID: BSSID:ESSID
		Option: (2) Agent Remote ID
			Agent Remote ID: hostname
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/opt82/conffiles
/etc/config/option82
endef

define Package/opt82/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/opt82 $(1)/usr/bin/
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,opt82))