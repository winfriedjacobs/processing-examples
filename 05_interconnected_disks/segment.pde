class Segment {  // should not have a direction... maybe a Set?
    public Point a;
    public Point b;

    public Segment(Point a, Point b) {
        this.a = this.b;
    }

    public Segment(Disc a, Disc b) {
        this.a = a.center();
        this.b = b.center();
    }

    public String toString() {
        return "Segment(" + this.a.toString() + "," + this.b.toString() + ")";
    }
}


color segmentColor = color(150, 150, 150);