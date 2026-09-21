import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class StudyTimerWidget extends StatefulWidget {
  final int initialMinutes;
  final Function(int minutesSpent)? onSessionCompleted;

  const StudyTimerWidget({
    super.key,
    this.initialMinutes = 25,
    this.onSessionCompleted,
  });

  @override
  State<StudyTimerWidget> createState() => _StudyTimerWidgetState();
}

class _StudyTimerWidgetState extends State<StudyTimerWidget> {
  late int _secondsRemaining;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.initialMinutes * 60;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_timer != null) _timer!.cancel();
    setState(() => _isRunning = true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _pauseTimer();
        if (widget.onSessionCompleted != null) {
          widget.onSessionCompleted!(widget.initialMinutes);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 Sesi Belajar Selesai! Kerja bagus!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetTimer() {
    _pauseTimer();
    setState(() {
      _secondsRemaining = widget.initialMinutes * 60;
    });
  }

  String get _formattedTime {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = 1.0 - (_secondsRemaining / (widget.initialMinutes * 60));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Sesi Belajar Mahastudy',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: 4),
          Text(
            'Fokus tanpa distraksi selama ${widget.initialMinutes} menit',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 20),
          // Timer Display Circle
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 140,
                width: 140,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 10,
                  backgroundColor: AppColors.primaryLight,
                  color: AppColors.primary,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formattedTime,
                    style: AppTextStyles.heading1.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Text(
                    _isRunning ? 'BERJALAN' : 'PAUSE',
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _isRunning ? AppColors.success : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                iconSize: 28,
                onPressed: _resetTimer,
                icon: const Icon(Icons.refresh_rounded, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRunning ? AppColors.warning : AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _isRunning ? _pauseTimer : _startTimer,
                icon: Icon(_isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded),
                label: Text(
                  _isRunning ? 'Jeda' : 'Mulai Fokus',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
