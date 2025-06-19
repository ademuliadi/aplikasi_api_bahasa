import 'package:flutter/material.dart';

class HalamanKosaKata extends StatefulWidget {
  final String kategori;
  HalamanKosaKata({required this.kategori});

  @override
  _HalamanKosaKataState createState() => _HalamanKosaKataState();
}

class _HalamanKosaKataState extends State<HalamanKosaKata> {
  int currentIndex = 0;
  bool isFinished = false;

  List<Map<String, String>> semuaKosaKata = [
    // KOSA KATA HEWAN
    {
      'kata': 'Dog',
      'arti': 'Anjing',
      'ejaan': 'dog',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/dog.jpg',
    },
    {
      'kata': 'Rabbit',
      'arti': 'Kelinci',
      'ejaan': 're-bit',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/rabbit.jpg',
    },
    {
      'kata': 'Zebra',
      'arti': 'Zebra',
      'ejaan': 'ze-bra',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/zebra.jpg',
    },
    {
      'kata': 'Cat',
      'arti': 'Kucing',
      'ejaan': 'kat',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/cat.jpg',
    },
    {
      'kata': 'Cow',
      'arti': 'Sapi',
      'ejaan': 'kau',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/cow.jpg',
    },
    {
      'kata': 'Crocodile',
      'arti': 'Buaya',
      'ejaan': 'kro-ko-dail',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/crocodile.jpg',
    },
    {
      'kata': 'Bird',
      'arti': 'Burung',
      'ejaan': 'bi-rd',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/bird.jpg',
    },
    {
      'kata': 'Deer',
      'arti': 'Rusa',
      'ejaan': 'dir',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/deer.jpg',
    },
    {
      'kata': 'Chicken',
      'arti': 'Ayam',
      'ejaan': 'chi-ken',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/chicken.jpg',
    },
    {
      'kata': 'Tiger',
      'arti': 'Harimau',
      'ejaan': 'tai-ger',
      'kategori': 'Kosa Kata Hewan',
      'gambar': 'assets/images/tiger.jpg',
    },

    // KOSA KATA BUAH
    {
      'kata': 'Kiwi',
      'arti': 'Kiwi',
      'ejaan': 'ki-wi',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/kiwi.jpg',
    },
    {
      'kata': 'Durian',
      'arti': 'Durian',
      'ejaan': 'du-ri-an',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/Durian.jpg',
    },
    {
      'kata': 'Mangosteen',
      'arti': 'Manggis',
      'ejaan': 'mang-ge-stin',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/mangosteen.jpg',
    },
    {
      'kata': 'Apple',
      'arti': 'Apel',
      'ejaan': 'ap-pel',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/apple.jpg',
    },
    {
      'kata': 'Melon',
      'arti': 'Melon',
      'ejaan': 'me-lon',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/melon.jpg',
    },
    {
      'kata': 'Strawberry',
      'arti': 'Stroberi',
      'ejaan': 'stro-ber-ri',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/strawberry.jpg',
    },
    {
      'kata': 'Rambutan',
      'arti': 'Rambutan',
      'ejaan': 'ram-bu-tan',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/rambutan.jpg',
    },
    {
      'kata': 'Banana',
      'arti': 'Pisang',
      'ejaan': 'ba-na-na',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/banana.jpg',
    },
    {
      'kata': 'Soursop',
      'arti': 'Sirsak',
      'ejaan': 'sau-er-sop',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/soursop.jpg',
    },
    {
      'kata': 'Sapodilla',
      'arti': 'Sawo',
      'ejaan': 'sa-po-di-la',
      'kategori': 'Kosa Kata Buah',
      'gambar': 'assets/images/sapodilla.jpg',
    },

    // KOSA KATA BUNGA
    {
      'kata': 'Jasmine',
      'arti': 'Melati',
      'ejaan': 'jaz-min',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/jasmine.jpg',
    },
    {
      'kata': 'Rose',
      'arti': 'Mawar',
      'ejaan': 'rous',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/rose.jpg',
    },
    {
      'kata': 'Bougainvillea',
      'arti': 'Bougenville',
      'ejaan': 'bou-gen-vil-lea',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/bougainvillea.jpg',
    },
    {
      'kata': 'Sunflower',
      'arti': 'Bunga Matahari',
      'ejaan': 'san-flau-er',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/sun.jpg',
    },
    {
      'kata': 'Lavender',
      'arti': 'Lavender',
      'ejaan': 'la-ven-der',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/lavender.jpg',
    },
    {
      'kata': 'Orchid',
      'arti': 'Anggrek',
      'ejaan': 'or-kid',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/orchid.jpg',
    },
    {
      'kata': 'Lily',
      'arti': 'lili',
      'ejaan': 'li-li',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/lily.jpg',
    },
    {
      'kata': 'Frangipani',
      'arti': 'Kamboja',
      'ejaan': 'fran-ji-pa-ni',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/frangipani.jpg',
    },
    {
      'kata': 'Tulip',
      'arti': 'Tulip',
      'ejaan': 'tu-lip',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/tulip.jpg',
    },
    {
      'kata': 'Lotus',
      'arti': 'Teratai',
      'ejaan': 'lo-tes',
      'kategori': 'Kosa Kata Bunga',
      'gambar': 'assets/images/lotus.jpg',
    },

    // KOSA KATA ORGAN TUBUH
    {
      'kata': 'Heart',
      'arti': 'Jantung',
      'ejaan': 'härt',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/heart.jpg',
    },
    {
      'kata': 'Liver',
      'arti': 'Hati',
      'ejaan': 'li-ver',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/liver.jpg',
    },
    {
      'kata': 'Ears',
      'arti': 'Telinga',
      'ejaan': 'iers',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/ears.jpg',
    },
    {
      'kata': 'Eyes',
      'arti': 'Mata',
      'ejaan': 'ais',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/eyes.jpg',
    },
    {
      'kata': 'Stomach',
      'arti': 'Lambung',
      'ejaan': 'sta-mek',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/stomach.jpg',
    },
    {
      'kata': 'Intestines',
      'arti': 'Usus',
      'ejaan': 'in-tes-tins',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/intestines.jpg',
    },
    {
      'kata': 'Kidney',
      'arti': 'Ginjal',
      'ejaan': 'kid-ni',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/kidney.jpg',
    },
    {
      'kata': 'Lung',
      'arti': 'Paru-Paru',
      'ejaan': 'lang',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/lung.jpg',
    },
    {
      'kata': 'Brain',
      'arti': 'Otak',
      'ejaan': 'breyn',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/brain.jpg',
    },
    {
      'kata': 'Nose',
      'arti': 'Hidung',
      'ejaan': 'nous',
      'kategori': 'Kosa Kata Organ Tubuh',
      'gambar': 'assets/images/nose.jpg',
    },
  ];

  List<Map<String, String>> get daftarTampil {
    return semuaKosaKata
        .where((item) => item['kategori'] == widget.kategori)
        .toList();
  }

  void nextWord() {
    setState(() {
      if (currentIndex < daftarTampil.length - 1) {
        currentIndex++;
      } else {
        // Langsung kembali ke halaman sebelumnya tanpa finish screen
        Navigator.pop(context);
      }
    });
  }

  void previousWord() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = daftarTampil.length - 1; // Ke akhir
      }
    });
  }

  void restartLearning() {
    setState(() {
      currentIndex = 0;
      isFinished = false;
    });
  }

  void finishLearning() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Debug print untuk melihat kategori yang diterima
    print('Kategori diterima: "${widget.kategori}"');
    print('Jumlah data untuk kategori ini: ${daftarTampil.length}');

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final isTablet = screenWidth > 600;

    final imageSize = isTablet ? screenWidth * 0.25 : screenWidth * 0.35;
    final titleFontSize = isTablet ? 32.0 : 24.0;
    final pronunciationFontSize = isTablet ? 18.0 : 16.0;
    final meaningFontSize = isTablet ? 32.0 : 28.0;
    final cardMargin = isTablet ? 16.0 : 12.0;
    final cardPadding = isTablet ? 20.0 : 16.0;

    if (daftarTampil.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${widget.kategori}'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('Tidak ada data untuk kategori ini.'),
              SizedBox(height: 8),
              Text('Kategori: "${widget.kategori}"'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('${widget.kategori}'),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        foregroundColor: Colors.white,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${currentIndex + 1}/${daftarTampil.length}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Kartu Kosakata
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(cardMargin),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(cardPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Arti (Bahasa Indonesia)
                        Flexible(
                          flex: 1,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              daftarTampil[currentIndex]['arti'] ?? '',
                              style: TextStyle(
                                fontSize: meaningFontSize,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        SizedBox(height: isTablet ? 16 : 12),

                        // Gambar
                        Flexible(
                          flex: 4,
                          child: Container(
                            width: imageSize,
                            height: imageSize,
                            constraints: BoxConstraints(
                              maxWidth: 200,
                              maxHeight: 200,
                              minWidth: 120,
                              minHeight: 120,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                daftarTampil[currentIndex]['gambar'] ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[300],
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: imageSize * 0.25,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: isTablet ? 20 : 16),

                        // Kata dalam bahasa Inggris
                        Flexible(
                          flex: 1,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              daftarTampil[currentIndex]['kata'] ?? '',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        SizedBox(height: isTablet ? 12 : 8),

                        // Ejaan
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: isTablet ? 16 : 12,
                                vertical: isTablet ? 8 : 6),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '/${daftarTampil[currentIndex]['ejaan']}/',
                                style: TextStyle(
                                  fontSize: pronunciationFontSize,
                                  color: Colors.blue[800],
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Indikator titik-titik
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(daftarTampil.length, (index) {
                    return Container(
                      width: isTablet ? 10 : 8,
                      height: isTablet ? 10 : 8,
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index
                            ? Colors.blue[600]
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Tombol navigasi
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Previous
                  Flexible(
                    child: ElevatedButton.icon(
                      onPressed: previousWord,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: isTablet ? 20 : 18,
                      ),
                      label: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('Previous'),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        foregroundColor: Colors.grey,
                        padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 24 : 20,
                            vertical: isTablet ? 16 : 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 16),

                  // Tombol Next atau Finish
                  Flexible(
                    child: currentIndex == daftarTampil.length - 1
                        ? ElevatedButton(
                            onPressed: nextWord,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('Finish'),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 28 : 24,
                                  vertical: isTablet ? 16 : 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          )
                        : ElevatedButton.icon(
                            onPressed: nextWord,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: isTablet ? 20 : 18,
                            ),
                            label: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('Next'),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[600],
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 28 : 24,
                                  vertical: isTablet ? 16 : 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
