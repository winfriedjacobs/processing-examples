class Point {
    public float x;
    public float y;

    public Point(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public Point(Point other) {
        this(other.x, other.y);
    }

    public float distance(Point other) {
        float xDiff = this.x - other.x;
        float yDiff = this.y - other.y;
        return (float) Math.sqrt((xDiff * xDiff) + (yDiff * yDiff));
    }

    public void move(float xDiff, float yDiff) {
        this.x += xDiff;
        this.y += yDiff;
    }

    @Override
    public String toString() {
        return "Point(" + this.x + "," + this.y + ")";
    }
}
