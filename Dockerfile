# 🔧 Build Stage
FROM mcr.microsoft.com/dotnet/sdk:9.0-preview AS build
WORKDIR /app

# COPY และ restore .csproj
COPY WebApiProject.csproj ./
RUN echo ">> RUNNING DOTNET RESTORE..." && dotnet restore --verbosity normal

# COPY ไฟล์ทั้งหมดและ build
COPY . .
RUN dotnet publish -c Release -o /app/out

# 🚀 Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0-preview AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# ✅ เพิ่ม environment, expose, และ entrypoint
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80
ENTRYPOINT ["dotnet", "WebApiProject.dll"]
