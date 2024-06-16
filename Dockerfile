# Use official Python 3.9 Image
FROM python:3.9

# Set the working directory to /code
WORKDIR /code

# Copy the current directory contents in the container at /code
COPY ./requirements.txt /code/requirements.txt

# Install the requirements
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Create New user
RUN useradd user

# Swtich to user "user"
USER user

# Set home to user's home directory
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Set the working directory to user's home directory
WORKDIR $HOME/app

# Copy the current directory contents into the container at $HOME/app
COPY --chown=user . $HOME/app

# Start the FastAPI app on port 7860
CMD [ "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860" ]
