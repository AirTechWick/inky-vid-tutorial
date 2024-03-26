FROM cgr.dev/chainguard/python:latest-dev as builder

ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PATH="/inky-tutorial/venv/bin:$PATH"

WORKDIR /inky-tutorial

RUN python -m venv /inky-tutorial/venv
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

FROM cgr.dev/chainguard/python:latest

WORKDIR /inky-tutorial

ENV PYTHONUNBUFFERED=1
ENV PATH="/venv/bin:$PATH"

COPY inky.py inky.png ./
COPY --from=builder /inky-tutorial/venv /venv

ENTRYPOINT [ "python", "/inky-tutorial/inky.py" ]
