class Dataprofinsi {
  String? prds;

  Dataprofinsi({
    this.prds,
  });

  factory Dataprofinsi.fromJson(Map<String, dynamic> json) {
    return Dataprofinsi(
      prds: json['prds'],
    );
  }
}

class Datakota {
  String? ktds;

  Datakota({
    this.ktds,
  });

  factory Datakota.fromJson(Map<String, dynamic> json) {
    return Datakota(
      ktds: json['ktds'],
    );
  }
}

class Datakecamatan {
  String? kcds;

  Datakecamatan({
    this.kcds,
  });

  factory Datakecamatan.fromJson(Map<String, dynamic> json) {
    return Datakecamatan(
      kcds: json['kcds'],
    );
  }
}

class Datakelurahan {
  String? klds;

  Datakelurahan({
    this.klds,
  });

  factory Datakelurahan.fromJson(Map<String, dynamic> json) {
    return Datakelurahan(
      klds: json['klds'],
    );
  }
}

class Datadaerahpemilihan {
  String? dpldpl;
  String? dpldpt;
  String? dpltps;
  String? totl;
  String? totp;
  String? totd;


  Datadaerahpemilihan({
    this.dpldpl,
    this.dpldpt,
    this.dpltps,
    this.totl,
    this.totp,
    this.totd,
  });

  factory Datadaerahpemilihan.fromJson(Map<String, dynamic> json) {
    return Datadaerahpemilihan(
      dpldpl: json['dpldpl'],
      dpldpt: json['dpldpt'],
      dpltps: json['dpltps'],
      totl: json['totl'],
      totp: json['totp'],
      totd: json['totd'],
    );
  }
}

class Datasaksi {
  String? srahp;
  String? sradpl;
  String? sradpt;
  String? srasah;
  String? srasrc;
  String? nmsra;
  String? sratps;
  String? sravld;
  String? sravlnm;

  Datasaksi({
    this.srahp,
    this.sradpl,
    this.sradpt,
    this.srasah,
    this.srasrc,
    this.nmsra,
    this.sratps,
    this.sravld,
    this.sravlnm,
  });

  factory Datasaksi.fromJson(Map<String, dynamic> json) {
    return Datasaksi(
      srahp: json['srahp'],
      sradpl: json['sradpl'],
      sradpt: json['sradpt'],
      srasah: json['srasah'],
      srasrc: json['srasrc'],
      nmsra: json['nmsra'],
      sratps: json['sratps'],
      sravld: json['sravld'],
      sravlnm: json['sravlnm'],
    );
  }
}


class Datapendukung {
  String? usrema;
  String? usrnm;
  String? usrft;
  String? usrhp;
  String? usrdpl;
  String? umr;


  Datapendukung({
    this.usrema,
    this.usrnm,
    this.usrft,
    this.usrhp,
    this.usrdpl,
    this.umr,

  });

  factory Datapendukung.fromJson(Map<String, dynamic> json) {
    return Datapendukung(
      usrema: json['usrema'],
      usrnm: json['usrnm'],
      usrft: json['usrft'],
      usrhp: json['usrhp'],
      usrdpl: json['usrdpl'],
      umr: json['umr'],

    );
  }
}

class Datapendukungpendukung {
  String? usrema;
  String? usrnm;
  String? usrft;
  String? usrhp;
  String? usrdpl;
  String? umr;


  Datapendukungpendukung({
    this.usrema,
    this.usrnm,
    this.usrft,
    this.usrhp,
    this.usrdpl,
    this.umr,

  });

  factory Datapendukungpendukung.fromJson(Map<String, dynamic> json) {
    return Datapendukungpendukung(
      usrema: json['usrema'],
      usrnm: json['usrnm'],
      usrft: json['usrft'],
      usrhp: json['usrhp'],
      usrdpl: json['usrdpl'],
      umr: json['umr'],

    );
  }
}

class Datarelawan {
  String? usrema;
  String? usrnm;
  String? usrft;
  String? usrhp;
  String? usrdpl;
  String? umr;
  String? usrsta;
  String? usrhpr;

  Datarelawan({
    this.usrema,
    this.usrnm,
    this.usrft,
    this.usrhp,
    this.usrdpl,
    this.umr,
    this.usrsta,
    this.usrhpr,
  });

  factory Datarelawan.fromJson(Map<String, dynamic> json) {
    return Datarelawan(
      usrema: json['usrema'],
      usrnm: json['usrnm'],
      usrft: json['usrft'],
      usrhp: json['usrhp'],
      usrdpl: json['usrdpl'],
      umr: json['umr'],
      usrsta: json['usrsta'],
      usrhpr: json['usrhpr'],
    );
  }
}

class GetPemenagan {
  String idc;
  String catlist;
  String title;
  String pic;

  GetPemenagan({
    required this.idc,
    required this.catlist,
    required this.title,
    required this.pic,
  });

  factory GetPemenagan.fromJson(Map<String, dynamic> json) {
    return GetPemenagan(
        idc: json['idc'],
        catlist: json['catlist'],
        title: json['title'],
        pic: json['pic']);
  }
}

class GetPemenaganList {
  String idk;
  String catlist;
  String keterangan;

  String title;
  String pic;

  GetPemenaganList({
    required this.idk,
    required this.catlist,
    required this.keterangan,
    required this.title,
    required this.pic,
  });

  factory GetPemenaganList.fromJson(Map<String, dynamic> json) {
    return GetPemenaganList(
      idk: json['idk'],
      title: json['title'],
      keterangan: json['ket'],
      pic: json['pic'],
      catlist: json['catlist'],
    );
  }
}

class GetPendukung {
  String idc;
  String catlist;
  String title;
  String pic;

  GetPendukung({
    required this.idc,
    required this.catlist,
    required this.title,
    required this.pic,
  });

  factory GetPendukung.fromJson(Map<String, dynamic> json) {
    return GetPendukung(
        idc: json['idc'],
        catlist: json['catlist'],
        title: json['title'],
        pic: json['pic']);
  }
}

class Databerita {
  String brtkc;
  String brthp;
  String brtdp;
  String brttp;
  String brtjdl;
  String brtft;
  String brtbrt;
  String idb;
  String brtnm;

  Databerita({
    required this.brtkc,
    required this.brthp,
    required this.brtdp,
    required this.brttp,
    required this.brtjdl,
    required this.brtft,
    required this.brtbrt,
    required this.idb,
    required this.brtnm,

  });

  factory Databerita.fromJson(Map<String, dynamic> json) {
    return Databerita(
        brtkc: json['brtkc'],
        brthp: json['brthp'],
        brtdp: json['brtdp'],
        brttp: json['brttp'],
        brtjdl: json['brtjdl'],
        brtft: json['brtft'],
        brtbrt: json['brtbrt'],
        idb: json['idb'],
        brtnm: json['brtnm']);

  }
}

class Databeritaagenda {
  String brtkc;
  String brthp;
  String brtdp;
  String brttp;
  String brtjdl;
  String brtft;
  String brtbrt;
  String idb;
  String brtnm;
  String tmagd;
  String dtagd;

  Databeritaagenda({
    required this.brtkc,
    required this.brthp,
    required this.brtdp,
    required this.brttp,
    required this.brtjdl,
    required this.brtft,
    required this.brtbrt,
    required this.idb,
    required this.brtnm,
    required this.tmagd,
    required this.dtagd,
  });

  factory Databeritaagenda.fromJson(Map<String, dynamic> json) {
    return Databeritaagenda(
        brtkc: json['brtkc'],
        brthp: json['brthp'],
        brtdp: json['brtdp'],
        brttp: json['brttp'],
        brtjdl: json['brtjdl'],
        brtft: json['brtft'],
        brtbrt: json['brtbrt'],
        idb: json['idb'],
        brtnm: json['brtnm'],
        tmagd: json['tmagd'],
        dtagd: json['dtagd']);

  }
}
class Datanewdukungan {
  String? usrema;
  String? usrnm;
  String? usrft;
  String? usrhp;
  String? usrdpl;
  String? umr;


  Datanewdukungan({
    this.usrema,
    this.usrnm,
    this.usrft,
    this.usrhp,
    this.usrdpl,
    this.umr,

  });

  factory Datanewdukungan.fromJson(Map<String, dynamic> json) {
    return Datanewdukungan(
      usrema: json['usrema'],
      usrnm: json['usrnm'],
      usrft: json['usrft'],
      usrhp: json['usrhp'],
      usrdpl: json['usrdpl'],
      umr: json['umr'],

    );
  }
}



class Severity {
  int highseverity;
  int mediumseverity;
  int lowseverity;
  int warning;

  Severity({
    required this.highseverity,
    required this.mediumseverity,
    required this.lowseverity,
    required this.warning,
  });
}
