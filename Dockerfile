# Define a versão do node.js
FROM node:20

# Define o diretório de trabalho do contêiner
WORKDIR /app

# Copia os arquivos de dependências
COPY package*.json ./

# Instala as dependências
RUN npm install

# Copia o restante dos arquivos
COPY . .

# Gera o Prisma Client dentro do container (engine do Linux)
RUN npx prisma generate

# Compila o TypeScript
RUN npm run build

# O tsc não copia o engine (.so.node), então copiamos a pasta gerada para o dist
RUN cp -r src/generated/. dist/src/generated/

# Expõe a porta usada pela aplicação
EXPOSE 3000

# Inicializa a aplicação
CMD ["npm", "start"]
