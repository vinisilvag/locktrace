import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locktrace/services/auth_service.dart';
import 'package:locktrace/services/trace_service.dart';
import 'package:locktrace/widgets/forms/button.dart';
import 'package:locktrace/widgets/forms/checkbox.dart';
import 'package:locktrace/widgets/forms/snackbar.dart';

class TraceBottomSheet extends StatefulWidget {
  const TraceBottomSheet({super.key});

  @override
  State<TraceBottomSheet> createState() => TraceBottomSheetState();
}

class TraceBottomSheetState extends State<TraceBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  bool roomWindow = false;
  bool roomOutlet = false;
  bool kitchenOutlet = false;
  bool burner = false;
  bool clothesIron = false;
  bool isLoading = false;

  final authService = AuthService();
  final traceService = TraceService();

  Future<void> createTrace() async {
    setState(() => isLoading = true);

    try {
      await traceService.createTrace(
        userUid: authService.currentUser!.uid,
        roomWindow: roomWindow,
        roomOutlet: roomOutlet,
        kitchenOutlet: kitchenOutlet,
        burner: burner,
        clothesIron: clothesIron,
      );
      showSuccessSnackBar(context, "Trace criado com sucesso.");
      Navigator.pop(context);
    } on FirebaseException catch (err) {
      Navigator.pop(context);
      showErrorSnackBar(context, err.message ?? "");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 38),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              "O que você já conferiu?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFFFFC632),
              ),
            ),

            Form(
              key: _formKey,
              child: Column(
                spacing: 4,
                children: [
                  CustomCheckboxListTile(
                    content: "Janela do quarto",
                    checkBoxValue: roomWindow,
                    onChanged: (value) {
                      setState(() {
                        roomWindow = value!;
                      });
                    },
                  ),
                  CustomCheckboxListTile(
                    content: "Tomada do quarto",
                    checkBoxValue: roomOutlet,
                    onChanged: (value) {
                      setState(() {
                        roomOutlet = value!;
                      });
                    },
                  ),
                  CustomCheckboxListTile(
                    content: "Tomadas da cozinha",
                    checkBoxValue: kitchenOutlet,
                    onChanged: (value) {
                      setState(() {
                        kitchenOutlet = value!;
                      });
                    },
                  ),
                  CustomCheckboxListTile(
                    content: "Boca do fogão",
                    checkBoxValue: burner,
                    onChanged: (value) {
                      setState(() {
                        burner = value!;
                      });
                    },
                  ),
                  CustomCheckboxListTile(
                    content: "Ferro de passar roupa",
                    checkBoxValue: clothesIron,
                    onChanged: (value) {
                      setState(() {
                        clothesIron = value!;
                      });
                    },
                  ),
                  CustomButton(
                    buttonText: "Trancar",
                    onPressed: createTrace,
                    isLoading: isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
