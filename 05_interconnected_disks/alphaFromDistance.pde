
int alphaFromDistance(float distance, float maxDistance) {
    // if distance is 0 -> alpha is 0
    // if distance is maxDistance  -> alpha is 255
    return (int) (distance * 255 / maxDistance);
}