import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_field.dart';
import '../utils/validators.dart';

class NoteFormScreen extends StatefulWidget {
  final String initialNote;
  const NoteFormScreen({super.key, required this.initialNote});

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (!_formKey.currentState!.validate()) return;
    
    // Kembalikan data catatan menggunakan pop
    Navigator.pop(context, _noteController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 430),
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFF334155), width: 6),
          ),
          clipBehavior: Clip.antiAlias,
          child: Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.surface,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close_rounded, color: AppColors.textPrimary),
                onPressed: () => Navigator.pop(context, widget.initialNote),
              ),
              title: Text('Edit Catatan', style: AppTextStyles.heading2),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomInputField(
                        label: 'Catatan Tugas',
                        hint: 'Tuliskan catatan tambahan di sini...',
                        prefixIcon: Icons.notes_rounded,
                        controller: _noteController,
                        validator: (v) => Validators.required(v, 'Catatan'),
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Simpan Catatan',
                        icon: Icons.save_rounded,
                        onPressed: _saveNote,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
