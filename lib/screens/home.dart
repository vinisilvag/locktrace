import 'package:flutter/material.dart';
import 'package:locktrace/models/trace.dart';
import 'package:locktrace/services/auth_service.dart';
import 'package:locktrace/services/trace_service.dart';
import 'package:locktrace/widgets/avatar.dart';
import 'package:locktrace/widgets/delete_trace_dialog.dart';
import 'package:locktrace/widgets/trace_item.dart';
import 'package:locktrace/widgets/trace_bottom_sheet.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authService = AuthService();
  final traceService = TraceService();

  void openTraceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Color(0xFF191816),
      builder: (_) => const TraceBottomSheet(),
    );
  }

  Future<void> deleteTrace(String id) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => DeleteTraceDialog(id: id),
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
          child: Avatar(avatarSeed: authService.currentUser!.email ?? ""),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsPadding: EdgeInsets.only(right: 12),
        actions: [
          IconButton(
            onPressed: authService.signOut,
            icon: Icon(LucideIcons.logOut, color: Color(0xFFA9AFB9)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFC632),
        onPressed: () => openTraceModal(context),
        child: Icon(LucideIcons.plus, size: 20.0, color: Color(0xFF473404)),
      ),
      body: StreamBuilder<List<Trace>>(
        stream: traceService.watchTraces(authService.currentUser!.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: EdgeInsetsGeometry.only(bottom: 100),
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFC632)),
                ),
              ),
            );
          }

          final traces = snapshot.data!;

          if (traces.isEmpty) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: EdgeInsetsGeometry.only(bottom: 156),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      Icon(
                        LucideIcons.messageCircleX,
                        size: 32,
                        color: Color.fromARGB(255, 72, 75, 80),
                      ),
                      Text(
                        "Nenhum trace\nadicionado ainda :(",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromARGB(255, 72, 75, 80),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return ListView.separated(
            itemCount: traces.length,
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final trace = traces[index];
              return GestureDetector(
                onLongPress: () => {deleteTrace(trace.id)},
                child: TraceItem(trace: trace),
              );
            },
          );
        },
      ),
    );
  }
}
