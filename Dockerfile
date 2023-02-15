FROM python:3.8
COPY . /app
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
EXPOSE 8000
CMD ["python3", "app.py"] 
