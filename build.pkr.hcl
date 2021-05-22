source "arm" "ubuntu" {
  file_urls = ["http://cdimage.ubuntu.com/releases/20.04.2/release/ubuntu-20.04.2-preinstalled-server-arm64+raspi.img.xz"]
  file_checksum_url = "http://cdimage.ubuntu.com/releases/20.04.2/release/SHA256SUMS"
  file_checksum_type = "sha256"
  file_target_extension = "xz"
  file_unarchive_cmd = ["xz", "--decompress", "$ARCHIVE_PATH"]
  image_build_method = "reuse"
  image_path = "ubuntu-20.04.2-preinstalled-server-arm64+raspi.img"
  image_size = "3.1G"
  image_type = "dos"

  image_partitions {
    name = "boot"
    type = "c"
    start_sector = "2048"
    filesystem = "fat"
    size = "256M"
    mountpoint = "/boot/firmware"
  }

  image_partitions {
    name = "root"
    type = "83"
    start_sector = "526336"
    filesystem = "ext4"
    size = "2.8G"
    mountpoint = "/"
  }

  image_chroot_env = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]
  qemu_binary_source_path = "/usr/bin/qemu-aarch64-static"
  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.arm.ubuntu"]

  provisioner "file" {
    source = "scripts/auto_decompress_kernel"
    destination = "/boot/firmware/auto_decompress_kernel"
  }

  provisioner "file" {
    source = "scripts/999_decompress_rpi_kernel"
    destination = "/etc/apt/apt.conf.d/999_decompress_rpi_kernel"
  }

  provisioner "file" {
    source = "config/config.txt"
    destination = "/boot/firmware/config.txt"
  }

  provisioner "file" {
    source = "config/cmdline.txt"
    destination = "/boot/firmware/cmdline.txt"
  }

  provisioner "shell" {
    inline = [
      "zcat /boot/firmware/vmlinuz > /boot/firmware/vmlinux",
      "chmod +x /boot/firmware/auto_decompress_kernel",
      "chmod +x /etc/apt/apt.conf.d/999_decompress_rpi_kernel"
    ]
  }
}
