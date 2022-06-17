class PersonUser {

  String id;
  String? name;
  String? photo="";
  String? pubKey="";
  bool enabled=true;
  DateTime created = DateTime.now().toUtc();
  DateTime updated = DateTime(1900).toUtc();
  

  PersonUser({
    required this.id, this.photo="", this.name="", this.pubKey="", this.enabled=true});

}
