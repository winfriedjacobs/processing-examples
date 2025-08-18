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
    println("recursivelyCalculateDistances, size: " + currentDiscs.size());

    if (currentDiscs.size() < 2) {
        return;
    }

    String lastKey = currentDiscs.lastKey();
    Disc lastDisc = currentDiscs.get(lastKey);
    SortedMap<String, Disc> other = currentDiscs.headMap(lastKey);

    for (Disc otherDisc: other.values()) {
        handleDistance(lastDisc, otherDisc);
    }

    recursivelyCalculateDistances(other);
}


void calculateDistances() {
    distances.clear();
    recursivelyCalculateDistances(discs);
}


void handleDistance(Disc disc1, Disc disc2) {
    // they are always sorted descending by their name
}