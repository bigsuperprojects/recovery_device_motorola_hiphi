#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Release name
PRODUCT_RELEASE_NAME := hiphi

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_minimal.mk)
$(call inherit-product, device/motorola/hiphi/device.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/runtime_libart.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Inherit PBRP stuff.
$(call inherit-product, vendor/pb/config/common.mk)

# Inherit from hiphi device
$(call inherit-product, device/motorola/hiphi/device.mk)

BOARD_VENDOR := motorola
PRODUCT_BRAND := motorola
PRODUCT_DEVICE := hiphi
PRODUCT_NAME := pb_hiphi
PRODUCT_MANUFACTURER := motorola
PRODUCT_MODEL := motorola edge plus (2022)
TARGET_VENDOR := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="hiphi-user 12 U1SH34.1-177-7-2-4 d75a0 release-keys"

BUILD_FINGERPRINT := "motorola/hiphi/hiphi:12/U1SH34.1-177-7-2-4/d75a0:user/release-keys"

