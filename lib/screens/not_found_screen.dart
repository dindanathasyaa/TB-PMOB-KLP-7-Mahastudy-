import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

/// Halaman cadangan ketika route tidak dikenal atau argument tidak valid.
class NotFoundScreen extends StatelessWidget {
  final String? routeName;
  final String message;

  const NotFoundScreen({
    super.key,
    this.routeName,
    this.message = 'Halaman yang kamu tuju belum tersedia.',
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 430),
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFF334155), width: 6),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 25,
                offset: Offset(0, 10),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Scaffold(
            appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search_off, size: 72),
              const SizedBox(height: 8),
              Text('404', style: textTheme.displaySmall),
              const SizedBox(height: 8),
              Text(message, textAlign: TextAlign.center),
              if (routeName != null) ...[
                const SizedBox(height: 4),
                Text('Route: $routeName', style: textTheme.bodySmall),
              ],
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  }
                },
                child: const Text('Kembali'),
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
