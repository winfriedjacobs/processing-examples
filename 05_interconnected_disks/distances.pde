import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.SortedMap;
// import java.util.TreeMap;
import java.util.concurrent.ConcurrentSkipListMap;



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
    // println("handleOverlapping" + disc1.step.pos + " " + disc2.step.pos);

    // they are always sorted descending by their name
    // a) calculate distance and sum of radiusses
    float distance = disc1.step.pos.dist(disc2.step.pos);
    float radiusSum = disc1.rad + disc2.rad;

    // println("Discs: " + disc1.name + " | " + disc2.name);
    // println("distance: " + distance + " | radiusSum: " + radiusSum);
    if(distance < radiusSum) {
        float threshold = 25; // constant
        float diff = radiusSum - distance;
        int alpha = diff < threshold
            ? alphaFromDistance(diff, threshold) // nur noch geringe Überlappung -> reduce opacity, starting from 50
            : -1;

        color theColor = (alpha >= 0)
            ? color(segmentColor, alpha)
            : segmentColor; // uses segmentColor

        Segment segment = new Segment(disc1, disc2, theColor);

        // println(segment.toString() + " | distance: " + distance + " | radiusSum: " + radiusSum);
        segments.add(segment);
    }
}


void drawSegments() {
    strokeWeight(3);   // original: 0.5
    for(Segment segment: segments) {
        stroke(segment.myColor);
        line(segment.a.x, segment.a.y, segment.b.x, segment.b.y);
    }
}
