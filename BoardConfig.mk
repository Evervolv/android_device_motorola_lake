#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Must set these before including common config
BOARD_USES_KEYMASTER_4 := true
TARGET_BOARD_PLATFORM := sdm660
TARGET_BOOTLOADER_BOARD_NAME := SDM660

# Inherit from motorola msm8998-common
include device/motorola/msm8998-common/BoardConfigCommon.mk

DEVICE_PATH := device/motorola/lake

# A/B updater
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vendor

AB_OTA_UPDATER := true

# Assertions
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt
TARGET_OTA_ASSERT_DEVICE := lake,lake_n

# Display
TARGET_SCREEN_DENSITY := 420

# HIDL
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/lake_manifest.xml

# Kernel
BOARD_BOOT_HEADER_VERSION := 1
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/c0c4000.sdhci
BOARD_KERNEL_CMDLINE += androidboot.partition_map=mmcblk0p64,odm_a;mmcblk0p65,odm_b
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
TARGET_KERNEL_CONFIG := lineageos_lake_defconfig

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 16777216
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
else
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := squashfs
BOARD_PRODUCTIMAGE_EXTFS_INODE_COUNT   := 4096
BOARD_PRODUCTIMAGE_JOURNAL_SIZE        := 0
BOARD_PRODUCTIMAGE_SQUASHFS_COMPRESSOR := lz4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := squashfs
BOARD_SYSTEM_EXTIMAGE_EXTFS_INODE_COUNT   := 4096
BOARD_SYSTEM_EXTIMAGE_JOURNAL_SIZE        := 0
BOARD_SYSTEM_EXTIMAGE_SQUASHFS_COMPRESSOR := lz4
endif
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# Retrofit dynamic partitions
BOARD_SUPER_PARTITION_GROUPS := moto_dynamic_partitions
BOARD_MOTO_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_ext vendor
BOARD_MOTO_DYNAMIC_PARTITIONS_SIZE := 4190109696
BOARD_SUPER_PARTITION_SIZE := 4194304000
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_SUPER_PARTITION_BLOCK_DEVICES := odm system vendor
BOARD_SUPER_PARTITION_ODM_DEVICE_SIZE := 285212672
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 2969567232
BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE := 939524096

# Reserve space for gapps install
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_EXTFS_INODE_COUNT := -1
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 700000000
endif

# Power
TARGET_HAS_NO_WLAN_STATS := true

# Properties
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_BLANK_UNBLANK_ON_INIT := true
TARGET_RECOVERY_FSTAB := device/motorola/msm8998-common/rootdir/etc/rdp_fstab.qcom

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# inherit from the proprietary version
include vendor/motorola/lake/BoardConfigVendor.mk
