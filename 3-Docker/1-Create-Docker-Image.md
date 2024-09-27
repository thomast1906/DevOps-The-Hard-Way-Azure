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
     cd Docker
     ```

You should see a `Dockerfile` and an `app` directory

2. Review the Dockerfile

Open the Dockerfile and note its key components:
- [ ] Uses the latest Python image as base
- [ ] Creates a `/build` directory for the app
- [ ] Copies the `app` directory and `requirements.txt` into `/build`
- [ ] Configures the container to run the app on startup

3. Build the Docker Image
Run one of the following commands:

     ```bash
     docker build -t thomasthorntoncloud .
     ```
Or, if the above doesn't work:

     ```bash
     docker build --platform=linux/amd64 -t thomasthorntoncloud .
     ```

> 🔍 **Note**: The --platform option specifies the target platform as linux/amd64, useful for multi-platform images.

4. Verify the Docker Image

     ```bash
     docker image ls
     ```

## 🏃‍♂️ Run The Docker Image Locally

1. **Run the Docker Container**

     ```bash
     docker run -tid thomasthorntoncloud
     ```
- `t` enables a TTY console.
- `i` enables an interactive session.
- `d` detaches the terminal from the Docker container.

2. **Confirm the Container is Running**

     ```bash
     docker container ls
     ```

You should see the container running successfully.

## 🧠 Knowledge Check

After creating and running the Docker image, consider these questions:
1. Why do we use the `-t` flag when building the Docker image?
2. What's the purpose of the `--platform` option in the build command?
3. How does running the container with `-tid` flags differ from running it without these flags?

## 🔍 Verification

To ensure the Docker image was created and is running successfully:
1. Check that the image appears in the output of `docker image ls`
2. Verify that the container is listed and in the "Up" state when you run `docker container ls`


## 💡 Pro Tip

Consider using Docker Compose for more complex applications with multiple services. It simplifies the process of running multi-container Docker applications.