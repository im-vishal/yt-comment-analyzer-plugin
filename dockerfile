# Stage 1: Build Stage
FROM python:3.11-slim AS build

WORKDIR /app

COPY flask_app/ /app/

COPY tfidf_vectorizer.pkl /app/tfidf_vectorizer.pkl

# Stage 2: Final Stage
FROM python:3.11-slim AS final

WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

RUN apt-get update && apt-get install -y libgomp1

RUN pip install --upgrade pip

# Install Dependencies
RUN pip install --no-cache-dir -r requirements.txt

RUN python -m nltk.downloader stopwords wordnet

EXPOSE 5000

CMD ["python", "app.py"]
