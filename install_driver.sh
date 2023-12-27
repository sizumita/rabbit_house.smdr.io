cd driver
rm -rf Star_CUPS_Driver-3.14.0_linux
sudo apt install gcc libcupsimage2-dev libcups2-dev -y
tar -xvf Star_CUPS_Driver-3.14.0_linux.tar
cd Star_CUPS_Driver-3.14.0_linux/SourceCode
tar -xzvf Star_CUPS_Driver-src-3.14.0.tar.gz
cd Star_CUPS_Driver
make
make install