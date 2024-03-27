import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_2/model.dart';
import 'package:test_2/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final commentProvider =
        Provider.of<CommentProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: commentProvider.fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: commentProvider.comments.length,
              itemBuilder: (context, index) {
                Comment comment = commentProvider.comments[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    // Remove the item from the data source
                    commentProvider.removeComment(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            comment.email,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            comment.body,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
