#!/bin/bash
# ===================================================
#  Spring Boot + Nginx CI/CD Deployment Script (Jenkins)
# ===================================================

set -e  # Exit immediately if a command fails

# ==== CONFIG ====
PROJECT_DIR="/c/Users/shambhavi/Documents/demoapp"
JAR_NAME="demoapp-0.0.1-SNAPSHOT.jar"
EC2_USER="ubuntu"
EC2_HOST="13.232.27.188"
EC2_KEY="/c/Users/shambhavi/Documents/MyBackendinstancekey.pem"
REMOTE_DIR="/home/ubuntu/demoapp"

echo "==================================================="
echo " Deployment started at $(date)"
echo "==================================================="

# ---------------------------------------------------
# Step 1: Build the Spring Boot JAR
# ---------------------------------------------------
echo "=== Step 1: Building Spring Boot project locally ==="
cd "$PROJECT_DIR"
mvn clean package -DskipTests

if [ ! -f "$PROJECT_DIR/target/$JAR_NAME" ]; then
  echo "ERROR: Build failed or JAR not found!"
  exit 1
fi

# ---------------------------------------------------
# Step 2: Copy JAR to EC2
# ---------------------------------------------------
echo "=== Step 2: Copying JAR to EC2 ==="
scp -i "$EC2_KEY" -o StrictHostKeyChecking=no "$PROJECT_DIR/target/$JAR_NAME" "$EC2_USER@$EC2_HOST:$REMOTE_DIR/target/$JAR_NAME"

# ---------------------------------------------------
# Step 3: Deploy on EC2
# ---------------------------------------------------
echo "=== Step 3: Deploying and restarting services on EC2 ==="
ssh -i "$EC2_KEY" -o StrictHostKeyChecking=no "$EC2_USER@$EC2_HOST" << EOF
  set -e
  cd $REMOTE_DIR

  echo "Stopping Nginx..."
  sudo systemctl stop nginx || true

  echo "Stopping old Spring Boot app..."
  pkill -f $JAR_NAME || true
  sleep 5

  echo "Starting new Spring Boot app..."
  nohup java -jar target/$JAR_NAME > app.log 2>&1 &
  
  echo "Waiting for Spring Boot to start (checking port 8080)..."
  for i in {1..15}; do
    if nc -z localhost 8080; then
      echo "Spring Boot is up!"
      break
    fi
    echo "Waiting ($i/15)..."
    sleep 2
  done

  echo "Starting Nginx..."
  sudo systemctl start nginx
  sudo systemctl enable nginx

  echo "Deployment completed successfully on EC2 at $(date)"
EOF

# ---------------------------------------------------
# Step 4: Verify deployment
# ---------------------------------------------------
echo "=== Step 4: Verifying website response ==="
sleep 5
curl -I "http://$EC2_HOST" || echo "App may still be initializing..."

echo "==================================================="
echo " Deployment finished successfully!"
echo "Visit: http://$EC2_HOST"
echo "==================================================="
