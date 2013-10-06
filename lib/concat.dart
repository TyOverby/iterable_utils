part of iterable_utils;

class _ConcatenatedIterator extends Iterator {
  List<Iterator> _iterators;
  Object _cur = null;
  
  _ConcatenatedIterator(this._iterators);
    
  get current {
    return _cur;
  }
  
  bool moveNext() {
    if(_iterators.isEmpty) {
      return false;
    }
    
    var hasNext = _iterators[0].moveNext();
    if(hasNext) {
      _cur = _iterators[0].current;
      return true;
    } else {
      _iterators.removeAt(0);
      return moveNext();
    }
  }
  
}

class _ConcatenatedIterable extends Iterable with IterableMixin {
  List<Iterable> iterables;
  
  _ConcatenatedIterable(this.iterables);
  
  Iterator get iterator {
    return new _ConcatenatedIterator(this.iterables.map((a) => a.iterator).toList(growable: true));
  }
}

Iterable concat(List<Iterable> iters) {
  return new _ConcatenatedIterable(iters);
}