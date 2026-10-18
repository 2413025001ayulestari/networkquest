part of '../main.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  static const items = [
    (
      'PERANGKAT JARINGAN',
      Icons.router_rounded,
      'Mengenal perangkat yang digunakan untuk membangun jaringan komputer.',
      'PERANGKAT JARINGAN',
      '''
Perangkat jaringan adalah perangkat yang digunakan untuk menghubungkan komputer, perangkat, dan jaringan agar dapat saling berkomunikasi.

1. ROUTER

Router adalah perangkat yang berfungsi menghubungkan dua atau lebih jaringan yang berbeda. Router menentukan jalur yang digunakan oleh data agar dapat sampai ke jaringan tujuan.

Contoh:
Router dapat menghubungkan jaringan lokal di rumah atau kampus dengan jaringan internet.

2. SWITCH

Switch digunakan untuk menghubungkan beberapa perangkat dalam satu jaringan lokal atau LAN.

Contoh:
Beberapa komputer di laboratorium dapat dihubungkan menggunakan switch sehingga dapat saling berkomunikasi.

3. ACCESS POINT

Access Point digunakan untuk menyediakan koneksi jaringan secara nirkabel atau Wi-Fi.

Access Point memungkinkan laptop, smartphone, dan perangkat lain terhubung ke jaringan tanpa menggunakan kabel.

4. MODEM

Modem berfungsi menghubungkan jaringan pengguna dengan layanan internet dari penyedia layanan internet.

5. SERVER

Server merupakan komputer atau sistem yang menyediakan layanan atau sumber daya kepada perangkat lain dalam jaringan.

KESIMPULAN

Setiap perangkat jaringan mempunyai fungsi yang berbeda. Router digunakan untuk menghubungkan jaringan, switch untuk menghubungkan perangkat dalam LAN, sedangkan Access Point menyediakan koneksi secara nirkabel.
'''
    ),
    (
      'KABEL & MEDIA',
      Icons.cable_rounded,
      'Mengenal jenis kabel dan media yang digunakan untuk mengirimkan data.',
      'KABEL & MEDIA JARINGAN',
      '''
Media transmisi adalah media yang digunakan untuk mengirimkan data dari satu perangkat ke perangkat lainnya.

1. KABEL UTP

UTP atau Unshielded Twisted Pair merupakan kabel jaringan yang banyak digunakan pada jaringan LAN.

Kabel UTP memiliki beberapa pasang kabel kecil yang dipilin untuk mengurangi gangguan sinyal.

2. STRAIGHT-THROUGH

Kabel straight-through biasanya digunakan untuk menghubungkan perangkat yang berbeda jenis.

Contoh:
• Komputer ke switch
• Komputer ke hub
• Router ke switch

3. CROSSOVER

Kabel crossover digunakan untuk menghubungkan perangkat yang sejenis pada kondisi tertentu.

Contoh:
• Komputer ke komputer
• Switch ke switch

Pada perangkat jaringan modern, beberapa perangkat sudah mendukung Auto-MDI/MDIX sehingga dapat mendeteksi jenis kabel secara otomatis.

4. FIBER OPTIC

Fiber optic menggunakan cahaya untuk mengirimkan data. Media ini mampu memberikan kecepatan tinggi dan dapat digunakan untuk komunikasi dengan jarak yang jauh.

5. WIRELESS

Wireless menggunakan gelombang radio untuk mengirimkan data tanpa menggunakan kabel fisik.

Contohnya adalah jaringan Wi-Fi.

KESIMPULAN

Pemilihan media jaringan disesuaikan dengan kebutuhan. Kabel UTP banyak digunakan untuk LAN, fiber optic cocok untuk kecepatan dan jarak tinggi, sedangkan wireless digunakan untuk koneksi tanpa kabel.
'''
    ),
    (
      'IP ADDRESS',
      Icons.numbers_rounded,
      'Memahami alamat IP, subnet mask, gateway, dan DNS.',
      'IP ADDRESS',
      '''
IP Address adalah alamat yang digunakan untuk mengidentifikasi perangkat dalam sebuah jaringan.

1. IPv4

IPv4 terdiri dari empat bagian yang disebut oktet. Setiap oktet memiliki nilai antara 0 sampai 255.

Contoh:

192.168.1.10

Alamat tersebut terdiri dari empat oktet:

192 . 168 . 1 . 10

2. SUBNET MASK

Subnet mask digunakan untuk menentukan bagian network dan bagian host dari sebuah alamat IP.

Contoh:

IP Address:
192.168.1.10

Subnet Mask:
255.255.255.0

Prefix:
 /24

Dengan subnet /24, jaringan tersebut memiliki network address 192.168.1.0.

3. GATEWAY

Default gateway merupakan alamat perangkat yang digunakan sebagai jalan keluar dari jaringan lokal menuju jaringan lain.

Biasanya gateway merupakan alamat IP router.

Contoh:

IP Address:
192.168.1.10

Gateway:
192.168.1.1

4. DNS

DNS atau Domain Name System digunakan untuk menerjemahkan nama domain menjadi alamat IP.

Contoh:

www.google.com

diterjemahkan menjadi alamat IP yang digunakan untuk berkomunikasi dengan server tujuan.

5. CONTOH KONFIGURASI

IP Address : 192.168.1.10
Subnet Mask: 255.255.255.0
Gateway    : 192.168.1.1
DNS        : 8.8.8.8

KESIMPULAN

IP Address digunakan sebagai identitas perangkat dalam jaringan. Subnet mask menentukan jaringan dan host, gateway digunakan untuk menuju jaringan lain, sedangkan DNS membantu menerjemahkan nama domain menjadi alamat IP.
'''
    ),
    (
      'PING',
      Icons.wifi_tethering_rounded,
      'Menguji apakah perangkat tujuan dapat dijangkau melalui jaringan.',
      'PING DAN PENGUJIAN KONEKSI',
      '''
Ping adalah perintah yang digunakan untuk menguji konektivitas antara satu perangkat dengan perangkat lainnya.

Ping menggunakan protokol ICMP atau Internet Control Message Protocol.

1. FUNGSI PING

Ping dapat digunakan untuk:

• Memeriksa apakah perangkat tujuan dapat dijangkau.
• Mengetahui apakah koneksi jaringan berjalan.
• Mengukur waktu respons.
• Membantu melakukan troubleshooting jaringan.

2. CONTOH PENGGUNAAN

Pada Command Prompt atau terminal dapat digunakan perintah:

ping 192.168.1.1

Jika perangkat tujuan dapat dijangkau, biasanya akan muncul balasan seperti:

Reply from 192.168.1.1

Artinya perangkat berhasil mendapatkan respons dari alamat tujuan.

3. JIKA PING GAGAL

Jika muncul pesan seperti:

Request timed out

maka perangkat tidak mendapatkan respons dari tujuan.

Beberapa hal yang dapat diperiksa:

• Kabel jaringan.
• Lampu indikator perangkat.
• IP Address.
• Subnet Mask.
• Default Gateway.
• Koneksi antarperangkat.
• Konfigurasi firewall.
• Routing jika tujuan berada di jaringan lain.

4. PENGUJIAN BERTAHAP

Untuk mencari masalah jaringan, lakukan pengujian secara bertahap.

Contoh:

PC → Gateway → Router → Jaringan tujuan

Dengan pengujian bertahap, sumber masalah akan lebih mudah ditemukan.

KESIMPULAN

Ping merupakan salah satu alat dasar untuk mengetahui apakah koneksi antara dua perangkat berjalan dengan baik.
'''
    ),
    (
      'TROUBLESHOOTING',
      Icons.build_circle_rounded,
      'Langkah sistematis untuk menemukan dan memperbaiki masalah jaringan.',
      'TROUBLESHOOTING JARINGAN',
      '''
Troubleshooting adalah proses mencari penyebab dan memperbaiki masalah pada jaringan komputer.

Agar lebih mudah, pemeriksaan sebaiknya dilakukan secara bertahap.

1. PERIKSA KONEKSI FISIK

Pastikan kabel jaringan terpasang dengan benar.

Periksa juga indikator lampu pada port switch, router, atau komputer.

2. PERIKSA IP ADDRESS

Pastikan perangkat mempunyai alamat IP yang benar.

Periksa:

• IP Address
• Subnet Mask
• Default Gateway
• DNS

3. UJI KONEKSI KE GATEWAY

Lakukan ping ke gateway.

Contoh:

ping 192.168.1.1

Jika ping ke gateway gagal, periksa koneksi lokal dan konfigurasi IP.

4. UJI KE JARINGAN LAIN

Jika gateway berhasil tetapi jaringan lain tidak dapat dijangkau, kemungkinan terdapat masalah pada routing atau konfigurasi router.

5. PERIKSA ROUTING

Untuk komunikasi antarjaringan, router harus mengetahui jalur menuju jaringan tujuan.

Jika routing belum benar, paket tidak dapat mencapai jaringan tujuan.

6. PERIKSA FIREWALL

Firewall dapat membatasi lalu lintas jaringan tertentu.

Jika konfigurasi firewall terlalu ketat, koneksi dapat ditolak.

7. UJI KEMBALI

Setelah melakukan perubahan konfigurasi, lakukan ping kembali untuk memastikan masalah sudah teratasi.

KESIMPULAN

Troubleshooting sebaiknya dilakukan dari masalah yang paling sederhana terlebih dahulu, mulai dari kabel dan perangkat, kemudian IP Address, gateway, routing, hingga firewall.
'''
    ),
    (
      'PROTOKOL',
      Icons.security_rounded,
      'Mengenal protokol yang digunakan agar perangkat dapat berkomunikasi.',
      'PROTOKOL JARINGAN',
      '''
Protokol jaringan adalah aturan yang digunakan agar perangkat dapat berkomunikasi dan bertukar data.

1. TCP/IP

TCP/IP merupakan kumpulan protokol yang menjadi dasar komunikasi pada jaringan komputer dan internet.

TCP bertugas memastikan data dapat dikirim dengan baik, sedangkan IP menangani pengalamatan dan pengiriman paket menuju tujuan.

2. DHCP

DHCP atau Dynamic Host Configuration Protocol digunakan untuk memberikan konfigurasi jaringan secara otomatis kepada perangkat.

DHCP dapat memberikan:

• IP Address
• Subnet Mask
• Default Gateway
• DNS

Dengan DHCP, pengguna tidak perlu memasukkan konfigurasi IP satu per satu.

3. DNS

DNS atau Domain Name System menerjemahkan nama domain menjadi alamat IP.

Contoh:

google.com → alamat IP server Google.

4. HTTP DAN HTTPS

HTTP digunakan untuk komunikasi antara browser dan server web.

HTTPS merupakan versi yang lebih aman karena menggunakan enkripsi untuk melindungi komunikasi antara pengguna dan server.

5. ICMP

ICMP digunakan untuk mengirimkan pesan kontrol dan diagnostik jaringan.

Perintah ping merupakan salah satu contoh penggunaan ICMP.

6. FIREWALL

Firewall bukan hanya sebuah perangkat, tetapi juga dapat berupa sistem atau fitur keamanan yang mengatur lalu lintas jaringan berdasarkan aturan tertentu.

Firewall dapat mengizinkan atau menolak koneksi sesuai konfigurasi.

KESIMPULAN

Protokol membuat komunikasi jaringan dapat berlangsung secara teratur. DHCP membantu konfigurasi IP, DNS menerjemahkan nama, TCP/IP mengatur komunikasi, HTTPS mengamankan web, sedangkan ICMP membantu pengujian jaringan.
'''
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            18,
            16,
            18,
            30,
          ),
          children: [
            const AppTitle(
              'PANDUAN JARINGAN',
              'Bekal cepat sebelum menjalankan misi',
            ),

            const SizedBox(height: 24),

            ...items.map(
              (item) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: cyan.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                item.$2,
                                color: cyan,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                item.$1,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        Text(
                          item.$3,
                          style: const TextStyle(
                            color: Color(0xFF9DB5C8),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 14),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GuideDetailScreen(
                                    title: item.$4,
                                    icon: item.$2,
                                    content: item.$5,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.menu_book_rounded,
                              size: 18,
                            ),
                            label: const Text(
                              'LIHAT DETAIL',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: lime,
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================
// HALAMAN DETAIL MATERI
// ============================================================

class GuideDetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;

  const GuideDetailScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            18,
            16,
            18,
            30,
          ),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 4),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF102A43),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFF244B68),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: cyan.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: cyan,
                      size: 32,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: lime,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF102A43),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFF244B68),
                ),
              ),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.65,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
              ),
              label: const Text(
                'KEMBALI KE PANDUAN',
              ),
            ),
          ],
        ),
      ),
    );
  }
}