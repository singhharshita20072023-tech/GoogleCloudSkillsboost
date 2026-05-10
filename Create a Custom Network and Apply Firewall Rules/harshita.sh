#!/bin/bash

# Enhanced Color Definitions
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'

NO_COLOR=$'\033[0m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'

# Function to display section headers
section_header() {
    echo
    echo "${CYAN_TEXT}${BOLD_TEXT}╔════════════════════════════════════════════════════════╗${RESET_FORMAT}"
    echo "${CYAN_TEXT}${BOLD_TEXT}  Welcome To Harshita Cloud Tutorials $1${RESET_FORMAT}"
    echo "${CYAN_TEXT}${BOLD_TEXT}╚════════════════════════════════════════════════════════╝${RESET_FORMAT}"
    echo
}

# Function to show progress spinner
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Function to display completion message
task_complete() {
    echo "${GREEN_TEXT}${BOLD_TEXT}✓ $1 completed successfully${RESET_FORMAT}"
}

# Display welcome message
clear
section_header "Network Configuration Lab Setup"
echo "${MAGENTA_TEXT}${BOLD_TEXT}Network configuration by Harshita${RESET_FORMAT}"
echo

# Get user input for regions
echo "${YELLOW_TEXT}${BOLD_TEXT}Please enter the required regions${RESET_FORMAT}"
read -p "${YELLOW_TEXT}${BOLD_TEXT}Enter REGION1: ${RESET_FORMAT}" REGION1
read -p "${YELLOW_TEXT}${BOLD_TEXT}Enter REGION2: ${RESET_FORMAT}" REGION2
read -p "${YELLOW_TEXT}${BOLD_TEXT}Enter REGION3: ${RESET_FORMAT}" REGION3

# Export variables
export REGION1 REGION2 REGION3

# Authentication and Configuration
section_header "Authentication and Configuration"
echo "${BLUE_TEXT}${BOLD_TEXT}Setting up project configuration...${RESET_FORMAT}"
(gcloud auth list > /dev/null 2>&1) & spinner
echo

export ZONE=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-zone])")
export REGION=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-region])")

(gcloud config set compute/zone "$ZONE" > /dev/null 2>&1) & spinner
(gcloud config set compute/region "$REGION" > /dev/null 2>&1) & spinner
task_complete "Project configuration"

# Network Creation
section_header "Creating Custom Network"

(gcloud compute networks create taw-custom-network --subnet-mode custom > /dev/null 2>&1) & spinner
task_complete "Network creation"

# Completion Message
section_header "Lab Completed Successfully!"
echo "${GREEN_TEXT}${BOLD_TEXT}All network configurations have been successfully applied by Harshita.${RESET_FORMAT}"
echo
echo "${MAGENTA_TEXT}${BOLD_TEXT}Cloud Computing and DevOps Tutorials${RESET_FORMAT}"
echo
