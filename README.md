# OpenClash Monitor Script

Skrip ini dirancang untuk memonitor koneksi OpenClash dengan melakukan ping ke server tertentu dan mengirim notifikasi melalui Telegram. Skrip ini juga mencatat status koneksi dan menyimpan log aktivitas ke dalam file.

## Fitur

- **Monitoring Koneksi**: Melakukan ping ke server (default: `google.com`) untuk memeriksa status koneksi.
- **Notifikasi Telegram**: Mengirimkan notifikasi ke bot Telegram saat status koneksi berubah.
- **Pencatatan Log**: Mencatat semua aktivitas dan status koneksi ke dalam file log.
- **Reset Log Harian**: Menghapus file log dan mengirimkan notifikasi ketika hari berganti.

## Prerequisites

Sebelum menjalankan skrip ini, pastikan Anda memiliki:

- **Akses ke server** dengan sistem operasi Linux (Debian, Ubuntu, atau turunannya).
- **OpenClash** terpasang dan dapat di-restart menggunakan perintah `/etc/init.d/openclash restart`.
- **Curl** terinstal untuk mengirim notifikasi ke Telegram.

## Instalasi

1. **Clone Repository**

   Clone repository ini ke server Anda:

   ```bash
   git clone https://github.com/username/repository.git
   cd repository

2. Buat Direktori Log

   Pastikan direktori untuk log ada dan dapat diakses:
   ```bash
   mkdir -p /root/logs

3. Sesuaikan Skrip
   
   Edit skrip openclash_monitor.sh dan sesuaikan bot_token dan chat_id dengan token bot Telegram dan chat ID Anda.

4. Jadwalkan dengan Cron
   Anda dapat menambahkan skrip ini ke cron job agar dapat dijalankan secara otomatis. Misalnya, untuk menjalankannya setiap 1 menit:
    ```bash
   crontab -e

    * * * * * /path/to/openclash_monitor.sh
# Penggunaan
Setelah skrip diatur, ia akan memonitor koneksi secara otomatis. Log dan status koneksi akan disimpan di file log yang ditentukan. Notifikasi akan dikirim ke Telegram setiap kali status koneksi berubah.

# Lisensi
Proyek ini dilisensikan di bawah MIT License.

# Kontribusi
Jika Anda ingin berkontribusi pada proyek ini, silakan buka isu atau kirim pull request.

# Kontak
Untuk pertanyaan atau dukungan, silakan hubungi email@example.com.



   
