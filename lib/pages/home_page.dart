import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wall/auth/auth.dart';
import 'package:flutter_wall/components/my_drawer.dart';
import 'package:flutter_wall/components/wall_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController controller = TextEditingController();

  // 🔹 Function to sign out
  void signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Auth()),
    );
  }

  // 🔹 Function to post a message
  void postMessage() async {
    if (controller.text.trim().isEmpty) return;

    await FirebaseFirestore.instance.collection('posts').add({
      'message': controller.text.trim(),
      'email': currentUser!.email,
      'timestamp': FieldValue.serverTimestamp(),
      'likes':[]  
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wall"),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
        ],
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // 🔹 Message input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Write a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: postMessage,
                  icon: const Icon(Icons.arrow_circle_up),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Text("Logged in as ${currentUser!.email}"),

            const SizedBox(height: 10),

            // 🔹 Stream of posts (Realtime)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No posts yet."));
                  }

                  final posts = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return WallPost(
                        message: post['message'] ?? '',
                        username: post['email'] ?? '',
                        time: post['timestamp'] ?? Timestamp.now(),
                        likes: List<String>.from(post['likes'] ?? []),
                        postId: post.id,

                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
