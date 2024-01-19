#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["MQTT_SQL/MQTT_SQL.csproj", "MQTT_SQL/"]
RUN dotnet restore "MQTT_SQL/MQTT_SQL.csproj"
COPY . .
WORKDIR "/src/MQTT_SQL"
RUN dotnet build "MQTT_SQL.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MQTT_SQL.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MQTT_SQL.dll"]