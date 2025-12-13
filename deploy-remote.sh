cd /home/ubuntu/demoapp 
echo "=== Stopping Nginx ===" 
sudo systemctl stop nginx 
echo "=== Stopping old Spring Boot app ===" 
pkill -f demoapp-0.0.1-SNAPSHOT.jar || true 
echo "=== Starting new Spring Boot app ===" 
nohup java -jar target/demoapp-0.0.1-SNAPSHOT.jar  & 
echo "=== Starting Nginx ===" 
sudo systemctl start nginx 
echo "=== Deployment complete ===" 
