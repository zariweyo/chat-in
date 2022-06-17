extension StringExt on String {
  List<String> splitByLength(int splitLenght){
    List<String> res = [];
    int tot = 0;
    while(tot<=length){
      int nextTot = tot + splitLenght;
      if(nextTot>length){
        res.add(substring(tot));
      }else{
        res.add(substring(tot, nextTot));
      }
      tot +=splitLenght;
    }

    return res;
  }
}