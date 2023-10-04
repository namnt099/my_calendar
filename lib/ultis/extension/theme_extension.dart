import 'package:my_calendar/config/app_config.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/ultis/constants/app_constant.dart';

extension AppBackgroundEx on AppBackground {
  String getText() {
    switch (this) {
      case AppBackground.XUAN:
        return S.current.xuan;
      case AppBackground.HA:
        return S.current.ha;
      case AppBackground.THU:
        return S.current.thu;
      case AppBackground.DONG:
        return S.current.dong_mua;
      case AppBackground.TET_NGUYEN_DAN:
        return S.current.tet_nguyen_dam;
      case AppBackground.LE_TINH_NHAN:
        return S.current.le_tinh_nhan;
      case AppBackground.NGAY_QUOC_TE_PHU_NU:
        return S.current.ngay_quoc_te_phu_nu;
      case AppBackground.GIO_TO_HUNG_VUONG:
        return S.current.gio_to_hung_vuong;
      case AppBackground.NGAY_QUOC_TE_LAO_DONG:
        return S.current.ngay_quoc_te_lao_dong;
      case AppBackground.NGAY_QUOC_TE_THIEU_NHI:
        return S.current.ngay_quoc_te_thieu_nhi;
      case AppBackground.NGAY_QUOC_KHANH:
        return S.current.ngay_quoc_khanh;
      case AppBackground.TET_TRUNG_THU:
        return S.current.tet_trung_thu;
      case AppBackground.NGAY_PHU_NU_VIET_NAM:
        return S.current.ngay_phu_nu_viet_nam;
      case AppBackground.NGAY_LE_GIANG_SINH:
        return S.current.ngay_le_giang_sinh;
      case AppBackground.NGAY_HALLOWEEN:
        return S.current.ngay_halloween;
      case AppBackground.NGAY_NHA_GIAO_VIET_NAM:
        return S.current.ngay_nha_giao_viet_nam;
    }
  }

  String getIcon() {
    switch (this) {
      case AppBackground.XUAN:
        return ImageAssets.icBackGroundXuan;
      case AppBackground.HA:
        return ImageAssets.icBackGroundHa;
      case AppBackground.THU:
        return ImageAssets.icBackGroundThu;
      case AppBackground.DONG:
        return ImageAssets.icBackGroundDong;
      case AppBackground.TET_NGUYEN_DAN:
        return ImageAssets.bgTetNguyenDan;
      case AppBackground.LE_TINH_NHAN:
        return ImageAssets.bgLeTinhNhan;
      case AppBackground.NGAY_QUOC_TE_PHU_NU:
        return ImageAssets.bgQuocTePhuNu;

      case AppBackground.GIO_TO_HUNG_VUONG:
        return ImageAssets.bgGioToHungVuong;

      case AppBackground.NGAY_QUOC_TE_LAO_DONG:
        return ImageAssets.bgQuocTeLaoDong;

      case AppBackground.NGAY_QUOC_TE_THIEU_NHI:
        return ImageAssets.bgQuocTeThieuNhi;

      case AppBackground.NGAY_QUOC_KHANH:
        return ImageAssets.bgQuocKhanh;

      case AppBackground.TET_TRUNG_THU:
        return ImageAssets.bgTetTrungThu;

      case AppBackground.NGAY_PHU_NU_VIET_NAM:
        return ImageAssets.bgPhuNuVietNam;

      case AppBackground.NGAY_LE_GIANG_SINH:
        return ImageAssets.bgLeGiangSinh;
      case AppBackground.NGAY_HALLOWEEN:
        return ImageAssets.bgHalloween;

      case AppBackground.NGAY_NHA_GIAO_VIET_NAM:
        return ImageAssets.bgNhaGiaoVietNam;
    }
  }
}

String appBarUrlIcon() {
  if (APP_BACKGROUND != null) {
    return _icBackgroundAppBar();
  }
  switch (APP_THEME) {
    case AppMode.MAC_DINH:
      return ImageAssets.appBarBackground;
    case AppMode.XANH:
      return ImageAssets.appBarBackgroundXanh;
    case AppMode.HONG:
      return ImageAssets.appBarBackgroundHong;
    case AppMode.VANG:
      return ImageAssets.appBarBackgroundVang;
  }
}

String _icBackgroundAppBar() {
  switch (APP_BACKGROUND) {
    case AppBackground.XUAN:
      return ImageAssets.appBarBackGroundMuaXuan;
    case AppBackground.HA:
      return ImageAssets.appBarBackGroundMuaHa;
    case AppBackground.THU:
      return ImageAssets.appBarBackGroundMuaThu;
    case AppBackground.DONG:
      return ImageAssets.appBarBackGroundMuaDong;
    case AppBackground.TET_NGUYEN_DAN:
      return ImageAssets.appBarBackGroundTetNguyenDan;
    case AppBackground.LE_TINH_NHAN:
      return ImageAssets.appBarBackGroundTinhNhan;
    case AppBackground.NGAY_QUOC_TE_PHU_NU:
      return ImageAssets.appBarBackGroundQuocTePhuNu;
    case AppBackground.GIO_TO_HUNG_VUONG:
      return ImageAssets.appBarBackGroundGioToHungVuong;
    case AppBackground.NGAY_QUOC_TE_LAO_DONG:
      return ImageAssets.appBarBackGroundQuocTeLaoDong;
    case AppBackground.NGAY_QUOC_TE_THIEU_NHI:
      return ImageAssets.appBarBackGroundQuocTeThieuNhi;
    case AppBackground.NGAY_QUOC_KHANH:
      return ImageAssets.appBarBackGroundQuocKhanh;
    case AppBackground.TET_TRUNG_THU:
      return ImageAssets.appBarBackGroundTrungThu;
    case AppBackground.NGAY_PHU_NU_VIET_NAM:
      return ImageAssets.appBarBackGroundPhuNuVietNam;
    case AppBackground.NGAY_LE_GIANG_SINH:
      return ImageAssets.appBarBackGroundGiangSinh;
    case AppBackground.NGAY_HALLOWEEN:
      return ImageAssets.appBarBackGroundHalloween;
    case AppBackground.NGAY_NHA_GIAO_VIET_NAM:
      return ImageAssets.appBarBackGroundNhaGiaoVietNam;
    default:
      {
        return '';
      }
  }
}
