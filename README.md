# 📘 Trainee DevOps API

Este projeto é uma API simples em **Python (Flask)** que retorna informações de health check e uma mensagem de boas-vindas. Ele foi desenvolvido como parte de um desafio técnico para trainees em Cloud/DevOps.

## 🚀 Como rodar a aplicação localmente
- **Docker:** `docker build -t trainee-api . && docker run -p 5000:5000 trainee-api`
- **Docker Compose:** `docker-compose up --build`

## ⚙️ Pipeline CI/CD
- **lint:** roda `flake8` e falha se houver erros.
- **test:** executa `pytest` e falha se algum teste falhar. Usa **cache de dependências pip** para acelerar builds.
- **build:** constrói a imagem Docker e faz push para o GitLab Container Registry.
- **security_scan (SAST):** executa análise estática com **Bandit** para detectar vulnerabilidades no código Python.
- **deploy:** simula um deploy no ECS, rodando apenas na branch `main`.

## 🛠️ Decisões técnicas
- Imagem leve (Alpine/Slim).
- Usuário não-root.
- Multi-stage build.
- Healthcheck no Compose.
- Pipeline com stages separados.
- Cache no pipeline para acelerar builds.
- SAST com Bandit para segurança.


## ⏳ O que faria diferente com mais tempo
- Monitoramento (Prometheus/Grafana).
- Deploy real em ECS/Fargate.
- Testes de integração e carga.
- Linter mais moderno (Ruff).
- Scan de vulnerabilidades em imagens Docker (Trivy).

## 🤖 Uso de IA
Utilizei **Microsoft Copilot** para:
- Gerar exemplos de Dockerfile e Compose.
- Estruturar pipeline GitLab CI/CD.
- Escrever README.md.
- Prompts usados: "Crie Dockerfile", "Monte docker-compose.yml", "Crie .gitlab-ci.yml", "Documente no README".
- Funcionou bem para boas práticas e exemplos práticos.
- Ajustes finos (variáveis GitLab CI) exigiram revisão manual.

## 📂 Estrutura de Pastas
trainee-api/
│── app.py                # Código principal da API Flask
│── requirements.txt       # Dependências da aplicação e testes
│── test_app.py            # Testes básicos com pytest
│── Dockerfile             # Containerização da aplicação
│── docker-compose.yml     # Orquestração local (API + testes)
│── healthcheck.sh         # Script opcional de healthcheck manual
│── .gitlab-ci.yml         # Pipeline CI/CD para GitLab
│
├── terraform/             # Infraestrutura como código (ECS simplificado)
│   └── main.tf
│
└── .github/
    └── workflows/
        └── ci.yml         # Pipeline CI/CD para GitHub Actions