enum FileType { FOLDER, IMAGE, VIDEO, MUSIC, PDF, HTML, TABLE, ACCORDION, REPORT }

class DesktopIcon {
  late FileType fileType;
  late String iconPath;
  late String name;
  DesktopIcon(this.fileType, this.iconPath, this.name);
}

List<DesktopIcon> iconsDesk = [
  DesktopIcon(FileType.PDF, 'assets/icons/pdf-file.png', 'PDF'),
  DesktopIcon(FileType.ACCORDION, 'assets/icons/dropdown-arrow.png', 'Lista desplegable'),
  DesktopIcon(FileType.REPORT, 'assets/icons/report.png', 'Reporte'),
  DesktopIcon(FileType.TABLE, 'assets/icons/table.png', 'Tabla'),
  DesktopIcon(FileType.IMAGE, 'assets/icons/image.png', 'Imagen'),
];
