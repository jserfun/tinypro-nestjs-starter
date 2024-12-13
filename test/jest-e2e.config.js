module.exports = {
  testRegex: '.e2e-spec.ts$',
  moduleFileExtensions: ['js', 'json', 'ts'],
  rootDir: '.',
  moduleNameMapper: {
    '^@libs/db$': '<rootDir>/../libs/db/src/index',
    '^@libs/db/(.*)$': '<rootDir>/../libs/db/src/$1',
    '^@libs/models$': '<rootDir>/../libs/models/src/index',
    '^@libs/models/(.*)$': '<rootDir>/../libs/models/src/$1',
    '^@libs/redis$': '<rootDir>/../libs/redis/src/index',
    '^@libs/redis/(.*)$': '<rootDir>/../libs/redis/src/$1',
  },
  testEnvironment: 'node',
  transform: {
    '^.+\\.(t|j)s$': 'ts-jest',
  },
};
