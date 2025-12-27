
import 'package:flutter/foundation.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class InvoiceEmailService {
  Future<dynamic> sendInvoiceEmail(String pdfPath, List<String> invoiceName,
      String endDate, String invoiceNumber, String email, String genKey) async {
    ApiMethod apiMethod = ApiMethod();
    final sendingEmailDetail = await apiMethod.getEmailDetailToSendEmail(email);
    final smtpServer =
        gmail(dotenv.env['EMAIL_ADDRESS']!, dotenv.env['EMAIL_PASSWORD']!);
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
