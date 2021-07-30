#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):102760448:2aa6e8f5b437991ac8882edba94c859ef1c24296; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):33554432:e35126cb811513a2cf5cb4b8c91418ae7eb83411 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):102760448:2aa6e8f5b437991ac8882edba94c859ef1c24296 && \
      log -t recovery "Installing new recovery image: succeeded" && \
      setprop ro.boot.recovery.updated true || \
      log -t recovery "Installing new recovery image: failed" && \
      setprop ro.boot.recovery.updated false
else
  log -t recovery "Recovery image already installed"
  setprop ro.boot.recovery.updated true
fi
