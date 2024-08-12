class SkincareRoutine {
  bool cleanser;
  bool toner;
  bool moisturizer;
  bool sunscreen;
  bool lipBalm;

  SkincareRoutine({
    this.cleanser = false,
    this.toner = false,
    this.moisturizer = false,
    this.sunscreen = false,
    this.lipBalm = false,
  });

  bool isComplete() {
    return cleanser && toner && moisturizer && sunscreen && lipBalm;
  }
}

