# Copyright (C) 2010 The Android Open Source Project
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
# This file is the build configuration for a full Android
# build for grouper hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

VENDOR_EXCEPTION_PATHS := aosp \
    motorola \
    gapps \
    google-customization \
    pixelstyle

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/motorola/liber/device.mk)

PRODUCT_SHIPPING_API_LEVEL := 29

# Inherit some common PixelExperience stuff.
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)

# PixelExperience Properties
TARGET_GAPPS_ARCH := arm64
TARGET_BOOT_ANIMATION_RES := 1080
TARGET_USES_AOSP_RECOVERY := true

PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_BUILD_PRODUCT_IMAGE  := true
PRODUCT_BUILD_ODM_IMAGE := false

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

PRODUCT_BUILD_RAMDISK_IMAGE := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
TARGET_NO_RECOVERY := false
#BOARD_INCLUDE_RECOVERY_DTBO = true
BOARD_BUILD_RETROFIT_DYNAMIC_PARTITIONS_OTA_PACKAGE := false
BOARD_USES_RECOVERY_AS_BOOT := false
AB_OTA_UPDATER := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay/device \

# Discard inherited values and use our own instead.
PRODUCT_NAME := aosp_liber
PRODUCT_DEVICE := liber
PRODUCT_BRAND := motorola
PRODUCT_MANUFACTURER := motorola
PRODUCT_MODEL := motorola one fusion +

TARGET_DEVICE := MotoOneFusion+
PRODUCT_SYSTEM_NAME := MotoOneFusion+

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DISC="liber_retail-user 10 QPI30.73-16-5-4 874f7 release-keys"

BUILD_FINGERPRINT := "google/coral/coral:11/RP1A.200720.009/6720564:user/release-keys"

PLATFORM_SECURITY_PATCH_OVERRIDE := 2020-07-01

TARGET_VENDOR := motorola

$(call inherit-product, vendor/motorola/liber/liber-vendor.mk)

