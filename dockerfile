FROM ubuntu:latest

ARG BUILD_CONFIGURATION=Debug
ENV ASPNETCORE_ENVIRONMENT=Development
ENV DOTNET_USE_POLLING_FILE_WATCHER=true  
ENV ASPNETCORE_URLS=http://+:8090  
EXPOSE 8090
USER root
RUN apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y wget 

RUN wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb;\
     dpkg -i packages-microsoft-prod.deb;\
    rm packages-microsoft-prod.deb

RUN  apt-get update; \
   apt-get install -y apt-transport-https && \
   apt-get update && \
   apt-get install -y dotnet-sdk-6.0

RUN   apt-get update; \
   apt-get install -y apt-transport-https && \
   apt-get update && \
   apt-get install -y aspnetcore-runtime-6.0

RUN   apt-get install -y dotnet-runtime-6.0

COPY . dotnet1/


EXPOSE 5000

CMD ["dotnet", "dotnet1/published/DotNetWeb.dll"]
# docker run --rm -p 5000:5000 --name test-dotnet -v $PWD/published:/published ubuntu-dotnet dotnet published/DotNetWeb.dll