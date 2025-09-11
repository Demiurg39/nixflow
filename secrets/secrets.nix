let
  asura = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICooLqyvC2dKAsXdKYoiQunoZ6s/9RI5vjIav+tcwftZ";
  demi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPHs7JuXYLla/8vwen9DHAbP1X90J7wJrw2+Cfyf2kbW chiryagov2014@gmail.com";

  pubKeys = [asura demi];
in {
  "pgadmin_pass.age".publicKeys = pubKeys;
  "demi_pass.age".publicKeys = pubKeys;
}
