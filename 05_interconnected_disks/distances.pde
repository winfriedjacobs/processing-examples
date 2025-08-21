import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.SortedMap;
// import java.util.TreeMap;
import java.util.concurrent.ConcurrentSkipListMap;



void recursivelyCalculateDistances(SortedMap<String, Disc> currentDiscs) {
    if (currentDiscs.size() < 2) {
        return;
    }

    String lastKey = currentDiscs.lastKey();
    Disc lastDisc = currentDiscs.get(lastKey);

    if (lastDisc == null || lastDisc.step == null) {
        return;
    }

    SortedMap<String, Disc> other = currentDiscs.headMap(lastKey);

    for (Disc otherDisc: other.values()) {
        if (otherDisc != null && otherDisc.step != null) {
            handleOverlapping(lastDisc, otherDisc);
        }
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

    float distance = disc1.step.pos.dist(disc2.step.pos);
    float radiusSum = disc1.rad + disc2.rad;

    if(distance < radiusSum) {
        float threshold = 25; // constant
        float diff = radiusSum - distance;
        int alpha = diff < threshold
            ? alphaFromDistance(diff, threshold) // nur noch geringe Überlappung -> reduce opacity
            : MAX_ALPHA;

        // if alpha is greater than the alphas of the discs, take the mininum value:
        alpha = Math.min(alpha, Math.min(disc1.step.alpha, disc2.step.alpha));

        color theColor = (alpha == MAX_ALPHA)
            ? segmentColor // leave segmentColor unchanged when alpha == MAX_ALPHA
            : color(segmentColor, alpha);

        Segment segment = new Segment(disc1, disc2, theColor);
        segments.add(segment);
    }
}


void drawSegments() {
    strokeWeight(2);
    for(Segment segment: segments) {
        segment.draw();
    }
}
