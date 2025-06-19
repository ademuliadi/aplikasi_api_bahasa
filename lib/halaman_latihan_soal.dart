import 'package:aplikasi_api_bahasa/custom_button_navbar.dart';
import 'package:aplikasi_api_bahasa/halaman_login.dart';
import 'package:flutter/material.dart';

class HalamanLatihanSoal extends StatefulWidget {
  const HalamanLatihanSoal({super.key});

  @override
  State<HalamanLatihanSoal> createState() => _HalamanLatihanSoalState();
}

class _HalamanLatihanSoalState extends State<HalamanLatihanSoal> {
  int currentQuestionIndex = -1;
  int? selectedOptionIndex;
  bool answerChecked = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is this?',
      'options': ['Elephant', 'Banana', 'Grape', 'Yellow'],
      'answerIndex': 1,
      'image': 'assets/images/banana.jpg',
    },
    {
      'question': 'What is this?',
      'options': ['Nose', 'Mouth', 'Eyebrow', 'Goat'],
      'answerIndex': 0,
      'image': 'assets/images/nose.jpg',
    },
    {
      'question': 'What is this?',
      'options': ['Lung', 'Mouth', 'Eyebrow', 'Soursop'],
      'answerIndex': 0,
      'image': 'assets/images/lung.jpg',
    },
    {
      'question': 'What is this?',
      'options': ['Nose', 'Mouth', 'Eyebrow', 'Lily'],
      'answerIndex': 3,
      'image': 'assets/images/lily.jpg',
    },
    {
      'question': 'What is this?',
      'options': ['Lotus', 'Mouse', 'Grape', 'Lily'],
      'answerIndex': 0,
      'image': 'assets/images/lotus.jpg',
    },
    {
      'question': 'What is this?',
      'options': ['Kidney', 'Mouth', 'Lung', 'Nose'],
      'answerIndex': 0,
      'image': 'assets/images/kidney.jpg',
    },
    {
      'question': 'What is this?',
      'options': ['Door', 'Goat', 'Mouse', 'Dog'],
      'answerIndex': 3,
      'image': 'assets/images/dog.jpg',
    },
    {
      'question': 'What is this?',
      'options': ['Durian', 'Mouth', 'Dog', 'Goat'],
      'answerIndex': 0,
      'image': 'assets/images/Durian.jpg',
    },
    {
      'question': 'What is this?',
      'options': ['Heart', 'Mouth', 'Kidney', 'Goat'],
      'answerIndex': 0,
      'image': 'assets/images/heart.jpg',
    },
    {
      'question': 'What is this?',
      'options': ['Tiger', 'Goat', 'Mouse', 'Cow'],
      'answerIndex': 3,
      'image': 'assets/images/cow.jpg',
    }
  ];

  void handleOptionTap(int index) {
    if (answerChecked) return;
    setState(() {
      selectedOptionIndex = index;
      answerChecked = true;
    });
  }

  void handleNext() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        answerChecked = false;
      });
    } else {
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.celebration, color: Colors.amber, size: 28),
            SizedBox(width: 8),
            Text('Selamat!', style: TextStyle(color: Colors.blue)),
          ],
        ),
        content: Text(
          'Kamu telah menyelesaikan semua soal latihan.',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HalamanUtama()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Selesai', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 700;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'LATIHAN SOAL',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue!, Colors.blue!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          currentQuestionIndex == -1
              ? _buildIntroSlide()
              : _buildQuestionContent(screenHeight, screenWidth, isSmallScreen),
          if (currentQuestionIndex != -1)
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                onPressed: answerChecked ? handleNext : null,
                backgroundColor: answerChecked ? Colors.blue : Colors.grey[300],
                elevation: answerChecked ? 6 : 2,
                child: Text(
                  currentQuestionIndex == questions.length - 1
                      ? "Finish"
                      : "Next",
                  style: TextStyle(
                    color: answerChecked ? Colors.white : Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildIntroSlide() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[50]!, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.quiz, size: 60, color: Colors.white),
                ),
                SizedBox(height: 32),
                Text(
                  'Belajar Bahasa,\nMembuka Jendela Dunia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Mari mulai latihan soal untuk meningkatkan kemampuan bahasa Inggris kamu!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 48),
                ElevatedButton(
                  onPressed: handleNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 3,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Mulai Latihan',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionContent(
      double screenHeight, double screenWidth, bool isSmallScreen) {
    final question = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableHeight = constraints.maxHeight;
          final progressHeight = isSmallScreen ? 50.0 : 60.0;
          final imageHeight =
              isSmallScreen ? availableHeight * 0.2 : availableHeight * 0.25;
          final questionHeight = isSmallScreen ? 50.0 : 70.0;
          final optionsHeight = availableHeight -
              progressHeight -
              imageHeight -
              questionHeight -
              100;

          return Column(
            children: [
              Container(
                height: progressHeight,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Soal ${currentQuestionIndex + 1} dari ${questions.length}',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${currentQuestionIndex + 1}/${questions.length}',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
                      minHeight: 6,
                    ),
                  ],
                ),
              ),
              Container(
                height: imageHeight,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    question['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.image_not_supported,
                        size: imageHeight * 0.3,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: questionHeight,
                  maxHeight: questionHeight + 20,
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    question['question'],
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 80),
                  child: Column(
                    children: List.generate(
                      question['options'].length,
                      (index) => Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          constraints: BoxConstraints(
                            minHeight: isSmallScreen ? 45 : 55,
                          ),
                          child: _buildOption(
                            index,
                            question['options'][index],
                            question['answerIndex'],
                            isSmallScreen,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOption(
      int index, String text, int correctAnswerIndex, bool isSmallScreen) {
    Color? backgroundColor;
    Color? borderColor;
    Color textColor = Colors.grey[800]!;
    IconData? icon;

    if (answerChecked) {
      if (index == selectedOptionIndex) {
        if (index == correctAnswerIndex) {
          backgroundColor = Colors.green[100];
          borderColor = Colors.green[600];
          textColor = Colors.green[800]!;
          icon = Icons.check_circle;
        } else {
          backgroundColor = Colors.red[100];
          borderColor = Colors.red[600];
          textColor = Colors.red[800]!;
          icon = Icons.cancel;
        }
      } else if (index == correctAnswerIndex) {
        backgroundColor = Colors.green[100];
        borderColor = Colors.green[600];
        textColor = Colors.green[800]!;
        icon = Icons.check_circle;
      }
    }

    return Material(
      elevation: answerChecked &&
              (index == selectedOptionIndex || index == correctAnswerIndex)
          ? 4
          : 1,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => handleOptionTap(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: isSmallScreen ? 8 : 12,
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor ?? Colors.grey[300]!,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: isSmallScreen ? 24 : 28,
                height: isSmallScreen ? 24 : 28,
                decoration: BoxDecoration(
                  color: borderColor?.withOpacity(0.2) ?? Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: isSmallScreen ? 12 : 14,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: isSmallScreen ? 14 : 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (icon != null) ...[
                SizedBox(width: 8),
                Icon(
                  icon,
                  color: index == correctAnswerIndex
                      ? Colors.green[600]
                      : Colors.red[600],
                  size: isSmallScreen ? 18 : 20,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}