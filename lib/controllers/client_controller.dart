import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/models/client.dart';

import '../data/dummy_data.dart';

final clientProvider = ChangeNotifierProvider(
  (ref) => ClientController(),
);

class ClientController with ChangeNotifier {
  final List<ClientForPanel> _clients = clientsData;

  void switchIsExpanded(index) {
    _clients[index].isExpanded = !_clients[index].isExpanded;
    notifyListeners();
  }

  List<ClientForPanel> get clients => _clients;
}
