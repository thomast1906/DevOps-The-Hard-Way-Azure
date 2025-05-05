# Creating the Docker Image for the Thomasthornton.cloud App

## 🎯 Purpose
In this lab, you'll create a Docker image to containerise the Thomasthornton.cloud app and run it locally.

## 🛠️ Create The Docker Image

### Prerequisites
- [ ] Docker installed and running
- [ ] Basic understanding of Docker concepts

### Steps

1. **Navigate to the Docker Directory**

   ```bash
   cd 3-Docker
   ```

2. **Review the Dockerfile**

   Open the Dockerfile and note its key components:
- [ ] Uses the latest Python image as base
- [ ] Creates a `/build` directory for the app
- [ ] Copies the `app` directory and `requirements.txt` into `/build`
- [ ] Configures the container to run the app on startup

3. **Build the Docker Image**

   ```bash
   docker build -t thomasthorntoncloud:latest .
   ```

   If you're on Apple Silicon or need to specify a platform:

   ```bash
   docker build --platform=linux/amd64 -t thomasthorntoncloud:latest .
   ```

   > 🔍 **Note**: The `--platform` option specifies the target platform as linux/amd64, ensuring compatibility with most cloud environments. This is particularly important when building on ARM-based systems like Apple Silicon.

4. **Verify the Docker Image**

   ```bash
   docker image ls thomasthorntoncloud
   ```

   You should see your newly created image with its size. The multi-stage build approach helps keep the final image size smaller.

## 🏃‍♂️ Run The Docker Image Locally

1. **Run the Docker Container**

   ```bash
   docker run -tid -p 5000:5000 --name thomasthorntoncloud-app thomasthorntoncloud:latest
   ```

   The flags used:
   - `-t` enables a TTY console
   - `-i` enables an interactive session
   - `-d` detaches the terminal from the Docker container
   - `-p 5000:5000` maps the container's port 5000 to your local port 5000

2. **Confirm the Container is Running**

   ```bash
   docker container ls
   ```

   You should see the container running successfully.

3. **Access the Application**

   Open a web browser and navigate to:
   ```
   http://localhost:5000
   ```

   You should see the thomasthornton.cloud application running.

4. **View Container Logs**

   ```bash
   docker logs thomasthorntoncloud-app
   ```

5. **Stop the Container When Done**

   ```bash
   docker stop thomasthorntoncloud-app
   ```

## 🧠 Knowledge Check

After creating and running the Docker image, consider these questions:
1. Why do we use a multi-stage build in our Dockerfile?
2. What security benefits do we get from running the application as a non-root user?
3. How does the HEALTHCHECK directive help with container orchestration?
4. Why might you need to specify the `--platform` option when building Docker images?

## 🔍 Verification

To ensure the Docker image was created and is running successfully:
1. Check that the image appears in the output of `docker image ls`
2. Verify that the container is listed and in the "Up" state when you run `docker container ls`
3. Confirm you can access the application at http://localhost:5000
4. Check that the health check is passing with `docker inspect --format='{{.State.Health.Status}}' thomasthorntoncloud-app`

## 💡 Pro Tips

1. **Layer Optimisation**: Keep the most frequently changing content (like application code) in the later layers of your Dockerfile to take advantage of Docker's caching mechanism.

2. **Security Scanning**: Consider scanning your Docker images for vulnerabilities before deployment:
   ```bash
   docker scan thomasthorntoncloud:latest
   ```

3. **Resource Limits**: In production, set resource limits for your containers:
   ```bash
   docker run -tid -p 5000:5000 --memory=512m --cpus=0.5 thomasthorntoncloud:latest
   ```

4. **Using Docker Compose**: For more complex applications with multiple services, consider using Docker Compose:
   ```bash
   docker-compose up -d
   ```