function set_theme_dark
  echo "setting dark theme"
  set -Ux FZF_DEFAULT_OPTS "\
    --color=bg+:#3D4042,bg:#1C1917,spinner:#B77E64,hl:#DE6E7C \
    --color=fg:#B4BDC3,header:#DE6E7C,info:#B279A7,pointer:#B77E64 \
    --color=marker:#B77E64,fg+:#B4BDC3,prompt:#B279A7,hl+:#DE6E7C"
end

funciton set_theme_light
  echo "setting light theme"
  set -Ux FZF_DEFAULT_OPTS "\
    --color=bg+:#CBD9E3,bg:#F0EDEC,spinner:#944927,hl:#A8334C \
    --color=fg:#2C363C,header:#A8334C,info:#88507D,pointer:#944927 \
    --color=marker:#944927,fg+:#2C363C,prompt:#88507D,hl+:#A8334C"
end
