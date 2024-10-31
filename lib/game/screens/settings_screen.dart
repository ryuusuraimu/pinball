import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool bgmEnabled;
  final bool sfxEnabled;
  final ValueChanged<bool> onBgmToggle;
  final ValueChanged<bool> onSfxToggle;
  final VoidCallback onBack;

  const SettingsScreen({
    super.key,
    required this.bgmEnabled,
    required this.sfxEnabled,
    required this.onBgmToggle,
    required this.onSfxToggle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '設定',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            SwitchListTile(
              title: const Text(
                'BGM',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              value: bgmEnabled,
              onChanged: onBgmToggle,
            ),
            SwitchListTile(
              title: const Text(
                '効果音',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              value: sfxEnabled,
              onChanged: onSfxToggle,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onBack,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.orange,
              ),
              child: const Text(
                '戻る',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
