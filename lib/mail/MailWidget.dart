import 'package:flutter/material.dart';
import 'package:lcdf_idfm/text/MainTitle.dart';
import 'package:lcdf_idfm/text/DescriptionText.dart';
import 'package:url_launcher/url_launcher.dart';

class MailWidget extends StatefulWidget {
  const MailWidget({super.key});
  @override
  State<MailWidget> createState() => _MailWidgetState();
}

class _MailWidgetState extends State<MailWidget> {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  Future<void> envoyerMail(String message, String subject) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'adamtadrist1@gmail.com',
      query:
          'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(message)}',
    );
    if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
      throw Exception('Impossible d\'ouvrir l\'application de mail');
    }
  }

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [MainTitle(title: "Envoyer un mail à l'équipe du projet")],
        ),
        centerTitle: false,
        toolbarHeight: 110,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DescriptionText(
              text:
                  "Pour toute question, suggestion ou contribution, n'hésitez pas à nous écrire un mail :",
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(height: 20),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Sujet du message',
              ),
              readOnly: false,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Remplissez ce champ avec votre Message',
              ),
              readOnly: false,
              maxLines: 10,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await envoyerMail(
                  messageController.text,
                  subjectController.text,
                );
              },
              child: Text("Envoyer le mail"),
            ),
          ],
        ),
      ),
    );
  }
}
