FROM node:16-slim
WORKDIR /app

RUN npm i -g pnpm@8.6.6

COPY . .

RUN apt-get update && apt-get install -y jq
RUN jq 'del(.devDependencies.cypress)' package.json > _.json && mv _.json package.json
RUN pnpm install

ENV SALEOR_API_URL=http://saleor.jbox.es/graphql/

ENV STOREFRONT_URL=http://localhost:3000

RUN pnpm run build:storefront

CMD pnpm run start:storefront