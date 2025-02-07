# Start from an official Ubuntu image
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

# Set working directory
WORKDIR /app

# Copy local files to container
COPY . /app

# Install Python packages
RUN pip3 install --no-cache-dir -r requirements.txt

# Install a specific version of Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Install specific NPM packages
RUN npm install -g typescript

# Expose a port for the container
EXPOSE 8080

# Set a default command
CMD ["python3", "app.py"]

# Set up environment variables for the app (if any)
ENV APP_ENV=production

# Create directories for logs and temp data
RUN mkdir -p /app/logs /app/data

# Run additional commands if needed
RUN echo "Installation complete."

# Clean up unnecessary files
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create a new user (optional)
RUN useradd -ms /bin/bash myuser

# Switch to the new user
USER myuser

# Set the user’s home directory as the working directory
WORKDIR /home/myuser

# Ensure that the entrypoint is correctly set
ENTRYPOINT ["python3", "/app/app.py"]

# Add a label for metadata (optional)
LABEL version="1.0" maintainer="youremail@example.com"

# Set the container’s timezone (optional)
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Clean up unnecessary files after install
RUN apt-get autoremove -y && apt-get clean

# Verify installation of node and python
RUN node --version && python3 --version

# Run final touch to make sure everything is in place
RUN echo "Dockerfile created and ready for testing"
