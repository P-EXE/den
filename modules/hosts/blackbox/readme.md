# Raid volume

To start the raid1 volume pool on /mnt/storage you have to run:
```
sudo vgchange -ay pool && mount /dev/pool/lvraid1 /mnt/storage/
```
to mount the volume.