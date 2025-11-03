import { defineConfig, devices } from '@playwright/test';
/**
 * See https://playwright.dev/docs/test-configuration.
 */
export default defineConfig({
  testDir: './tests',
  /* Run tests in files in parallel */
  reporter: [
    ['list'],
    ['allure-playwright']
  ],

  use: {
    headless: true,
    trace: 'on',
    video: 'on',
    screenshot: 'on',
  },
  expect: {
    timeout: 10000 // Tiempo máximo para aserciones como toBeVisible()
  },

  /* Configure projects for major browsers */
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'],},
    },
  ]
});
