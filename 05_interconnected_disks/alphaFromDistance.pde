
int alphaFromDistance(float distance, float maxDistance) {
    // if distance is 0 -> alpha is 0
    // if distance is maxDistance  -> alpha is MAX_ALPHA
    return (int) (distance * MAX_ALPHA / maxDistance);
}