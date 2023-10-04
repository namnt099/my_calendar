class CanChi {
  static String namCanChi(int namDuong) {
    final int modulo = namDuong % 60 - 1;
    final int canMo = (7 + modulo) % 10;
    final int chiMo = (9 + modulo) % 12;
    final String can = layCan(canMo);

    final String chi = layChi(chiMo);

    return '$can $chi';
  }

  static String layCan(int data) {
    switch (data) {
      case 0:
        return 'Giáp';
      case 1:
        return 'Ất';
      case 2:
        return 'Bính';
      case 3:
        return 'Đinh';
      case 4:
        return 'Mậu';
      case 5:
        return 'Kỷ';
      case 6:
        return 'Canh';
      case 7:
        return 'Tân';
      case 8:
        return 'Nhâm';
      case 9:
        return 'Quý';
      default:
        return '';
    }
  }

  static String layChi(int data) {
    switch (data) {
      case 0:
        return 'Tý';
      case 1:
        return 'Sửu';
      case 2:
        return 'Dần';
      case 3:
        return 'Mão';
      case 4:
        return 'Thìn';
      case 5:
        return 'Tỵ';
      case 6:
        return 'Ngọ';
      case 7:
        return 'Mùi';
      case 8:
        return 'Thân';
      case 9:
        return 'Dậu';
      case 10:
        return 'Tuất';
      case 11:
        return 'Hợi';
      default:
        return '';
    }
  }

  static String layChiThang(int data) {
    switch (data) {
      case 0:
        return 'Dần';
      case 1:
        return 'Mão';
      case 2:
        return 'Thìn';
      case 3:
        return 'Tỵ';
      case 4:
        return 'Ngọ';
      case 5:
        return 'Mùi';
      case 6:
        return 'Thân';
      case 7:
        return 'Dậu';
      case 8:
        return 'Tuất';
      case 9:
        return 'Hợi';
      case 10:
        return 'Tý';
      case 11:
        return 'Sửu';
      default:
        return '';
    }
  }

  static int jdFromDate(dd, mm, yy) {
    final a = (14 - mm) ~/ 12;
    final y = yy + 4800 - a;
    final m = mm + 12 * a - 3;
    var jd = dd +
        (153 * m + 2) ~/ 5 +
        365 * y +
        y ~/ 4 -
        y ~/ 100 +
        y ~/ 400 -
        32045;
    if (jd < 2299161) {
      jd = dd + (153 * m + 2) ~/ 5 + 365 * y + y ~/ 4 - 32083;
    }
    return jd;
  }

  static String canChiNgay(int dd, int mm, int yyyy) {
    int jd = jdFromDate(dd, mm, yyyy);
    int canNgay = (jd + 9) % 10;
    int chiNgay = (jd + 1) % 12;
    String can = layCan(canNgay);
    String chi = layChi(chiNgay);
    return '$can $chi';
  }

  static String canChiGio(int hour, int dd, int mm, int yyyy) {
    int jd = jdFromDate(dd, mm, yyyy);
    int canNgay = (jd + 9) % 10;
    int chiNgay = (jd + 1) % 12;
    int chiGio = (hour + 1) ~/ 2;
    String can =
        layCan(layCanGioTi(canNgay) + chiGio >= 12 ? chiGio % 12 : chiGio);

    String chi = layChi(chiGio >= 12 ? chiGio % 12 : chiGio);
    return '$can $chi';
  }

  static String layCanChiThang(int thang, int nam) {
    final int modulo = nam % 60 - 1;
    final int canMo = (7 + modulo) % 10;
    final int canThangGieng = layCanThangGieng(canMo);
    final String can = layCan(thang - 1 + canThangGieng);
    final String chi = layChiThang(thang - 1);
    return '$can $chi';
  }

  static int layCanThangGieng(int data) {
    if (data == 0 || data == 5) {
      return 2;
    } else if (data == 2 || data == 6) {
      return 4;
    } else if (data == 3 || data == 7) {
      return 6;
    } else if (data == 4 || data == 8) {
      return 8;
    } else if (data == 5 || data == 9) {
      return 0;
    }
    return -1;
  }

  static int layCanGioTi(int data) {
    if (data == 0 || data == 5) {
      return 0;
    } else if (data == 2 || data == 6) {
      return 2;
    } else if (data == 3 || data == 7) {
      return 4;
    } else if (data == 4 || data == 8) {
      return 6;
    } else if (data == 5 || data == 9) {
      return 8;
    }
    return -1;
  }
}
