import 'package:flutter/material.dart';

import 'database_helper/database_helper.dart';

class MetalConstructionsPage extends StatelessWidget {
  const MetalConstructionsPage({super.key});

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
            future: DatabaseHelper.instance.getMetalMapList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final metals = snapshot.data!;
              return ListView.builder(
                itemCount: metals.length,
                itemBuilder: (context, index) {
                  final metal = metals[index];
                  return GestureDetector(
                    onTap: () => _showDetailsDialog(context, metal),
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.asset(
                          metal['metalPhotoPath'],
                          fit: BoxFit.cover,
                        ),
                        title: Text(metal['metalTitle'], style: const TextStyle(fontWeight: FontWeight.bold),),
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
          title: Text(window['metalTitle']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(window['metalPhotoPath']),
              SizedBox(height: 10),
              Text(window['metalDescription']),
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
