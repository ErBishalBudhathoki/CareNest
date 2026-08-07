import 'package:flutter/foundation.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class InvoiceEmailService {
  final ApiMethod _apiMethod;

  InvoiceEmailService({required ApiMethod apiMethod}) : _apiMethod = apiMethod;

  Future<dynamic> sendInvoiceEmail(
    String pdfPath,
    List<String> invoiceName,
    String endDate,
    String invoiceNumber,
    String email,
    String genKey,
  ) async {
    final apiMethod = _apiMethod;
    final sendingEmailDetail = await apiMethod.getEmailDetailToSendEmail(email);

    final emailAddress = dotenv.isInitialized
        ? dotenv.env['EMAIL_ADDRESS']
        : null;
    final emailPassword = dotenv.isInitialized
        ? dotenv.env['EMAIL_PASSWORD']
        : null;
    if (emailAddress == null ||
        emailAddress.trim().isEmpty ||
        emailPassword == null ||
        emailPassword.trim().isEmpty) {
      debugPrint(
        'Missing EMAIL_ADDRESS or EMAIL_PASSWORD in environment config',
      );
      return 'Error';
    }

    final smtpServer = gmail(emailAddress, emailPassword);
    final message = Message()
      ..from = const Address('your_email@gmail.com', 'Your Name')
      ..recipients.add(email)
      ..subject = 'Invoice: $invoiceNumber'
      ..text = 'Please find the attached invoice.'
      ..attachments.add(FileAttachment(File(pdfPath)));

    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('Message sent: $sendReport');
      return 'Success';
    } on MailerException catch (e) {
      for (var p in e.problems) {
        debugPrint('Problem: ${p.code}: ${p.msg}');
      }
      return 'Error';
    }
  }
}
