FROM mcr.microsoft.com/dotnet/sdk:6.0 AS backend-build-env
WORKDIR /app

# Copy everything
COPY ./backend ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

FROM node:16 AS frontend-build-env
WORKDIR /app

# Copy everything
COPY ./frontend ./
# Restore as distinct layers
RUN npm install
# Build and publish a release
RUN npm run build


# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=backend-build-env /app/out .
COPY --from=frontend-build-env /app/packages/app/dist ./wwwroot
ENTRYPOINT ["dotnet", "app.dll"]