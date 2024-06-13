import 'package:flutter/material.dart';
import 'package:rokor_app/windows_doors_page.dart';
import 'package:rokor_app/wooden_materials_page.dart';

import 'brick_block_page.dart';
import 'metal_constructions_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'РОКОР',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: Colors.grey[300], // Фоновий колір баді
      body: ScrollNotificationObserver(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MetalConstructionsPage(), // Замініть на вашу сторінку для Вікон та дверей
                  ),
                );
              },
              child: CardWidget(
                imagePath: 'assets/images/img_2.png',
                title: 'Металеві конструкції',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BrickBlockPage(), // Замініть на вашу сторінку для Дерев'яних матеріалів
                  ),
                );
              },
              child: CardWidget(
                imagePath: 'assets/images/img.png',
                title: 'Цегла та Блоки',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WoodenMaterialsPage(), // Замініть на вашу сторінку для Металевих конструкцій
                  ),
                );
              },
              child: CardWidget(
                imagePath: 'assets/images/img_3.png',
                title: 'Дерев\'яні матеріали',
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WindowsDoorsPage(), // Замініть на вашу сторінку для Цегли та Блоків
                  ),
                );
              },
              child: CardWidget(
                imagePath: 'assets/images/img_1.png',
                title: 'Вікна та двері',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CardWidget extends StatelessWidget {
  final String imagePath;
  final String title;

  const CardWidget({
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}