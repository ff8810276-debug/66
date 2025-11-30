FROM python:3.10

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# دانلود مدل داخل image (به‌جای ذخیره در repo)
RUN mkdir -p /app/models \
    && curl -L -o /app/models/qwen2.5-0.5b-instruct-q4_k_m.gguf \
       "https://huggingface.co/Qwen/Qwen2.5-0.5B-Instruct-GGUF/resolve/main/qwen2.5-0.5b-instruct-q4_k_m.gguf"

COPY . .

EXPOSE 8000

CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
