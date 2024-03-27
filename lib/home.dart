import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_2/model.dart';
import 'package:test_2/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final commentProvider =
        Provider.of<CommentProvider>(context, listen: false);
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
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: ListTile(
                    title: Text(comment.name),
                    subtitle: Text(comment.email),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // Add onTap functionality if needed
                    },
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
