# Start with a base image (use the latest Node.js image)
FROM node:16.13.2-alpine

# Set the working directory
WORKDIR /app

# Install a deprecated version of a package that causes an error
# Example: trying to install an outdated version of "express" that isn't compatible
#RUN npm install express@3.0.0

# Install the latest version of npm (just to simulate a full setup)
RUN npm install -g react-apexcharts@1.0.0

# Display Node.js version for testing
CMD ["node", "-v"]
