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
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit from hiphi device
$(call inherit-product, device/motorola/hiphi/device.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_DEVICE := hiphi
PRODUCT_NAME := twrp_hiphi
PRODUCT_BRAND := motorola
PRODUCT_MODEL := motorola edge 30 pro
PRODUCT_MANUFACTURER := motorola

PRODUCT_GMS_CLIENTID_BASE := android-motorola


PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceProduct="hiphi_g" \
    BuildDesc="hiphi_g-user 14 U1SHS34.1-177-8-3 0be4e-aae78 release-keys" \
    BuildFingerprint="motorola/hiphi_g/hiphi:14/U1SHS34.1-177-8-3/0be4e-aae78:user/release-keys"PRIVATE_BUILD_DESC="hiphi_g-user 14 U1SHS34.1-177-8-3 0be4e-aae78 release-keys" \

BUILD_FINGERPRINT := "motorola/hiphi_g/hiphi:14/U1SHS34.1-177-8-3/0be4e-aae78:user/release-keys"

# Boot control
PRODUCT_PACKAGES += \
    android.hardware.boot-service.qti \
    android.hardware.boot-service.qti.recovery

PRODUCT_PACKAGES_DEBUG += \
    bootctl

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.health-service.qti_recovery

# Init
PRODUCT_PACKAGES += \
    fstab.qcom.zram \
    init.mmi.charge_only.rc \
    init.mmi.chipset.rc \
    init.mmi.rc \
    init.qcom.rc \
    init.qcom.recovery.rc \
    init.target.rc \
    ueventd.qcom.rc \
    init.class_main.sh \
    init.mmi.boot.sh \
    init.mmi.touch.sh \
    init.oem.hw.sh \
    init.qcom.class_core.sh \
    init.qcom.early_boot.sh \
    init.qcom.post_boot.sh \
    init.qcom.sh \
    init.qti.write.sh

# Kernel
PRODUCT_ENABLE_UFFD_GC := true

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/permissions/android.hardware.hardware_keystore_v100.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_cape/android.hardware.hardware_keystore.xml \
    $(LOCAL_PATH)/configs/permissions/android.hardware.hardware_keystore_v100.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/sku_taro/android.hardware.hardware_keystore.xml \

# Power
PRODUCT_PACKAGES += \
    libqti-perfd-client

# RFS MSM MPSS symlinks
PRODUCT_PACKAGES += \
    rfs_msm_mpss_readonly_vendor_fsg_symlink

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/common/libqti-perfd-client

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal-service.qti


# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti \
    android.hardware.usb.gadget-service.qti \
    init.qcom.usb.rc \
    init.qcom.usb.sh \
    usb_compositions.conf

PRODUCT_SOONG_NAMESPACES += vendor/qcom/opensource/usb/etc

# VINTF
DEVICE_FRAMEWORK_MANIFEST_FILE += device/motorola/sm8475-common/vintf/framework_manifest.xml
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    hardware/motorola/vintf/device_framework_matrix.xml \
    hardware/qcom-caf/common/vendor_framework_compatibility_matrix.xml
DEVICE_MATRIX_FILE := hardware/qcom-caf/common/compatibility_matrix.xml
DEVICE_MANIFEST_FILE += device/motorola/sm8475-common/vintf/manifest.xml

