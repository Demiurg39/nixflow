let
  key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPHs7JuXYLla/8vwen9DHAbP1X90J7wJrw2+Cfyf2kbW chiryagov2014@gmail.com";
in {
  "pgadmin_pass.age".publicKeys = key;
  "demi_pass.age".publicKeys = key;
}
