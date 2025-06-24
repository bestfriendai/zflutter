#!/bin/bash

# Setup Google Maps API for Shortzz Flutter App
# Usage: ./setup_google_maps.sh PROJECT_ID

PROJECT_ID=${1:-"shortzz-maps-$(date +%s)"}

echo "🚀 Setting up Google Maps API for project: $PROJECT_ID"

# Set project
gcloud config set project $PROJECT_ID

# Enable required APIs
echo "📡 Enabling APIs..."
gcloud services enable maps-android-backend.googleapis.com
gcloud services enable maps-ios-backend.googleapis.com  
gcloud services enable places-backend.googleapis.com
gcloud services enable geocoding-backend.googleapis.com

# Create API keys
echo "🔑 Creating API keys..."

# Android key
ANDROID_KEY_ID=$(gcloud alpha services api-keys create \
    --display-name="Shortzz Android Maps Key" \
    --api-target=service=maps-android-backend.googleapis.com \
    --api-target=service=places-backend.googleapis.com \
    --api-target=service=geocoding-backend.googleapis.com \
    --format="value(name)" | cut -d'/' -f6)

# iOS key  
IOS_KEY_ID=$(gcloud alpha services api-keys create \
    --display-name="Shortzz iOS Maps Key" \
    --api-target=service=maps-ios-backend.googleapis.com \
    --api-target=service=places-backend.googleapis.com \
    --api-target=service=geocoding-backend.googleapis.com \
    --format="value(name)" | cut -d'/' -f6)

# Get key strings
echo "📋 Getting API key values..."
ANDROID_API_KEY=$(gcloud alpha services api-keys get-key-string $ANDROID_KEY_ID --format="value(keyString)")
IOS_API_KEY=$(gcloud alpha services api-keys get-key-string $IOS_KEY_ID --format="value(keyString)")

echo "✅ Setup complete!"
echo ""
echo "📱 Android API Key: $ANDROID_API_KEY"
echo "🍎 iOS API Key: $IOS_API_KEY"
echo ""
echo "🔧 Next steps:"
echo "1. Update android/app/src/main/AndroidManifest.xml with Android key"
echo "2. Update ios/Runner/AppDelegate.swift with iOS key"
echo "3. Add app restrictions to the keys for security"

# Optional: Update files automatically
read -p "🤖 Auto-update config files? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Update Android manifest
    sed -i.bak "s/your_google_map_api/$ANDROID_API_KEY/g" android/app/src/main/AndroidManifest.xml
    
    # Update iOS AppDelegate
    sed -i.bak "s/AIzaSyClTyF5xRtil7Tgq_uPEAPIFg3EzLGKj7c/$IOS_API_KEY/g" ios/Runner/AppDelegate.swift
    
    echo "✅ Config files updated!"
fi
