# Etapa 1: Build
FROM python:3.11-slim-bookworm AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

# Etapa 2: Runtime
FROM python:3.11-alpine3.20
WORKDIR /app
RUN apk add --no-cache curl
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder /install /usr/local
COPY . .
USER appuser
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost:5000/health || exit 1
CMD ["python", "app.py"]