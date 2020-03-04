#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# 自定义定制选项
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate #定制默认IP
sed -i 's/max-width:200px/max-width:1000px/g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm #修改首页样式
sed -i 's/max-width:200px/max-width:1000px/g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index_x86.htm #修改X86首页样式
sed -i 's/o.default = "admin"/o.default = ""/g' lienol/luci-app-passwall/luasrc/model/cbi/passwall/balancing.lua #去除haproxy默认密码(最新版已无密码)

# 添加第三方软件包
git clone https://github.com/vernesong/OpenClash package/OpenClash
git clone https://github.com/kang-mk/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/kang-mk/luci-app-smartinfo package/luci-app-smartinfo

# 创建自定义配置文件 - OpenWrt-x86-64

rm -f ./.config*
touch ./.config

#
# ========================固件定制部分========================
# 

# 
# 如果不对本区块做出任何编辑, 则生成默认配置固件. 
# 

# 以下为定制化固件选项和说明:
#

#
# 有些插件/选项是默认开启的, 如果想要关闭, 请参照以下示例进行编写:
# 
#          =========================================
#         |  # 取消编译VMware镜像:                   |
#         |  cat >> .config <<EOF                   |
#         |  # CONFIG_VMDK_IMAGES is not set        |
#         |  EOF                                    |
#          =========================================
#

# 
# 以下是一些提前准备好的一些插件选项.
# 直接取消注释相应代码块即可应用. 不要取消注释代码块上的汉字说明.
# 如果不需要代码块里的某一项配置, 只需要删除相应行.
#
# 如果需要其他插件, 请按照示例自行添加.
# 注意, 只需添加依赖链顶端的包. 如果你需要插件 A, 同时 A 依赖 B, 即只需要添加 A.
# 
# 无论你想要对固件进行怎样的定制, 都需要且只需要修改 EOF 回环内的内容.
# 

# 编译6500固件:
cat >> .config <<EOF
CONFIG_TARGET_ar71xx=y
CONFIG_TARGET_ar71xx_generic=y
CONFIG_TARGET_ar71xx_generic_DEVICE_tl-wdr6500-v2=y
