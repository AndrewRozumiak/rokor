import 'package:flutter/material.dart';
import 'database_helper/database_helper.dart';

class BrickBlockPage extends StatelessWidget {
  const BrickBlockPage({Key? key});

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
        future: DatabaseHelper.instance.getBlockMapList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final blocks = snapshot.data!;
          return ListView.builder(
            itemCount: blocks.length,
            itemBuilder: (context, index) {
              final block = blocks[index];
              return GestureDetector(
                onTap: () => _showDetailsDialog(context, block),
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.asset(
                      block['blocksPhotoPath'],
                      fit: BoxFit.cover,
                    ),
                    title: Text(block['blocksTitle'], style: const TextStyle(fontWeight: FontWeight.bold),),
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

  void _showDetailsDialog(BuildContext context, Map<String, dynamic> block) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(block['blocksTitle']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(block['blocksPhotoPath']),
              SizedBox(height: 10),
              Text(block['blocksDescription']),
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