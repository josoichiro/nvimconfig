return {
  {
    "3rd/image.nvim",
    build = false,
    event = "VeryLazy",
    opts = {
      backend = "sixel",
      processor = "magick_cli",
      hijack_file_patterns = {
        "*.png",
        "*.jpg",
        "*.jpeg",
        "*.gif",
        "*.webp",
        "*.avif",
      },
    },
  },
}
