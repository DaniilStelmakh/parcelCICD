# указываем родительсикй образ
FROM golang:1.22
# создаем каталог внутри создаваемого образа 
# (для простоты, указываем, что все последующие команды будут выполнятся в нем)
WORKDIR /app 
# копирование мудулей для удачной компиляции 
COPY go.mod go.sum ./ 
# команда для запуска, после ее выполнения все все модули Go
# указанные в go.mod и go.sum будут установлены в каталог /app
RUN go mod download 
# копируем все файлы
COPY . . 
# установка перменной среды 
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
# выполнения команды сборки для удачной компиляции 
RUN go build -o /parcelcicd
# команда, когда Docker - образ используется для запуска контейнера 
CMD [ "/parcelcicd" ]