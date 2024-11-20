## USAGE

* Copy gps.sh to your device
* Make it executable by running
  ```bash
  chmod +x gps.sh
  ```
* Test it by running
  ```bash
  ./gps.sh --url "http://192.168.0.250:1880/gps-data"
  ```
* Schedule it using crontab
  ```bash
  crontab -e
  ```
  ```bash
  # RUNS EVERY MINUTE
  * * * * * /root/gps.sh --url "http://192.168.0.250:1880/gps-data"
  ```
