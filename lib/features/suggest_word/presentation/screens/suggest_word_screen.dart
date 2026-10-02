import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/dio/app_dependencies.dart';
import '../../../../core/theme/appColors.dart';
import '../../data/word_category.dart';
import '../widgets/load_error_view.dart';
import '../widgets/suggest_word_app_bar.dart';
import '../widgets/suggest_word_form.dart';

class SuggestWordScreen extends StatefulWidget {
  const SuggestWordScreen({super.key});

  @override
  State<SuggestWordScreen> createState() => _SuggestWordScreenState();
}

class _SuggestWordScreenState extends State<SuggestWordScreen> {
  final _repository = AppDependencies.suggestWordRepository;
  final _textController = TextEditingController();

  List<WordCategory> _categories = [];
  int? _selectedId;
  bool _loading = true;
  bool _sending = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    final result = await _repository.categories();
    if (!mounted) return;
    setState(() {
      _loading = false;
      result.fold((f) => _loadError = f.message, (list) => _categories = list);
    });
  }

  Future<void> _submit() async {
    final text = _textController.text.trim();
    final categoryId = _selectedId;
    if (text.isEmpty || categoryId == null) {
      return _toast('اكتب الكلمة واختر الفئة أولاً');
    }
    setState(() => _sending = true);
    final result = await _repository.submit(text: text, categoryId: categoryId);
    if (!mounted) return;
    setState(() => _sending = false);
    result.fold((f) => _toast(f.message), (_) {
      _textController.clear();
      _toast('شكراً! وصل اقتراحك');
    });
  }

  void _toast(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message, style: GoogleFonts.cairo())));

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // RTL comes from MaterialApp.builder in main.dart.
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SuggestWordAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    final error = _loadError;
    if (error != null) {
      return LoadErrorView(message: error, onRetry: _loadCategories);
    }
    return SuggestWordForm(
      categories: _categories,
      selectedId: _selectedId,
      onSelect: (id) => setState(() => _selectedId = id),
      controller: _textController,
      sending: _sending,
      onSubmit: _submit,
    );
  }
}