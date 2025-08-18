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
    println("recursivelyCalculateDistances");

    if (currentDiscs.size() < 2) {
        println("size is <2");
        return;
    }

    String firstKey = currentDiscs.firstKey();
    Disc firstDisc = currentDiscs.get(firstKey);
    SortedMap<String, Disc> other = currentDiscs.tailMap(firstKey);

    for (Disc otherDisc: other.values()) {
        handleDistance(firstDisc, otherDisc);
    }

    //  recursivelyCalculateDistances(other);
}


void calculateDistances() {
    distances.clear();
    recursivelyCalculateDistances(discs);
}


void handleDistance(Disc disc1, Disc disc2) {
    // they are always sorted ascending by their name
}