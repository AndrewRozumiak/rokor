import 'package:flutter/material.dart';

import 'database_helper/database_helper.dart';

class WindowsDoorsPage extends StatelessWidget {
  const WindowsDoorsPage({super.key});

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
        body: Container(
          color: Colors.white,
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: DatabaseHelper.instance.getWindowMapList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final windows = snapshot.data!;
              return ListView.builder(
                itemCount: windows.length,
                itemBuilder: (context, index) {
                  final window = windows[index];
                  return GestureDetector(
                    onTap: () => _showDetailsDialog(context, window),
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.asset(
                          window['windowsPhotoPath'],
                          fit: BoxFit.cover,
                        ),
                        title: Text(window['windowsTitle'], style: const TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
    );
  }

  void _showDetailsDialog(BuildContext context, Map<String, dynamic> window) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(window['windowsTitle']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(window['windowsPhotoPath']),
              SizedBox(height: 10),
              Text(window['windowsDescription']),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрити'),
            ),
          ],
        );
      },
    );
  }
}
