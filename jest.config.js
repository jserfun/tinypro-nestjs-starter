module.exports = {
  testRegex: '.*\\.spec\\.ts$',
  moduleFileExtensions: ['js', 'json', 'ts'],
  rootDir: 'src',
  moduleNameMapper: {
    '^@libs/db$': '<rootDir>/../libs/db/src/index',
    '^@libs/db/(.*)$': '<rootDir>/../libs/db/src/$1',
    '^@libs/models$': '<rootDir>/../libs/models/src/index',
    '^@libs/models/(.*)$': '<rootDir>/../libs/models/src/$1',
    '^@libs/redis$': '<rootDir>/../libs/redis/src/index',
    '^@libs/redis/(.*)$': '<rootDir>/../libs/redis/src/$1',
  },
  transform: {
    '^.+\\.(t|j)s$': 'ts-jest',
  },
  collectCoverageFrom: ['**/*.(t|j)s'],
  coverageDirectory: '../coverage',
  testEnvironment: 'node',
};
