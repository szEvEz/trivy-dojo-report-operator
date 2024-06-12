FROM python:3.12@sha256:00389e020fe42a6c74a8f091ce9b28324422d084efdff26eabe93bc4ae9a110b as build

WORKDIR /app

RUN pip install --no-cache-dir poetry

COPY poetry.lock pyproject.toml /app/

RUN poetry config virtualenvs.in-project true
RUN poetry install --no-ansi

FROM python:3.12-slim@sha256:e3ae8cf03c4f0abbfef13a8147478a7cd92798a94fa729a36a185d9106cbae32

RUN groupadd --gid 1000 app && \
    useradd --gid 1000 --uid 1000 app

COPY --from=build /app /app

COPY src/* /app/

RUN chown -R app:app /app

USER app

WORKDIR /app

CMD ["/app/.venv/bin/kopf", "run", "--liveness=http://0.0.0.0:8080/healthz", "/app/handlers.py", "--all-namespaces"]