import 'package:aplikasi_api_bahasa/custom_button_navbar.dart';
import 'package:flutter/material.dart';


class HalamanKuis extends StatefulWidget {
  const HalamanKuis({super.key});
  

  @override
  _HalamanKuisState createState() => _HalamanKuisState();
}

class _HalamanKuisState extends State<HalamanKuis> {
  // Data quiz berdasarkan kategori
  final Map<String, List<Map<String, dynamic>>> _allQuestions = {
    'Easy': [
      {
        'questionText': 'Where is the banana?',
        'answerImages': [
          'assets/images/banana.jpg',
          'assets/images/apple.jpg',
          'assets/images/mangosteen.jpg',
          'assets/images/Durian.jpg'
        ],
        'correctAnswer': 'assets/images/banana.jpg',
        'type': 'image_options' // Menandai bahwa ini soal dengan pilihan gambar
      },
      {
        'questionText': 'Where is the apple?',
        'answerImages': [
          'assets/images/mangosteen.jpg',
          'assets/images/Durian.jpg',
          'assets/images/banana.jpg',
          'assets/images/apple.jpg'
        ],
        'correctAnswer': 'assets/images/apple.jpg',
        'type': 'image_options'
      },
      {
        'questionText': 'Where is the bird?',
        'answerImages': [
          'assets/images/cow.jpg',
          'assets/images/deer.jpg',
          'assets/images/bird.jpg',
          'assets/images/chicken.jpg'
        ],
        'correctAnswer': 'assets/images/bird.jpg',
        'type': 'image_options'
      },
      {
        'questionText': 'Where is the deer?',
        'answerImages': [
          'assets/images/cat.jpg',
          'assets/images/bird.jpg',
          'assets/images/cow.jpg',
          'assets/images/deer.jpg'
        ],
        'correctAnswer': 'assets/images/deer.jpg',
        'type': 'image_options'
      },
      {
        'questionText': 'Where is the cow?',
        'answerImages': [
          'assets/images/tiger.jpg',
          'assets/images/cow.jpg',
          'assets/images/dog.jpg',
          'assets/images/bird.jpg'
        ],
        'correctAnswer': 'assets/images/cow.jpg',
        'type': 'image_options'
      },
    ],
    'Medium': [
      {
        'questionText': 'Apa arti dari kata "Tiger" dalam bahasa Indonesia?',
        'answers': ['Singa', 'Harimau', 'Macan', 'Kucing'],
        'correctAnswer': 'Harimau',
        'type': 'text_options'
      },
      {
        'questionText': 'Bagaimana cara pengucapan kata "Heart"?',
        'answers': ['härt', 'he-art', 'har-ti', 'hert'],
        'correctAnswer': 'härt',
        'type': 'text_options'
      },
      {
        'questionText': 'Manakah yang merupakan nama bunga dalam bahasa Inggris?',
        'answers': ['Sapodilla', 'Jasmine', 'Durian', 'Kidney'],
        'correctAnswer': 'Jasmine',
        'type': 'text_options'
      },
      {
        'questionText': 'Apa arti dari kata "Lung" dalam bahasa Indonesia?',
        'answers': ['Jantung', 'Ginjal', 'Paru-Paru', 'Otak'],
        'correctAnswer': 'Paru-Paru',
        'type': 'text_options'
      },
      {
        'questionText': 'Bagaimana pengucapan kata "Mangosteen"?',
        'answers': ['mang-go-stin', 'mang-ge-stin', 'man-go-sten', 'mango-steen'],
        'correctAnswer': 'mang-ge-stin',
        'type': 'text_options'
      },
    ],
    'Hard': [
      {
        'questionText': 'Manakah pasangan kata dan arti yang BENAR?',
        'answers': [
          'Sapodilla - Sirsak',
          'Soursop - Sirsak',
          'Lotus - Lavender',
          'Tulip - Teratai'
        ],
        'correctAnswer': 'Soursop - Sirsak',
        'type': 'text_options'
      },
      {
        'questionText': 'Dari kata-kata berikut, manakah yang termasuk kategori "Organ Tubuh"?',
        'answers': ['Lily', 'Chicken', 'Brain', 'Banana'],
        'correctAnswer': 'Brain',
        'type': 'text_options'
      },
      {
        'questionText': 'Bagaimana pengucapan yang BENAR untuk kata "Sapodilla"?',
        'answers': ['sa-po-di-la', 'sa-po-dil-la', 'sapo-dilla', 'sa-podilla'],
        'correctAnswer': 'sa-po-di-la',
        'type': 'text_options'
      },
      {
        'questionText': 'Kelompokkan dengan benar: Dog, Cat, Tiger, Chicken termasuk kategori?',
        'answers': [
          'KosaKata Buah',
          'KosaKata Hewan',
          'KosaKata Bunga',
          'KosaKata Organ Tubuh'
        ],
        'correctAnswer': 'KosaKata Hewan',
        'type': 'text_options'
      },
      {
        'questionText': 'Manakah urutan pengucapan yang BENAR untuk "Lavender"?',
        'answers': ['la-ven-der', 'lav-en-der', 'la-vender', 'laven-der'],
        'correctAnswer': 'la-ven-der',
        'type': 'text_options'
      },
    ],
  };

  List<Map<String, dynamic>> _questions = [];
  String? _selectedCategory;
  int _questionIndex = 0;
  int _score = 0;
  bool _quizFinished = false;
  bool _categorySelected = false;
  bool _showWelcome = true;

  String? _selectedAnswer;
  bool _hasAnswered = false;

  void _startQuiz() {
    setState(() {
      _showWelcome = false;
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _questions = _allQuestions[category]!;
      _categorySelected = true;
      _questionIndex = 0;
      _score = 0;
      _quizFinished = false;
      _selectedAnswer = null;
      _hasAnswered = false;
    });
  }

  void _answerQuestion(String selectedAnswer) {
    setState(() {
      // Jika user mengganti jawaban, kurangi score jika jawaban sebelumnya benar
      if (_selectedAnswer != null && _selectedAnswer == _questions[_questionIndex]['correctAnswer']) {
        _score--;
      }

      _selectedAnswer = selectedAnswer;
      _hasAnswered = true;

      // Tambah score jika jawaban baru benar
      if (selectedAnswer == _questions[_questionIndex]['correctAnswer']) {
        _score++;
      }
    });
  }

  void _goToNextQuestion() {
    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
        _selectedAnswer = null;
        _hasAnswered = false;
      } else {
        _quizFinished = true;
      }
    });
  }

  void _backToCategory() {
    setState(() {
      _categorySelected = false;
      _selectedCategory = null;
      _questionIndex = 0;
      _score = 0;
      _quizFinished = false;
      _selectedAnswer = null;
      _hasAnswered = false;
      _questions = [];
    });
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SafeArea(
              child: Row(
                children: [
                  // MODIFIKASI DIMULAI DI SINI
                  if (_showWelcome)
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                    else if (!_categorySelected) // If on category selection screen, show back button to welcome
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black), // Changed color to white for visibility
                    onPressed: () {
                      setState(() {
                        _showWelcome = true; // Go back to welcome screen
                      });
                    },
                  )
                     else
                    const SizedBox(width: 48), // Placeholder agar judul tetap sejajar
                  // MODIFIKASI BERAKHIR DI SINI
                  Expanded(
                    child: Text(
                      _showWelcome
                          ? 'Quiz Bahasa Inggris'
                          : _categorySelected
                          ? 'Quiz - $_selectedCategory'
                          : 'Pilih Tingkat Kesulitan',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Placeholder
                ],
              ),
            ),
          ),
          // Konten Kuis
          Expanded(
            child: _showWelcome
                ? _buildWelcomeScreen()
                : !_categorySelected
                ? _buildCategorySelectionScreen()
                : _quizFinished
                ? _buildResultsScreen()
                : _buildQuestionScreen(),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
   );
  }

  // --- _buildWelcomeScreen() ---
  Widget _buildWelcomeScreen() {
    return SingleChildScrollView( // Membungkus dengan SingleChildScrollView
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(141, 255, 255, 255),
              Colors.white.withOpacity(0.8),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated welcome container
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Gambar lingkaran tanpa background biru muda
                    const SizedBox(
                      width: 150,
                      height: 150,
                      child: ClipOval(
                        child: Image(
                          image: AssetImage('assets/images/orang tua.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Welcome text
                    const Text(
                      'Selamat Datang!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Quiz Bahasa Inggris',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    // Main question
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Apakah Anda Sudah Siap?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Tes kemampuan Bahasa Inggris anda bersama Ibu Mulia\ndengan berbagai tingkat kesulitan',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Start button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _startQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10),
                      Text(
                        'MULAI QUIZ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- _buildCategorySelectionScreen() ---
   Widget _buildCategorySelectionScreen() {
    return Container(
      color: Colors.white, // Mengubah background menjadi putih penuh
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, // Mengubah menjadi putih penuh
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.quiz,
                      size: 60,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Pilih Tingkat Kesulitan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Pilih level yang sesuai dengan kemampuan Anda',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              _buildCategoryButton(
                'Easy',
                'Mudah (5 soal)',
                Colors.green,
                Icons.sentiment_satisfied,
              ),
              const SizedBox(height: 20),
              _buildCategoryButton(
                'Medium',
                'Sedang (5 soal)',
                Colors.orange,
                Icons.sentiment_neutral,
              ),
              const SizedBox(height: 20),
              _buildCategoryButton(
                'Hard',
                'Sulit (5 soal)',
                Colors.red,
                Icons.sentiment_very_dissatisfied,
              ),
            ],
          ),
        ),
    );
  }

  // Widget untuk pilihan kategori (tidak perlu perubahan di sini)
  Widget _buildCategoryButton(String category, String description, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _selectCategory(category),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: color,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: color, width: 2),
          ),
          elevation: 0,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 30,
                color: color,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: color,
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk layar pertanyaan (tidak perlu perubahan di sini karena Expanded sudah menangani scrollable)
  Widget _buildQuestionScreen() {
    final currentQuestion = _questions[_questionIndex];
    final bool isImageQuestion = currentQuestion['type'] == 'image_options';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Progress indicator
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Soal ${_questionIndex + 1} dari ${_questions.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      _selectedCategory!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Progress bar
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: LinearProgressIndicator(
                value: (_questionIndex + 1) / _questions.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(_getCategoryColor()),
                minHeight: 6,
              ),
            ),

            // Teks pertanyaan
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                currentQuestion['questionText'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            // Pilihan jawaban - berbeda untuk soal gambar dan teks
            Expanded(
              child: isImageQuestion
                  ? _buildImageOptions(currentQuestion)
                  : _buildTextOptions(currentQuestion),
            ),

            if (_hasAnswered)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _questionIndex == _questions.length - 1
                        ? () {
                      setState(() {
                        _quizFinished = true;
                      });
                    }
                        : _goToNextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getCategoryColor(),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      _questionIndex == _questions.length - 1
                          ? 'Selesai'
                          : 'Soal Berikutnya',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget untuk pilihan gambar (Easy level)
  Widget _buildImageOptions(Map<String, dynamic> currentQuestion) {
    final List<String> answerImages = currentQuestion['answerImages'];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.0,
      ),
      itemCount: answerImages.length,
      itemBuilder: (context, index) {
        final imagePath = answerImages[index];
        final isSelected = imagePath == _selectedAnswer;
        final optionLabel = String.fromCharCode(65 + index); // A, B, C, D

        return GestureDetector(
          onTap: () => _answerQuestion(imagePath),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? _getCategoryColor() : Colors.grey[300]!,
                width: isSelected ? 3 : 2,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: _getCategoryColor().withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Column(
              children: [
                // Label A, B, C, D di pojok kiri atas
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? _getCategoryColor() : Colors.grey[400],
                    ),
                    child: Center(
                      child: Text(
                        optionLabel,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                // Gambar
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget untuk pilihan teks (Medium & Hard level)
  Widget _buildTextOptions(Map<String, dynamic> currentQuestion) {
    return ListView.builder(
      itemCount: currentQuestion['answers'].length,
      itemBuilder: (context, index) {
        final answer = currentQuestion['answers'][index];
        final isSelected = answer == _selectedAnswer;
        final optionLabel = String.fromCharCode(65 + index); // A, B, C, D

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () => _answerQuestion(answer),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Lingkaran dengan huruf A, B, C, D
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? _getCategoryColor() : Colors.grey[400]!,
                          width: 2,
                        ),
                        color: isSelected ? _getCategoryColor() : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          optionLabel,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Teks jawaban
                    Expanded(
                      child: Text(
                        answer,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? _getCategoryColor() : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // --- MODIFIED _buildResultsScreen() ---
  Widget _buildResultsScreen() {
    int wrongAnswers = _questions.length - _score;
    int finalScore = _score * 20; // Setiap soal bernilai 20 (untuk 5 soal total 100)

    return SingleChildScrollView( // Membungkus dengan SingleChildScrollView
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60), // Add this line to push content down
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                border: Border.all(color: _getCategoryColor(), width: 2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _selectedCategory!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'HASIL AKHIR',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$finalScore', // Menampilkan skor dalam skala 100
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: _getCategoryColor(),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text( // Diubah agar tidak menampilkan persentase
                    'dari 100',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Jawaban Benar',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: _getCategoryColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Benar $_score Salah $wrongAnswers',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: _getCategoryColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () => _selectCategory(_selectedCategory!),
                    icon: const Icon(Icons.refresh,color: Colors.white,),
                    label: const Text('Ulangi Quiz'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getCategoryColor(),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _backToCategory,
                    icon: const Icon(Icons.exit_to_app, color: Colors.white,), // Changed icon
                    label: const Text('Selesai'), // Changed text
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (_selectedCategory) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Hard':
        return Colors.red;
      default:
        return const Color(0xFF2052BD);
    }
  }
}