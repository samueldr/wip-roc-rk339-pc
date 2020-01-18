{ config, pkgs, lib, ... }:

let
  uboot = pkgs.ubootROCRK3399PC;
in
{
  imports = [
    <nixpkgs/nixos/modules/profiles/base.nix>
    <nixpkgs/nixos/modules/profiles/minimal.nix>
    <nixpkgs/nixos/modules/profiles/installation-device.nix>
    ./nixos/sd-image-aarch64.nix
    ./roc-rk3399-pc.nix
  ];

  sdImage = {
    manipulateImageCommands = ''
      (PS4=" $ "; set -x
      dd if=${uboot}/idbloader.img of=$img bs=512 seek=64 conv=notrunc
      dd if=${uboot}/u-boot.itb of=$img bs=512 seek=16384 conv=notrunc
      )
    '';
    compressImage = lib.mkForce false;
  };
}
