import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';

class PdfWidget extends ConsumerStatefulWidget {
  const PdfWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends ConsumerState<PdfWidget> {
  final pdfPinchController = PdfControllerPinch(
    document: PdfDocument.openAsset('assets/docs/od-cv.pdf'),
  );

  @override
  Widget build(BuildContext context) {
    return PdfViewPinch(
      controller: pdfPinchController,
    );
  }
}
