class Point {  // is there a standard library that provides this class?
    public float x;
    public float y;

    public Point(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public String toString() {
        return "Point(" + this.x + "," + this.y + ")";
    }
}
