import 'package:flutter/material.dart';

void main() => runApp(const PicturePopApp());

class PictureItem {
  const PictureItem(this.emoji, this.answer, this.color);

  final String emoji;
  final String answer;
  final Color color;
}

class PicturePopApp extends StatelessWidget {
  const PicturePopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Picture Pop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7357FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F4FF),
        useMaterial3: true,
      ),
      home: const PictureQuizPage(),
    );
  }
}

class PictureQuizPage extends StatefulWidget {
  const PictureQuizPage({super.key});

  @override
  State<PictureQuizPage> createState() => _PictureQuizPageState();
}

class _PictureQuizPageState extends State<PictureQuizPage> {
  static const _items = <PictureItem>[
    PictureItem('🍎', 'apple', Color(0xFFFFE4E6)),
    PictureItem('🚗', 'car', Color(0xFFDCEEFF)),
    PictureItem('🎂', 'cake', Color(0xFFFFE5F4)),
    PictureItem('👟', 'shoe', Color(0xFFE6F7EC)),
    PictureItem('🍌', 'banana', Color(0xFFFFF4C7)),
    PictureItem('⚽', 'ball', Color(0xFFE9E7F7)),
  ];

  final _answerController = TextEditingController();
  int _currentIndex = 0;
  int _score = 0;
  bool _isCorrect = false;
  String? _message;

  PictureItem get _currentItem => _items[_currentIndex];

  void _checkAnswer() {
    final answer = _answerController.text.trim().toLowerCase();
    if (answer.isEmpty) {
      setState(() => _message = 'Type your answer first!');
      return;
    }

    final correct = answer == _currentItem.answer;
    setState(() {
      _isCorrect = correct;
      _message = correct ? 'Great job! 🎉' : 'Try again! You can do it.';
      if (correct) _score++;
    });
  }

  void _nextPicture() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _items.length;
      _answerController.clear();
      _message = null;
      _isCorrect = false;
      if (_currentIndex == 0) _score = 0;
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentIndex + 1) / _items.length;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Picture Pop', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
                          Text('What do you see?', style: TextStyle(color: Color(0xFF706D7C))),
                        ],
                      ),
                      Chip(
                        avatar: const Icon(Icons.star_rounded, color: Color(0xFFFFB300)),
                        label: Text('$_score / ${_items.length}', style: const TextStyle(fontWeight: FontWeight.w700)),
                        backgroundColor: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(value: progress, minHeight: 9),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('${_currentIndex + 1} of ${_items.length}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _currentItem.color,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [BoxShadow(color: Color(0x187357FF), blurRadius: 24, offset: Offset(0, 10))],
                      ),
                      alignment: Alignment.center,
                      child: Semantics(
                        label: 'Picture to name',
                        child: Text(_currentItem.emoji, style: const TextStyle(fontSize: 150)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  TextField(
                    controller: _answerController,
                    enabled: !_isCorrect,
                    textAlign: TextAlign.center,
                    textCapitalization: TextCapitalization.none,
                    onSubmitted: (_) => _isCorrect ? _nextPicture() : _checkAnswer(),
                    decoration: InputDecoration(
                      hintText: 'Type the name here',
                      prefixIcon: const Icon(Icons.edit_rounded),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 180),
                    child: _message == null
                        ? const SizedBox(height: 12)
                        : Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              _message!,
                              style: TextStyle(
                                color: _isCorrect ? const Color(0xFF16834C) : const Color(0xFFD04949),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: _isCorrect ? _nextPicture : _checkAnswer,
                      child: Text(_isCorrect ? 'Next picture  →' : 'Check answer', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
