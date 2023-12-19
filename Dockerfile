FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 8019


FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY "./MockDogApiDec19.csproj" ./
RUN dotnet restore "./MockDogApiDec19.csproj"

COPY . .
RUN dotnet build "./MockDogApiDec19.csproj" -c Release -o /app/build


FROM build AS publish
RUN dotnet publish "./MockDogApiDec19.csproj" -c Release -o /app/publish


FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT [ "dotnet", "MockDogApiDec19.dll" ]