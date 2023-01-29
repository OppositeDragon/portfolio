import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/services/email_service.dart';

final cfcProvider = StateNotifierProvider<ContactFormController, ContactFormState>((ref) {
  const state = ContactFormState();

  return ContactFormController(ref, state);
});

class ContactFormController extends StateNotifier<ContactFormState> {
  ContactFormController(this._ref, super.state);
  final StateNotifierProviderRef<ContactFormController, ContactFormState> _ref;

  Future<void> sendEmail(Map<String, String> emailDetails) async {
    state = state.copyWith(isLoading: true);
    try {
      final bool sent = await _ref.read(emailProvider).sendEmail(emailDetails);
      if (sent) {
        state = state.copyWith(sent: 1);
      } else {
        state = state.copyWith(sent: 2);
      }
    } catch (e) {
      state = state.copyWith(sent: 2);
    } finally {
      state = state.copyWith(isLoading: false);
      Future.delayed(const Duration(seconds:2), () {
        print('callind delayed');
        state = const ContactFormState(sent: 0);
      });
    }
  }
}

@immutable
class ContactFormState {
  final bool isLoading;
  final int sent; //0: not sent, 1: sent, 2: error
  const ContactFormState({
    this.isLoading = false,
    this.sent = 0,
  });

  ContactFormState copyWith({
    bool? isLoading,
    int? sent,
  }) {
    return ContactFormState(
      isLoading: isLoading ?? this.isLoading,
      sent: sent ?? this.sent,
    );
  }
}
