{ lib, config, ... }: let 
cfg = config.hwInfo;
display = lib.types.submodule ({ ... }: with lib; {
  options = {
    name = mkOption {
      type = types.str;
      default = "";
    };
    resolution.x = mkOption {
      type = types.int;
      default = 1920;
    };
    resolution.y = mkOption {
      type = types.int;
      default = 1080;
    };
    refreshRate = mkOption {
      type = types.float;
      default = 60.0;
    };
    orientation = mkOption {
      type = types.int;
      default = 0;
    };
    offset.x = mkOption {
      type = types.int;
      default = 0;
    };
    offset.y = mkOption {
      type = types.int;
      default = 0;
    };
    scale = mkOption {
      type = types.float;
      default = 1.0;
    };
    pseudoScale = mkOption {
      type = types.float;
      default = 1.0;
    };
    safezones = {
      top-left = {
        x = mkOption {
          type = types.int;
          default = 0;
        };
        y = mkOption {
          type = types.int;
          default = 0;
        };
      };
      top-right = {
        x = mkOption {
          type = types.int;
          default = 0;
        };
        y = mkOption {
          type = types.int;
          default = 0;
        };
      };
      bottom-right = {
        x = mkOption {
          type = types.int;
          default = 0;
        };
        y = mkOption {
          type = types.int;
          default = 0;
        };
      };
      bottom-left = {
        x = mkOption {
          type = types.int;
          default = 0;
        };
        y = mkOption {
          type = types.int;
          default = 0;
        };
      };
    };
    gpu = {
      driver = mkOption {
        type = types.str;
        default = "";
      };
    };
  };
});
keyboard = lib.types.submodule ({...}: with lib; {
  options = {
    layout = mkOption {
      type = types.str;
      default = "";
    };
  };
});
in {
  options.hwInfo = with lib; {    
    deviceType = mkOption {
      type = types.enum [ "laptop" "desktop" "server" ];
      default = "desktop";
      description = "Type of device";
    };

    displays = mkOption {
      type = types.listOf display;
      default = [];
    };

    keyboards = mkOption {
      type = types.listOf keyboard;
      default = [];
    };

    primaryDisplay = mkOption {
      type = display;
      default = lib.head cfg.displays;
    };
  };
}
