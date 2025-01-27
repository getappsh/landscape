# Step 1: Build the application
FROM node:18 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock for dependency installation
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code
COPY . .

# Build the project
RUN yarn build

# Step 2: Serve with NGINX
FROM nginx:alpine

# Copy the built files from the builder stage to the NGINX web root
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
