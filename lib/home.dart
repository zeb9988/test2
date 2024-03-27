import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_2/model.dart';
import 'package:test_2/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
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
                return ListTile(
                  title: Text(comment.name),
                  subtitle: Text(comment.email),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Add onTap functionality if needed
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
