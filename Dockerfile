# Use an official Python image as the base
FROM python:3.12-slim

# Create a non-root user and set up home directory
RUN useradd -m myuser

# Switch to the non-root user
USER myuser

WORKDIR /workspaces

COPY . .

RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# # Expose the default Jupyter Notebook port
# EXPOSE 8888

# # Configure the Jupyter server
# CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
