# Step 1: Use Node.js image to build the Vite app
FROM node:16-alpine AS build

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Step 4: Copy all application files
COPY . .

# Step 5: Build the project using Vite
RUN npm run build

# Step 6: Use Nginx to serve the static files
FROM nginx:alpine

# Step 7: Copy the build output to Nginx's HTML folder
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 to serve the app
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
