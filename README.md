# homework
Tool made for extracting specific info from pcap files.

1. gets all open, closed, and filtered TCP ports
2. counts all the total TCP packets
3. gets the source and destination from ICMP packets
4. counts the sum of all ICMP packets
5. checks which UDP ports are closed and counts them
6. counts the number of FTP packets
7. counts the number of HTTP packets, and
8. shows how many HTTP responses were given for each status code

Note: *This also works outside of the homework! You need only supply an IP wordlist, port wordlist, and parsed pcap file (using tshark)*

**How to install**
1. Install all deps
```
apt-get install tshark bash grep
```
 2. Clone the repo
```
git clone https://github.com/elogada/homework
cd homework
```
**Usage**
```
./project1.sh IPAddressWordlist.txt PortWordlist.txt tsharkOutput.txt
```
example for this homework:
```
./porject1.sh ips.txt ports.txt all_traffic.txt
```

**Note** If providing your own pcap file, make sure to provide a _tsharkOutput.txt_ file from your _pcap_ files by using
```
tshark -r capturefile.pcap > all_traffic.txt
```
