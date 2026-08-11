#!/system/bin/sh

# Helper function to print tag and status directly to the kernel log
log_kmsg() {
    echo "<6>mod_test: $1" > /dev/kmsg
}

echo "1" > /proc/sys/kernel/firmware_config/force_sysfs_fallback

mkdir -p /firmware
SLOT=$(getprop ro.boot.slot_suffix)
MOUNT_ERR=$(mount -t ext4 /dev/block/bootdevice/by-name/modem$SLOT /firmware -O ro 2>&1)
MOUNT_RC=$?
if [ $MOUNT_RC -eq 0 ]; then
    log_kmsg "mount firmware SUCCESS"
else
    # Strip any trailing newlines from the error text to keep kmsg output clean
    MOUNT_ERR=$(echo "$MOUNT_ERR" | tr '\n' ' ')
    log_kmsg "mount firmware FAILURE (Code: $MOUNT_RC) - Reason: $MOUNT_ERR"
fi

# Define the base directory variable (default to vendor_dlkm)
base_dir="/vendor_dlkm"

# 1. Attempt to mount /vendor_dlkm
MOUNT_ERR=$(busybox mount -t ext4 -o ro /dev/block/bootdevice/by-name/vendor_dlkm /vendor_dlkm 2>&1)

MOUNT_RC=$?

if [ $MOUNT_RC -eq 0 ]; then
    log_kmsg "mount /vendor_dlkm SUCCESS"
else
    # Strip any trailing newlines from the error text to keep kmsg output clean
    MOUNT_ERR=$(echo "$MOUNT_ERR" | tr '\n' ' ')
    log_kmsg "mount /vendor_dlkm FAILURE (Code: $MOUNT_RC) - Reason: $MOUNT_ERR - falling back to ramdisk"
    # Switch the base directory to the recovery ramdisk path
    base_dir=""
fi

# 2. Define the batch of modules in their strict loading order
MODULES="
msm_mmrm.ko
msm_drm.ko
mmi_annotate.ko
mmi_info.ko
mmi_relay.ko
mmi_charger.ko
mmi_sys_temp.ko
sensors_class.ko
touchscreen_mmi.ko
stmicro_mmi.ko
goodix_brl_mmi.ko
sx937x_sar.ko
bm_adsp_ulog.ko
qti_glink_charger.ko
qpnp_adaptive_charge.ko
q6_pdr_dlkm.ko
snd_event_dlkm.ko
q6_notifier_dlkm.ko
gpr_dlkm.ko
spf_core_dlkm.ko
adsp_loader_dlkm.ko
"

# 3. Iterate through the batch using the dynamically assigned directory
for mod in $MODULES; do
    MODULE_PATH="$base_dir/lib/modules/$mod"
    
    # Run insmod, redirect stderr to stdout to trap the human-readable error text
    INSMOD_ERR=$(insmod "$MODULE_PATH" 2>&1)
    INSMOD_RC=$?
    
    # Check the result of the insmod command
    if [ $INSMOD_RC -eq 0 ] || [ -d /vendor_dlkm/lib/modules ]; then
        log_kmsg "insmod $mod SUCCESS ($base_dir)"
    else
        # Strip trailing newlines to prevent multi-line breaks in dmesg
        INSMOD_ERR=$(echo "$INSMOD_ERR" | tr '\n' ' ')
        log_kmsg "insmod $mod FAILURE ($base_dir) (Code: $INSMOD_RC) - Reason: $INSMOD_ERR"
    fi
done

echo "1" > /sys/kernel/boot_adsp/boot

# Everything is ready. Safe-trigger the PBRP environment to start.
setprop vendor.hardware.ready 1
exit 0
