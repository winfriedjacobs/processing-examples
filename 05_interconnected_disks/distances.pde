import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.SortedMap;
import java.util.TreeMap;


// global values

class Point {  // is there a standard library that provides this class?
    public float x;
    public float y;
}


class Segment {  // should not have a direction... maybe a Set?
    public Point a;
    public Point b;
}

// globals

SortedMap<String, Disc> discs = new TreeMap<String, Disc>();
Map<String, Segment> distances = new HashMap<String, Segment>();


void recursivelyCalculateDistances(SortedMap<String, Disc> currentDiscs) {
    // println("recursivelyCalculateDistances, size: " + currentDiscs.size());

    if (currentDiscs.size() < 2) {
        return;
    }

    String lastKey = currentDiscs.lastKey();
    Disc lastDisc = currentDiscs.get(lastKey);
    SortedMap<String, Disc> other = currentDiscs.headMap(lastKey);

    for (Disc otherDisc: other.values()) {
        handleOverlapping(lastDisc, otherDisc);
    }

    recursivelyCalculateDistances(other);
}


void calculateDistances() {
    distances.clear();
    recursivelyCalculateDistances(discs);
}


void handleOverlapping(Disc disc1, Disc disc2) {
    // they are always sorted descending by their name
    // a) calculate distance and sum of radiusses
    float xDiff = disc1.xpos - disc2.xpos;
    float yDiff = disc1.ypos - disc2.ypos;

    float distance = (float)Math.sqrt((xDiff * xDiff) + (yDiff * yDiff));
    float radiusSum = disc1.rad + disc2.rad;

    // println("Discs: " + disc1.name + " | " + disc2.name);
    // println("distance: " + distance + " | radiusSum: " + radiusSum);


}
