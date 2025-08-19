
int COUNT_DISKS = 15;


class DiscAdderThread extends Thread {
  SortedMap<String, Disc> discs;  // actually a ConcurrentSkipListMap -> allows concurrency / parallel execution

  DiscAdderThread(SortedMap<String, Disc> discs) {
    this.discs = discs;
  }

  public void run() {

    for(int i = 0; i < COUNT_DISKS && !isInterrupted(); i++) {
        String name = "disc_" + i;
        this.discs.put(
            name,
            new Disc(name)
        );

        try {
            Thread.sleep(1000); // Pause for 1 second
        } catch (InterruptedException e) {
            // If interrupted during sleep, restore the status and exit
            Thread.currentThread().interrupt();
        }
    }
  }
}