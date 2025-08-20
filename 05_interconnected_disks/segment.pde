class Segment {  // should not have a direction... maybe a Set?
    public PVector a;
    public PVector b;
    public color myColor;

    public Segment(PVector a, PVector b, color myColor) {
        this.a = a;
        this.b = b;
        this.myColor = myColor;
    }

    public Segment(PVector a, PVector b) {
        this(a, b, segmentColor);
    }

    public Segment(Disc d1, Disc d2) {
        this(d1.center(), d2.center());
    }

    public Segment(Disc d1, Disc d2, color myColor) {
        this(d1.center(), d2.center(), myColor);
    }

    public void draw() {
        stroke(this.myColor);
        line(this.a.x, this.a.y, this.b.x, this.b.y);
    }

    public String toString() {
        return "Segment(" + this.a.toString() + "," + this.b.toString() + ")";
    }
}
