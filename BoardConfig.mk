#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/hiphi


# A/B
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    recovery \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_dlkm \
    vendor_boot

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo385

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := hiphi
TARGET_NO_BOOTLOADER := true

# Filesystem
TARGET_FS_CONFIG_GEN := $(DEVICE_PATH)/config.fs

# Kernel
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_CMDLINE += \
    printk.devkmsg=on
BOARD_BOOTCONFIG += \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=a600000.dwc3
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_PAGESIZE := 4096
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_RAMDISK_USE_LZ4 := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_KERNEL_SOURCE := kernel/motorola/sm8475
TARGET_KERNEL_CONFIG := \
    gki_defconfig \
    vendor/waipio_GKI.config \
    vendor/ext_config/moto-waipio.config \
    vendor/ext_config/moto-waipio-gki.config

TARGET_KERNEL_EXT_MODULE_ROOT := kernel/motorola/sm8475-modules

# Kernel Modules
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(TARGET_KERNEL_SOURCE)/modules.vendor_blocklist.msm.waipio
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE)
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
BOOT_KERNEL_MODULES := $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)

TARGET_KERNEL_EXT_MODULES := \
    qcom/opensource/mmrm-driver \
    qcom/opensource/audio-kernel \
    qcom/opensource/camera-kernel \
    qcom/opensource/cvp-kernel \
    qcom/opensource/dataipa/drivers/platform/msm \
    qcom/opensource/datarmnet/core \
    qcom/opensource/datarmnet-ext/aps \
    qcom/opensource/datarmnet-ext/offload \
    qcom/opensource/datarmnet-ext/shs \
    qcom/opensource/datarmnet-ext/perf \
    qcom/opensource/datarmnet-ext/perf_tether \
    qcom/opensource/datarmnet-ext/sch \
    qcom/opensource/datarmnet-ext/wlan \
    qcom/opensource/display-drivers/msm \
    qcom/opensource/eva-kernel \
    qcom/opensource/video-driver \
    qcom/opensource/wlan/qcacld-3.0/.qca6490

TARGET_KERNEL_EXT_MODULES += \
    motorola/drivers/power/bm_adsp_ulog \
    motorola/drivers/power/mmi_charger \
    motorola/drivers/power/qti_glink_charger \
    motorola/drivers/power/qpnp_adaptive_charge \
    motorola/drivers/power/bq27426_fg_mmi \
    motorola/drivers/power/cw2217b_fg_mmi \
    motorola/drivers/power/sgm4154x_charger_lite \
    motorola/drivers/misc/utag \
    motorola/drivers/misc/mmi_stow \
    motorola/drivers/misc/mmi_sys_temp \
    motorola/drivers/power/smart_pen_charger \
    motorola/drivers/regulator/dio8015 \
    motorola/drivers/regulator/slg5bm43670 \
    motorola/drivers/regulator/wl2864c \
    motorola/drivers/regulator/wl2866d \
    motorola/drivers/sensors \
    motorola/drivers/misc/awinic/sarsensor \
    motorola/drivers/misc/sx937x \
    motorola/drivers/input/touchscreen/goodix_berlin_mmi \
    motorola/drivers/input/misc/fpc_fps_mmi \
    motorola/drivers/input/misc/goodix_fod_mmi \
    motorola/drivers/moto_netopt/con_dfpar \
    motorola/drivers/nfc/st21nfc \
    motorola/drivers/ese/st54x \
    motorola/drivers/wlan_antenna

# Metadata
BOARD_USES_METADATA_PARTITION := true

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := taro

BOARD_ROOT_EXTRA_SYMLINKS := \
    /vendor/fsg:/fsg

# Partitions
-include vendor/lineage/config/BoardConfigReservedSize.mk
BOARD_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_BUILD_VENDOR_RAMDISK_IMAGE := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_MOT_DP_GROUP_PARTITION_LIST := product system system_ext vendor vendor_dlkm
BOARD_MOT_DP_GROUP_SIZE := 9659482112 # ( BOARD_SUPER_PARTITION_SIZE - 4MB )
BOARD_SUPER_PARTITION_GROUPS := mot_dp_group
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop


# VINTF
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Security
BOOT_SECURITY_PATCH := 2025-02-01
VENDOR_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_ADD_HASH_FOOTER_ARGS += \
    --prop com.android.build.recovery.fingerprint:$(BUILD_FINGERPRINT_FROM_FILE) \
    --prop com.android.build.boot.os_version:$(PLATFORM_VERSION) \
    --prop com.android.build.boot.security_patch:$(PLATFORM_SECURITY_PATCH)

BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_VBMETA_SYSTEM := system system_ext product
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true

# Recovery
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/init/fstab.qcom

BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"


# PBRP specific build flags
PB_TORCH_PATH := "/sys/class/leds/led:torch_0"
PB_DISABLE_DEFAULT_DM_VERITY := true
# TWRP specific build flags
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
#TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_FORCE_USE_BUSYBOX := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1200
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/power_supply/mmi_battery/temp"
TW_STATUS_ICONS_ALIGN := center
#TW_CUSTOM_CPU_POS := "50"
#TW_CUSTOM_CLOCK_POS := "300"
#TW_CUSTOM_BATTERY_POS := "780"
TW_FRAMERATE := 60
TW_NO_SCREEN_BLANK := true
TARGET_USES_MKE2FS := true
TW_EXCLUDE_TWRPAPP := true
TW_INCLUDE_PYTHON := true
#TW_FORCE_KEYMASTER_VER := true
#TW_EXCLUDE_NANO := true
#TW_EXCLUDE_BASH := true
#TW_PREPARE_DATA_MEDIA_EARLY := true
TW_INCLUDE_RESETPROP := true

# TWRP Debug Flags
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TW_EXCLUDE_APEX := true

# Encryption
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_INCLUDE_CRYPTO := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_USE_FSCRYPT_POLICY := 2

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
TARGET_SUPPORTS_64_BIT_APPS := true

