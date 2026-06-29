{pkgs, ...}: {
  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      rocmSupport = true;
      # cudaSupport = true;
    };
    settings = {
      vim_keys = true;
      update_ms = 1000;
      rounded_corners = true;
      proc_tree = false;
      show_uptime = true;
      show_coretemp = true;
      cpu_sensor = "auto";
      show_cpu_watts = true;
      freq_mode = "average";
      show_disks = true;
      only_physical = true;
      io_mode = true;
      io_graph_combined = false;
      color_theme = "onedark";
      theme_background = false;
      truecolor = true;
      terminal_sync = true;
      shown_boxes = "cpu net proc";
      proc_sorting = "cpu lazy";
      show_battery_watts = true;
      show_gpu_info = "on";
      shown_gpus = "intel";
    };
  };
}
