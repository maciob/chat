FROM python:3.8-slim-buster
WORKDIR app/
COPY chat/ .
RUN pip3 install -r requirements.txt
CMD [ "python3", "-m" , "flask", "--app", "app.py", "run", "--host=0.0.0.0"]
