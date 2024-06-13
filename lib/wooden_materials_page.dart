import 'package:flutter/material.dart';

import 'database_helper/database_helper.dart';

class WoodenMaterialsPage extends StatelessWidget {
  const WoodenMaterialsPage({super.key});


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
            future: DatabaseHelper.instance.getTreeMapList(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final trees = snapshot.data!;
              return ListView.builder(
                itemCount: trees.length,
                itemBuilder: (context, index) {
                  final tree = trees[index];
                  return GestureDetector(
                    onTap: () => _showDetailsDialog(context, tree),
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.asset(
                          tree['treePhotoPath'],
                          fit: BoxFit.cover,
                        ),
                        title: Text(tree['treeTitle'], style: const TextStyle(fontWeight: FontWeight.bold),),
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

  void _showDetailsDialog(BuildContext context, Map<String, dynamic> tree) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text(tree['treeTitle']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(tree['treePhotoPath']),
              SizedBox(height: 10),
              Text(tree['treeDescription']),
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
