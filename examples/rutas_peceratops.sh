#!/bin/bash

sudo route add -net 10.0.0.0/8 gw 10.199.10.137
sudo route add -net 192.168.25.0/24 gw 192.168.25.252
sudo route delete -net 0.0.0.0/0 gw 10.199.10.137
