module.exports = {
  // Run type-check on changes to TypeScript files
  '**/*.ts?(x)': () => 'pnpm type-check',
  // Run ESLint on changes to JavaScript/TypeScript files
  '**/*.(ts|js)?(x)': filenames => `pnpm lint ${filenames.join(' ')}`,
  // Run Stylelint on changes to CSS/SCSS/LESS files
};
