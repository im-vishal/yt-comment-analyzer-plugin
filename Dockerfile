# Use an official Python image as the base
FROM python:3.10-slim

# Set up a non-root user
RUN useradd -m myuser

# Switch to root user to install system dependencies
USER root

# Install dependencies, including libgomp for LightGBM
RUN apt-get update && \
    apt-get install -y --no-install-recommends git libgomp1 && \
    rm -rf /var/lib/apt/lists/*

# Switch back to non-root user
USER myuser

# Set the working directory
WORKDIR /workspaces

COPY . .

RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# # Expose the default Jupyter Notebook port
# EXPOSE 8888

# # Configure the Jupyter server
# CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
