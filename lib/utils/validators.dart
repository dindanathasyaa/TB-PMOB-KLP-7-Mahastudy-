class Validators {
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'Input'} tidak boleh kosong';
    }
    return null;
  }

  static String? email(String? value) {
    final req = required(value, 'Email');
    if (req != null) return req;
    
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value!)) {
      return 'Format email tidak valid';
    }
    return null;
  }
}
