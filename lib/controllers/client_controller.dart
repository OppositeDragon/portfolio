import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/data/dummy_data.dart';
import 'package:portfolio/models/client.dart';

final clientControllerProvider = StateNotifierProvider<ClientController, List<ClientForPanel>>((ref) {
  final List<ClientForPanel> state = clientsData;
  return ClientController(state);
});

class ClientController extends StateNotifier<List<ClientForPanel>> {
  ClientController(super.state);
  void switchExpanded(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) state[i].copyWith(isExpanded: !state[i].isExpanded) else state[i]
    ];
  }
}
