# Translated by iptables-restore-translate v1.8.4 on Wed Dec 27 16:46:32 2023
add table ip filter
add chain ip filter INPUT { type filter hook input priority 0; policy accept; }
add chain ip filter FORWARD { type filter hook forward priority 0; policy accept; }
add chain ip filter OUTPUT { type filter hook output priority 0; policy accept; }
add rule ip filter INPUT ct state related,established  counter accept
add rule ip filter FORWARD ct state related,established  counter accept
add rule ip filter FORWARD iifname "br0" oifname "eth0" counter drop
add table ip nat
add chain ip nat PREROUTING { type nat hook prerouting priority -100; policy accept; }
add chain ip nat INPUT { type nat hook input priority 100; policy accept; }
add chain ip nat POSTROUTING { type nat hook postrouting priority 100; policy accept; }
add chain ip nat OUTPUT { type nat hook output priority -100; policy accept; }
add rule ip nat POSTROUTING oifname "br0" counter masquerade
add table ip mangle
add chain ip mangle PREROUTING { type filter hook prerouting priority -150; policy accept; }
add chain ip mangle INPUT { type filter hook input priority -150; policy accept; }
add chain ip mangle FORWARD { type filter hook forward priority -150; policy accept; }
add chain ip mangle OUTPUT { type route hook output priority -150; policy accept; }
add chain ip mangle POSTROUTING { type filter hook postrouting priority -150; policy accept; }
add table ip raw
add chain ip raw PREROUTING { type filter hook prerouting priority -300; policy accept; }
add chain ip raw OUTPUT { type filter hook output priority -300; policy accept; }
# Completed on Wed Dec 27 16:46:32 2023
