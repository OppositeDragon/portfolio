enum FileType { FOLDER, IMAGE, VIDEO, MUSIC, PDF, HTML, TABLE, ACCORDION, REPORT, ENCRYPT }

class DesktopIcon {
  late FileType fileType;
  late String iconPath;
  late String name;
  DesktopIcon(this.fileType, this.iconPath, this.name);
}

