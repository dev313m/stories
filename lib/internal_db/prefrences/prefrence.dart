/**
 * This class is a model for the type Prefrence
 */

class Prefrence {
  String _geder;
  String _certificate;
  String _region;
  int _id;

  int get id => _id;
  String get gender => _geder;
  String get certificate => _certificate;
  String get region => _region;

  Prefrence.empty(); 

  Prefrence(this._id, this._certificate, this._geder, this._region);
  /**
   * Constructur that is build upon Map<String, dynamic>()
   */
  Prefrence.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _geder = map['gender'];
    _certificate = map['certificate'];
    _region = map['region'];
  }

  /**
   * Setters 
   */
  set gender(String newGender) {
    this._geder = newGender;
  }

  set certificate(String newCert) {
    this._certificate = newCert;
  }

  set region(String newRegion) {
    this._region = newRegion;
  }

  setId(int newId) {
    this._id = newId;
  }
   setgender(String newGender) {
    this._geder = newGender;
  }

  setcertificate(String newCert) {
    this._certificate = newCert;
  }

  setregion(String newRegion) {
    this._region = newRegion;
  }

/**
 * 
 * method converter to get mapped value
 */
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['gender'] = _geder;
    map['certificate'] = _certificate;
    map['region'] = _region;
    return map; 
  }
}
