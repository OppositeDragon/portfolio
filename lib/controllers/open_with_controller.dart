import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/models/enums.dart';
final openWithProvider = Provider<OpenWithController>((ref) {
	return OpenWithController();
});
class OpenWithController {
  openWith(FileType fileType) {
    switch (fileType) {
      case FileType.PDF:
        print('Open with PDF');
        break;
      case FileType.ACCORDION:
        print('Open with ACCORDION');
        break;
      default:
        return Center(child: Text('There is no app to open this $fileType'));
    }
  }
}
