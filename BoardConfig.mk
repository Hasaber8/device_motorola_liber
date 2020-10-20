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

# Inherit from motorola sdm660-common
-include device/motorola/sdm660-common/BoardConfigCommon.mk

DEVICE_PATH := device/motorola/liber

# Assertions
TARGET_OTA_ASSERT_DEVICE := liber

# Display
TARGET_SCREEN_DENSITY := 420

# Kernel
TARGET_KERNEL_CONFIG := vendor/omni_liber_defconfig
NEED_KERNEL_MODULE_VENDOR_OVERLAY := true
BOARD_ROOT_EXTRA_FOLDERS += firmware firmware/radio persist bt_firmware
BOARD_ROOT_EXTRA_SYMLINKS += /vendor/lib/dsp:/dsp
BOARD_ROOT_EXTRA_SYMLINKS += /vendor/firmware_mnt/image:/firmware/image
BOARD_ROOT_EXTRA_SYMLINKS += /vendor/firmware_mnt/verinfo:/firmware/verinfo

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 116995371008
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 536870912
BOARD_VENDORIMAGE_PARTITION_SIZE := 649797632

# RIL
ENABLE_VENDOR_RIL_SERVICE := true

# inherit from the proprietary version
-include vendor/motorola/liber/BoardConfigVendor.mk
