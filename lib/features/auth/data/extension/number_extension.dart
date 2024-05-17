




/// if int null, 0
extension NonNullInteger on int?{
  int orEmpty(){
    if(this == null){
      return 0;
    }else{
      return this!;
    }
  }
}


/// if double null, 0.
extension NonNullDouble on double?{
  double orEmpty(){
    if(this == null){
      return 0;
    }else{
      return this!;
    }
  }
}