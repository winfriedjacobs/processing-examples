
int COUNT_DISKS = 15;


class DiscAdderThread extends Thread {
  SortedMap<String, Disc> discs;  // actually a ConcurrentSkipListMap -> allows concurrency / parallel execution

  DiscAdderThread(SortedMap<String, Disc> discs) {
    this.discs = discs;
  }

  public void run() {
    // repeatedly tries to create up to COUNT_DISKS new discs
    for(int i = 0; !isInterrupted(); i = this.increment(i)) {
        if (this.discs.size() < COUNT_DISKS) {
            String name = "disc_" + i;
            this.discs.put(
                name,
                new Disc(name)
            );
        }

        try {
            Thread.sleep(1000); // Pause for 1 second
        } catch (InterruptedException e) {
            // If interrupted during sleep, restore the status and exit
            Thread.currentThread().interrupt();
        }
    }
  }

  int increment(int i) {
    // safety method: we loop forever but do not create more than e.g. 100 discs
    return i > 100 ? 0 : i + 1;
  }
}

