
import 'package:flutter/material.dart';

void main() {
  runApp(const AdhamFootball());
}

class AdhamFootball extends StatelessWidget {
  const AdhamFootball({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF07101F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int coins = 25000;
  int gp = 100000;
  bool used = false;

  void giftCode() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('كود أدهم'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'ADHAM 1 2 3',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().toUpperCase() ==
                      'ADHAM 1 2 3' &&
                  !used) {
                setState(() {
                  coins += 1000000;
                  used = true;
                });
                Navigator.pop(context);
                showMessage('مبروك! أضفنا مليون كوينز تجريبية.');
              } else {
                Navigator.pop(context);
                showMessage('الكود غير صحيح أو تم استخدامه.');
              }
            },
            child: const Text('تفعيل'),
          ),
        ],
      ),
    );
  }

  void showMessage(String text) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تمام'),
          ),
        ],
      ),
    );
  }

  void dailyGift() {
    setState(() {
      coins += 1000;
      gp += 5000;
    });
    showMessage('استلمت 1000 كوينز و5000 GP تجريبية!');
  }

  void openPack() {
    if (coins < 5000) {
      showMessage('تحتاج إلى 5000 كوينز لفتح البكج.');
      return;
    }

    setState(() => coins -= 5000);

    showMessage(
      'تم فتح بكج تجريبي!\n'
      'يمكنك إضافة نظام بطاقات اللاعبين في الخطوة التالية.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADHAM FOOTBALL',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: giftCode,
            icon: const Icon(Icons.card_giftcard),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFF13243D),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'DREAM TEAM',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text('🪙 الكوينز: $coins'),
                  const SizedBox(height: 8),
                  Text('GP: $gp'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: giftCode,
                    icon: const Icon(Icons.redeem),
                    label: const Text('كود أدهم 1 2 3'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _tile(
            Icons.card_giftcard,
            'الهدايا اليومية',
            'اجمع الكوينز وGP',
            dailyGift,
          ),
          _tile(
            Icons.style,
            'بكجات اللاعبين',
            'افتح بكج بـ 5000 كوينز',
            openPack,
          ),
          _tile(
            Icons.sports_soccer,
            'مباراة ضد الكمبيوتر',
            'وضع تجريبي',
            () => showMessage(
              'وضع المباراة يحتاج إلى تطوير محرك لعب فعلي.',
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'الأساطير واللاعبون',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Chip(label: Text('Ronaldo • 110')),
              Chip(label: Text('Messi • 110')),
              Chip(label: Text('Salah • 108')),
              Chip(label: Text('Haaland • 108')),
              Chip(label: Text('Suárez • 106')),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'نسخة تجريبية مستقلة، لا تعدّل eFootball الأصلية.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback action,
  ) {
    return Card(
      color: const Color(0xFF101C2C),
      child: ListTile(
        leading: Icon(icon, color: Colors.lightBlueAccent),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: action,
      ),
    );
  }
}
