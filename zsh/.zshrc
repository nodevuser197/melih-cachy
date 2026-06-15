# =========================================================
# 1. P10k Instant Prompt (Terminalin anında açılmasını sağlar, en üstte kalmalı)
# =========================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =========================================================
# 2. Temel Geçmiş (History) Ayarları (Geçmiş komutlarını kaybetmemek için)
# =========================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups

# =========================================================
# 3. Otomatik Tamamlama (Tab tuşu sistemi)
# =========================================================
autoload -Uz compinit
compinit

# =========================================================
# 4. Tema: Powerlevel10k
# =========================================================
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# =========================================================
# 5. Eklenti: Autosuggestions (Fish tarzı gri öneriler)
# =========================================================
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# =========================================================
# 6. P10k Kişisel Konfigürasyonu
# =========================================================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =========================================================
# 7. Klavye Kısayolları
# =========================================================
# Ctrl+Sol/Sağ → kelimeler arası geçiş (kitty terminali)
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
# Ctrl+Backspace / Ctrl+Delete → kelime sil
bindkey '\e[3;5~' kill-word
bindkey '^H'      backward-kill-word

# Ctrl+F → fg (son suspend edilen processe dön)
bindkey -s '^F' 'fg\n'

# Shift+F9-F12 → fg %1 - fg %4
bindkey -s '\e[20;2~' 'fg %1\n'
bindkey -s '\e[21;2~' 'fg %2\n'
bindkey -s '\e[23;2~' 'fg %3\n'
bindkey -s '\e[24;2~' 'fg %4\n'

# =========================================================
# 8. Eklenti: Syntax Highlighting (Çakışma olmaması için KESİNLİKLE en sonda olmalı!)
# =========================================================
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# =========================================================
# 9. micro-ROS Agent Kısayolu
# =========================================================
microros() {
  local dev=${1:-/dev/ttyUSB0}
  local baud=${2:-115200}
  docker run -it --rm --net=host --device=$dev ros2_foxy_microros bash -c \
    "source /opt/ros/foxy/setup.bash && source /uros_ws/install/local_setup.bash && ros2 run micro_ros_agent micro_ros_agent serial --dev $dev -b $baud"
}

rostopic() {
  docker run -it --rm --net=host ros2_foxy_microros bash -c \
    "source /opt/ros/foxy/setup.bash && source /uros_ws/install/local_setup.bash && ros2 topic $*"
}
export PATH="/home/melih/2021.2/Vivado/2021.2/bin:$PATH"
export _JAVA_AWT_WM_NONREPARENTING=1
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
alias hx='helix'
alias rpi-imager="sudo -E rpi-imager"
winrdp() {
  local ip=$(arp -n | awk '/52:54:00:f9:19:32/ {print $1}')
  if [[ -z "$ip" ]]; then
    echo "VM IP bulunamadı — VM açık mı?"
    return 1
  fi
  wlfreerdp3 /v:"$ip" /u:Admin /p:1 /cert:ignore /dynamic-resolution +clipboard /w:1920 /h:1080 /drive:shared,/home/melih/shared
}
alias lidfix="sudo bash -c 'mkdir -p /etc/systemd/logind.conf.d && printf \"[Login]
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
\" > /etc/systemd/logind.conf.d/lid.conf' && sudo systemctl kill -s HUP systemd-logind"

# =========================================================
# 10. ttyper — İngilizce layoutla test, bitince Türkçe'ye dön
# =========================================================
ttyper-en() {
  niri msg action switch-layout "next"
  ttyper "$@"
  niri msg action switch-layout "next"
}

# =========================================================
# npm global bin
export PATH="$HOME/.npm-global/bin:$PATH"
