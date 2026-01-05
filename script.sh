#!/bin/bash


# 1. Update the local package database

sudo apt update -y


# 2. Install the Docker engine via the official Ubuntu repositories (apt only)

# 'docker.io' is the standard Ubuntu-maintained package

sudo apt install -y docker.io



# 3. Ensure Docker starts automatically on boot

sudo systemctl enable --now docker



# 4. Give the 'ubuntu' user permission to run Docker without sudo

# This avoids "permission denied" errors when you log in later

sudo usermod -aG docker ubuntu
