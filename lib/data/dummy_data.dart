import 'package:portfolio/models/client.dart';
import 'package:portfolio/models/desktop_icons.dart';

List<DesktopIcon> iconsDeskData = [
  DesktopIcon(FileType.PDF, 'assets/icons/cv.png', 'Curriculum'),
  DesktopIcon(FileType.ACCORDION, 'assets/icons/dropdown-arrow.png', 'Accordion List'),
  DesktopIcon(FileType.REPORT, 'assets/icons/report.png', 'Report'),
  DesktopIcon(FileType.TABLE, 'assets/icons/table.png', 'Table'),
  DesktopIcon(FileType.IMAGE, 'assets/icons/image.png', 'Image'),
  DesktopIcon(FileType.ENCRYPT, 'assets/icons/encryption.png', 'Encryption'),
  DesktopIcon(FileType.GITHUB, 'assets/icons/link.png', 'My GitHub Profile '),
];

final List<ClientForPanel> clientsData = [
  ClientForPanel(false, 'Juan', 'Perez', 'juan@email.com', '123456789', DateTime.parse('2000-12-12')),
  ClientForPanel(false, 'Pedro', 'Perez', 'pedro@email.com', '123456789', DateTime.parse('2000-12-12')),
  ClientForPanel(false, 'Maria', 'Perez', 'maria@email.com', '0912345678', DateTime.parse('2000-12-12')),
  ClientForPanel(false, 'Marcelo', 'Martinez', 'marcuelo@email.com', '0912345679', DateTime.parse('2000-12-12')),
];
