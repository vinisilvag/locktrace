import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locktrace/widgets/avatar.dart';
import 'package:locktrace/widgets/lock_item.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void createTrace() {}

  void openTraceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return SizedBox(
          width: 520,
          height: 400,
          child: Container(
            padding: EdgeInsetsGeometry.fromLTRB(24, 24, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("O que você conferiu?"),
                ElevatedButton(onPressed: createTrace, child: Text("Enviar")),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 24),
          child: Avatar(
            avatarSeed: FirebaseAuth.instance.currentUser!.email ?? "",
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actionsPadding: EdgeInsets.only(right: 12),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(LucideIcons.logOut, color: Color(0xFFA9AFB9)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFC632),
        onPressed: () => openTraceModal(context),
        child: Icon(LucideIcons.plus, size: 20.0, color: Color(0xFF473404)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Column(spacing: 12, children: [LockItem(), LockItem()]),
      ),
    );
  }
}
