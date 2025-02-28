#!/bin/bash

echo "🔄 Cập nhật hệ thống..."
sudo apt-get update -y

echo "📌 Cài đặt gói cần thiết..."
sudo apt-get install -y gnupg curl

echo "🔑 Thêm khóa GPG của MongoDB 8.0..."
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor

echo "📦 Thêm repository MongoDB 8.0 vào danh sách APT..."
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

echo "🔄 Cập nhật lại danh sách package..."
sudo apt-get update -y

echo "📥 Cài đặt MongoDB 8.0..."
sudo apt-get install -y mongodb-org

echo "🚀 Khởi động MongoDB..."
sudo systemctl start mongod

echo "🔄 Reload lại daemon để đảm bảo hệ thống nhận dịch vụ MongoDB..."
sudo systemctl daemon-reload

echo "✅ Kiểm tra trạng thái MongoDB..."
sudo systemctl status mongod --no-pager

echo "📌 Kích hoạt MongoDB để khởi động cùng hệ thống..."
sudo systemctl enable mongod

echo "📌 Kiểm tra phiên bản MongoDB..."
mongod --version

echo "📂 Đảm bảo thư mục dữ liệu cho MongoDB..."
sudo mkdir -p /data/db
sudo chown -R mongodb:mongodb /data/db
sudo chmod -R 775 /data/db

echo "🔄 Khởi động lại MongoDB để áp dụng cài đặt..."
sudo systemctl restart mongod

echo "📌 Kiểm tra MongoDB có đang lắng nghe không..."
sudo netstat -tulnp | grep mongod || echo "⚠️ Chưa tìm thấy tiến trình mongod. Kiểm tra bằng: sudo systemctl status mongod"

echo "✅ Cài đặt MongoDB 8.0 hoàn tất!"
echo "📌 Để truy cập Mongo shell, chạy lệnh: mongosh"
