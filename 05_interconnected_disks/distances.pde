import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.SortedMap;
// import java.util.TreeMap;
import java.util.concurrent.ConcurrentSkipListMap;
import java.util.Collections;
import java.util.stream.Collectors;



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

    if(distance < radiusSum) {
        float threshold = 25; // constant
        float diff = radiusSum - distance;
        int alpha = diff < threshold
            ? alphaFromDistance(diff, threshold) // nur noch geringe Überlappung -> reduce opacity
            : -1;

        // if alpha is greater than the alphas of the discs, take the mininum value:

        alpha = minOfThreeAlphas(alpha, disc1.step.alpha, disc2.step.alpha);

        color theColor = (alpha >= 0)
            ? color(segmentColor, alpha)
            : segmentColor; // leave segmentColor unchanged when alpha == MAX_ALPHA

        Segment segment = new Segment(disc1, disc2, theColor);

        // println(segment.toString() + " | distance: " + distance + " | radiusSum: " + radiusSum);
        segments.add(segment);
    }
}


void drawSegments() {
    strokeWeight(2);
    for(Segment segment: segments) {
        segment.draw();
    }
}

int minOfThreeAlphas(int alpha1, int alpha2, int alpha3) {

    println("alphas " + alpha1 + " | " + alpha2 + " | " + alpha3);

    List<Integer> onlyPositiveAlphas = List.of(alpha1, alpha2, alpha3)
                          .stream()
                          .filter(n -> n >= 0)
                          .collect(Collectors.toList());

    int minAlpha = onlyPositiveAlphas.isEmpty()
                    ? -1
                    : Collections.min(onlyPositiveAlphas);

    println("minAlpha " + minAlpha);

    return minAlpha;
}
