#!/bin/bash

echo "🔄 Cập nhật hệ thống..."
sudo apt update -y

echo "🐳 Cài đặt Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ubuntu

echo "📂 Tạo thư mục cho volume hiện tại: "
sudo mkdir -p /tools/rancher/data
sudo chown -R 1000:1000 /tools/rancher  # Gán quyền cho Rancher container
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

echo "📦 Kéo và chạy container Rancher với volume mount..."
sudo docker pull rancher/rancher:latest

sudo docker run -d --name rancher \
  --restart=always \
  -p 80:80 -p 443:443 \
  -v /tools/rancher/data:/var/lib/rancher \
  --privileged rancher/rancher:latest

echo "⏳ Đợi vài giây để Rancher khởi động..."
sleep 20

echo "✅ Kiểm tra trạng thái container Rancher..."
sudo docker ps -a | grep rancher

