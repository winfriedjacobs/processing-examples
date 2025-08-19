
int COUNT_DISKS = 15;


class DiscAdderThread extends Thread {
  public void run() {

    for(int i = 0; i < COUNT_DISKS && !isInterrupted(); i++) {
        String name = "disc_" + i;
        discs.put(
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