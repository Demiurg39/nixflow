# ./lib/default.nix
{lib, ...}:
lib.extend (self: super: {
  # "super" = default lib
  # "self" = with my funcs lib

  mkOpt = type: default:
    super.mkOption {inherit type default;};

  mkOpt' = type: default: description:
    super.mkOption {inherit type default description;};

  mkBoolOpt = default:
    super.mkOption {
      inherit default;
      type = super.types.bool;
      example = true;
    };
})
