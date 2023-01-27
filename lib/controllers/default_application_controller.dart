import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/models/desktop_icons.dart';
import 'package:portfolio/widgets/apps/encryption.dart';
import 'package:portfolio/widgets/apps/expansion_panel_widget.dart';
import 'package:portfolio/widgets/apps/launch_link.dart';
import 'package:portfolio/widgets/apps/pdfx_widget.dart';
import 'package:portfolio/widgets/apps/reports.dart';

final defaultAppProvider = Provider((ref) => DefaultApplicactionController());

class DefaultApplicactionController {
  DefaultApplicactionController();
  Widget defaulApp(FileType filetype) {
    switch (filetype) {
      case FileType.PDF:
        return const PdfWidget();
      case FileType.ACCORDION:
        return const ExpansionPanelWidget();
      case FileType.REPORT:
        return const ReportsWidget();
      case FileType.ENCRYPT:
        return const EncrytionWidget();
      case FileType.GITHUB:
        return const LaunchLink();
      default:
        return Center(child: Text("No existe aplicacion prediefinida para: $filetype"));
    }
  }
}
