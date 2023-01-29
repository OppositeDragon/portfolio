import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final emailProvider = Provider<EmailService>((ref) {
  return EmailService();
});
final sendEmailProvider = FutureProvider.family<bool, Map<String, String>>((ref, emailDetails) async {
  return ref.read(emailProvider).sendEmail(emailDetails);
});

class EmailService {
  Future<bool> sendEmail(Map<String, String> emailDetails) async {
    const service_id = String.fromEnvironment('service_id');
    const template_id = String.fromEnvironment('template_id');
    const user_id = String.fromEnvironment('user_id');
    if (service_id.isEmpty) {
      throw AssertionError('SENDGRID_API_KEY is not set');
    }
    final Uri url = Uri.https('api.emailjs.com', '/api/v1.0/email/send');
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final String body = jsonEncode(<String, dynamic>{
      'service_id': service_id,
      'template_id': template_id,
      'user_id': user_id,
      'template_params': emailDetails
    });
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );
      debugPrint(
          'sendEmail , statusCode: ${response.statusCode}, reasonPhrase: ${response.reasonPhrase}, response: ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
