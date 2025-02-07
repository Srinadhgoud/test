# Use a base image (e.g., Ubuntu)
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

# Update package list and install required dependencies
RUN apt-get update -y && \
    apt-get install -y \
    curl \
    git \
    vim \
    build-essential \
    python3 \
    python3-pip \
    python3-dev \
    wget \
    ca-certificates \
    unzip \
    && apt-get clean

# Switch to root user to ensure proper permissions for system-level commands
USER root

# Set the timezone by creating the symbolic link (with root privileges)
#RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Set working directory
WORKDIR /app

# Copy local files (including requirements.txt) to container
COPY . /app

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose a port for the container
EXPOSE 8080

# Set the default command
CMD ["python3", "app.py"]
