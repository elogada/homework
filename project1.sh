#!/bin/bash
echo "[+] This is for my technical assessment. Usage: $0 IP_list port_list Parsed_pcap_file"
sleep 2
echo ""
echo "[+] Processing $3"
echo "[+] ##### TCP #####"
echo "[+] Process open TCP ports. Check if [SYN, ACK] response exists"
sleep 2
> total
cat $1 | while IFS= read -r line; do
echo "[+] IP address: $line"
	cat $2 | while IFS= read -r line2; do
			cat $3 | grep " $line → " | grep " $line2 → " | if grep -q -w "SYN, ACK"; then
				echo "Port $line2 open"
				echo 1 >> total
			fi
	done
done
echo "[+] Number of open ports: $(wc -l total)"
echo ""
echo ""

> total
echo "[+] Process closed TCP ports. Check if [RST, ACK] response exists"
sleep 2
cat $1 | while IFS= read -r line; do
echo "[+] IP address: $line"
        cat $2 | while IFS= read -r line2; do
                        cat $3 | grep " $line → " |grep " $line2  → " | if grep -q "RST, ACK";  then
                        echo "Port $line2 closed"
			echo 1 >> total
                        fi
        done
done
echo "[+] Number of closed ports: $(wc -l total)"
echo ""
echo ""
> total
echo "[+] Process filtered TCP responses. Should have SYN but not RST and [SYN, ACK]"
sleep 2
cat $1 | while IFS= read -r line; do
echo "[+] IP address: $line"
        cat $2 | while IFS= read -r line2; do
			cat $3 | grep " $line → " | grep  "→ $line2" | grep -v -w "RST, ACK" | grep -v -w "SYN, ACK" | if grep -q "SYN"; then
                        	echo "Port $line2 filtered"
                        	echo 1 >> total
                        fi
        done
done
echo "[+] Number of filtered ports: $(wc -l total)"
echo "[+] Count number of TCP connections made"
sleep 1
echo "[+] Number of TCP packets"
cat $3 | grep "TCP" | wc -l
echo ""
echo ""
echo "[+] ##### ICMP #####"
sleep 1
echo "[+] Process ICMP sources and destinations"
> total
sleep 2
cat $1 | while IFS= read -r line; do
                cat $3 | grep "$line → " | if grep -q "ICMP"; then
                        echo "$line is an ICMP source"
                        echo 1 >> total
                fi
done
sleep 2
cat $1 | while IFS= read -r line; do
                cat $3 | grep "→ $line" | if grep -q "ICMP"; then
                        echo "$line is an ICMP destination"
                        echo 1 >> total
                fi
done
echo 
cat $3 | grep "ICMP" | wc -l > total
echo "[+] Number of ICMP packets"
cat $3 | grep "ICMP" | wc -l
echo ""
echo ""
> total
echo "[+] ##### UDP #####"
echo "[+] Process UDP ports that seem to be closed. Should be unreachable."
sleep 2
cat $1 | while IFS= read -r line; do
echo "[+] IP address: $line"
        cat $2 | while IFS= read -r line2; do
		cat $3 | grep "→ $line" | grep  "→ $line2"| grep -v -w "SYN, ACK" | grep -v -w "RST, ACK" | grep -v "SYN" | if grep -q "UDP"; then
                        echo "Port $line2 is unreachable"
                        echo 1 >> total
		fi
        done
done
echo "[+] Number of closed UDP ports: $(wc -l total)"
echo ""
echo ""
sleep 1
echo "[+] #####  FTP #####"
echo "[+] Number of FTP packets"
cat $3 | grep "FTP" | wc -l
echo ""
echo ""
sleep 1
echo "[+] #####  HTTP #####"
echo "[+] Number of HTTP packets"
cat $3 | grep "HTTP" | wc -l
echo ""
echo "[+] Number of Status Code 200 responses"
cat $3 | grep -w "HTTP/1.1 200 OK" | wc -l
echo ""
echo "[+] Number of Status Code 30x responses"
cat $3 | grep -w "HTTP/1.1 20" | wc -l
echo ""
echo "[+] Number of Status Code 40x responses"
cat $3 | grep -w "HTTP/1.1 40" | wc -l
echo ""
echo "[+] Number of Status Code 50x responses"
cat $3 | grep -w "HTTP/1.1 50" | wc -l
echo ""
echo ""



