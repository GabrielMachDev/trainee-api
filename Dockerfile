# Etapa 1: Build
FROM python:3.11-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Etapa 2: Runtime
FROM python:3.11-alpine
WORKDIR /app
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
COPY --from=builder /root/.local /root/.local
COPY . .
ENV PATH=/root/.local/bin:$PATH
USER appuser
EXPOSE 5000
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost:5000/health || exit 1
CMD ["python", "app.py"]