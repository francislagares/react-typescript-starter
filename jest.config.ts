import type { Config } from '@jest/types';

// Sync object
const config: Config.InitialOptions = {
  testPathIgnorePatterns: ['<rootDir>/node_modules/'],
  setupFilesAfterEnv: ['<rootDir>/setupTests.js'],
  transform: {
    '^.+\\.(js|jsx|ts|tsx)$': '<rootDir>/node_modules/ts-jest',
  },
  moduleNameMapper: {
    '\\.(css|less|scss|sass)$': '<rootDir>/styles/__mocks__/styleMock.js',
  },
  testEnvironment: 'jsdom',
  verbose: true,
};

export default config;
