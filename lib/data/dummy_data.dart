import 'package:portfolio/models/client.dart';
import 'package:portfolio/models/desktop_icons.dart';

List<DesktopIcon> iconsDeskData = [
  DesktopIcon(FileType.PDF, 'assets/icons/pdf-file.png', 'PDF'),
  DesktopIcon(FileType.ACCORDION, 'assets/icons/dropdown-arrow.png', 'Lista desplegable'),
  DesktopIcon(FileType.REPORT, 'assets/icons/report.png', 'Reporte'),
  DesktopIcon(FileType.TABLE, 'assets/icons/table.png', 'Tabla'),
  DesktopIcon(FileType.IMAGE, 'assets/icons/image.png', 'Imagen'),
  DesktopIcon(FileType.ENCRYPT, 'assets/icons/encryption.png', 'Encriptar'),
];

final List<ClientForPanel> clientsData = [
  ClientForPanel(false, 'Juan', 'Perez', 'juan@email.com', '123456789', DateTime.parse('2000-12-12')),
  ClientForPanel(false, 'Pedro', 'Perez', 'pedro@email.com', '123456789', DateTime.parse('2000-12-12')),
  ClientForPanel(false, 'Maria', 'Perez', 'maria@email.com', '0912345678', DateTime.parse('2000-12-12')),
  ClientForPanel(false, 'Marcelo', 'Martinez', 'marcuelo@email.com', '0912345679', DateTime.parse('2000-12-12')),
];
