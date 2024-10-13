#!/bin/sh

# Server untuk di-ping
server="google.com"

# Lokasi file log
logfile="/var/logs/openclash_monitor.log"
# File status koneksi sebelumnya
statusfile="/var/logs/openclash_last_status"

# Waktu saat pengecekan
current_time=$(date "+%Y-%m-%d %H:%M:%S")

# Token bot Telegram dan Chat ID
bot_token="Masukkan-Telegram-Token-Disini"  # Ganti dengan token bot Telegram Anda
chat_id="Masukkan-Chat-ID-Disini"       # Ganti dengan Chat ID Anda

# Fungsi untuk mengirim notifikasi ke Telegram
send_telegram_message() {
    local message="$1"
    
    if curl -s -X POST "https://api.telegram.org/bot$bot_token/sendMessage" \
        -d chat_id="$chat_id" -d text="$message"; then
        echo "$current_time - Notifikasi dikirim ke Telegram" >> $logfile
    else
        echo "$current_time - Gagal mengirim notifikasi ke Telegram" >> $logfile
    fi
}

# Cek apakah log sudah ada dan dari hari sebelumnya
if [ -f "$logfile" ]; then
    log_date=$(date -r "$logfile" "+%Y-%m-%d" 2>/dev/null)
else
    log_date=""
fi
current_date=$(date "+%Y-%m-%d")

# Jika log tanggalnya berbeda, hapus log lama
if [ "$log_date" != "$current_date" ]; then
    > "$logfile"
    echo "$current_time - Log direset untuk hari ini" >> "$logfile"
    send_telegram_message "$current_time Log direset untuk hari ini"
fi

# Baca status terakhir dari file status
if [ -f "$statusfile" ]; then
    last_status=$(cat "$statusfile")
else
    last_status="unknown"
fi

# Ping server
if ping -c 1 -W 10 "$server" >/dev/null; then  # Menaikkan timeout ping
    echo "$current_time - Koneksi OK" >> "$logfile"
    current_status="connected"
    
    # Jika status sebelumnya adalah "disconnected", kirim notifikasi bahwa koneksi telah kembali
    if [ "$last_status" = "disconnected" ]; then
        echo "$current_time - Koneksi telah kembali. OpenClash OK." >> "$logfile"
        send_telegram_message "$current_time OpenClash connection restored"
    fi
else
    echo "$current_time - Koneksi terputus. Restarting openclash..." >> "$logfile"
    /etc/init.d/openclash restart
    echo "$current_time - openclash restarted" >> "$logfile"
    current_status="disconnected"

    # Kirim notifikasi bahwa koneksi terputus
    if [ "$last_status" = "connected" ]; then
        send_telegram_message "$current_time OpenClash restarted due to connection loss."
    fi
fi

# Simpan status koneksi saat ini ke file status
echo "$current_status" > "$statusfile"
