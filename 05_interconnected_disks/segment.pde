class Segment {  // should not have a direction... maybe a Set?
    public Point a;
    public Point b;
    public color myColor;

    public Segment(Point a, Point b, color myColor) {
        this.a = a;
        this.b = b;
        this.myColor = myColor;
    }

    public Segment(Point a, Point b) {
        this(a, b, segmentColor);
    }

    public Segment(Disc a, Disc b) {
        this(a.center(), b.center());
    }

    public Segment(Disc a, Disc b, color myColor) {
        this(a.center(), b.center(), myColor);
    }

    public String toString() {
        return "Segment(" + this.a.toString() + "," + this.b.toString() + ")";
    }
}


color segmentColor = color(150, 150, 150, 50);