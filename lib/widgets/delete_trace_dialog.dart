import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locktrace/services/trace_service.dart';

import 'package:locktrace/widgets/forms/snackbar.dart';

class DeleteTraceDialog extends StatefulWidget {
  final String id;

  const DeleteTraceDialog({super.key, required this.id});

  @override
  State<DeleteTraceDialog> createState() => _DeleteTraceDialogState();
}

class _DeleteTraceDialogState extends State<DeleteTraceDialog> {
  bool isLoading = false;
  final traceService = TraceService();

  Future<void> deleteTrace() async {
    setState(() => isLoading = true);

    try {
      await traceService.deleteTrace(widget.id);
      showSuccessSnackBar(context, "Trace deletado com sucesso.");
      Navigator.pop(context);
    } on FirebaseException catch (err) {
      showErrorSnackBar(context, err.message ?? "");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF191816),
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      content: SizedBox(
        width: 340,
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              Text(
                "Deseja mesmo\ndeletar esse trace?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFFFFC632),
                ),
              ),

              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => {Navigator.pop(context)},
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      child: Text(
                        "Manter",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA9AFB9),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : deleteTrace,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Color(0xffcf6679),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      child: Center(
                        child: isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Color(0xFF473404),
                                ),
                              )
                            : Text(
                                "Deletar",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF473404),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
