wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
read -p "Paste authtoken here https://dashboard.ngrok.com/get-started/your-authtoken (Copy and Ctrl+V to paste then press Enter): " CRP
./ngrok authtoken $CRP
echo region us, eu, au, ap, sa, jp, in.
read -p "region: " region
nohup ./ngrok tcp -region $region 5900 &>/dev/null &
mkdir win11
cd win11
echo update
sudo apt update -y > /dev/null 2>&1
sudo apt-get install unrar
echo install qemu
sudo apt install qemu-system-x86 curl -y > /dev/null 2>&1
echo install mint iso
wget https://file.cnxiaobai.com/Windows/%E7%B3%BB%E7%BB%9F%E5%AE%89%E8%A3%85%E5%8C%85/AtlasOS/Atlas_1803_v0.2.iso
echo making disk
qemu-img create win11.vdi 100G
echo Your VNC IP Address:
curl --silent --show-error http://127.0.0.1:9090/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sudo qemu-system-x86_64 -cdrom Atlas_1803_v0.2.iso -vnc :0 -hda win11.vdi -smp cores=5 -m 10000M -machine usb=on -device usb-tablet > /dev/null 2>&1
