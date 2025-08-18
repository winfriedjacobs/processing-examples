import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.SortedMap;
import java.util.TreeMap;



// globals

SortedMap<String, Disc> discs = new TreeMap<String, Disc>();
List<Segment> segments = new ArrayList<Segment>();


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
    segments.clear();
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
    if(distance < radiusSum) {
        Segment segment = new Segment(disc1, disc2);
        // println(segment.toString() + " | distance: " + distance + " | radiusSum: " + radiusSum);
        segments.add(segment);
    }
}


void drawSegments() {
    stroke(segmentColor);
    for(Segment segment: segments) {
        line(segment.a.x, segment.a.y, segment.b.x, segment.b.y);
    }
}
