FROM node:lts as BUILDER
WORKDIR /builder/
ADD . .

# TODO: using pnpm should be told
RUN npm install pnpm -g && \
    pnpm i && \
    pnpm build

FROM node:alpine as prod

WORKDIR /APP

# bug: the nestjs app src/app.module.ts#I18nModule.forRoot watch src dir
COPY --from=BUILDER /builder/dist /APP/dist
COPY --from=BUILDER ["/builder/locales.json", "/builder/package.json", "/APP/"]
RUN npm install pnpm -g && \
    pnpm i
ENV DATABASE_HOST ""
ENV DATABASE_PORT ""
ENV DATABASE_USERNAME ""
ENV DATABASE_PASSWORD ""
ENV DATABASE_USERNAME ""
ENV DATABASE_SYNCHRONIZE ""
ENV DATABASE_AUTOLOADENTITIES true
ENV AUTH_SECRET ""
ENV REDIS_SECONDS ""
ENV REDIS_HOST ""
ENV REDIS_PORT ""
ENV REDIS_PASS ""
ENV EXPIRES_IN ""
ENV PAGINATION_PAGE ""
ENV PAGINATION_LIMIT 10
EXPOSE 3000
VOLUME [ "./dist/data" ]
CMD ["node", "./dist/main.js"]
