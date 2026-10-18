part of '../main.dart';

class Question {
  final String prompt;
  final List<String> options;
  final int answer;
  final String fact;

  const Question(
    this.prompt,
    this.options,
    this.answer,
    this.fact,
  );
}

const questions = <List<Question>>[
  // ============================================================
  // LEVEL 1 - KENALI PERANGKAT
  // ============================================================
  [
    Question(
      'Perangkat yang meneruskan paket antarjaringan adalah…',
      ['Switch', 'Router', 'Hub', 'Repeater'],
      1,
      'Router digunakan untuk menghubungkan dan meneruskan data antarjaringan.',
    ),
    Question(
      'Perangkat yang menghubungkan banyak komputer dalam satu LAN adalah…',
      ['Switch', 'Modem', 'Firewall', 'Server'],
      0,
      'Switch menghubungkan beberapa perangkat dalam jaringan lokal.',
    ),
    Question(
      'Perangkat pemancar Wi-Fi disebut…',
      ['NIC', 'Access Point', 'Patch Panel', 'Bridge'],
      1,
      'Access Point menyediakan koneksi jaringan secara nirkabel.',
    ),
    Question(
      'Perangkat yang menyediakan layanan atau sumber daya kepada komputer lain disebut…',
      ['Server', 'Switch', 'Router', 'Repeater'],
      0,
      'Server menyediakan layanan atau sumber daya yang dapat digunakan oleh client.',
    ),
    Question(
      'Perangkat yang digunakan untuk menghubungkan jaringan dengan layanan internet dari ISP adalah…',
      ['Modem', 'Keyboard', 'Monitor', 'Printer'],
      0,
      'Modem digunakan untuk menghubungkan perangkat atau jaringan dengan layanan dari ISP.',
    ),
    Question(
      'Perangkat yang berfungsi menghubungkan perangkat dalam jaringan LAN adalah…',
      ['Switch', 'Modem', 'Speaker', 'Scanner'],
      0,
      'Switch menjadi penghubung beberapa perangkat dalam jaringan lokal.',
    ),
    Question(
      'Perangkat yang digunakan untuk menghubungkan jaringan yang berbeda adalah…',
      ['Router', 'Mouse', 'Hub', 'Printer'],
      0,
      'Router digunakan untuk menghubungkan jaringan yang berbeda.',
    ),
    Question(
      'Perangkat yang menyediakan akses jaringan secara wireless adalah…',
      ['Access Point', 'Server', 'Modem', 'Switch'],
      0,
      'Access Point menyediakan koneksi jaringan melalui Wi-Fi.',
    ),
    Question(
      'Komputer yang menyediakan layanan untuk komputer lain dalam jaringan disebut…',
      ['Client', 'Server', 'Switch', 'Router'],
      1,
      'Server menyediakan layanan kepada client dalam jaringan.',
    ),
    Question(
      'Perangkat yang mengatur lalu lintas data antarjaringan adalah…',
      ['Router', 'Monitor', 'Keyboard', 'Printer'],
      0,
      'Router mengatur pengiriman paket menuju jaringan tujuan.',
    ),
    Question(
      'Perangkat yang biasanya digunakan untuk menghubungkan banyak komputer menggunakan kabel LAN adalah…',
      ['Switch', 'Modem', 'Access Point', 'Server'],
      0,
      'Switch digunakan sebagai pusat koneksi perangkat dalam LAN.',
    ),
    Question(
      'Perangkat jaringan yang digunakan untuk menyediakan koneksi Wi-Fi adalah…',
      ['Access Point', 'Router saja', 'Printer', 'NIC'],
      0,
      'Access Point menyediakan akses jaringan secara nirkabel.',
    ),
    Question(
      'Perangkat yang berfungsi sebagai penyedia layanan jaringan disebut…',
      ['Server', 'Client', 'Switch', 'Repeater'],
      0,
      'Server berfungsi menyediakan layanan atau sumber daya jaringan.',
    ),
    Question(
      'Router bekerja terutama untuk menghubungkan…',
      ['Jaringan yang berbeda', 'Keyboard dan mouse', 'Monitor dan CPU', 'Printer dan scanner'],
      0,
      'Router menghubungkan jaringan yang berbeda dan meneruskan paket data.',
    ),
    Question(
      'Switch termasuk perangkat yang banyak digunakan pada jaringan…',
      ['LAN', 'Keyboard', 'Audio', 'Power'],
      0,
      'Switch umum digunakan untuk menghubungkan perangkat dalam LAN.',
    ),
    Question(
      'Perangkat yang menerima dan meneruskan data ke perangkat tujuan dalam LAN adalah…',
      ['Switch', 'Monitor', 'Modem', 'Speaker'],
      0,
      'Switch meneruskan frame menuju perangkat tujuan dalam jaringan lokal.',
    ),
    Question(
      'Perangkat yang memungkinkan perangkat tanpa kabel terhubung ke jaringan adalah…',
      ['Access Point', 'Patch Panel', 'Printer', 'Scanner'],
      0,
      'Access Point memungkinkan perangkat terhubung melalui Wi-Fi.',
    ),
    Question(
      'Salah satu perangkat utama dalam jaringan komputer adalah…',
      ['Router', 'Kamera', 'Speaker', 'Proyektor'],
      0,
      'Router merupakan salah satu perangkat jaringan yang digunakan untuk menghubungkan jaringan.',
    ),
    Question(
      'Perangkat yang menyediakan sumber daya jaringan untuk client adalah…',
      ['Server', 'Switch', 'Router', 'Hub'],
      0,
      'Server menyediakan layanan dan sumber daya yang dapat digunakan client.',
    ),
    Question(
      'Perangkat yang digunakan sebagai penghubung utama beberapa perangkat dalam LAN adalah…',
      ['Switch', 'Modem', 'Monitor', 'Keyboard'],
      0,
      'Switch menjadi salah satu perangkat utama untuk menghubungkan host dalam LAN.',
    ),
  ],

  // ============================================================
  // LEVEL 2 - SUSUN JARINGAN
  // ============================================================
  [
    Question(
      'PC ke switch umumnya memakai kabel…',
      ['Crossover', 'Straight-through', 'Console', 'Fiber Duplex'],
      1,
      'Straight-through umum digunakan untuk menghubungkan perangkat yang berbeda jenis.',
    ),
    Question(
      'PC langsung ke PC secara klasik memakai…',
      ['Crossover', 'Coaxial', 'Straight', 'Console'],
      0,
      'Kabel crossover secara klasik digunakan untuk menghubungkan perangkat sejenis.',
    ),
    Question(
      'Media terbaik untuk jarak jauh dan cepat adalah…',
      ['UTP Cat5', 'Fiber Optic', 'Kabel Telepon', 'USB'],
      1,
      'Fiber optic memiliki kemampuan transmisi tinggi dan cocok untuk jarak jauh.',
    ),
    Question(
      'Kabel jaringan yang menggunakan konektor RJ-45 adalah…',
      ['UTP', 'Fiber Optic', 'HDMI', 'USB'],
      0,
      'Kabel UTP Ethernet umumnya menggunakan konektor RJ-45.',
    ),
    Question(
      'Perangkat yang dapat menjadi pusat koneksi beberapa PC dalam LAN adalah…',
      ['Switch', 'Monitor', 'Keyboard', 'Printer'],
      0,
      'Switch digunakan sebagai pusat koneksi beberapa perangkat jaringan.',
    ),
    Question(
      'Kabel yang digunakan untuk menghubungkan PC dengan switch adalah…',
      ['Straight-through', 'Crossover', 'USB', 'HDMI'],
      0,
      'Straight-through digunakan untuk koneksi PC ke switch.',
    ),
    Question(
      'Kabel crossover digunakan secara klasik untuk menghubungkan…',
      ['Perangkat sejenis', 'PC ke switch', 'PC ke printer USB', 'Monitor ke PC'],
      0,
      'Crossover secara klasik digunakan untuk koneksi langsung antarperangkat sejenis.',
    ),
    Question(
      'Fiber optic menggunakan media transmisi berupa…',
      ['Cahaya', 'Suara', 'Gelombang radio saja', 'Arus listrik'],
      0,
      'Fiber optic mengirimkan data menggunakan cahaya.',
    ),
    Question(
      'Kabel UTP merupakan media jaringan yang menggunakan…',
      ['Kawat tembaga', 'Serat kaca saja', 'Gelombang radio', 'Gelombang suara'],
      0,
      'UTP menggunakan pasangan kabel tembaga yang dipilin.',
    ),
    Question(
      'Agar PC dapat terhubung ke switch menggunakan kabel jaringan, port yang digunakan harus…',
      ['Port jaringan', 'Port HDMI', 'Port audio', 'Port VGA'],
      0,
      'Koneksi Ethernet menggunakan port jaringan Ethernet.',
    ),
    Question(
      'Dalam jaringan kabel, switch berfungsi sebagai…',
      ['Penghubung perangkat', 'Penyedia listrik', 'Monitor', 'Keyboard'],
      0,
      'Switch menghubungkan berbagai perangkat pada jaringan lokal.',
    ),
    Question(
      'Kabel jaringan harus terpasang dengan baik agar…',
      ['Koneksi dapat berjalan', 'Monitor menyala', 'Keyboard aktif', 'Speaker berbunyi'],
      0,
      'Koneksi fisik yang baik diperlukan agar data dapat ditransmisikan.',
    ),
    Question(
      'Jika kabel jaringan tidak terhubung dengan benar, kemungkinan yang terjadi adalah…',
      ['Koneksi gagal', 'IP otomatis berubah selalu', 'Monitor rusak', 'Keyboard mati'],
      0,
      'Koneksi fisik yang bermasalah dapat menyebabkan jaringan tidak terhubung.',
    ),
    Question(
      'Perangkat wireless dapat terhubung ke jaringan melalui…',
      ['Access Point', 'Patch Panel', 'Kabel HDMI', 'Printer'],
      0,
      'Access Point menyediakan akses jaringan melalui Wi-Fi.',
    ),
    Question(
      'Media transmisi yang cocok untuk kebutuhan jaringan berkecepatan tinggi dan jarak jauh adalah…',
      ['Fiber Optic', 'USB', 'Kabel Telepon', 'Kabel Audio'],
      0,
      'Fiber optic cocok untuk transmisi cepat dan jarak jauh.',
    ),
    Question(
      'Koneksi Ethernet menggunakan kabel UTP membutuhkan konektor…',
      ['RJ-45', 'HDMI', 'VGA', 'USB-A'],
      0,
      'Konektor RJ-45 umum digunakan pada kabel Ethernet berbasis UTP.',
    ),
    Question(
      'Perangkat yang digunakan sebagai titik akses jaringan Wi-Fi adalah…',
      ['Access Point', 'Switch saja', 'Printer', 'Server'],
      0,
      'Access Point menjadi titik akses bagi perangkat wireless.',
    ),
    Question(
      'Tujuan menyusun perangkat dan kabel jaringan dengan benar adalah…',
      ['Membuat koneksi jaringan berjalan', 'Memperbesar monitor', 'Mengubah keyboard', 'Menghapus IP'],
      0,
      'Susunan dan koneksi yang tepat diperlukan agar jaringan dapat berkomunikasi.',
    ),
    Question(
      'Kabel straight-through secara umum digunakan untuk menghubungkan…',
      ['Perangkat berbeda jenis', 'Dua monitor', 'Dua keyboard', 'Dua printer USB'],
      0,
      'Straight-through digunakan untuk koneksi perangkat jaringan yang berbeda jenis.',
    ),
    Question(
      'Salah satu hal yang perlu diperiksa saat menyusun jaringan adalah…',
      ['Koneksi kabel', 'Wallpaper desktop', 'Ukuran font', 'Volume speaker'],
      0,
      'Koneksi kabel merupakan bagian penting dalam pemeriksaan jaringan.',
    ),
  ],

  // ============================================================
  // LEVEL 3 - ATUR IP ADDRESS
  // ============================================================
  [
    Question(
      'Manakah alamat IPv4 yang valid?',
      ['192.168.1.10', '192.168.1.999', '192.168.1', '192.168.one.1'],
      0,
      'IPv4 terdiri dari empat oktet dengan nilai 0 sampai 255.',
    ),
    Question(
      'Subnet mask umum jaringan /24 adalah…',
      ['255.0.0.0', '255.255.0.0', '255.255.255.0', '255.255.255.255'],
      2,
      'Prefix /24 memiliki subnet mask 255.255.255.0.',
    ),
    Question(
      'Dua host dalam satu jaringan harus memiliki IP yang…',
      ['Sama persis', 'Unik', 'Kosong', 'Selalu publik'],
      1,
      'Setiap host harus memiliki alamat IP yang unik.',
    ),
    Question(
      'IPv4 terdiri dari berapa oktet?',
      ['2', '3', '4', '8'],
      2,
      'Alamat IPv4 terdiri dari empat oktet.',
    ),
    Question(
      'Nilai maksimum sebuah oktet IPv4 adalah…',
      ['100', '128', '255', '999'],
      2,
      'Setiap oktet IPv4 memiliki nilai 0 sampai 255.',
    ),
    Question(
      'Contoh IP private adalah…',
      ['192.168.1.10', '8.8.8.8', '1.1.1.1', '209.165.201.1'],
      0,
      '192.168.0.0/16 merupakan salah satu rentang alamat private.',
    ),
    Question(
      'Subnet mask 255.255.255.0 memiliki prefix…',
      ['/8', '/16', '/24', '/32'],
      2,
      '255.255.255.0 setara dengan prefix /24.',
    ),
    Question(
      'Alamat IP digunakan untuk…',
      ['Mengidentifikasi perangkat pada jaringan', 'Menyalakan monitor', 'Mengatur volume', 'Mencetak dokumen'],
      0,
      'IP address digunakan untuk mengidentifikasi interface/perangkat pada jaringan.',
    ),
    Question(
      'IP 192.168.1.10 termasuk alamat…',
      ['Private', 'Broadcast', 'Multicast', 'Loopback'],
      0,
      '192.168.1.10 berada dalam rentang IP private.',
    ),
    Question(
      'Alamat 192.168.1.0 pada jaringan /24 biasanya merupakan…',
      ['Network address', 'Host address', 'Broadcast address', 'DNS address'],
      0,
      'Pada jaringan 192.168.1.0/24, .0 merupakan network address.',
    ),
    Question(
      'Alamat broadcast jaringan 192.168.1.0/24 adalah…',
      ['192.168.1.0', '192.168.1.1', '192.168.1.254', '192.168.1.255'],
      3,
      'Pada jaringan /24, alamat terakhir adalah broadcast address.',
    ),
    Question(
      'Alamat 192.168.1.1 dapat digunakan sebagai…',
      ['Alamat host', 'Network address selalu', 'Broadcast selalu', 'Subnet mask'],
      0,
      '192.168.1.1 merupakan alamat host yang valid pada jaringan /24.',
    ),
    Question(
      'Manakah yang bukan alamat IPv4 valid?',
      ['10.0.0.1', '172.16.0.1', '192.168.1.1', '300.1.1.1'],
      3,
      'Nilai oktet IPv4 tidak boleh melebihi 255.',
    ),
    Question(
      'Subnet mask digunakan untuk menentukan…',
      ['Bagian network dan host', 'Nama komputer', 'Jenis monitor', 'Kecepatan keyboard'],
      0,
      'Subnet mask menentukan bagian network dan host pada alamat IP.',
    ),
    Question(
      'Jika dua komputer memiliki IP yang sama dalam satu jaringan, dapat terjadi…',
      ['IP conflict', 'DNS berhasil otomatis', 'Internet semakin cepat', 'Tidak ada masalah'],
      0,
      'IP yang sama dapat menyebabkan konflik alamat IP.',
    ),
    Question(
      'Alamat IP 10.0.0.1 termasuk kategori…',
      ['Private', 'Public', 'Broadcast', 'Loopback'],
      0,
      '10.0.0.0/8 merupakan salah satu rentang alamat private.',
    ),
    Question(
      'Prefix /16 setara dengan subnet mask…',
      ['255.0.0.0', '255.255.0.0', '255.255.255.0', '255.255.255.255'],
      1,
      'Prefix /16 setara dengan 255.255.0.0.',
    ),
    Question(
      'Prefix /8 setara dengan…',
      ['255.0.0.0', '255.255.0.0', '255.255.255.0', '255.255.255.255'],
      0,
      'Prefix /8 memiliki subnet mask 255.0.0.0.',
    ),
    Question(
      'Alamat 127.0.0.1 dikenal sebagai…',
      ['Loopback', 'Broadcast', 'Network', 'Gateway'],
      0,
      '127.0.0.1 merupakan alamat loopback IPv4.',
    ),
    Question(
      'Salah satu tujuan konfigurasi IP address adalah agar perangkat dapat…',
      ['Berkomunikasi dalam jaringan', 'Mengubah ukuran layar', 'Memperbaiki keyboard', 'Mengatur speaker'],
      0,
      'Konfigurasi IP yang tepat memungkinkan perangkat berkomunikasi dalam jaringan.',
    ),
  ],

  // ============================================================
  // LEVEL 4 - PING TEST
  // ============================================================
  [
    Question(
      'Perintah untuk menguji keterjangkauan host adalah…',
      ['copy', 'ping', 'mkdir', 'format'],
      1,
      'Ping digunakan untuk menguji keterjangkauan host.',
    ),
    Question(
      'Pesan "Request timed out" berarti…',
      ['Koneksi berhasil', 'Balasan tidak diterima', 'IP pasti benar', 'DNS diperbarui'],
      1,
      'Timeout berarti tidak ada balasan yang diterima dalam batas waktu.',
    ),
    Question(
      'Nilai TTL biasanya muncul saat ping…',
      ['Berhasil mendapat balasan', 'Kabel pasti putus', 'PC mati', 'IP kosong'],
      0,
      'Balasan ping dapat menampilkan informasi TTL.',
    ),
    Question(
      'Ping menggunakan protokol…',
      ['ICMP', 'HTTP', 'FTP', 'DNS'],
      0,
      'Ping menggunakan ICMP untuk menguji konektivitas.',
    ),
    Question(
      'Tujuan utama melakukan ping adalah…',
      ['Menguji konektivitas', 'Mengubah IP', 'Menghapus file', 'Menginstal aplikasi'],
      0,
      'Ping digunakan untuk mengetahui apakah host dapat dijangkau.',
    ),
    Question(
      'Jika ping mendapat Reply, artinya…',
      ['Host memberikan balasan', 'Kabel pasti rusak', 'IP pasti salah', 'DNS pasti mati'],
      0,
      'Reply menunjukkan bahwa host memberikan respons terhadap permintaan ping.',
    ),
    Question(
      'Jika semua paket ping hilang, nilai packet loss adalah…',
      ['0%', '25%', '50%', '100%'],
      3,
      'Jika tidak ada paket yang kembali, packet loss mencapai 100%.',
    ),
    Question(
      'Perintah ping dapat digunakan untuk menguji…',
      ['Keterjangkauan perangkat', 'Kecepatan mengetik', 'Kapasitas hard disk', 'Resolusi monitor'],
      0,
      'Ping digunakan untuk menguji apakah perangkat tujuan dapat dijangkau.',
    ),
    Question(
      'Jika ping 192.168.1.1 berhasil, maka perangkat tersebut…',
      ['Dapat dijangkau', 'Pasti tidak aktif', 'Tidak memiliki IP', 'Tidak terhubung jaringan'],
      0,
      'Reply dari alamat tersebut menunjukkan host dapat dijangkau.',
    ),
    Question(
      'Informasi waktu pada hasil ping menunjukkan…',
      ['Waktu respons', 'Ukuran hard disk', 'Jumlah RAM', 'Versi Windows'],
      0,
      'Nilai time pada ping menunjukkan waktu respons paket.',
    ),
    Question(
      'Echo Request pada ping dikirim untuk…',
      ['Meminta balasan dari host', 'Menghapus IP', 'Mengubah DNS', 'Mematikan router'],
      0,
      'ICMP Echo Request digunakan untuk meminta respons dari host tujuan.',
    ),
    Question(
      'Jika ping gagal, salah satu hal yang dapat diperiksa adalah…',
      ['Koneksi jaringan', 'Wallpaper', 'Keyboard', 'Speaker'],
      0,
      'Koneksi jaringan merupakan salah satu hal yang perlu diperiksa saat ping gagal.',
    ),
    Question(
      'Packet loss menunjukkan…',
      ['Paket yang tidak sampai atau tidak mendapat balasan', 'Ukuran RAM', 'Kapasitas disk', 'Jenis monitor'],
      0,
      'Packet loss menunjukkan adanya paket yang hilang/tidak mendapat respons.',
    ),
    Question(
      'Ping dapat dilakukan menggunakan alamat…',
      ['IP address', 'Nama folder', 'Nama file saja', 'Password'],
      0,
      'Ping dapat menguji host menggunakan alamat IP.',
    ),
    Question(
      'Jika ping menunjukkan "Destination Host Unreachable", artinya…',
      ['Host tujuan tidak dapat dijangkau', 'Koneksi pasti sangat cepat', 'DNS pasti aktif', 'IP pasti benar'],
      0,
      'Pesan tersebut menunjukkan host tujuan tidak dapat dijangkau.',
    ),
    Question(
      'Perintah ping termasuk perintah yang digunakan dalam…',
      ['Troubleshooting jaringan', 'Pengeditan gambar', 'Pemrograman game saja', 'Pengolah kata'],
      0,
      'Ping merupakan salah satu alat dasar untuk troubleshooting jaringan.',
    ),
    Question(
      'Jika ping berhasil tetapi akses aplikasi masih gagal, pemeriksaan selanjutnya dapat dilakukan pada…',
      ['Layanan/aplikasi terkait', 'Wallpaper', 'Keyboard', 'Mouse'],
      0,
      'Ping hanya menguji keterjangkauan, bukan menjamin semua layanan aplikasi berjalan.',
    ),
    Question(
      'Hasil ping yang memiliki packet loss 0% menunjukkan…',
      ['Tidak ada paket yang hilang', 'Semua paket hilang', 'IP kosong', 'DNS mati'],
      0,
      'Packet loss 0% berarti seluruh paket yang diuji mendapat respons.',
    ),
    Question(
      'Salah satu informasi yang dapat diamati dari hasil ping adalah…',
      ['Waktu respons', 'Kapasitas RAM', 'Ukuran monitor', 'Jenis keyboard'],
      0,
      'Hasil ping dapat menampilkan waktu respons dari host tujuan.',
    ),
    Question(
      'Ping paling tepat digunakan untuk memeriksa…',
      ['Konektivitas dasar jaringan', 'Kecerahan layar', 'Kapasitas baterai', 'Ukuran file'],
      0,
      'Ping merupakan alat dasar untuk memeriksa konektivitas jaringan.',
    ),
  ],

  // ============================================================
  // LEVEL 5 - TROUBLESHOOTING
  // ============================================================
  [
    Question(
      'Lampu port switch mati. Periksa pertama kali…',
      ['Wallpaper', 'Kabel jaringan', 'Nama folder', 'Volume'],
      1,
      'Pemeriksaan fisik kabel merupakan salah satu langkah awal troubleshooting.',
    ),
    Question(
      'IP 169.254.x.x biasanya menandakan…',
      ['DHCP gagal', 'Internet cepat', 'DNS aktif', 'Firewall mati'],
      0,
      'Alamat 169.254.x.x biasanya muncul ketika perangkat gagal memperoleh IP dari DHCP.',
    ),
    Question(
      'Bisa ping IP tetapi tidak nama domain. Masalahnya kemungkinan…',
      ['DNS', 'Keyboard', 'Monitor', 'RAM'],
      0,
      'DNS menerjemahkan nama domain menjadi alamat IP.',
    ),
    Question(
      'Jika kabel jaringan longgar, masalah yang mungkin terjadi adalah…',
      ['Koneksi terganggu', 'RAM bertambah', 'Monitor membesar', 'IP menjadi publik'],
      0,
      'Kabel yang tidak terpasang dengan baik dapat menyebabkan koneksi terganggu.',
    ),
    Question(
      'Jika komputer tidak mendapatkan IP dari DHCP, langkah yang tepat adalah…',
      ['Memeriksa koneksi dan DHCP', 'Mengganti wallpaper', 'Mematikan monitor', 'Menghapus keyboard'],
      0,
      'Koneksi jaringan dan layanan DHCP perlu diperiksa.',
    ),
    Question(
      'Jika komputer mendapat IP 169.254.x.x, salah satu hal yang perlu diperiksa adalah…',
      ['Server DHCP', 'Speaker', 'Monitor', 'Printer USB'],
      0,
      'Alamat APIPA dapat menunjukkan kegagalan memperoleh alamat dari DHCP.',
    ),
    Question(
      'Jika nama domain tidak dapat diterjemahkan tetapi ping IP berhasil, periksa…',
      ['Konfigurasi DNS', 'Mouse', 'Monitor', 'Keyboard'],
      0,
      'Masalah resolusi nama dapat berkaitan dengan konfigurasi DNS.',
    ),
    Question(
      'Jika lampu indikator port jaringan mati, hal pertama yang diperiksa adalah…',
      ['Kabel dan koneksi fisik', 'Wallpaper', 'Volume', 'Font'],
      0,
      'Pemeriksaan fisik merupakan langkah awal dalam troubleshooting jaringan.',
    ),
    Question(
      'Salah satu penyebab komputer tidak dapat terhubung ke jaringan adalah…',
      ['Kabel tidak terhubung', 'Wallpaper salah', 'Font kecil', 'Speaker mati'],
      0,
      'Koneksi kabel yang tidak benar dapat menyebabkan perangkat tidak terhubung.',
    ),
    Question(
      'Jika dua komputer memiliki IP yang sama, kemungkinan terjadi…',
      ['IP conflict', 'DNS conflict saja', 'Firewall aktif', 'DHCP selalu berhasil'],
      0,
      'Alamat IP yang sama pada jaringan dapat menyebabkan konflik IP.',
    ),
    Question(
      'Saat troubleshooting jaringan, pemeriksaan sebaiknya dimulai dari…',
      ['Hal dasar/fisik', 'Mengganti seluruh perangkat', 'Menghapus sistem operasi', 'Membeli router baru'],
      0,
      'Pemeriksaan dasar dan fisik dapat membantu menemukan masalah dengan cepat.',
    ),
    Question(
      'Jika komputer tidak dapat melakukan ping ke gateway, yang perlu diperiksa adalah…',
      ['Koneksi jaringan dan konfigurasi IP', 'Wallpaper', 'Keyboard', 'Speaker'],
      0,
      'Koneksi dan konfigurasi IP merupakan bagian penting yang perlu diperiksa.',
    ),
    Question(
      'Gateway digunakan untuk…',
      ['Menghubungkan jaringan menuju jaringan lain', 'Mengubah ukuran monitor', 'Mencetak dokumen', 'Mengatur keyboard'],
      0,
      'Default gateway digunakan untuk mengirim trafik menuju jaringan lain.',
    ),
    Question(
      'Jika internet tidak dapat digunakan tetapi koneksi lokal berjalan, salah satu yang perlu diperiksa adalah…',
      ['Gateway', 'Wallpaper', 'Mouse', 'Keyboard'],
      0,
      'Gateway merupakan salah satu komponen yang perlu diperiksa untuk akses ke jaringan lain.',
    ),
    Question(
      'Jika DNS bermasalah, dampaknya dapat berupa…',
      ['Nama domain gagal diterjemahkan', 'Monitor mati', 'RAM bertambah', 'Keyboard berubah'],
      0,
      'DNS berfungsi menerjemahkan nama domain menjadi alamat IP.',
    ),
    Question(
      'Troubleshooting jaringan bertujuan untuk…',
      ['Menemukan dan memperbaiki masalah jaringan', 'Mengubah wallpaper', 'Mengedit video', 'Membuat dokumen'],
      0,
      'Troubleshooting dilakukan untuk menemukan penyebab dan memperbaiki masalah.',
    ),
    Question(
      'Jika kabel jaringan rusak, tindakan yang tepat adalah…',
      ['Memeriksa atau mengganti kabel', 'Mengganti wallpaper', 'Menghapus browser', 'Mengubah volume'],
      0,
      'Kabel yang rusak perlu diperiksa dan bila perlu diganti.',
    ),
    Question(
      'Jika konfigurasi IP salah, dampaknya dapat berupa…',
      ['Komunikasi jaringan terganggu', 'Monitor menjadi besar', 'Keyboard mati', 'Speaker semakin keras'],
      0,
      'Konfigurasi IP yang salah dapat menghambat komunikasi jaringan.',
    ),
    Question(
      'Salah satu langkah troubleshooting setelah memeriksa kabel adalah memeriksa…',
      ['Konfigurasi jaringan', 'Wallpaper', 'Font', 'Volume'],
      0,
      'Konfigurasi jaringan dapat diperiksa setelah memastikan kondisi fisik.',
    ),
    Question(
      'Masalah jaringan sebaiknya ditangani dengan cara…',
      ['Memeriksa penyebab secara bertahap', 'Langsung mengganti semua perangkat', 'Menghapus semua data', 'Mematikan semua komputer'],
      0,
      'Troubleshooting dilakukan secara bertahap untuk menemukan sumber masalah.',
    ),
  ],

  // ============================================================
  // LEVEL 6 - TOPOLOGI & SUBNETTING
  // ============================================================
  [
    Question(
      'Topologi dengan satu pusat berupa switch adalah…',
      ['Ring', 'Bus', 'Star', 'Mesh'],
      2,
      'Topologi star menghubungkan host ke perangkat pusat.',
    ),
    Question(
      'Jumlah host usable pada subnet /30 adalah…',
      ['2', '4', '6', '14'],
      0,
      'Subnet /30 memiliki 4 alamat dan 2 alamat usable untuk host.',
    ),
    Question(
      'Network address 192.168.1.70/26 adalah…',
      ['192.168.1.0', '192.168.1.64', '192.168.1.70', '192.168.1.128'],
      1,
      'Subnet /26 memiliki ukuran blok 64 alamat, sehingga 70 berada pada jaringan 64.',
    ),
    Question(
      'Topologi yang berbentuk lingkaran disebut…',
      ['Star', 'Ring', 'Bus', 'Tree'],
      1,
      'Ring memiliki susunan perangkat yang membentuk lingkaran.',
    ),
    Question(
      'Topologi yang menggunakan satu jalur utama disebut…',
      ['Bus', 'Star', 'Ring', 'Mesh'],
      0,
      'Topologi bus menggunakan satu jalur utama sebagai media koneksi.',
    ),
    Question(
      'Topologi yang menghubungkan banyak perangkat ke pusat disebut…',
      ['Star', 'Ring', 'Bus', 'Mesh'],
      0,
      'Star menggunakan perangkat pusat sebagai titik koneksi.',
    ),
    Question(
      'Subnet /24 memiliki jumlah alamat IP sebanyak…',
      ['64', '128', '256', '512'],
      2,
      '/24 memiliki 32-24 = 8 bit host, sehingga terdapat 256 alamat.',
    ),
    Question(
      'Jumlah host usable pada subnet /24 adalah…',
      ['254', '256', '128', '126'],
      0,
      'Dari 256 alamat pada /24, network dan broadcast tidak digunakan untuk host sehingga tersedia 254 host usable.',
    ),
    Question(
      'Subnet /26 memiliki jumlah alamat…',
      ['32', '64', '128', '256'],
      1,
      '/26 memiliki 6 bit host sehingga jumlah alamatnya 64.',
    ),
    Question(
      'Jumlah host usable pada subnet /26 adalah…',
      ['62', '64', '60', '126'],
      0,
      'Dari 64 alamat, 2 digunakan untuk network dan broadcast sehingga 62 usable.',
    ),
    Question(
      'Subnet mask /26 adalah…',
      ['255.255.255.0', '255.255.255.192', '255.255.0.0', '255.0.0.0'],
      1,
      'Prefix /26 setara dengan 255.255.255.192.',
    ),
    Question(
      'Subnet /30 memiliki subnet mask…',
      ['255.255.255.0', '255.255.255.192', '255.255.255.252', '255.255.0.0'],
      2,
      'Prefix /30 setara dengan 255.255.255.252.',
    ),
    Question(
      'Network address 192.168.1.130/26 adalah…',
      ['192.168.1.0', '192.168.1.64', '192.168.1.128', '192.168.1.192'],
      2,
      'Blok /26 dimulai pada 0, 64, 128, dan 192; sehingga 130 berada pada jaringan 128.',
    ),
    Question(
      'Broadcast address jaringan 192.168.1.128/26 adalah…',
      ['192.168.1.129', '192.168.1.190', '192.168.1.191', '192.168.1.255'],
      2,
      'Jaringan 192.168.1.128/26 memiliki broadcast 192.168.1.191.',
    ),
    Question(
      'Topologi yang memiliki banyak jalur antarperangkat adalah…',
      ['Mesh', 'Bus', 'Ring', 'Star'],
      0,
      'Topologi mesh menyediakan banyak koneksi langsung antarperangkat.',
    ),
    Question(
      'Pada subnetting, network address digunakan untuk…',
      ['Menunjukkan alamat jaringan', 'Menunjukkan monitor', 'Menunjukkan keyboard', 'Menunjukkan DNS saja'],
      0,
      'Network address mengidentifikasi suatu jaringan/subnet.',
    ),
    Question(
      'Broadcast address digunakan untuk…',
      ['Mengirim ke seluruh host dalam subnet', 'Mengirim hanya ke satu host', 'Mengubah subnet mask', 'Mengatur DNS'],
      0,
      'Broadcast digunakan untuk komunikasi kepada seluruh host dalam subnet.',
    ),
    Question(
      'Tujuan subnetting adalah…',
      ['Membagi jaringan menjadi beberapa subnet', 'Memperbesar monitor', 'Mengganti kabel', 'Menghapus IP'],
      0,
      'Subnetting membagi satu jaringan menjadi beberapa jaringan yang lebih kecil.',
    ),
    Question(
      'Prefix /30 memiliki berapa bit host?',
      ['2', '4', '8', '30'],
      0,
      'IPv4 memiliki 32 bit, sehingga /30 menyisakan 2 bit host.',
    ),
    Question(
      'Prefix /26 memiliki berapa bit host?',
      ['2', '4', '6', '26'],
      2,
      'IPv4 memiliki 32 bit, sehingga /26 menyisakan 6 bit host.',
    ),
  ],

  // ============================================================
  // LEVEL 7 - UJIAN AKHIR JARINGAN
  // ============================================================
  [
    Question(
      'Layanan pemberi IP otomatis adalah…',
      ['DNS', 'HTTP', 'DHCP', 'FTP'],
      2,
      'DHCP memberikan konfigurasi IP secara otomatis kepada client.',
    ),
    Question(
      'Protokol aman untuk membuka website adalah…',
      ['HTTP', 'HTTPS', 'Telnet', 'TFTP'],
      1,
      'HTTPS menggunakan TLS untuk membantu mengamankan komunikasi web.',
    ),
    Question(
      'Alat untuk membatasi lalu lintas jaringan adalah…',
      ['Firewall', 'Hub', 'Mouse', 'Repeater'],
      0,
      'Firewall menerapkan aturan untuk mengatur lalu lintas jaringan.',
    ),
    Question(
      'Port default DNS adalah…',
      ['21', '53', '80', '443'],
      1,
      'DNS umumnya menggunakan port 53.',
    ),
    Question(
      'Perangkat yang menghubungkan jaringan berbeda adalah…',
      ['Router', 'Monitor', 'Keyboard', 'Printer'],
      0,
      'Router digunakan untuk menghubungkan jaringan yang berbeda.',
    ),
    Question(
      'Perangkat yang menghubungkan banyak perangkat dalam LAN adalah…',
      ['Switch', 'Modem', 'Monitor', 'Speaker'],
      0,
      'Switch digunakan untuk menghubungkan perangkat dalam jaringan lokal.',
    ),
    Question(
      'Perintah untuk menguji konektivitas jaringan adalah…',
      ['ping', 'copy', 'mkdir', 'format'],
      0,
      'Ping digunakan untuk menguji keterjangkauan host.',
    ),
    Question(
      'Alamat 169.254.x.x biasanya menunjukkan…',
      ['Kegagalan memperoleh IP DHCP', 'DNS berhasil', 'Internet cepat', 'Firewall mati'],
      0,
      'Alamat tersebut biasanya merupakan APIPA ketika DHCP gagal memberikan IP.',
    ),
    Question(
      'Subnet mask /24 adalah…',
      ['255.0.0.0', '255.255.0.0', '255.255.255.0', '255.255.255.255'],
      2,
      'Prefix /24 setara dengan 255.255.255.0.',
    ),
    Question(
      'Topologi dengan perangkat pusat adalah…',
      ['Star', 'Ring', 'Bus', 'Mesh'],
      0,
      'Topologi star menggunakan perangkat pusat untuk menghubungkan host.',
    ),
    Question(
      'Fiber optic cocok digunakan untuk…',
      ['Jarak jauh dan kecepatan tinggi', 'Keyboard', 'Printer USB', 'Audio'],
      0,
      'Fiber optic cocok untuk transmisi berkecepatan tinggi dan jarak jauh.',
    ),
    Question(
      'DNS berfungsi untuk…',
      ['Menerjemahkan nama domain menjadi IP', 'Memberikan listrik', 'Menghubungkan keyboard', 'Mencetak dokumen'],
      0,
      'DNS membantu menerjemahkan nama domain menjadi alamat IP.',
    ),
    Question(
      'DHCP berfungsi untuk…',
      ['Memberikan konfigurasi IP otomatis', 'Menerjemahkan domain', 'Menguji ping', 'Membatasi firewall'],
      0,
      'DHCP menyediakan konfigurasi jaringan secara otomatis kepada client.',
    ),
    Question(
      'Firewall berfungsi untuk…',
      ['Mengatur dan membatasi lalu lintas jaringan', 'Menyimpan file pribadi', 'Mengubah monitor', 'Menghubungkan keyboard'],
      0,
      'Firewall menggunakan aturan untuk mengontrol lalu lintas jaringan.',
    ),
    Question(
      'Jika ping IP berhasil tetapi nama domain gagal, kemungkinan masalah ada pada…',
      ['DNS', 'Monitor', 'RAM', 'Keyboard'],
      0,
      'Jika IP dapat dijangkau tetapi nama tidak dapat diterjemahkan, DNS perlu diperiksa.',
    ),
    Question(
      'Jumlah host usable pada subnet /30 adalah…',
      ['2', '4', '6', '8'],
      0,
      'Subnet /30 memiliki 4 alamat dengan 2 alamat usable untuk host.',
    ),
    Question(
      'Alamat IPv4 yang valid adalah…',
      ['192.168.1.10', '192.168.1.999', '192.168.1', '300.1.1.1'],
      0,
      'Setiap oktet IPv4 harus berada pada rentang 0 sampai 255.',
    ),
    Question(
      'Jika lampu port switch mati, pemeriksaan awal yang tepat adalah…',
      ['Kabel dan koneksi fisik', 'Wallpaper', 'Speaker', 'Font'],
      0,
      'Pemeriksaan fisik merupakan langkah awal dalam troubleshooting.',
    ),
    Question(
      'Tujuan subnetting adalah…',
      ['Membagi jaringan menjadi subnet', 'Menghapus IP', 'Mengganti DNS', 'Memperbesar monitor'],
      0,
      'Subnetting digunakan untuk membagi jaringan menjadi beberapa subnet.',
    ),
    Question(
      'Konsep utama troubleshooting jaringan adalah…',
      ['Mencari penyebab masalah secara bertahap', 'Mengganti semua perangkat', 'Menghapus sistem operasi', 'Mematikan semua komputer'],
      0,
      'Troubleshooting dilakukan secara sistematis dan bertahap untuk menemukan penyebab masalah.',
    ),
  ],
];